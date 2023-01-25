## 指定依赖

你的crate能够于依赖另一个库，来自 [crates.io] 、其他注册中心、git仓库、本地文件系统中的子目录。
你可以暂时覆盖某个依赖的路径，从而在本地检查和修复依赖的bug。对于不同目标平台可以指定不同的依赖，也可以指定某个依赖仅在开发阶段使用。

### 指定crate.io中的依赖

默认，Cargo从 [crates.io] 查找依赖。之前在 [cargo指南](../guide/index.md) 中指定了 `time` crate 作为依赖: 

```toml
[dependencies]
time = "0.1.12"
```

`"0.1.12"` 这个字符串表示限定的版本，虽然貌似表示一个具体的 `time` 版本，但实际表示一个范围，接受 [SemVer] 语义化兼容的更新。
具体来说，接受不改变 `主版本号.次版本号.修订号` 中**第一个非零数字**的所有更新。
如果运行 `cargo update -p time` ，Cargo 会把 `time` 更新到 `0.1.13` (假设 `0.1.z` 表示的最新版本)，但不会更新到 `0.2.0`。
如果指定版本为 `1.0` ，那么Cargo 会将其更新到 `1.1` (假设 `1.y` 表示的最新版本)，但不会更新到 `2.0` 。 `0.0.x` 版本和其他版本都不兼容。

[SemVer]: https://semver.org

下面是一些书写示例，以及符合要求的版本范围:

```notrust
1.2.3  :=  >=1.2.3, <2.0.0
1.2    :=  >=1.2.0, <2.0.0
1      :=  >=1.0.0, <2.0.0
0.2.3  :=  >=0.2.3, <0.3.0
0.2    :=  >=0.2.0, <0.3.0
0.0.3  :=  >=0.0.3, <0.0.4
0.0    :=  >=0.0.0, <0.1.0
0      :=  >=0.0.0, <1.0.0
```

这种兼容规则与SemVer规则有些不同，SemVer认为在1.0.0之前都不兼容，而Cargo认为 `0.x.y` 与 `0.x.z`兼容 (只要 `y ≥ z` 且 `x > 0`)。

可以通过一些特殊操作符来调整选择兼容版本的逻辑，但在大多数情况不需要。

### 使用 `^` 符号

 `^` 符号表示默认策略，`^1.2.3` 和 `1.2.3` 的意义相同。

### 使用 `~` 符号

`~` 符号表示在某个最小版本的基础上可以做指定更新。
如果指定了如 `主.次.修` 或者 `主.次` 的版本，那么可以做修订级别的改变。
如果是只指定了主版本号，那么次版本号和修订号可以改变。

`~1.2.3` 的例子:

```notrust
~1.2.3  := >=1.2.3, <1.3.0
~1.2    := >=1.2.0, <1.3.0
~1      := >=1.0.0, <2.0.0
```

### 使用 `*` 通配符

通配符出现的位置表示任意数字。

比如 `*` 、 `1.*` 、 `1.2.*`。

```notrust
*     := >=0.0.0
1.*   := >=1.0.0, <2.0.0
1.2.* := >=1.2.0, <1.3.0
```

> **注意**: [crates.io] 不允许单独的 `*`。

### 使用比较符号

使用比较符号可以手动指定版本范围或一个具体的版本。

下面是一些例子:

```notrust
>= 1.2.0
> 1
< 2
= 1.2.3
```

### 多重约束

参考上面的示例，多个版本约束可以用逗号分隔，如 `>= 1.2, < 1.5`。

### 指定来自其他注册中心的依赖

要指定非 [crates.io] 的依赖，首先该注册中心须在 `.cargo/config.toml` 中设置，参见 [registries documentation] 。在依赖中，将 `registry` 字段设置为要使用的注册中心。

```toml
[dependencies]
some-crate = { version = "1.0", registry = "my-registry" }
```

> **注意**: [crates.io] 不允许发布带有其他注册中心依赖的包。

[registries documentation]: registries.md

### 指定来自 `git` 的依赖

要指定位于 `git` 仓库的依赖，需要的最少信息是在 `git` 字段中给出该仓库的地址:

