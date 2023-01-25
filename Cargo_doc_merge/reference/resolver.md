# 依赖解析

Cargo 的主要功能之一就是依据每个包指定的依赖版本，解析出具体使用的依赖版本。
这个过程称为 "依赖解析" ，由 "解析器" (resolver) 完成。
解析的结果保存在 `Cargo.lock` 文件中，将每个依赖 "锁定" 到特定版本，使其不会改变。

解析器会尽力统一处理相同依赖，同时也会考虑可能的冲突。下面一节详细介绍了使用解析器和约束处理。

查看 [Specifying Dependencies] 一章了解如何指定依赖的更多细节。

可以用 `[cargo tree]` 命令来可视化查看解析结果。

[Specifying Dependencies]: specifying-dependencies.md
[`cargo tree`]: ../commands/cargo-tree.md

## SemVer规则兼容性

Cargo 使用 [SemVer] 语义化规则来表述版本，从而判断某个包两个不同版本的 "兼容" 情况，关于 "兼容性" 改变的更多信息查看 [SemVer Compatibility] 。
"兼容性" 的概念很重要，因为Cargo假设在版本兼容范围内更新依赖后构建是安全的。

认为 *最左侧非零数字* 相同的版本之间是兼容的。比如 `1.0.3` 和 `1.1.0` 被认为是兼容的，因此可以安全地从低版本升级到高版本。
然而， `1.1.0` 到 `2.0.0` 不允许自动升级。以0开头的版本也适用这种约定，比如 `0.1.0` 与 `0.1.2` 兼容，与 `0.2.0` 不兼容。同样的， `0.0.1` 与 `0.0.2` 不兼容。

继续加深一下，Cargo 依赖使用的 [*版本请求* 语法][Specifying Dependencies] 为:

版本请求 | 示例 | 等同于 | 描述
--|--------|--|-------------
`^` | `1.2.3` or `^1.2.3` | <code>>=1.2.3,&nbsp;<2.0.0</code> | SemVer 兼容的版本, 高于或等于所给版本
`~` | `~1.2` | <code>>=1.2.0,&nbsp;<1.3.0</code> | 更受限的兼容范围
通配符 | `1.*` | <code>>=1.0.0,&nbsp;<2.0.0</code> |  `*` 位置可以运行任何值
等于号 | `=1.2.3` | <code>=1.2.3</code> | 完全等于指定的版本
比较符号 | `>1.1` | <code>>=1.2.0</code> | 进行简单的数字比较
组合 | <code>>=1.2,&nbsp;<1.5</code> | <code>>1.2.0,&nbsp;<1.5.0</code> | 同时满足多个条件

当多个包共同指定某个公共包为依赖时，解析器会尝试使用该公共包的同一个版本，前提是在 SemVer 规则兼容的范围。
解析器会尽可能使用兼容范围内包的最新版本。比如，假设现在解析图中有下面两个依赖请求:

```toml
# Package A
[dependencies]
bitflags = "1.0"

# Package B
[dependencies]
bitflags = "1.1"
```

如果生成 `Cargo.lock` 时 `bigflags` 的最高版本是 `1.2.1`，那么两个包都会使用 `1.2.1`，因为这是兼容范围内的最高版本。
如果 `2.0.0` 已经发布，仍会使用 `1.2.1`，因为 `2.0.0` 被认为是不兼容的。

Cargo 允许多个包依赖的公共包版本不兼容的情况，对公共包构建多份拷贝。比如:

```toml
# Package A
[dependencies]
rand = "0.7"

# Package B
[dependencies]
rand = "0.6"
```

上面的配置会使得包A使用最高的 `0.7` 版本(本文写作时为 `0.7.3` )，包B使用最高的 `0.6` 版本(比如 `0.6.5` )。
这可能会有潜在的问题，参考 [Version-incompatibility hazards] 。

不允许使用兼容范围内的多个版本，这会导致解析器错误。例如，解析图中的两个包有下面的依赖请求:

```toml
# Package A
[dependencies]
log = "=0.4.11"

# Package B
[dependencies]
log = "=0.4.8"
```

上面的解析会失败，因为不允许有两份 `0.4` 版的 `log` 包。

[SemVer]: https://semver.org/
[SemVer Compatibility]: semver.md
[Version-incompatibility hazards]: #version-incompatibility-hazards

### 版本不兼容的风险

