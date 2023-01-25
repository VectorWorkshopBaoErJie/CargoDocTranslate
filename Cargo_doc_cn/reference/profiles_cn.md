{==+==}
## Profiles
{==+==}
## 编译设置
{==+==}


{==+==}
Profiles provide a way to alter the compiler settings, influencing things like
optimizations and debugging symbols.
{==+==}
编译设置提供了一种修改编译器设置的方法，从而影响性能优化和调试符号等。
{==+==}

{==+==}
Cargo has 4 built-in profiles: `dev`, `release`, `test`, and `bench`. The
profile is automatically chosen based on which command is being run if a
profile is not specified on the command-line. In addition to the built-in
profiles, custom user-defined profiles can also be specified.
{==+==}
Cargo有4种内置的编译设置： `dev` 、  `release` 、 `test`  和 `bench` 。
如果命令行中并未指定具体的编译配置，Cargo会根据当前运行的命令来自动选择。
除了内置，用户也可以自定义。
{==+==}

{==+==}
Profile settings can be changed in [`Cargo.toml`](manifest.md) with the
`[profile]` table. Within each named profile, individual settings can be changed
with key/value pairs like this:
{==+==}
编译设置可以在 `Cargo.toml` 文件中 `[profile]` 表中进行修改。
具体名称的编译设置中，单独的设置条目可以用键值对来修改：
{==+==}

{==+==}
```toml
[profile.dev]
opt-level = 1               # Use slightly better optimizations.
overflow-checks = false     # Disable integer overflow checks.
```
{==+==}
```toml
[profile.dev]
opt-level = 1               # 使用较好的优化级别。
overflow-checks = false     # 关闭整数溢出检查。
```
{==+==}

{==+==}
Cargo only looks at the profile settings in the `Cargo.toml` manifest at the
root of the workspace. Profile settings defined in dependencies will be
ignored.
{==+==}
Cargo只会扫描工作空间根目录下 `Cargo.toml` 配置清单中的编译设置。
在依赖中定义的编译设置会被忽略。
{==+==}

{==+==}
Additionally, profiles can be overridden from a [config] definition.
Specifying a profile in a config file or environment variable will override
the settings from `Cargo.toml`.
{==+==}
此外，可以通过[config]的定义来覆盖编译设置。
在config文件或环境变量中指定编译设置将会覆盖 `Cargo.toml` 中的。
{==+==}


{==+==}
[config]: config.md
{==+==}

{==+==}


{==+==}
### Profile settings
{==+==}
### 编译设置
{==+==}

{==+==}
The following is a list of settings that can be controlled in a profile.
{==+==}
下面是可以在编译设置中进行控制的设置条目列表。
{==+==}

{==+==}
#### opt-level
{==+==}

{==+==}

{==+==}
The `opt-level` setting controls the [`-C opt-level` flag] which controls the level
of optimization. Higher optimization levels may produce faster runtime code at
the expense of longer compiler times. Higher levels may also change and
rearrange the compiled code which may make it harder to use with a debugger.
{==+==}
`opt-level` 设置控制 [`-C opt-level` flag] 优化级别。高优化级别通过更长的编译时间换来生成后更快的运行时代码。更高的优化级别同时也可能改变或者重新布局编译过的代码，从而更难调试。
{==+==}

{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}

{==+==}
* `0`: no optimizations
* `1`: basic optimizations
* `2`: some optimizations
* `3`: all optimizations
* `"s"`: optimize for binary size
* `"z"`: optimize for binary size, but also turn off loop vectorization.
{==+==}
* `0` ： 无优化
* `1` ： 基础优化
* `2` ： 适量优化
* `3` ： 优化全开
* `"s"` ： 优化二进制大小
* `"z"` ： 优化二进制大小，同时关闭循环向量化
{==+==}