```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git" }
```

Cargo 会 fetch 该 `git` 仓库，并在仓库中查找所需crate对应的 `Cargo.toml` 文件(该文件不要求必须在地址根目录下，比如说指定的是工作空间某个成员crate，这时 `git` 字段只需给出工作空间的地址)。

因为没有指定其他信息，Cargo会假设使用该仓库主分支的最新提交。也可以在 `git`字段后加上 `rev`、`tag` 或 `branch` 字段，来指定想要的提交。下面是一个指定 `next` 分支上最新提交的例子:

```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git", branch = "next" }
```

如果想要指定的依赖版本不是某个分支或标签，那么用 `rev` 来指定。
`rev` 字段可以是 `rev = "4c59b707"` 这样的提交hash，也可以是 `rev = "refs/pull/493/head"` 这样的名称。
哪些引用是合法的取决于这个git仓库具体的管理组织。
Github 暴露每个pull requeset 最新提交的引用，其他git组织一般也提供类似的，只是可能有不同的命名规则。

一旦添加某个 `git` 依赖，Cargo会马上锁定到该依赖最新的提交。
之后即使有新的提交，Cargo也不会自动拉取。可以通过 `cargo update` 命令来手动拉取。

对于私有仓库的身份验证，参考 [Git 身份验证][Git Authentication]。