当解析图中出现同一crate的多个版本时，这些版本中的类型(types)可能会被使用它们的crate再暴露出来，这会导致问题。
这是因为Rust编译器以不同方式解读类型(types)和语法元素(items)，即使它们有相同的名字。
一个库在发布一个 SemVer 不兼容版本时一定要小心(比如 `1.0.0` 在被使用的情况下发布 `2.0.0`)，尤其是那些被广泛使用的库。

"[semver trick]" 是解决这个问题的一个变通方法，可以在发布破坏性更新的同时保持与旧版本的兼容性。
上面链接中的文章详细介绍了该问题的来源以及解决方法。简而言之，当一个库想要发布一个 SemVer 破坏性更新时，
先发布破坏性新版本，再同时发布一个旧版本的修复版本，在这个版本中引用新版本并将其中的类型 (types) 导出。

这种不兼容通常表现为编译错误，但有时也会显现为运行时的错误行为。
例如，比如说有一个库 `foo` 以 `1.0.0` 和 `2.0.0` 在解析图中出现了两次，
当在使用`foo 1.0.0` 的库生成的一个对象上进行  [`downcast_ref`] ，
而调用 [`downcast_ref`] 的代码引用的类型却来自 `foo 2.0.0`，downcast 就会在运行时失败。

一定要确认你是否用到了某个库的多个版本，尤其是检查混用不同版本的类型(types)的可能性。
[`cargo tree -d`][`cargo tree`] 命令可以用来检查重复依赖的存在和来源。
同样的，当你发布一个很流行的库的SemVer不兼容版本时，仔细考虑其对生态的影响。

[semver trick]: https://github.com/dtolnay/semver-trick
[`downcast_ref`]: ../../std/any/trait.Any.html#method.downcast_ref

### 预发布

SemVer 有 "预发布" 的概念，在版本号中带有 `-` ，比如 `1.0.0-alpha` 、 `1.0.0-beta` 。
Cargo 会避免自动使用预发布版本，除非显式要求。例如，如果包 `foo` 发布了 `1.0.0-alpha` ，而版本请求是 `foo = "1.0"` ，
则版本是不匹配的，Cargo 会返回错误。预发布版本必须显式指定，比如 `foo = "1.0.0-alpha"`。
同样的， [`cargo install`] 也会在未显式声明情况下避免使用预发布版本。

Cargo 允许预发布版本间的自动更新。例如，如果 `1.0.0-beta` 发布，那么请求 `foo = "1.0.0-alpha"` 会允许更新到 `beta` 版本。
注意，预发布版本是不稳定的，使用时要小心。一些项目可能会选择在预发布版本间进行破坏性更新，
建议不要使用预发布的依赖，除非你的库也是预发布版本。更新 `Cargo.lock` 时要小心，在预发布版本造成问题之前做好充分准备。

预发布标记可能会用句点来分割为不同的部分。数字部分会进行数值的比较。
比如 `1.0.0-alpha.4` 中的 `4` 会作为数字来比较， `1.0.0-alpha.11` 的版本就比它高。
非数字部分通过字典排序来比较。

[`cargo install`]: ../commands/cargo-install.md

### 版本元数据

SemVer 有 "版本元数据" 的概念，会在版本后附带一个加号出现，比如 `1.0.0+21AF26D3` 。
通常忽略这个元数据，而且不应该在版本请求中使用。
永远不要在 [crates.io] 上发布两个仅有元数据不同的版本( 然而目前 [crates.io] 却允许这一点，这是一个 [known issue] 已知的问题)。

[known issue]: https://github.com/rust-lang/crates.io/issues/1059
[crates.io]: https://crates.io/

## 其他约束

版本请求并不是决定解析过程的唯一因素。下面章节中介绍了影响解析过程的其他几种约束:

### 特性

