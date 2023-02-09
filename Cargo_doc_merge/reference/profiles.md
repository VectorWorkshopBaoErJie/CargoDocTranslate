## 编译设置

Profile "编译设置" 提供了一种修改编译器设置的方法，从而影响代码优化和调试符号等。

Cargo 内置的编译设置有4种： `dev` 、  `release` 、 `test`  和 `bench` 。
如果命令行中并未指定具体的编译设置，Cargo会根据当前运行的命令来自动选择。
除了内置，用户也可以自定义。

编译设置可以在 `Cargo.toml` 文件 `[profile]` 表中进行修改。
具体某个名称的编译设置中，单独的设置条目可以用键值对来修改：

```toml
[profile.dev]
opt-level = 1               # 使用较好的优化级别。
overflow-checks = false     # 关闭整数溢出检查。
```

Cargo只会扫描工作空间根目录下 `Cargo.toml` 配置清单中的编译设置。
在依赖中定义的编译设置会被忽略。

此外，可以通过 [config] 的定义来覆盖编译设置。
在config文件或环境变量中指定编译设置将会覆盖 `Cargo.toml` 中的。

[config]: config.md

### 编译设置条目

下面是可以在编译设置中进行控制的设置条目列表。

#### opt-level

`opt-level` 设置控制 [`-C opt-level` flag] 优化级别。高优化级别通过更长的编译时间换来生成后更快的运行时代码。
更高的优化级别同时也可能改变或者重新布局编译过的代码，从而更难调试。

有效选项：

* `0` ： 无优化
* `1` ： 基础优化
* `2` ： 适量优化
* `3` ： 优化全开
* `"s"` ： 优化二进制大小
* `"z"` ： 优化二进制大小，同时关闭循环向量化

建议你的项目尝试用不同的优化级别，从而找到合理的平衡。也许你有时会惊讶级别 `3` 会比级别 `2` 慢，或者 `"s"` 和 `"z"` 级别未能压缩二进制的大小。
在开发的过程中，由于 `rustc` 版本更新可能改变了优化行为，也许你也需要重新评估设置。

另请参阅[Profile Guided Optimization]了解更多的高级优化技巧。

[`-C opt-level` flag]: ../../rustc/codegen-options/index.html#opt-level
[Profile Guided Optimization]: ../../rustc/profile-guided-optimization.html

#### debug

`debug` 设置控制 [ `-C debuginfo` flag] 编译后的二进制调试的信息量。

有效选项：

* `0` 或 `false`： 无调试信息
* `1` ： 只包含行号表
* `2` 或 `true` ： 包含完整的调试信息