> **注意**: [crates.io] 不允许发布带 `git` 依赖的包(`git` [dev-dependencies] 除外)。关于备用方案，参考[Multiple locations](#multiple-locations)。

[Git Authentication]: ../appendix/git-authentication.md

### 指定路径依赖

经过一段时间，我们的 `hello_world` 包 (来自[指南](../guide/index.md)) 内容增多了。可能想把其中一部分拆出来。
Cargo为此提供了指定路径依赖的功能，常见的情况是一个git仓库中有很多个子crate。
首先在 `hello_world` 项目里面创建一个新的crate:

```console
# hello_world/ 目录中
$ cargo new hello_utils
```

这将创建新的 `hello_utils` 文件夹，其中已经设置好了 `Cargo.toml` 和 `src` 文件夹。
为了让Cargo知道新crate的存在，需要在 `hello_world/Cargo.toml` 中将 `hello_utils` 添加为依赖:

```toml
[dependencies]
hello_utils = { path = "hello_utils" }
```

这会告诉Cargo依赖了一个名为 `hello_utils` 的crate，在 `hello_utils` 文件夹中(相对于 `Cargo.toml` 的位置)。

搞定！下次执行 `cargo build` 会自动构建 `hello_utils` 和它的所有依赖，其他包也可以使用这个crate。
但 [crates.io] 不允许发布以路径指定某个依赖的包。
如果我们想发布 `hello_world`，就必须把 `hello_utils` 发布到 [crates.io]，然后在 `hello_word` 配置中指定依赖版本:

```toml
[dependencies]
hello_utils = { path = "hello_utils", version = "0.1.0" }
```

> **注意**: [crates.io] 不允许发布带 `path` 依赖的包( `path` [dev-dependencies] 除外)。对于备用选择，参考[Multiple locations](#multiple-locations)。

### 多依赖位置

对于依赖可以同时指定注册中心依赖、 `git` 或 `path` 位置。
`git` 或 `path` 依赖项用于本地( `version` 会与本地副本进行对比)，
而要发布到一个注册中心 (比如[crates.io]) 时，使用注册中心中的版本，不允许其他组合。例如:

```toml
[dependencies]
# 在本地时会使用 `my-bitflags`
# 而上传后会使用 crates.io 中的1.0 版本
bitflags = { path = "my-bitflags", version = "1.0" }

# 在本地时会使用给定的 git 仓库
# 而上传后会使用 crates.io 中的1.0 版本
smallvec = { git = "https://github.com/servo/rust-smallvec.git", version = "1.0" }

# 如果version没有匹配，Cargo 会编译失败！
```

比如这种使用场景，当你把一个库拆分成工作空间中的多个包，
在开发阶段，可以用 `path` 指定工作空间内的本地包做为依赖，而将其发布后，就可以使用 [crates.io] 上的版本了。

### 平台特定依赖

平台特定依赖的书写格式没什么变化，但是要列在 `target` 部分。
通常使用与rust代码类似的 [`#[cfg]` 语法](../../reference/conditional-compilation.html):

```toml
[target.'cfg(windows)'.dependencies]
winhttp = "0.4.0"

[target.'cfg(unix)'.dependencies]
openssl = "1.0.1"

[target.'cfg(target_arch = "x86")'.dependencies]
native-i686 = { path = "native/i686" }

[target.'cfg(target_arch = "x86_64")'.dependencies]
native-x86_64 = { path = "native/x86_64" }
```

如同rust代码一样，语法支持 `not`、`any` 和 `all` 操作符，从而组合不同的cfg键值对。

如果你想知道自己的平台支持哪些cfg目标，可以运行 `rustc --print=cfg` 来获取。如果你想知道其他平台可用的cfg目标，可以使用 `rustc --print=cfg --target=x86_64-pc-windows-msvc`。

与rust代码不同，你不能使用 `[target.'cfg(feature = "fancy-feature")'.dependencies]` 根据特性指定依赖，而应该使用 [features](features.md)。

```toml
[dependencies]
foo = { version = "1.0", optional = true }
bar = { version = "1.0", optional = true }

[features]
fancy-feature = ["foo", "bar"]
```

 `cfg(debug_assertions)` ， `cfg(test)` 和 `cfg(proc_macro)` 也是同样的，这些值不生效。
 总是有 `rustc --print=cfg` 返回的默认值。目前，无法根据这些设置添加依赖。

除 `#[cfg]` 标志，Cargo支持直接写出target全名来指定依赖:

```toml
[target.x86_64-pc-windows-gnu.dependencies]
winhttp = "0.4.0"

[target.i686-unknown-linux-gnu.dependencies]
openssl = "1.0.1"
```


#### 为自定义目标指定依赖

如果使用自定义构建目标 (比如 `--target foo/bar.json` )，使用不含 `.json` 后缀的文件名:

```toml
[target.bar.dependencies]
winhttp = "0.4.0"

[target.my-special-i686-platform.dependencies]
openssl = "1.0.1"
native = { path = "native/i686" }
```

> **注意**: 在稳定版不支持自定义目标依赖。

### 开发依赖

你可以在 `Cargo.toml` 中添加 `[dev-dependencies]` ，格式与 `[dependencies]` 一致:

```toml
[dev-dependencies]
tempdir = "0.3"
```

在构建包时不会使用开发依赖，而是用在编译测试、示例和基准。

这些依赖不会传播给依赖此包的那些包。

你也可以为特定目标指定开发依赖，只需要把 `dependencies` 换成 `dev-denpendencies` 。

```toml
[target.'cfg(unix)'.dev-dependencies]
mio = "0.0.1"
```

> **注意**: 当发布包时，只有那些以 `version` 指定的开发依赖才会包含在发布的包中。
大部分情况下，包发布后就不需要开发依赖了，但是也有一些使用者(比如操作系统包)希望在crate中运行一些测试，所以给开发依赖提供一个 `version` 也是有好处的。

### 构建依赖

你可以在构建脚本中依赖一些使用Cargo的crate。在配置清单中指定 `build-dependencies` 来声明依赖。

```toml
[build-dependencies]
cc = "1.0.3"
```


你也可以为特定目标指定构建依赖，只需将 `dependencies` 替换为 `build-dependencies` 。例如:

```toml
[target.'cfg(unix)'.build-dependencies]
cc = "1.0.3"
```

这样，只有当主机平台满足指定目标要求时，才会构建相关依赖。

构建脚本无法使用 `dependencies` 和 `dev-dependencies` 中列出的依赖。
同样的，包也无法使用构建依赖(`build-dependencies`)，除非该依赖放在 `dependencies` 中。
一个包和它的构建脚本是各自分开编译的，因此它们的依赖项不需要相同。
Cargo通过不同目的使用各自依赖来保持简洁。

### 选择特性

如果你依赖的包提供了可选的特性(feature)，可以选择使用:

```toml
[dependencies.awesome]
version = "1.3.5"
default-features = false # 不使用默认特性
                         # 手动选择单独的特性
features = ["secure-password", "civet"]
```

关于特性的更多信息，参考 [features chapter](features.md#dependency-features)。

### 在 `Cargo.toml` 中重命名依赖

当你在 `Cargo.toml` 中添加 `[dependencies]` 时，依赖名称就是导入代码的crate名称。
但在某些项目中，可能想要用另一个名称来引用这个crate，而不是它在crates.io上的名称。比如，你想:

* 避免在代码中使用 `use foo as bar`。
* 同时使用某个crate的多个版本。
* 依赖不同注册中心同名的包。

Cargo 通过在 `[dependencies]` 加入`package` 字段来支持此功能。

```toml
[package]
name = "mypackage"
version = "0.0.1"

[dependencies]
foo = "0.1"
bar = { git = "https://github.com/example/project.git", package = "foo" }
baz = { version = "0.1", registry = "custom", package = "foo" }
```

在这个例子中，这三个crate都在代码中可用:

```rust,ignore
extern crate foo; // crates.io
extern crate bar; // git repository
extern crate baz; // registry `custom`
```

这三个crate都在自己的 `Cargo.toml` 里名为 `foo` ，所以我们用 `package` 来声明想要的是那个 `foo` 的包，即使我们会在本地用另一个别名。
如果没有指定 `package` ，则认为其名称与指定的依赖名称一致。

注意，如果你有一个可选依赖:

```toml
[dependencies]
bar = { version = "0.1", package = 'foo', optional = true }
```

你依赖的是 crates.io 上的 `foo` 包，但是你的包指定的是 `bar` 特性而不是 `foo` 特性。也就是说如果你给一个依赖改了名，特性使用的是依赖的名字，而不是包原本的名字。

传递依赖也是如此，比如我们可以把下面的条目加入清单文件:

```toml
[features]
log-debug = ['bar/log-debug'] # 用 'foo/log-debug' 会报错!
```

### 从工作空间中继承依赖

可以在工作空间的 [`[workspace.dependencies]`][workspace.dependencies] 字段指定依赖，然后在crate的 `[dependencies]` 中添加 `workspace = true` 就可以继承这个依赖。

除了 `workspace` 字段，还可以加入:
- [`optional`][optional]: 注意 `[workspace.dependencies]` 不允许使用 `optional`。
- [`features`][features]:  这是对于 `[workspace.dependencies]` 中声明的依赖的补充。

在 `optional` 和 `features` 之外，继承依赖不允许使用任何其他字段(比如 `version` 或 `default-features`)。

`[dependencies]` 、 `[dev-dependencies]` 、 `[build-dependencies]` 、 `[target."...".dependencies]` 都可以引用 `[workspace.dependencies]` 中定义的依赖。

```toml
[package]
name = "bar"
version = "0.2.0"

[dependencies]
regex = { workspace = true, features = ["unicode"] }

[build-dependencies]
cc.workspace = true

[dev-dependencies]
rand = { workspace = true, optional = true }
```


[crates.io]: https://crates.io/
[dev-dependencies]: #development-dependencies
[workspace.dependencies]: workspaces.md#the-dependencies-table
[optional]: features.md#optional-dependencies
[features]: features.md

<script>
(function() {
    var fragments = {
        "#overriding-dependencies": "overriding-dependencies.html",
        "#testing-a-bugfix": "overriding-dependencies.html#testing-a-bugfix",
        "#working-with-an-unpublished-minor-version": "overriding-dependencies.html#working-with-an-unpublished-minor-version",
        "#overriding-repository-url": "overriding-dependencies.html#overriding-repository-url",
        "#prepublishing-a-breaking-change": "overriding-dependencies.html#prepublishing-a-breaking-change",
        "#overriding-with-local-dependencies": "overriding-dependencies.html#paths-overrides",
    };
    var target = fragments[window.location.hash];
    if (target) {
        var url = window.location.toString();
        var base = url.substring(0, url.lastIndexOf('/'));
        window.location.replace(base + "/" + target);
    }
})();
</script>