为了生成 `cargo.lock`，解析器在构建依赖图时会假设所有 [workspace] 的所有 [feature] 都被启用。
这保证所有可选的依赖都可用且被解析，当在命令行中通过 [`--features` 命令行标志](features.md#command-line-feature-options) 添加或删除特性时，功能可以正常实现。
当 *编译* crate时，解析器第二次执行，根据命令来决定实际启用的特性。

当解析依赖时，会将其被启用的所有特性一起解析。
例如，一个包依赖 [`im`] 包，开启了 [`serde` dependency]；另一个包也依赖 [`im`]，开启了 [`rayon` dependency]。
这时 `im` 会按照两个特性都启用的状态进行构建， `serde` 和 `rayon` 都会被加入解析图。
如果依赖 `im` 的包都没有包含这些特性，那么这些可选依赖会被忽略，不会影响解析过程。

当在工作空间(workspace)中构建多个包(比如通过 `--workspace` 或者 多个 `-p` 标记)，这些包所有依赖的所有特性会统一进行构建。
如果你有需要避免合并，可以单独执行 `cargo` 进行构建。

解析器会跳过那些缺失所请求特性的包版本。例如，如果一个包依赖 [`regex`] 的 `^1` 版本，且开启了 [`perf` feature]，那么其可以选择的最早版本是 `1.3.0`，因为那之前的版本没有 `perf` 这个特性。同样的，如果一个特性在新版本中被移除，那么需要这个特性的包的版本就会卡在之前包含这个特性的版本。
不建议在 SemVer 兼容的更新中移除特性。注意，可选依赖是隐式的特性，因此移除某个可选依赖或者将其改变为非可选可能会导致问题，详见 [removing an optional dependency]。

[`im`]: https://crates.io/crates/im
[`perf` feature]: https://github.com/rust-lang/regex/blob/1.3.0/Cargo.toml#L56
[`rayon` dependency]: https://github.com/bodil/im-rs/blob/v15.0.0/Cargo.toml#L47
[`regex`]: https://crates.io/crates/regex
[`serde` dependency]: https://github.com/bodil/im-rs/blob/v15.0.0/Cargo.toml#L46
[features]: features.md
[removing an optional dependency]: semver.md#cargo-remove-opt-dep
[workspace]: workspaces.md

#### Feature 解析器 v2

在 `Cargo.toml` 中指定 `resolver = "2"` 时，会启用不同算法的另一个特性解析器。
`"1"` 解析器会将一个包启用的所有特性合并起来，无论这些特性是在哪里指定的。
而 `"2"` 解析器会在以下场景中避免合并特性:

* 当没有实际被构建时，平台特定依赖的特性不会被启用。例如:

  ```toml
  [dependencies.common]
  version = "1.0"
  features = ["f1"]

  [target.'cfg(windows)'.dependencies.common]
  version = "1.0"
  features = ["f2"]
  ```

* 当在一个非windows平台构建这个示例时，*不会* 启用 `f2` 特性 。

* 在这些相同的依赖作为常规依赖使用时，在[build-dependencies]或proc-macros上启用的特性，不会被合并。

  ```toml
  [dependencies]
  log = "0.4"

  [build-dependencies]
  log = {version = "0.4", features=['std']}
  ```

  当编译构建脚本时， `log` crate 和 `std` 特性一起编译。而当编译你的库时，则不会启用该特性。

* 构建普通目标时，不会把 [dev-dependencies] 中相同依赖的特性合并进来。只有构建开发时目标(test、example等)，构建 [dev-dependencies] 时，才会进行合并。

  ```toml
  [dependencies]
  serde = {version = "1.0", default-features = false}

  [dev-dependencies]
  serde = {version = "1.0", features = ["std"]}
  ```

  在这个例子中，该库构建 `serde` 不会带 `std` feature。然而，当构建一个 test或example时，就会带 `std` feature。比如执行 `cargo test` 或 `cargo build --all-targets` 会合并 feature 。注意 dev-dependencies 总是会被忽略，以上内容仅针对顶层包或工作空间成员。

[build-dependencies]: specifying-dependencies.md#build-dependencies
[dev-dependencies]: specifying-dependencies.md#development-dependencies
[resolver-field]: features.md#resolver-versions

### `links`

[`links` field] 字段用于确保二进制目标对每个本地库只链接一次。
解析器会尝试创建依赖图，使得每个 `links` 名只对应一个实例。
如果无法找到这样的依赖图，就会返回错误。

例如，如果一个包依赖 [`libgit2-sys`] 的 `0.11` 版，而另一个包依赖 `0.12`，则会报错，因为 Cargo 无法将两个依赖合并，即使这个两个版本链接的都是 `git2` 本地库。
因此，在发布带 `links`字段的库的 SemVer 不兼容版本时，一定要多加注意。

[`links` field]: manifest.md#the-links-field
[`libgit2-sys`]: https://crates.io/crates/libgit2-sys

### Yanked versions

[Yanked releases][yank] 是那些标记为不应该使用的版本。当解析器在构建依赖图时，会忽略哪些标记为yanked的版本，除非其已经写入了 `Cargo.lock`。

[yank]: publishing.md#cargo-yank

## 更新依赖

需要知晓依赖图的那些 Cargo 命令会自动执行依赖解析。
例如，[`cargo build`] 会运行解析器来知晓所有需要构建的依赖。
在第一次执行之后，结果被保存到 `Cargo.lock` 中。
接下来的命令也会执行解析器，保持依赖被锁定在 `Cargo.lock` 中声明的版本(*如果可以做到的话*)。

如果修改了 `Cargo.toml` 中的依赖列表，比如把依赖从 `1.0` 改到 `2.0`，解析器会选择该依赖的新版本以满足依赖请求。
如果新的依赖也引用了新的依赖，那么会触发后者的更新。会更新 `Cargo.lock` 。
 `--locked` 或 `--frozen` 标志可以改变这种行为，或者会返回一个错误，以防止依赖请求变更时的自动依赖更新。

[`cargo update`] 可以更新 `Cargo.lock` 中有新版本的依赖项。如果不带任何选项，其会更新 lock file 中的所有包。 `-p` 标志可以指定更新的包名，其他标志如 `--aggressive` 或 `--precise` 可以用于控制如何进行版本选择。

[`cargo build`]: ../commands/cargo-build.md
[`cargo update`]: ../commands/cargo-update.md

## 覆盖

Cargo有多种机制来覆盖依赖图中的依赖项， [Overriding Dependencies] 一章中进行了详细介绍。
覆盖项是对注册中心(registry)进行覆盖，将被覆盖的依赖替换为其他条目，除此之外解析过程没有任何区别。

[Overriding Dependencies]: overriding-dependencies.md

## 依赖的种类

包 (package) 中有三种依赖：常规的，[build]，和 [dev][dev-dependencies]。
大多数情况下，这三种依赖在解析器的方式一样，一个区别是非工作空间成员的 dev-dependencies 总是被忽略，不会影响到解析过程。

带有 `[target]` 表的 [Platform-specific dependencies] 解析为启用所有平台。换句话说，解析器忽略平台或 `cfg` 表达式。

[build]: specifying-dependencies.md#build-dependencies
[dev-dependencies]: specifying-dependencies.md#development-dependencies
[Platform-specific dependencies]: specifying-dependencies.md#platform-specific-dependencies

### dev-dependency cycles

通常解析器不允许循环依赖，但是在 [dev-dependencies] 却是允许的。
例如，项目 `foo` 有一个 [dev-dependencies] `bar`，而 `bar` 有一个依赖 `foo` (通常是以 "path" 依赖的形式)。
这是允许的，因为在构建制品看来，这并不是一个循环依赖。
在这个例子中， `foo` 库先被构建(这个过程中不需要 `bar`，因为 `bar` 只用于测试)，然后依赖 `foo` 的 `bar` 被构建，最后 `foo` 的测试也可以链接 `bar` 而被构建。

小心这里会产生令人困惑的错误。在构建 `foo` 的单元测试(unit tests)时，实际上有两份 `foo` 的拷贝被链接进最后的测试二进制文件：一份是 `bar` 依赖的 `foo`，另一份是包含着单元测试的 `foo`。如同在 [Version-incompatibility hazards] 一节中提到问题，这两个 `foo` 的类型是不兼容的。在把 `bar` 中的 `foo` 的类型进行再导出时，要小心 `foo` 的单元测试不会把这些类型与本地类型视作等同。

尽可能拆分重构你的包，以保证依赖图中没有循环。

## 解析器版本

可以在 `Cargo.toml` 中指定解析器版本来使用另一种特性解析算法:

```toml
[package]
name = "my-package"
version = "1.0.0"
resolver = "2"
```

在 Cargo `1.50` 之前默认为 `"1"` 代解析器。
如果在根包中指定 [`edition = "2021"`](manifest.md#the-edition-field) 或者更高版本，则会使用 `"2"` 代解析器。其他情况下默认都是 `"1"` 代解析器。

 `"2"` 代解析器主要是改变了 [feature 合并](#features) 的过程。详情见 [features 一章][features-2]。

解析器版本设置是全局性的，会影响到整个工作空间(workspace)。
依赖中定义的 `resolver` 版本会被忽略，只有顶层包中定义的才有效。
如果使用了 [virtual workspace] ，解析器版本应该在 `[workspace]` 表中指定:

```toml
[workspace]
members = ["member1", "member2"]
resolver = "2"
```

[virtual workspace]: workspaces.md#virtual-workspace
[features-2]: features.md#feature-resolver-version-2

## 一些建议

下面是一些关于设置你的包以及依赖项版本的建议。这些建议在一般情况下的通用的，不过会有一些情况需要你指定不常规的依赖请求。

* 在更新你的版本数时，遵从 [SemVer guidelines]，无论是 SemVer 兼容或不兼容的更新。
* 尽可能使用 crate 依赖请求，比如 `1.2.3` 。这让解析器可以在保证构建兼容性同时尽可能灵活地选择依赖版本。
  * 三个数字都应该设置，这可以指定可用的最小版本，保证库的使用者不会使用比这个版本更旧的版本，因而缺失一些构建所需的东西。
  * 避免使用 `*` 版本，因为 [crates.io] 不允许这种请求，而且可能会导致 `[cargo update]` 时产生破坏 SemVer 兼容的更改。
  * 避免过度放宽依赖需求。例如 `>="2.0.0"` 可以允许任何 SemVer 不兼容的版本，比如 `5.0.0`，这会在未来破坏依赖过程。
  * 尽可能避免过度缩窄依赖需求。例如你指定 `bar=~"1.3"`，而另一个包指定 `bar="1.4"`，这会导致解析失败，即使一般情况下*次版本更新* (minor release)是兼容的。
* 保持声明依赖版本与你的库实际所需的最小依赖版本一致。比如说，你有个库声明需要 `bar="1.0.12"` ，后来你的库实际开始使用 `bar` `1.1.0` 版中的某些功能，这时应该更新声明为 `bar="1.1.0"`。

  如果你没有这样做，可能问题不会立即显现出来，因为当你执行 `cargo update` 时，Cargo会对把所有依赖更新到最新的版本。然而，当另一个用户使用你的库时，可能会执行 `cargo update -p your-library`，这*不会*更新 `bar` 的版本，因为 `bar` 版本可能被他的 `Cargo.lock` 锁定了。只有当声明的依赖项版本被改变时，`bar` 才会被更新。进行 `cargo update -p` 时的失败可能会让这个用户非常困惑。
* 如果两个包的耦合很强，使用 `=` 来指定依赖可以保证之间的同步。例如，一个库有一个对应的 proc-macro，通常情况下假设必须保持版本统一(两者也不会独立使用)。这时parent library 可以用 `=` 来指定这个 proc-macro，然后把这些宏重导出方便使用。
* `0.0.x` 版本可以用于那些暂时还不稳定的包。

一般来说，你的依赖指定的越严格，解析越可能失败；反过来说，你的依赖指定的太宽松，新版本就可能破坏构建。

[SemVer guidelines]: semver.md

## 问题检查

下面部分阐述了一些你可能会遇到的问题，以及相应的解决办法:

### SemVer不兼容的修订版更新导致构建被破坏

有时一个项目可能无意间发布了一个修订版更新(point release)，但是却带有SemVer不兼容的改变。
当用户通过 `cargo update` 更新到最新版本后，构建被破坏了。这时建议该项目 [yank] 掉这个版本，要么移除这个不兼容改变，要么以主版本更新来发布。

如果这个改变来自第三方项目，可以(礼貌地)与项目合作来解决问题。

当等待该版本被 yank 时，可以采用一些变通措施:

* 如果你的项目是一个末端产品(比如一个二进制可执行程序)，可以通过 `Cargo.lock` 避免更新这个有问题的包。这可以通过在 [`cargo update`] 使用 `--precise` 标志来实现。
* 如果你发布一个二进制程序到 [crates.io]，那么可以暂时添加一个 `=` 来强制依赖使用某个特定的"好"版本。
	* 或者建议用户在 [`cargo install`] 时使用 `--locked` 标志来使用自带的 `Cargo.lock`，其中包含着保证可以编译成功的依赖版本。
* 库项目可以考虑发布一个暂时的新版本，其中包含更严格的依赖版本限制，以避免导致问题的依赖。你可以考虑使用一个范围限制(而不是 `=` )来避免过于严格的要求导致与其他包的依赖冲突。当问题解决后，你可以发布另一个修订版本来放松这个依赖限制。
* 如果这个(出问题的)第三方项目看起来无法或者不情愿yank这个更新，那么一个办法是更新你的代码来兼容这个更新，同时更新依赖请求，将这个版本设置为最小要求版本。同时你还需要考虑这对于你的库来说是否是一个SemVer破坏性更新，例如你这个库导出了依赖中的某些类型。