{==+==}
It is recommended to experiment with different levels to find the right
balance for your project. There may be surprising results, such as level `3`
being slower than `2`, or the `"s"` and `"z"` levels not being necessarily
smaller. You may also want to reevaluate your settings over time as newer
versions of `rustc` changes optimization behavior.
{==+==}
建议你的项目尝试用不同的优化级别，从而找到合理的平衡。也许你有时会惊讶级别 `3` 会比级别 `2` 慢，或者 `"s"` 和 `"z"` 级别未能压缩二进制的大小。在开发的过程中，由于 `rustc` 版本更新可能改变了优化行为，也许你也需要重新评估设置。
{==+==}

{==+==}
See also [Profile Guided Optimization] for more advanced optimization
techniques.
{==+==}
另请参阅[Profile Guided Optimization]了解更多的高级优化技巧。
{==+==}

{==+==}
[`-C opt-level` flag]: ../../rustc/codegen-options/index.html#opt-level
[Profile Guided Optimization]: ../../rustc/profile-guided-optimization.html
{==+==}

{==+==}

{==+==}
#### debug

The `debug` setting controls the [`-C debuginfo` flag] which controls the
amount of debug information included in the compiled binary.
{==+==}
#### debug

`debug` 设置控制 [ `-C debuginfo` flag] 编译后的二进制调试的信息量。
{==+==}

{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}

{==+==}
* `0` or `false`: no debug info at all
* `1`: line tables only
* `2` or `true`: full debug info
{==+==}
* `0` 或 `false`： 无调试信息
* `1` ： 只包含行号表
* `2` 或 `true` ： 包含完整的调试信息
{==+==}

