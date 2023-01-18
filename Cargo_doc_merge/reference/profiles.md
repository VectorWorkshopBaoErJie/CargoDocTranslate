## 编译配置

编译配置提供了一种修改编译器设置的方法，可以影响如性能优化和调试符号等结果。

Cargo有4种内置的编译设置： `dev` 、  `release` 、 `test`  和 `bench` 。
如果命令行中并未指定具体的编译配置，Cargo会根据当前运行的命令来自动选择编译配置。
除了内置的编译配置，也可以指定用户自定义的编译配置。

编译配置的设置可以在 `Cargo.toml` 文件中的 `[profile]` 表格中进行修改。
在每个命名的编译配置中，单独的设置可以像下面这样使用键/值对来修改：

```toml
[profile.dev]
opt-level = 1               # 使用稍微好点的优化。
overflow-checks = false     # 关闭整数溢出检查。
```

Cargo只会扫描工作空间根目录下 `Cargo.toml` 清单中的编译配置设置。
在依赖中定义的编译配置的设置将会被忽略。

除此之外，编译配置可以通过一个[config]的定义来来覆盖。
在config文件或环境变量中指定一个编译配置将会覆盖 `Cargo.toml` 中的设置。

[config]: config.md

### 编译配置的设置

下面是一系列可以在编译配置里进行控制的设置。

#### opt-level

`opt-level` 设置所控制的[ `-C opt-level` flag]控制着优化的等级。高优化等级可以用更长的编译时间换来生成更快的运行时代码。更高的优化等级同时也可能改变或者重新布局编译过的代码，使得其更难被debugger使用。

有效选项包括：

* `0` ： 无优化
* `1` ： 基础优化
* `2` ： 适量优化
* `3` ： 优化全开
* `"s"` ： 优化二进制大小
* `"z"` ： 优化二进制大小，同时关闭循环向量化

推荐为你的项目尝试试用各种不同的优化等级来找到一个合理的平衡。也许你会惊讶于有时候等级 `3` 会比等级 `2` 慢或者 `"s"` 和 `"z"` 等级没能压缩二进制大小。在开发的过程中，由于更新版本的 `rustc` 可能改变了优化的行为，也许你也会需要重新评估你的用户设置。

另请参阅[Profile Guided Optimization]了解更多的高级优化技术。

[`-C opt-level` flag]: ../../rustc/codegen-options/index.html#opt-level
[Profile Guided Optimization]: ../../rustc/profile-guided-optimization.html

#### debug

`debug` 设置所控制的[ `-C debuginfo` flag]控制着编译之后的二进制调试信息的信息量。

有效选项包括：

* `0` 或 `false`： 无任何调试信息
* `1` ： 只包含行号表
* `2` 或 `true` ： 包含完整的调试信息