也许根据需要，同时配置 [`split-debuginfo`](#split-debuginfo) 选项。

[`-C debuginfo` flag]: ../../rustc/codegen-options/index.html#debuginfo

#### split-debuginfo

`split-debuginfo` 设置控制 [`-C split-debuginfo` flag] 调试信息，如果产生的话，是放在可执行文件本身，还是放在其旁边。

这个选项是字符串，可接受的值与[编译器接受的][`-C split-debuginfo` flag]相同。
在macOS上，这个选项的默认值是 `unpacked` ，用于已启用调试信息的编译设置。
否则，这个选项的默认值是 [rustc文档][`-C split-debuginfo` flag]，并且是特定平台的。
有些选项只在 [每日构建通道][nightly channel] 中可用。
一旦进行了更多的测试，并且对DWARF的支持稳定下来，Cargo的默认值可能会在未来发生变化。

[nightly channel]: ../../book/appendix-07-nightly-rust.html
[`-C split-debuginfo` flag]: ../../rustc/codegen-options/index.html#split-debuginfo

#### strip

`strip` 选项控制 [ `-C strip` flag] 从而告知 rustc 从二进制文件中去除符号或调试信息。可以像这样启用:

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

`debug-assertions` 设置控制 [ `-C debug-assertions` flag] ，从而可以打开或关闭 `cfg(debug_assertions)` [conditional compilation] "条件编译"。
调试断言旨在包含仅在调试或开发版本可用的运行时验证。这些对于发布版本来说可能消耗过高或者并不需要。调试断言会开启标准库中的 [`debug_assert!` macro] 。

有效选项：

* `true` ： 开启
* `false` ： 禁用

[`-C debug-assertions` flag]: ../../rustc/codegen-options/index.html#debug-assertions
[conditional compilation]: ../../reference/conditional-compilation.md#debug_assertions
[`debug_assert!` macro]: ../../std/macro.debug_assert.html

#### overflow-checks

`overflow-checks` 设置控制[ `-C overflow-checks` flag] ，控制 [runtime integer overflow] 的行为。当启用溢出检查时，溢出将导致系统发生严重错误，从而panic恐慌。

有效选项：

* `true` ： 开启
* `false` ： 禁用

[`-C overflow-checks` flag]: ../../rustc/codegen-options/index.html#overflow-checks
[runtime integer overflow]: ../../reference/expressions/operator-expr.md#overflow

#### lto

`lto` 设置控制 [`-C lto` flag]，控制LLVM [link time optimizations] "链接时优化"。
LTO可以使用全过程分析，以更长的链接时间换取生成更好的优化后的代码。

有效选项：

* `false` ： 执行 "thin local LTO"，仅在本地的所有crate上执行 "thin" LTO[codegen units](#codegen-units)。如果codegen单位为1或[opt-level](#opt-level)是0，则不会进行LTO优化。
* `true` 或 `"fat"` ：执行 "fat" LTO，尝试对依赖图中的所有crate执行优化。
* `"thin"` ：执行 "thin" LTO。这与 "fat" 类似，但运行时间缩短，同时仍能获得类似于 "fat" 的性能提升。
* `"off"` ： 禁用 LTO。

另请参阅[ `-C linker-plugin-lto`] `rustc` 跨语言LTO标志。

[`-C lto` flag]: ../../rustc/codegen-options/index.html#lto
[link time optimizations]: https://llvm.org/docs/LinkTimeOptimization.html
[`-C linker-plugin-lto`]: ../../rustc/codegen-options/index.html#linker-plugin-lto
["thin" LTO]: http://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html

#### panic

`panic` 设置控制 [ `-C panic` flag] ，控制使用哪种恐慌策略。

有效选项：

* `"unwind"` ：panic时进行栈解旋。
* `"abort"` ：panic时终止进程。

当设置为 `"unwind"` 时，实际值取决于目标平台的默认值。例如，NVPTX平台不支持栈解旋，所以它总是使用 `"abort"` 。

测试、性能测试、构建脚本、过程宏会忽略 `panic` 设置。
`rust` 测试工具目前需要 `unwind` 行为。 见 [`panic-abort-tests`] 未稳定的标志启用 `abort` 行为。

此外，当使用 `abort` 策略和构建测试时，所有依赖也将强制使用 `unwind` 策略来构建。

[`-C panic` flag]: ../../rustc/codegen-options/index.html#panic
[`panic-abort-tests`]: unstable.md#panic-abort-tests

#### incremental

`incremental` 设置控制[ `-C incremental` flag]，控制是否启用增量编译。
增量编译会使 `rustc` 将额外的信息保存到磁盘，这些额外信息在重新编译crate时可重复使用，从而缩短重新编译时间。附加信息存储在 `target` 目录中。

有效选项：

* `true` ： 开启
* `false` ： 禁用

增量编译仅用于工作空间成员和 "path" 依赖。

增量值可以用 `CARGO_INCREMENTAL` [environment variable] 或者 [ `build.incremental` ] config 变量来进行全局覆盖。

[`-C incremental` flag]: ../../rustc/codegen-options/index.html#incremental
[environment variable]: environment-variables.md
[`build.incremental`]: config.md#buildincremental

#### codegen-units

`codegen-units` 设置控制[ `-C codegen-units` flag]，控制着crate分割到多少个"代码生成单元"。
更多的代码生成单元允许并行处理更多的crate，这可能会减少编译时间，但可能会生成较慢的代码。

此选项接受大于0的整数。

默认值为256 [incremental](#incremental)构建 ，16用于非增量构建。

[`-C codegen-units` flag]: ../../rustc/codegen-options/index.html#codegen-units

#### rpath

`rpath` 设置控制[ `-C rpath` flag]，控制是否启用 [ `rpath` ] 。

[`-C rpath` flag]: ../../rustc/codegen-options/index.html#rpath
[`rpath`]: https://en.wikipedia.org/wiki/Rpath

### 默认编译设置

#### dev

`dev` 编译设置用于日常的开发和调试。它是构建指令如[ `cargo build` ]的默认参数，并且用于 `cargo install --debug` 。

`dev` 编译设置的默认设置有：

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

`release` 编译设置旨在发布和产生优化后的制品，当使用 `--release` 标志时启用，是[ `cargo install` ]的默认设置。

`release` 编译设置的默认条目有：

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

`test` 编译设置是 [`cargo test`] 的默认配置。
`test` 编译设置继承了 [`dev`](#dev) 编译设置项。

#### bench

`bench` 编译配置是 [ `cargo bench` ] 的默认编译配置。
`bench` 编译配置继承了[ `release` ](#release)编译配置中的设置。

#### 构建依赖

默认情况下，所有的编译设置都不会优化构建依赖(构建脚本、过程宏、它们的依赖)。构建覆盖的默认设置为：

```toml
[profile.dev.build-override]
opt-level = 0
codegen-units = 256

[profile.release.build-override]
opt-level = 0
codegen-units = 256
```

构建依赖项以其他方式继承正在使用的编译设置条目，如[Profile selection](#profile-selection)所描述。

### 自定义编译设置

除了内置编译设置，还可以自定义。在需要划分多个工作流和构建模式时，可能会用到自定义编译设置。
在自定义编译设置时，必须指定 `inherits` 键，以便在条目没有指定时，可以找到自定义继承了的哪个编译设置。

举例来说，假如你想将一个普通的发布构建与使用[LTO](#lto)优化的构建做比较，那么可以如下在 `Cargo.toml` 指定：

```toml
[profile.release-lto]
inherits = "release"
lto = true
```

`--profile` 标志可用来选择自定义编译设置：

```console
cargo build --profile release-lto
```

每个编译设置的输出会放在[`target` directory]下和编译设置同名的文件夹下。对于上面的例子来说，编译设置产生的输出会放置在路径为 `target/release-lto` 文件夹下。

[`target` directory]: ../guide/build-cache.md

### 编译设置选择

编译设置的使用依赖于指令、命令行标志如 `--release` 或 `--profile` 和包(比如[overrides](#overrides))。如果未指定那么默认的编译设置为：

| Command | Default Profile |
|---------|-----------------|
| [`cargo run`], [`cargo build`],<br>[`cargo check`], [`cargo rustc`] | [`dev` profile](#dev) |
| [`cargo test`] | [`test` profile](#test)
| [`cargo bench`] | [`bench` profile](#bench)
| [`cargo install`] | [`release` profile](#release)

可以使用 `--profile=NAME` 来切换到不同的编译设置。 `--release` 标志等价于 `--profile=release` 。

选择的编译设置作用于Cargo所有的生成目标，包括 [library](./cargo-targets.md#library),
[binary](./cargo-targets.md#binaries), 
[example](./cargo-targets.md#examples), 
[test](./cargo-targets.md#tests), 
[benchmark](./cargo-targets.md#benchmarks)。

对于特定包的编译设置可以使用[overrides](#overrides)来指定，描述如下。

[`cargo bench`]: ../commands/cargo-bench.md
[`cargo build`]: ../commands/cargo-build.md
[`cargo check`]: ../commands/cargo-check.md
[`cargo install`]: ../commands/cargo-install.md
[`cargo run`]: ../commands/cargo-run.md
[`cargo rustc`]: ../commands/cargo-rustc.md
[`cargo test`]: ../commands/cargo-test.md

### 覆盖

编译设置可对特定包和构建时的crate进行覆盖。如需对特定的包进行覆盖，使用 `package` 表来更改已命名的包的编译设置：

```toml
# `foo` 包会使用 -Copt-level=3 标志。
[profile.dev.package.foo]
opt-level = 3
```

包的名字实际为[Package ID Spec](pkgid-spec.md)，所以可以使用如 `[profile.dev.package."foo:2.1.0"]` 的语法定位到某个版本的包。

如需覆盖所有依赖的设置(但是并非任意工作空间的成员)，使用 `"*"` 包名 :

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

> 注意：当依赖既是普通依赖而且是构建依赖时， 
> 如果 `--target` 未指定，Cargo 会试图只构建一次。
> 当使用 `build-override` 时，依赖可能需要构建两次， 一次作为正常依赖项，一次使用覆盖的构建设置。这可能会增加初始构建的时间。

使用值的优先顺序如下(先匹配到的优先)：

1. `[profile.dev.package.name]` — 命名的包。
2. `[profile.dev.package."*"]` — 对于任何非工作空间成员。
3. `[profile.dev.build-override]` — 仅适用于构建脚本、过程宏及其依赖项。
4. `[profile.dev]` — `Cargo.toml` 中的设置。
5. Cargo中内置的默认值。

覆盖不能指定 `panic` 、 `lto` 、 `rpath` 设置。

#### 覆盖和泛型

实例化泛型代码的位置会影响用于该泛型代码的优化配置。
当使用编译配置覆盖去更改特定crate的优化级别时，这可能会导致微妙的影响。
如果试图提高定义泛型函数依赖的优化级别，在本地crate中使用这些泛型函数时可能无法进行优化。
这是因为代码可能会在其实例化的crate中生成，因而可能会使用该crate的优化设置。

举例来说， [nalgebra] 是一个定义向量和矩阵的库，并且大量使用了泛型参数。
如果你的本地代码定义了具体的nalgebra类型，比如 `Vector4<f64>` 并使用他们的方法，相应的nalgebra代码将被实例化并构建在你的crate中。
因此，如果你试图使用覆盖编译配置来提高nalgebra的优化级别的话，可能并不会带来更快的性能。

更复杂的是， `rustc` 有一些优化尝试在crate之间共享单态化的泛型。如果优化级别是2或3，
那么crate将不会使用其他crate中单态化的泛型，也不会导出本地定义的与其他crate共享的单态化内容。

[nalgebra]: https://crates.io/crates/nalgebra