{==+==}
You may wish to also configure the [`split-debuginfo`](#split-debuginfo) option
depending on your needs as well.
{==+==}
也许根据需要，你同时会配置 [`split-debuginfo`](#split-debuginfo) 选项。
{==+==}

{==+==}
[`-C debuginfo` flag]: ../../rustc/codegen-options/index.html#debuginfo
{==+==}

{==+==}

{==+==}
#### split-debuginfo
{==+==}

{==+==}

{==+==}
The `split-debuginfo` setting controls the [`-C split-debuginfo` flag] which
controls whether debug information, if generated, is either placed in the
executable itself or adjacent to it.
{==+==}
`split-debuginfo` 设置控制 [`-C split-debuginfo` flag] 调试信息，如果产生的话，是放在可执行文件本身，还是放在其旁边。
{==+==}

{==+==}
This option is a string and acceptable values are the same as those the
[compiler accepts][`-C split-debuginfo` flag]. The default value for this option
is `unpacked` on macOS for profiles that have debug information otherwise
enabled. Otherwise the default for this option is [documented with rustc][`-C
split-debuginfo` flag] and is platform-specific. Some options are only
available on the [nightly channel]. The Cargo default may change in the future
once more testing has been performed, and support for DWARF is stabilized.
{==+==}
这个选项是字符串，可接受的值与[编译器接受的][`-C split-debuginfo` flag]相同。
在macOS上，这个选项的默认值是 `unpacked` ，用于已启用调试信息的编译设置。
否则，这个选项的默认值是 [rustc文档][`-C split-debuginfo` flag]，并且是特定平台的。
有些选项只在 [nightly channel] 中可用。
一旦进行了更多的测试，并且对DWARF的支持稳定下来，Cargo的默认值可能会在未来发生变化。
{==+==}


{==+==}
[nightly channel]: ../../book/appendix-07-nightly-rust.html
[`-C split-debuginfo` flag]: ../../rustc/codegen-options/index.html#split-debuginfo
{==+==}

{==+==}


{==+==}
#### strip
{==+==}

{==+==}


{==+==}
The `strip` option controls the [`-C strip` flag], which directs rustc to
strip either symbols or debuginfo from a binary. This can be enabled like so:
{==+==}
`strip` 选项控制 [ `-C strip` flag] 从而告知 rustc 从二进制文件中去除符号或调试信息。可以像这样启用：
{==+==}

{==+==}
```toml
[package]
# ...

[profile.release]
strip = "debuginfo"
```
{==+==}

{==+==}

{==+==}
Possible string values of `strip` are `"none"`, `"debuginfo"`, and `"symbols"`.
The default is `"none"`.
{==+==}
可能的 `strip` 字符串值包括 `"none"` 、 `"debuginfo"` 和 `"symbols"` 。默认值是 `"none"` 。
{==+==}

{==+==}
You can also configure this option with the boolean values `true` or `false`.
`strip = true` is equivalent to `strip = "symbols"`. `strip = false` is
equivalent to `strip = "none"` and disables `strip` completely.
{==+==}
你还可以使用布尔值 `true `或 `false` 配置此选项。
`strip = true` 等同于 `strip = "symbols"` 。
`strip = false` 等同于 `strip = "none"` 并完全禁用 `strip` 。
{==+==}


{==+==}
[`-C strip` flag]: ../../rustc/codegen-options/index.html#strip
{==+==}

{==+==}


{==+==}
#### debug-assertions
{==+==}

{==+==}


{==+==}
The `debug-assertions` setting controls the [`-C debug-assertions` flag] which
turns `cfg(debug_assertions)` [conditional compilation] on or off. Debug
assertions are intended to include runtime validation which is only available
in debug/development builds. These may be things that are too expensive or
otherwise undesirable in a release build. Debug assertions enables the
[`debug_assert!` macro] in the standard library.
{==+==}
`debug-assertions` 设置控制 [ `-C debug-assertions` flag] ，从而可以打开或关闭  `cfg(debug_assertions)` [conditional compilation] "条件编译"。
调试断言旨在包含仅在调试或开发版本可用的运行时验证。这些对于发布版本来说可能消耗过高或者并不需要。调试断言会开启标准库中的 [`debug_assert!` macro] 。
{==+==}

{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}

{==+==}
* `true`: enabled
* `false`: disabled
{==+==}
* `true` ： 开启
* `false` ： 禁用
{==+==}

{==+==}
[`-C debug-assertions` flag]: ../../rustc/codegen-options/index.html#debug-assertions
[conditional compilation]: ../../reference/conditional-compilation.md#debug_assertions
[`debug_assert!` macro]: ../../std/macro.debug_assert.html
{==+==}

{==+==}


{==+==}
#### overflow-checks
{==+==}

{==+==}


{==+==}
The `overflow-checks` setting controls the [`-C overflow-checks` flag] which
controls the behavior of [runtime integer overflow]. When overflow-checks are
enabled, a panic will occur on overflow.
{==+==}
`overflow-checks` 设置控制[ `-C overflow-checks` flag] ，控制 [runtime integer overflow] 的行为。当启用溢出检查时，溢出发生将导致系统发生严重错误，而panic恐慌。
{==+==}


{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}


{==+==}
* `true`: enabled
* `false`: disabled
{==+==}
* `true` ： 开启
* `false` ： 禁用
{==+==}

{==+==}
[`-C overflow-checks` flag]: ../../rustc/codegen-options/index.html#overflow-checks
[runtime integer overflow]: ../../reference/expressions/operator-expr.md#overflow
{==+==}

{==+==}

{==+==}
#### lto
{==+==}

{==+==}

{==+==}
The `lto` setting controls the [`-C lto` flag] which controls LLVM's [link
time optimizations]. LTO can produce better optimized code, using
whole-program analysis, at the cost of longer linking time.
{==+==}
`lto` 设置控制 [`-C lto` flag]，控制LLVM [link time optimizations] "链接时优化"。
LTO可以使用全程序分析，以更长的链接时间换取生成更好的优化后的代码。
{==+==}

{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}

{==+==}
* `false`: Performs "thin local LTO" which performs "thin" LTO on the local
  crate only across its [codegen units](#codegen-units). No LTO is performed
  if codegen units is 1 or [opt-level](#opt-level) is 0.
* `true` or `"fat"`: Performs "fat" LTO which attempts to perform
  optimizations across all crates within the dependency graph.
* `"thin"`: Performs ["thin" LTO]. This is similar to "fat", but takes
  substantially less time to run while still achieving performance gains
  similar to "fat".
* `"off"`: Disables LTO.
{==+==}
* `false` ： 执行 "thin local LTO"，仅在本地的所有crate上执行 "thin" LTO[codegen units](#codegen-units)。如果codegen单位为1或[opt-level](#opt-level)是0，则不会进行LTO优化。
* `true` 或 `"fat"` ：执行 "fat" LTO，尝试对依赖图中的所有crate执行优化。
* `"thin"` ：执行 "thin" LTO。这与 "fat" 类似，但运行时间缩短，同时仍能获得类似于 "fat" 的性能提升。
* `"off"` ： 禁用 LTO。
{==+==}

{==+==}
See also the [`-C linker-plugin-lto`] `rustc` flag for cross-language LTO.
{==+==}
另请参阅[ `-C linker-plugin-lto`] `rustc` 跨语言LTO标志。
{==+==}

{==+==}
[`-C lto` flag]: ../../rustc/codegen-options/index.html#lto
[link time optimizations]: https://llvm.org/docs/LinkTimeOptimization.html
[`-C linker-plugin-lto`]: ../../rustc/codegen-options/index.html#linker-plugin-lto
["thin" LTO]: http://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html
{==+==}

{==+==}


{==+==}
#### panic
{==+==}

{==+==}


{==+==}
The `panic` setting controls the [`-C panic` flag] which controls which panic
strategy to use.
{==+==}
`panic` 设置控制 [ `-C panic` flag] ，控制使用哪种恐慌策略。
{==+==}


{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}


{==+==}
* `"unwind"`: Unwind the stack upon panic.
* `"abort"`: Terminate the process upon panic.
{==+==}
* `"unwind"` ：panic时进行栈展开。
* `"abort"` ：panic时终止进程。
{==+==}

{==+==}
When set to `"unwind"`, the actual value depends on the default of the target
platform. For example, the NVPTX platform does not support unwinding, so it
always uses `"abort"`.
{==+==}
当设置为 `"unwind"` 时，实际值取决于目标平台的默认值。例如，NVPTX平台不支持栈展开，所以它总是使用 `"abort"` 。
{==+==}

{==+==}
Tests, benchmarks, build scripts, and proc macros ignore the `panic` setting.
The `rustc` test harness currently requires `unwind` behavior. See the
[`panic-abort-tests`] unstable flag which enables `abort` behavior.
{==+==}
测试、基准、构建脚本、过程宏会忽略 `panic` 设置。
`rust` 测试工具目前需要 `unwind` 行为。 见 [`panic-abort-tests`] 未稳定的标志启用 `abort` 行为。
{==+==}

{==+==}
Additionally, when using the `abort` strategy and building a test, all of the
dependencies will also be forced to build with the `unwind` strategy.
{==+==}
此外，当使用 `abort` 策略和构建测试时，所有依赖也将强制使用 `unwind` 策略来构建。
{==+==}


{==+==}
[`-C panic` flag]: ../../rustc/codegen-options/index.html#panic
[`panic-abort-tests`]: unstable.md#panic-abort-tests
{==+==}

{==+==}


{==+==}
#### incremental
{==+==}

{==+==}


{==+==}
The `incremental` setting controls the [`-C incremental` flag] which controls
whether or not incremental compilation is enabled. Incremental compilation
causes `rustc` to save additional information to disk which will be reused
when recompiling the crate, improving re-compile times. The additional
information is stored in the `target` directory.
{==+==}
`incremental` 设置控制[ `-C incremental` flag]，控制是否启用增量编译。
增量编译会使 `rustc` 将额外的信息保存到磁盘，这些额外信息在重新编译crate时可重复使用，从而缩短重新编译时间。附加信息存储在 `target` 目录中。
{==+==}


{==+==}
The valid options are:
{==+==}
有效选项：
{==+==}


{==+==}
* `true`: enabled
* `false`: disabled
{==+==}
* `true` ：开启
* `false` ：禁用
{==+==}

{==+==}
Incremental compilation is only used for workspace members and "path"
dependencies.
{==+==}
增量编译仅用于工作空间成员和 "path" 依赖。
{==+==}

{==+==}
The incremental value can be overridden globally with the `CARGO_INCREMENTAL`
[environment variable] or the [`build.incremental`] config variable.
{==+==}
增量值可以用 `CARGO_INCREMENTAL` [environment variable] 或者 [ `build.incremental` ] config 变量来进行全局覆盖。
{==+==}


{==+==}
[`-C incremental` flag]: ../../rustc/codegen-options/index.html#incremental
[environment variable]: environment-variables.md
[`build.incremental`]: config.md#buildincremental
{==+==}

{==+==}


{==+==}
#### codegen-units
{==+==}

{==+==}


{==+==}
The `codegen-units` setting controls the [`-C codegen-units` flag] which
controls how many "code generation units" a crate will be split into. More
code generation units allows more of a crate to be processed in parallel
possibly reducing compile time, but may produce slower code.
{==+==}
`codegen-units` 设置控制[ `-C codegen-units` flag]，控制着crate分割到多少个"代码生成单元"。
更多的代码生成单元允许并行处理更多的crate，这可能会减少编译时间，但可能会生成较慢的代码。
{==+==}

{==+==}
This option takes an integer greater than 0.
{==+==}
此选项接受大于0的整数。
{==+==}

{==+==}
The default is 256 for [incremental](#incremental) builds, and 16 for
non-incremental builds.
{==+==}
默认值为256 [incremental](#incremental)构建 ，16用于非增量构建。
{==+==}


{==+==}
[`-C codegen-units` flag]: ../../rustc/codegen-options/index.html#codegen-units
{==+==}

{==+==}


{==+==}
#### rpath
{==+==}

{==+==}


{==+==}
The `rpath` setting controls the [`-C rpath` flag] which controls
whether or not [`rpath`] is enabled.
{==+==}
`rpath` 设置控制[ `-C rpath` flag]，控制是否启用 [ `rpath` ] 。
{==+==}


{==+==}
[`-C rpath` flag]: ../../rustc/codegen-options/index.html#rpath
[`rpath`]: https://en.wikipedia.org/wiki/Rpath
{==+==}

{==+==}

{==+==}
### Default profiles
{==+==}
### 默认编译设置
{==+==}


{==+==}
#### dev
{==+==}

{==+==}


{==+==}
The `dev` profile is used for normal development and debugging. It is the
default for build commands like [`cargo build`], and is used for `cargo install --debug`.
{==+==}
`dev` 编译设置用于日常的开发和调试。它是构建指令如[ `cargo build` ]的默认参数，并且用于 `cargo install --debug` 。
{==+==}


{==+==}
The default settings for the `dev` profile are:
{==+==}
`dev` 编译设置的默认设置有：
{==+==}


{==+==}
```toml
[profile.dev]
opt-level = 0
debug = true
split-debuginfo = '...'  # Platform-specific.
debug-assertions = true
overflow-checks = true
lto = false
panic = 'unwind'
incremental = true
codegen-units = 256
rpath = false
```
{==+==}
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
{==+==}

{==+==}
#### release
{==+==}

{==+==}


{==+==}
The `release` profile is intended for optimized artifacts used for releases
and in production. This profile is used when the `--release` flag is used, and
is the default for [`cargo install`].
{==+==}
`release` 编译设置旨在发布和产生优化后的制品，当使用 `--release` 标志时启用，是[ `cargo install` ]的默认设置。
{==+==}


{==+==}
The default settings for the `release` profile are:
{==+==}
`release` 编译设置的默认条目有：
{==+==}

{==+==}
```toml
[profile.release]
opt-level = 3
debug = false
split-debuginfo = '...'  # Platform-specific.
debug-assertions = false
overflow-checks = false
lto = false
panic = 'unwind'
incremental = false
codegen-units = 16
rpath = false
```
{==+==}
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
{==+==}

{==+==}
#### test
{==+==}

{==+==}

{==+==}
The `test` profile is the default profile used by [`cargo test`].
The `test` profile inherits the settings from the [`dev`](#dev) profile.
{==+==}
`test` 编译设置是 [`cargo test`] 的默认配置。
`test` 编译设置继承了 [`dev`](#dev) 编译设置项。
{==+==}

{==+==}
#### bench
{==+==}

{==+==}


{==+==}
The `bench` profile is the default profile used by [`cargo bench`].
The `bench` profile inherits the settings from the [`release`](#release) profile.
{==+==}
`bench` 编译配置是 [ `cargo bench` ] 的默认编译配置。
`bench` 编译配置继承了[ `release` ](#release)编译配置中的设置。
{==+==}


{==+==}
#### Build Dependencies
{==+==}
#### 构建依赖
{==+==}

{==+==}
All profiles, by default, do not optimize build dependencies (build scripts,
proc macros, and their dependencies). The default settings for build overrides
are:
{==+==}
默认情况下，所有的编译设置都不会优化构建依赖(构建脚本、过程宏、它们的依赖)。构建覆盖的默认设置为：
{==+==}


{==+==}
```toml
[profile.dev.build-override]
opt-level = 0
codegen-units = 256

[profile.release.build-override]
opt-level = 0
codegen-units = 256
```
{==+==}

{==+==}


{==+==}
Build dependencies otherwise inherit settings from the active profile in use, as
described in [Profile selection](#profile-selection).
{==+==}
构建依赖项以其他方式继承正在使用的编译设置条目，如[Profile selection](#profile-selection)所描述。
{==+==}


{==+==}
### Custom profiles
{==+==}
### 自定义编译设置
{==+==}

{==+==}
In addition to the built-in profiles, additional custom profiles can be
defined. These may be useful for setting up multiple workflows and build
modes. When defining a custom profile, you must specify the `inherits` key to
specify which profile the custom profile inherits settings from when the
setting is not specified.
{==+==}
除了内置编译设置，还可以自定义。在需要划分多个工作流和构建模式时，可能会用到自定义编译设置。
在自定义编译设置时，必须指定 `inherits` 键，以便在条目没有指定时，可以找到自定义继承了的哪个编译设置。
{==+==}

{==+==}
For example, let's say you want to compare a normal release build with a
release build with [LTO](#lto) optimizations, you can specify something like
the following in `Cargo.toml`:
{==+==}
举例来说，假如你想将一个普通的发布构建与使用[LTO](#lto)优化的构建做比较，那么可以如下在 `Cargo.toml` 指定：
{==+==}


{==+==}
```toml
[profile.release-lto]
inherits = "release"
lto = true
```
{==+==}

{==+==}


{==+==}
The `--profile` flag can then be used to choose this custom profile:
{==+==}
`--profile` 标志可用来选择自定义编译设置：
{==+==}


{==+==}
```console
cargo build --profile release-lto
```
{==+==}

{==+==}


{==+==}
The output for each profile will be placed in a directory of the same name
as the profile in the [`target` directory]. As in the example above, the
output would go into the `target/release-lto` directory.
{==+==}
每个编译设置的输出会放在[`target` directory]下和编译设置同名的文件夹下。对于上面的例子来说，编译设置产生的输出会放置在路径为 `target/release-lto` 文件夹下。
{==+==}


{==+==}
[`target` directory]: ../guide/build-cache.md
{==+==}

{==+==}


{==+==}
### Profile selection
{==+==}
### 编译设置选择
{==+==}

{==+==}
The profile used depends on the command, the command-line flags like
`--release` or `--profile`, and the package (in the case of
[overrides](#overrides)). The default profile if none is specified is:
{==+==}
编译设置的使用依赖于指令、命令行标志如 `--release` 或 `--profile` 和包(比如[overrides](#overrides))。如果未指定那么默认的编译设置为：
{==+==}

{==+==}
| Command | Default Profile |
|---------|-----------------|
| [`cargo run`], [`cargo build`],<br>[`cargo check`], [`cargo rustc`] | [`dev` profile](#dev) |
| [`cargo test`] | [`test` profile](#test)
| [`cargo bench`] | [`bench` profile](#bench)
| [`cargo install`] | [`release` profile](#release)
{==+==}

{==+==}

{==+==}
You can switch to a different profile using the `--profile=NAME` option which will used the given profile.
The `--release` flag is equivalent to `--profile=release`.
{==+==}
可以使用 `--profile=NAME` 来切换到不同的编译设置。 `--release` 标志等价于 `--profile=release` 。
{==+==}

{==+==}
The selected profile applies to all Cargo targets, 
including [library](./cargo-targets.md#library),
[binary](./cargo-targets.md#binaries), 
[example](./cargo-targets.md#examples), 
[test](./cargo-targets.md#tests), 
and [benchmark](./cargo-targets.md#benchmarks).
{==+==}
选择的编译设置作用于Cargo所有的生成目标，包括 [library](./cargo-targets.md#library),
[binary](./cargo-targets.md#binaries), 
[example](./cargo-targets.md#examples), 
[test](./cargo-targets.md#tests), 
[benchmark](./cargo-targets.md#benchmarks)。
{==+==}

{==+==}
The profile for specific packages can be specified with
[overrides](#overrides), described below.
{==+==}
对于特定包的编译设置可以使用[overrides](#overrides)来指定，描述如下。
{==+==}

{==+==}
[`cargo bench`]: ../commands/cargo-bench.md
[`cargo build`]: ../commands/cargo-build.md
[`cargo check`]: ../commands/cargo-check.md
[`cargo install`]: ../commands/cargo-install.md
[`cargo run`]: ../commands/cargo-run.md
[`cargo rustc`]: ../commands/cargo-rustc.md
[`cargo test`]: ../commands/cargo-test.md
{==+==}

{==+==}


{==+==}
### Overrides
{==+==}
### 覆盖
{==+==}


{==+==}
Profile settings can be overridden for specific packages and build-time
crates. To override the settings for a specific package, use the `package`
table to change the settings for the named package:
{==+==}
编译设置可对特定包和构建时的crate进行覆盖。如需对特定的包进行覆盖，使用 `package` 表来更改已命名的包的编译设置：
{==+==}


{==+==}
```toml
# The `foo` package will use the -Copt-level=3 flag.
[profile.dev.package.foo]
opt-level = 3
```
{==+==}
```toml
# `foo` 包会使用 -Copt-level=3 标志。
[profile.dev.package.foo]
opt-level = 3
```
{==+==}


{==+==}
The package name is actually a [Package ID Spec](pkgid-spec.md), so you can
target individual versions of a package with syntax such as
`[profile.dev.package."foo:2.1.0"]`.
{==+==}
包的名字实际为[Package ID Spec](pkgid-spec.md)，所以可以使用如 `[profile.dev.package."foo:2.1.0"]` 的语法定位到某个版本的包。
{==+==}


{==+==}
To override the settings for all dependencies (but not any workspace member),
use the `"*"` package name:
{==+==}
如需覆盖所有依赖的设置(但是并非任何工作空间的成员)，使用 `"*"` 包名 :
{==+==}

{==+==}
```toml
# Set the default for dependencies.
[profile.dev.package."*"]
opt-level = 2
```
{==+==}
```toml
# 为所有配置设定默认设置。
[profile.dev.package."*"]
opt-level = 2
```
{==+==}


{==+==}
To override the settings for build scripts, proc macros, and their
dependencies, use the `build-override` table:
{==+==}
如需覆盖构建脚本、过程宏和相关依赖的设置，使用 `build-override` 表：
{==+==}


{==+==}
```toml
# Set the settings for build scripts and proc-macros.
[profile.dev.build-override]
opt-level = 3
```
{==+==}
```toml
# 为构建脚本和过程宏设置配置。
[profile.dev.build-override]
opt-level = 3
```
{==+==}


{==+==}
> Note: When a dependency is both a normal dependency and a build dependency,
> Cargo will try to only build it once when `--target` is not specified. When
> using `build-override`, the dependency may need to be built twice, once as a
> normal dependency and once with the overridden build settings. This may
> increase initial build times.
{==+==}
> 注意：当依赖既是普通依赖而且是构建依赖时， 
> 如果 `--target` 未指定，Cargo 会试图只构建一次。
> 当使用 `build-override` 时，依赖可能需要构建两次， 一次作为正常依赖项，一次使用覆盖的构建设置。这可能会增加初始构建的时间。
{==+==}


{==+==}
The precedence for which value is used is done in the following order (first
match wins):
{==+==}
使用值的优先顺序如下(先匹配到的优先)：
{==+==}


{==+==}
1. `[profile.dev.package.name]` — A named package.
2. `[profile.dev.package."*"]` — For any non-workspace member.
3. `[profile.dev.build-override]` — Only for build scripts, proc macros, and
   their dependencies.
4. `[profile.dev]` — Settings in `Cargo.toml`.
5. Default values built-in to Cargo.
{==+==}
1. `[profile.dev.package.name]` — 命名的包。
2. `[profile.dev.package."*"]` — 对于任何非工作空间成员。
3. `[profile.dev.build-override]` — 仅适用于构建脚本、过程宏及其依赖项。
4. `[profile.dev]` — `Cargo.toml` 中的设置。
5. Cargo中内置的默认值。
{==+==}


{==+==}
Overrides cannot specify the `panic`, `lto`, or `rpath` settings.
{==+==}
覆盖不能指定 `panic` 、 `lto` 、 `rpath` 设置。
{==+==}


{==+==}
#### Overrides and generics
{==+==}
#### 覆盖和泛型
{==+==}


{==+==}
The location where generic code is instantiated will influence the
optimization settings used for that generic code. This can cause subtle
interactions when using profile overrides to change the optimization level of
a specific crate. If you attempt to raise the optimization level of a
dependency which defines generic functions, those generic functions may not be
optimized when used in your local crate. This is because the code may be
generated in the crate where it is instantiated, and thus may use the
optimization settings of that crate.
{==+==}
实例化泛型代码的位置会影响用于该泛型代码的优化配置。
当使用编译配置覆盖去更改特定crate的优化级别时，这可能会导致微妙的影响。
如果试图提高定义泛型函数依赖的优化级别，在本地crate中使用这些泛型函数时可能无法进行优化。
这是因为代码可能会在其实例化的crate中生成，因而可能会使用该crate的优化设置。
{==+==}

{==+==}
For example, [nalgebra] is a library which defines vectors and matrices making
heavy use of generic parameters. If your local code defines concrete nalgebra
types like `Vector4<f64>` and uses their methods, the corresponding nalgebra
code will be instantiated and built within your crate. Thus, if you attempt to
increase the optimization level of `nalgebra` using a profile override, it may
not result in faster performance.
{==+==}
举例来说， [nalgebra] 是一个定义向量和矩阵的库，并且大量使用了泛型参数。
如果你的本地代码定义了具体的nalgebra类型，比如 `Vector4<f64>` 并使用他们的方法，相应的nalgebra代码将被实例化并构建在你的crate中。
因此，如果你试图使用覆盖编译配置来提高nalgebra的优化级别的话，可能并不会带来更快的性能。
{==+==}

{==+==}
Further complicating the issue, `rustc` has some optimizations where it will
attempt to share monomorphized generics between crates. If the opt-level is 2
or 3, then a crate will not use monomorphized generics from other crates, nor
will it export locally defined monomorphized items to be shared with other
crates. When experimenting with optimizing dependencies for development,
consider trying opt-level 1, which will apply some optimizations while still
allowing monomorphized items to be shared.
{==+==}
更复杂的是， `rustc` 有一些优化尝试在crate之间共享单态化的泛型。如果优化级别是2或3，
那么crate将不会使用其他crate中单态化的泛型，也不会导出本地定义的与其他crate共享的单态化内容。
{==+==}

{==+==}
[nalgebra]: https://crates.io/crates/nalgebra
{==+==}

{==+==}