也许你同时会根据你的需要想要配置 [ `split-debuginfo` ](#split-debuginfo) 这一选项。

[`-C debuginfo` flag]: ../../rustc/codegen-options/index.html#debuginfo

#### split-debuginfo

`split-debuginfo` 设置控制 [ `-C split-debuginfo` flag]，它控制调试信息(如果生成)是否放置在可执行文件本身或与其相邻。

此选项是一个字符串，可接受的值与那些相同[compiler accepts][`-C split-debuginfo` flag]。 此选项的默认值对于具有调试信息的配置文件，在 macOS 上是 `unpacked` 启用。 否则此选项的默认值是 [documented with rustc][`-C split-debuginfo` flag] 并且是特定于平台的。 有些选项只是在[nightly channel]上可用。 一旦进行再次测试，并且对DWARF的支持稳定，Cargo的默认值可能会在未来发生变化。

[nightly channel]: ../../book/appendix-07-nightly-rust.html
[`-C split-debuginfo` flag]: ../../rustc/codegen-options/index.html#split-debuginfo

#### strip

`strip` 选项控制 [ `-C strip` flag]，它告诉 rustc 从二进制文件中去除符号或调试信息。 可以像这样启用：

```toml
[package]
# ...

[profile.release]
strip = "debuginfo"
```

可能的 `strip` 字符串值包括 `"none"` 、 `"debuginfo"` 和 `"symbols"` 。默认值是 `"none"` 。

你还可以使用布尔值 `true `或 `false` 配置此选项。
`strip = true` 等同于 `strip = "symbols"` 。
`strip = false` 等同于 `strip = "none"` 并完全禁用 `strip` 。

[`-C strip` flag]: ../../rustc/codegen-options/index.html#strip

#### debug-assertions

`debug-assertions` 设置控制 [ `-C debug-assertions` flag]，它可以打开或关闭  `cfg(debug_assertions)` [conditional compilation]。 调试断言旨在包含仅在调试/开发版本可用的运行时验证。 这些对于发布版本来说可能是代价太高的东西或者不需要的。 调试断言会开启标准库中的[ `debug_assert!` macro]。

有效选项包括：

* `true` ： 开启
* `false` ： 禁用

[`-C debug-assertions` flag]: ../../rustc/codegen-options/index.html#debug-assertions
[conditional compilation]: ../../reference/conditional-compilation.md#debug_assertions
[`debug_assert!` macro]: ../../std/macro.debug_assert.html

#### overflow-checks

`overflow-checks` 设置控制[ `-C overflow-checks` flag]。它控制着[runtime integer overflow]的行为。当启用溢出检查时，溢出将发生导致系统发生严重错误，导致panic。

有效选项包括：

* `true` ： 开启
* `false` ： 禁用

[`-C overflow-checks` flag]: ../../rustc/codegen-options/index.html#overflow-checks
[runtime integer overflow]: ../../reference/expressions/operator-expr.md#overflow

#### lto

`lto` 设置控制[ `-C lto` flag]。它控制着LLVM的[link time optimizations]。LTO可以使用全程序分析，以更长的链接时间换取生成更好的优化代码。

有效选项包括：

* `false` ： 执行 "thin local LTO"，仅在本地箱子上的所有箱子上执行"thin"LTO[codegen units](#codegen-units). 如果codegen单位为1或[opt-level](#opt-level)是0，则不会进行LTO优化。
* `true` 或 `"fat"` ：执行"fat"LTO，尝试对依赖关系图中的所有crate执行优化。
* `"thin"` ：执行"thin"LTO。这与"fat"类似，但运行时间大大缩短，同时仍能获得类似于"fat"的性能提升。
* `"off"` ： 禁用 LTO。

另请参阅[ `-C linker-plugin-lto`] `rustc` 跨语言LTO标志。

[`-C lto` flag]: ../../rustc/codegen-options/index.html#lto
[link time optimizations]: https://llvm.org/docs/LinkTimeOptimization.html
[`-C linker-plugin-lto`]: ../../rustc/codegen-options/index.html#linker-plugin-lto
["thin" LTO]: http://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html

#### panic

`panic` 设置控制[ `-C panic` flag]，它控制着使用哪种panic策略。

有效选项包括：

* `"unwind"` ：panic时进行栈展开。
* `"abort"` ：panic时终止进程。

当设置为 `"unwind"` 时，实际值取决于目标平台的默认值。例如，NVPTX平台不支持栈展开，所以它总是使用 `"abort"` 。

Tests，benchmarks，build scripts 和 proc macros 会忽略 `panic` 设置。
`rust` 测试工具目前需要 `unwind` 行为。 见[ `panic-abort-tests` ] 启用 `abort` 行为的unstable flag。

此外，当使用 `abort` 策略和构建测试时，所有依赖也将强制使用 `unwind` 策略来构筑。

[`-C panic` flag]: ../../rustc/codegen-options/index.html#panic
[`panic-abort-tests`]: unstable.md#panic-abort-tests

#### incremental

`incremental` 设置控制[ `-C incremental` flag]，它控制是否启用增量编译。增量编译会使 `rustc` 将额外的信息保存到磁盘，这些额外信息在重新编译crate时可重复使用，从而缩短重新编译时间。附加信息存储在 `target` 目录中。

有效选项包括：

* `true` ： 开启
* `false` ： 禁用

增量编译仅用于工作空间成员和"path"依赖项。

增量值可以用 `CARGO_INCREMENTAL` [environment variable] 或者[ `build.incremental` ] config 变量来进行全局覆盖。

[`-C incremental` flag]: ../../rustc/codegen-options/index.html#incremental
[environment variable]: environment-variables.md
[`build.incremental`]: config.md#buildincremental

#### codegen-units

`codegen-units` 设置控制[ `-C codegen-units` flag]，它控制着一个crate会被分割到多少个"代码生成单元"。更多的代码生成单元允许并行处理更多的crate，这可能会减少编译时间，但可能会生成较慢的代码。

此选项接受大于0的整数。

默认值为256[incremental](#incremental)构建，16个用于非增量构建。

[`-C codegen-units` flag]: ../../rustc/codegen-options/index.html#codegen-units

#### rpath

`rpath` 设置控制[ `-C rpath` flag]，它控制着[ `rpath` ]是否启用。

[`-C rpath` flag]: ../../rustc/codegen-options/index.html#rpath
[`rpath`]: https://en.wikipedia.org/wiki/Rpath

### 默认编译配置

#### dev

`dev` 编译配置用于日常的开发和调试。它使构建指令如[ `cargo build` ]的默认参数，并且用于 `cargo install --debug` 。

`dev` 编译配置的默认设置有：

```toml
[profile.dev]
opt-level = 0
debug = true
split-debuginfo = '...'  # 平台指定。
debug-assertions = true
overflow-checks = true
lto = false
panic = 'unwind'
incremental = true
codegen-units = 256
rpath = false
```

#### release

`release` 编译配置旨在用于发布和生产中的优化工件。当使用 `--release` 标志时本编译配置将被使用，而且本编译配置是[ `cargo install` ]的默认设置。

`release` 编译配置的默认设置有：

```toml
[profile.release]
opt-level = 3
debug = false
split-debuginfo = '...'  # 平台指定。
debug-assertions = false
overflow-checks = false
lto = false
panic = 'unwind'
incremental = false
codegen-units = 16
rpath = false
```

#### test

`test` 编译配置是 [ `cargo test` ] 的默认编译配置。
`test` 编译配置继承了[`dev`](#dev)编译配置中的设置。

#### bench

`bench` 编译配置是 [ `cargo bench` ] 的默认编译配置。
`bench` 编译配置继承了[ `release` ](#release)编译配置中的设置。

#### 构建依赖

默认情况下，所有的编译配置都不会优化构建依赖项(build scripts,
proc macros 和它们的依赖)。构建覆盖的默认设置为：

```toml
[profile.dev.build-override]
opt-level = 0
codegen-units = 256

[profile.release.build-override]
opt-level = 0
codegen-units = 256
```

构建依赖项以其他方式继承正在使用的配置文件中的设置，如[Profile selection](#profile-selection)所描述。

### 自定义编译配置

除了内置编译配置外，还可以定义其他自定义的编译配置。在需要划分多个工作流和构建模式的时候，可能会用到自定义编译配置。在定义一个自定义的编译配置时，你必须指定一个 `inherits` 的键值，以便在设置没有指定时可以找到该自定义编译配置继承了哪个编译配置。

举例来说，假如你想将一个普通的发布构建与使用[LTO](#lto)优化的构建做比较，那么你可以像下面这样来在 `Cargo.toml` 中指定：

```toml
[profile.release-lto]
inherits = "release"
lto = true
```

这里的 `--profile` 标志可以被用来选择这个自定义编译配置：

```console
cargo build --profile release-lto
```

每个编译配置的输出将会被放在[ `target` 目录]下的一个和编译配置同名的一个文件夹下。对于上面的例子来说，编译配置产生的输出将会被放置在路径为 `target/release-lto` 文件夹下。

[`target` directory]: ../guide/build-cache.md

### 编译配置选择

编译配置的使用依赖于指令、命令行标志如 `--release` 或 `--profile` 和包(如果是[overrides](#overrides))。如果没有指定那么默认的编译配置为：

| Command | Default Profile |
|---------|-----------------|
| [`cargo run`], [`cargo build`],<br>[`cargo check`], [`cargo rustc`] | [`dev` profile](#dev) |
| [`cargo test`] | [`test` profile](#test)
| [`cargo bench`] | [`bench` profile](#bench)
| [`cargo install`] | [`release` profile](#release)

你可以使用 `--profile=NAME` 来切换到一个不同的编译配置。 `--release` 这个标志等价于 `--profile=release` 。

被选择的编译配置作用于整个Cargo的生成结果，包括 [library](./cargo-targets.md#library),
[binary](./cargo-targets.md#binaries), 
[example](./cargo-targets.md#examples), 
[test](./cargo-targets.md#tests), 
和 [benchmark](./cargo-targets.md#benchmarks)。

对于特定包的编译配置可以使用[overrides](#overrides)来指定，描述如下。

[`cargo bench`]: ../commands/cargo-bench.md
[`cargo build`]: ../commands/cargo-build.md
[`cargo check`]: ../commands/cargo-check.md
[`cargo install`]: ../commands/cargo-install.md
[`cargo run`]: ../commands/cargo-run.md
[`cargo rustc`]: ../commands/cargo-rustc.md
[`cargo test`]: ../commands/cargo-test.md

### 覆盖

编译配置的设置可以对于特定的包和构建时的crate进行覆盖。如需对一个特定的包进行覆盖设置，使用 `package` 表来更改已命名的包的编译配置：

```toml
# `foo`包会使用 -Copt-level=3 标志。
[profile.dev.package.foo]
opt-level = 3
```

包的名字实际上是一个[Package ID Spec](pkgid-spec.md)，所以你可以使用如 `[profile.dev.package."foo:2.1.0"]` 的语法定位到某个版本的包。

如需覆盖所有依赖的设置(但是并非任何工作空间的成员)，使用包名 `"*"` 。

```toml
# 为所有配置设定默认设置。
[profile.dev.package."*"]
opt-level = 2
```

如需覆盖构建脚本、过程宏和相关依赖的设置，使用 `build-override` 表：

```toml
# 为构建脚本和过程宏设置配置。
[profile.dev.build-override]
opt-level = 3
```

> 注意：当一个依赖既是一个普通依赖而且是一个构建依赖时， 
> 如果 `--target` 没有被指定，Cargo 将会试图只构建一次。
> 当使用 `build-override` 时，依赖可能需要构建两次， 一次作为正常依赖项，一次使用覆盖的生成设置。这可能会增加初始构建的时间。

使用值的优先顺序如下(先匹配到的胜出)：

1. `[profile.dev.package.name]` — 一个命名的包。
2. `[profile.dev.package."*"]` — 对于任何非工作空间成员。
3. `[profile.dev.build-override]` — 仅适用于构建脚本、过程宏及其依赖项。
4. `[profile.dev]` — `Cargo.toml`中的设置。
5. Cargo中内置的默认值。

覆盖不能指定 `panic` 、 `lto` 或 `rpath` 设置。

#### 覆盖和泛型

实例化泛型代码的位置将会影响用于该泛型代码的优化配置。当使用编译配置覆盖去更改特定crate的优化级别时，这可能会导致微妙的影响。如果试图提高定义泛型函数的依赖项的优化级别，在本地crate中使用这些泛型函数时可能无法进行优化。这是因为代码可能会在其实例化的crate中生成，因此可能会使用该crate的优化设置。

举例来说，[nalgebra]是一个定义向量和矩阵的库，并且大量使用了泛型参数。如果你的本地代码定义了具体的nalgebra类型，比如 `Vector4<f64>` 并使用他们的方法，相应的nalgebra代码将被实例化并构建在你的crate中。因此，如果你试图使用覆盖编译配置来提高nalgebra的优化等级的话，可能并不会带来更快的性能。

更复杂的是， `rustc` 有一些优化尝试在crate之间共享单态化的泛型。如果优化等级是2或3，那么crate将不会使用其他crate中的单态化的泛型，也不会导出本地定义的与其他crate共享的单态化内容。

[nalgebra]: https://crates.io/crates/nalgebra
