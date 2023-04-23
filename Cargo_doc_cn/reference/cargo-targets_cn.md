{==+==}
## Cargo Targets
{==+==}
## Cargo 构建目标
{==+==}


{==+==}
Cargo packages consist of *targets* which correspond to source files which can
be compiled into a crate. Packages can have [library](#library),
[binary](#binaries), [example](#examples), [test](#tests), and
[benchmark](#benchmarks) targets. The list of targets can be configured in the
`Cargo.toml` manifest, often [inferred automatically](#target-auto-discovery)
by the [directory layout][package layout] of the source files.
{==+==}
Cargo 包由 *目标* 组成，这些目标对应于可以编译的 crate 源文件。
包可以拥有 [library](#library), [binary](#binaries), [example](#examples), [test](#tests) 和 [benchmark](#benchmarks) 。
目标列表可以在 `Cargo.toml` 清单中配置，在大多数情况下会根据源文件的 [目录布局][package layout] 进行 [自动推断](#target-auto-discovery) 。
{==+==}


{==+==}
See [Configuring a target](#configuring-a-target) below for details on
configuring the settings for a target.
{==+==}
请参见下面的 [配置目标](#configuring-a-target) 部分以获取有关配置目标设置的详细信息。
{==+==}

{==+==}
### Library
{==+==}
### 库
{==+==}


{==+==}
The library target defines a "library" that can be used and linked by other
libraries and executables. The filename defaults to `src/lib.rs`, and the name
of the library defaults to the name of the package. A package can have only
one library. The settings for the library can be [customized] in the `[lib]`
table in `Cargo.toml`.
{==+==}
定义 "library" 库目标 ，可以被其他库和可执行程序使用和链接。
默认的文件名为 `src/lib.rs`，库的名称默认为包的名称。一个包只能有一个库。
可以在 `Cargo.toml` 文件中的 `[lib]` 表中 [自定义][customized] 设置。
{==+==}


{==+==}
```toml
# Example of customizing the library in Cargo.toml.
[lib]
crate-type = ["cdylib"]
bench = false
```
{==+==}
```toml
# 在 Cargo.toml 自定义库设置的例子。
[lib]
crate-type = ["cdylib"]
bench = false
```
{==+==}


{==+==}
### Binaries
{==+==}
### 二进制目标
{==+==}

{==+==}
Binary targets are executable programs that can be run after being compiled.
The default binary filename is `src/main.rs`, which defaults to the name of
the package. Additional binaries are stored in the [`src/bin/`
directory][package layout]. The settings for each binary can be [customized]
in the `[[bin]]` tables in `Cargo.toml`.
{==+==}
二进制目标是可执行程序，在编译后可以运行。
默认的二进制文件名为 `src/main.rs` ，默认名称为包名称。
额外的二进制文件存储在 [`src/bin/` 目录][package layout] 中。
每个二进制文件的设置可以在 `Cargo.toml` 中的 `[[bin]]` 表中进行 [自定义][customized] 。
{==+==}


{==+==}
Binaries can use the public API of the package's library. They are also linked
with the [`[dependencies]`][dependencies] defined in `Cargo.toml`.
{==+==}
二进制文件可以使用包自身的库所提供的公共 API。
需要通过 `Cargo.toml` 中明确定义 [`[dependencies]`][dependencies] 而链接起来。
{==+==}


{==+==}
You can run individual binaries with the [`cargo run`] command with the `--bin
<bin-name>` option. [`cargo install`] can be used to copy the executable to a
common location.
{==+==}
可以使用 [`cargo run`] 命令，带 `--bin <bin-name>` 参数，来运行指定的二进制文件。
可以使用 [`cargo install`] 命令将可执行文件复制到通用位置。
{==+==}


{==+==}
```toml
# Example of customizing binaries in Cargo.toml.
[[bin]]
name = "cool-tool"
test = false
bench = false

[[bin]]
name = "frobnicator"
required-features = ["frobnicate"]
```
{==+==}
```toml
# 在 Cargo.toml 给二进制文件自定义设置。
[[bin]]
name = "cool-tool"
test = false
bench = false

[[bin]]
name = "frobnicator"
required-features = ["frobnicate"]
```
{==+==}


{==+==}
### Examples
{==+==}
### 实例
{==+==}


{==+==}
Files located under the [`examples` directory][package layout] are example
uses of the functionality provided by the library. When compiled, they are
placed in the [`target/debug/examples` directory][build cache].
{==+==}
[`examples` 目录][package layout] 下的文件是库功能的使用实例。
在编译时，文件被放置在 [`target/debug/examples` 目录][build cache] 中。
{==+==}


{==+==}
Examples can use the public API of the package's library. They are also linked
with the [`[dependencies]`][dependencies] and
[`[dev-dependencies]`][dev-dependencies] defined in `Cargo.toml`.
{==+==}
实例可以使用包中库的公共 API 。通过 `Cargo.toml` 中明确定义 [`[dependencies]`][dependencies] 和 [`[dev-dependencies]`][dev-dependencies] 链接起来。
{==+==}


{==+==}
By default, examples are executable binaries (with a `main()` function). You
can specify the [`crate-type` field](#the-crate-type-field) to make an example
be compiled as a library:
{==+==}
默认情况下，实例是可执行二进制文件 (包含 `main()` 函数) 。
你可以指定 [`crate-type` 字段](#the-crate-type-field) 将一个实例编译成为库:
{==+==}


{==+==}
```toml
[[example]]
name = "foo"
crate-type = ["staticlib"]
```
{==+==}

{==+==}


{==+==}
You can run individual executable examples with the [`cargo run`] command with
the `--example <example-name>` option. Library examples can be built with
[`cargo build`] with the `--example <example-name>` option. [`cargo install`]
with the `--example <example-name>` option can be used to copy executable
binaries to a common location. Examples are compiled by [`cargo test`] by
default to protect them from bit-rotting. Set [the `test`
field](#the-test-field) to `true` if you have `#[test]` functions in the
example that you want to run with [`cargo test`].
{==+==}
可以使用 [`cargo run`] 命令，带 `--example <example-name>` 选项来运行单个可执行的实例。
可以使用 [`cargo build`] 命令，带 `--example <example-name>` 选项来构建库实例。
使用 [`cargo install`] 命令，带 `--example <example-name>` 选项可以将可执行二进制文件复制到通用位置。
默认情况下，实例由 [`cargo test`] 编译，以防止单元损坏。
如果实例中有 `#[test]` 函数，你可以将 [`test` 字段](#the-test-field) 设置为 `true`，这样可以使用 [`cargo test`] 运行这些函数。
{==+==}


{==+==}
### Tests
{==+==}
### 测试
{==+==}


{==+==}
There are two styles of tests within a Cargo project:
{==+==}
在一个 Cargo 项目中有两种测试风格:
{==+==}


{==+==}
* *Unit tests* which are functions marked with the [`#[test]`
  attribute][test-attribute] located within your library or binaries (or any
  target enabled with [the `test` field](#the-test-field)). These tests have
  access to private APIs located within the target they are defined in.
* *Integration tests* which is a separate executable binary, also containing
  `#[test]` functions, which is linked with the project's library and has
  access to its *public* API.
{==+==}
* *单元测试* 检测在库或二进制(或任何启用了 [ `test` 字段](#the-test-field) 的构建目标)中使用 [`#[test]` 属性][test-attribute] 标记的函数，这种测试可以访问构建目标中定义的私有 API 。
* *集成测试* 检测单独的与项目的库链接的二进制可执行文件。也包含 `#[test]` 函数，仅能访问 *公共* API 。
{==+==}


{==+==}
Tests are run with the [`cargo test`] command. By default, Cargo and `rustc`
use the [libtest harness] which is responsible for collecting functions
annotated with the [`#[test]` attribute][test-attribute] and executing them in
parallel, reporting the success and failure of each test. See [the `harness`
field](#the-harness-field) if you want to use a different harness or test
strategy.
{==+==}
可以通过执行 [`cargo test`] 命令来运行测试。
默认情况下，Cargo 和 `rustc` 使用 [libtest harness] 来收集标有 [`#[test]` 属性][test-attribute] 的函数，并将它们并行执行，报告每个测试成功和失败情况。
如果要使用不同的测试工具或测试策略，可以参考 [ `harness` 字段](#the-harness-field) 。
{==+==}


{==+==}
> **Note**: There is another special style of test in Cargo:
> [documentation tests][documentation examples].
> They are handled by `rustdoc` and have a slightly different execution model.
> For more information, please see [`cargo test`][cargo-test-documentation-tests].
{==+==}
> **注意**: Cargo 中还有另一种特殊的测试样式: [文档测试][documentation examples] 。
> 它们由 `rustdoc` 处理，具有略有不同的执行模型。有关更多信息，请参见 [`cargo test`][cargo-test-documentation-tests] 。
{==+==}


{==+==}
[libtest harness]: ../../rustc/tests/index.html
[cargo-test-documentation-tests]: ../commands/cargo-test.md#documentation-tests
{==+==}

{==+==}


{==+==}
#### Integration tests
{==+==}
#### 集成测试
{==+==}


{==+==}
Files located under the [`tests` directory][package layout] are integration
tests. When you run [`cargo test`], Cargo will compile each of these files as
a separate crate, and execute them.
{==+==}
位于 [`tests` 目录][package layout] 下的文件是集成测试。
当你运行 [`cargo test`] 时，Cargo 将把这些文件编译为单独的 crate，并执行它们。
{==+==}


{==+==}
Integration tests can use the public API of the package's library. They are
also linked with the [`[dependencies]`][dependencies] and
[`[dev-dependencies]`][dev-dependencies] defined in `Cargo.toml`.
{==+==}
集成测试可以使用包中库的公有 API 。
通过 `Cargo.toml` 中明确定义 [`[dependencies]`][dependencies] 和 [`[dev-dependencies]`][dev-dependencies] 链接起来。
{==+==}


{==+==}
If you want to share code among multiple integration tests, you can place it
in a separate module such as `tests/common/mod.rs` and then put `mod common;`
in each test to import it.
{==+==}
如果你想在多个集成测试中共享代码，可以将代码放在一个单独的模块中，例如 `tests/common/mod.rs`，然后在每个测试中使用 `mod common;` 进行导入。
{==+==}


{==+==}
Each integration test results in a separate executable binary, and [`cargo
test`] will run them serially. In some cases this can be inefficient, as it
can take longer to compile, and may not make full use of multiple CPUs when
running the tests. If you have a lot of integration tests, you may want to
consider creating a single integration test, and split the tests into multiple
modules. The libtest harness will automatically find all of the `#[test]`
annotated functions and run them in parallel. You can pass module names to
[`cargo test`] to only run the tests within that module.
{==+==}
每个集成测试都会生成一个单独的可执行二进制文件， [`cargo test`] 会以串行方式运行它们。
在某些情况下，这可能效率较低，编译时间较长，且可能无法充分利用多个 CPU 运行测试。
如果有很多集成测试，可以考虑创建一个单独的集成测试，然后将测试拆分为多个模块。
libtest 测试框架将自动查找所有标记了 `#[test]` 的函数并以并行方式运行它们。
你可以将模块名称传递给 [`cargo test`] ，而只运行该模块中的测试。
{==+==}


{==+==}
Binary targets are automatically built if there is an integration test. This
allows an integration test to execute the binary to exercise and test its
behavior. The `CARGO_BIN_EXE_<name>` [environment variable] is set when the
integration test is built so that it can use the [`env` macro] to locate the
executable.
{==+==}
如果存在一个集成测试，那么会自动构建二进制目标。这使得集成测试可以执行二进制文件以测试其行为。
当构建集成测试时，会设置 `CARGO_BIN_EXE_<name>` [环境变量][environment variable] ，以便使用 [`env` 宏][`env` macro] 查找可执行文件。
{==+==}


{==+==}
[environment variable]: environment-variables.md#environment-variables-cargo-sets-for-crates
[`env` macro]: ../../std/macro.env.html
{==+==}

{==+==}

{==+==}
### Benchmarks
{==+==}
### 性能测试
{==+==}

{==+==}
Benchmarks provide a way to test the performance of your code using the
[`cargo bench`] command. They follow the same structure as [tests](#tests),
with each benchmark function annotated with the `#[bench]` attribute.
Similarly to tests:
{==+==}
基准测试提供了一种使用 [`cargo bench`] 命令测试代码性能的方式。
它们遵循与集成测试相同的结构，其中每个基准测试函数都带有 `#[bench]` 属性。
以下几点与集成测试相似:
{==+==}


{==+==}
* Benchmarks are placed in the [`benches` directory][package layout].
* Benchmark functions defined in libraries and binaries have access to the
  *private* API within the target they are defined in. Benchmarks in the
  `benches` directory may use the *public* API.
* [The `bench` field](#the-bench-field) can be used to define which targets
  are benchmarked by default.
* [The `harness` field](#the-harness-field) can be used to disable the
  built-in harness.
{==+==}
* 性能测试的文件放置在 [`benches` 目录][package layout] 下。
* 库和二进制文件中定义的性能测试可以访问构建目标中定义的 *私有* API。 `benches` 目录下的性能测试仅能访问 *公有* API 。
* [ `bench` 字段](#the-bench-field) 可以用来定义默认对哪个构建目标进行性能测试。
* [ `harness` 字段](#the-harness-field) 可以用来禁用内置的 harness (测试框架) 。
{==+==}

{==+==}
> **Note**: The [`#[bench]`
> attribute](../../unstable-book/library-features/test.html) is currently
> unstable and only available on the [nightly channel]. There are some
> packages available on [crates.io](https://crates.io/keywords/benchmark) that
> may help with running benchmarks on the stable channel, such as
> [Criterion](https://crates.io/crates/criterion).
{==+==}
> **注意**: 目前 [`#[bench]` 属性][test-attribute] 仅在 [nightly 频道][nightly channel] 上提供，并且是不稳定的。
> 在 [crates.io][crates-io] 上有一些包可以在稳定频道上帮助运行基准测试，例如 [Criterion][criterion] 。
{==+==}

{==+==}
### Configuring a target
{==+==}
### 配置构建目标
{==+==}

{==+==}
All of the  `[lib]`, `[[bin]]`, `[[example]]`, `[[test]]`, and `[[bench]]`
sections in `Cargo.toml` support similar configuration for specifying how a
target should be built. The double-bracket sections like `[[bin]]` are
[array-of-table of TOML](https://toml.io/en/v1.0.0-rc.3#array-of-tables),
which means you can write more than one `[[bin]]` section to make several
executables in your crate. You can only specify one library, so `[lib]` is a
normal TOML table.
{==+==}
所有在 `Cargo.toml` 中的 `[lib]` , `[[bin]]` , `[[example]]` , `[[test]]` 和 `[[bench]]` 都支持类似的配置以指定如何构建一个目标。
类似 `[[bin]]` 这样的双重方括号节是  [TOML 数组表](https://toml.io/en/v1.0.0-rc.3#array-of-tables)，这意味着你可以编写多个 `[[bin]]` 节以制作你的包中的多个可执行文件。
你只能指定一个库，所以 `[lib]` 是一个普通的 TOML 表。
{==+==}


{==+==}
The following is an overview of the TOML settings for each target, with each
field described in detail below.
{==+==}
以下是每个目标的 TOML 设置的概述，每个字段的详细描述在下面。
{==+==}


{==+==}
```toml
[lib]
name = "foo"           # The name of the target.
path = "src/lib.rs"    # The source file of the target.
test = true            # Is tested by default.
doctest = true         # Documentation examples are tested by default.
bench = true           # Is benchmarked by default.
doc = true             # Is documented by default.
plugin = false         # Used as a compiler plugin (deprecated).
proc-macro = false     # Set to `true` for a proc-macro library.
harness = true         # Use libtest harness.
edition = "2015"       # The edition of the target.
crate-type = ["lib"]   # The crate types to generate.
required-features = [] # Features required to build this target (N/A for lib).
```
{==+==}
```toml
[lib]
name = "foo"           # 构建目标的名称
path = "src/lib.rs"    # 构建目标的源文件相对路径
test = true            # 是否默认进行测试
doctest = true         # 文档示例是否默认进行测试
bench = true           # 是否默认进行性能测试
doc = true             # 是否默认带有文档
plugin = false         # 是否用作编译器插件(已弃用)
proc-macro = false     # proc-macro 库要设置为 `true`
harness = true         # 是否使用库测试harness
edition = "2015"       # 构建目标的版本
crate-type = ["lib"]   # 要生成的 crate 类型
required-features = [] # 构建此目标需要使用的特性 (库不适用)
```
{==+==}


{==+==}
#### The `name` field
{==+==}
### `name` 字段
{==+==}

{==+==}
The `name` field specifies the name of the target, which corresponds to the
filename of the artifact that will be generated. For a library, this is the
crate name that dependencies will use to reference it.
{==+==}
`name` 字段指定目标的名称，对应将是要生成的制品的文件名。
对于库来说，将是依赖用来引用它的 crate 名称。
{==+==}


{==+==}
For the `[lib]` and the default binary (`src/main.rs`), this defaults to the
name of the package, with any dashes replaced with underscores. For other
[auto discovered](#target-auto-discovery) targets, it defaults to the
directory or file name.
{==+==}
对于 `[lib]` 和默认二进制文件 (`src/main.rs`) ，该字段默认为包的名称，其中任何短横线都将被替换为下划线。
对于 [自动发现](#target-auto-discovery) 的其他目标，默认为目录或文件名。
{==+==}


{==+==}
This is required for all targets except `[lib]`.
{==+==}
这个字段对所有构建目标是必需的，除了 `[lib]` 。
{==+==}


{==+==}
#### The `path` field
{==+==}
#### `path` 字段
{==+==}


{==+==}
The `path` field specifies where the source for the crate is located, relative
to the `Cargo.toml` file.
{==+==}
`path` 字段指定 crate 源码所在的相对路径，相对于 `Cargo.toml` 文件。
{==+==}


{==+==}
If not specified, the [inferred path](#target-auto-discovery) is used based on
the target name.
{==+==}
如果未指定，则基于目标名称使用 [推断路径](#target-auto-discovery) 。
{==+==}


{==+==}
#### The `test` field
{==+==}
#### `test` 字段
{==+==}


{==+==}
The `test` field indicates whether or not the target is tested by default by
[`cargo test`]. The default is `true` for lib, bins, and tests.
{==+==}
`test` 字段指明构建目标是否默认使用 [`cargo test`] 命令进行测试。
对于库、可执行程序和测试来说，默认为 `true` 。
{==+==}


{==+==}
> **Note**: Examples are built by [`cargo test`] by default to ensure they
> continue to compile, but they are not *tested* by default. Setting `test =
> true` for an example will also build it as a test and run any
> [`#[test]`][test-attribute] functions defined in the example.
{==+==}
> **注意**: 注意：默认情况下，实例会被 [`cargo test`] 构建以保证它们可以通过编译，但默认情况下不会被 *测试* 。
> 为示例设置 `test = true` 将会作为一个测试构建它，并运行在该实例中定义的任何 [`#[test]`][test-attribute] 函数。
{==+==}


{==+==}
#### The `doctest` field
{==+==}
#### `doctest` 字段
{==+==}


{==+==}
The `doctest` field indicates whether or not [documentation examples] are
tested by default by [`cargo test`]. This is only relevant for libraries, it
has no effect on other sections. The default is `true` for the library.
{==+==}
`doctest` 字段指示是否默认使用 [`cargo test`] 来测试 [文档实例][documentation examples]。
它只与库相关，对其他部分没有作用。默认情况下，对于库，该值为 `true`。
{==+==}


{==+==}
#### The `bench` field
{==+==}
#### `bench` 字段
{==+==}

{==+==}
The `bench` field indicates whether or not the target is benchmarked by
default by [`cargo bench`]. The default is `true` for lib, bins, and
benchmarks.
{==+==}
`bench` 字段指示默认情况下 [`cargo bench`] 是否对目标进行性能测试。
默认情况下，`lib`、`bins` 和 `benchmarks` 的值为 `true`。
{==+==}


{==+==}
#### The `doc` field
{==+==}
#### `doc` 字段
{==+==}


{==+==}
The `doc` field indicates whether or not the target is included in the
documentation generated by [`cargo doc`] by default. The default is `true` for
libraries and binaries.
{==+==}
`doc` 字段指定默认情况下是否将目标包含在 [`cargo doc`] 生成的文档中。
对于库和二进制文件，默认值为 `true` 。
{==+==}


{==+==}
> **Note**: The binary will be skipped if its name is the same as the lib
> target.
{==+==}
> **注意**: 若二进制文件的名称与库的名称相同，则会跳过二进制程序。
{==+==}


{==+==}
#### The `plugin` field
{==+==}
#### `plugin` 字段
{==+==}

{==+==}
This field is used for `rustc` plugins, which are being deprecated.
{==+==}
这个字段是用于 `rustc` 插件的，但是已经被弃用。
{==+==}


{==+==}
#### The `proc-macro` field
{==+==}
#### `proc-macro` 字段
{==+==}


{==+==}
The `proc-macro` field indicates that the library is a [procedural macro]
([reference][proc-macro-reference]). This is only valid for the `[lib]`
target.
{==+==}
`proc-macro` 字段指定库为 [过程宏]([reference][proc-macro-reference]) 。该字段只适用于 `[lib]` 目标。
{==+==}


{==+==}
#### The `harness` field
{==+==}
#### `harness` 字段
{==+==}


{==+==}
The `harness` field indicates that the [`--test` flag] will be passed to
`rustc` which will automatically include the libtest library which is the
driver for collecting and running tests marked with the [`#[test]`
attribute][test-attribute] or benchmarks with the `#[bench]` attribute. The
default is `true` for all targets.
{==+==}
`harness` 字段指示会向 `rustc` 传递 [`--test` 标志][--test flag] ，从而自动包含 `libtest` 库，该库是用于收集和运行带有 [`#[test]` 属性][test-attribute] 或使用 `#[bench]` 属性的基准测试的驱动程序。
对于所有目标，默认值为 `true`。
{==+==}


{==+==}
If set to `false`, then you are responsible for defining a `main()` function
to run tests and benchmarks.
{==+==}
如果将其设置为 `false` ，则需要你负责定义一个 `main()` 函数来运行测试和基准测试。
{==+==}

{==+==}
Tests have the [`cfg(test)` conditional expression][cfg-test] enabled whether
or not the harness is enabled.
{==+==}
不管 `harness` 是否被启用，测试都会启用 [`cfg(test)` 条件表达式][cfg-test] 。
{==+==}

{==+==}
#### The `edition` field
{==+==}
#### `edition` 字段
{==+==}

{==+==}
The `edition` field defines the [Rust edition] the target will use. If not
specified, it defaults to the [`edition` field][package-edition] for the
`[package]`. This field should usually not be set, and is only intended for
advanced scenarios such as incrementally transitioning a large package to a
new edition.
{==+==}
`edition` 字段定义目标将使用的 Rust 版本，如果未指定，它将默认为 `[package]` 的 `edition` 字段。
通常不需要设置此字段，它仅用于高级场景，例如逐步将大型包迁移到新版本。
{==+==}

{==+==}
#### The `crate-type` field
{==+==}
#### `crate-type` 字段
{==+==}

{==+==}
The `crate-type` field defines the [crate types] that will be generated by the
target. It is an array of strings, allowing you to specify multiple crate
types for a single target. This can only be specified for libraries and
examples. Binaries, tests, and benchmarks are always the "bin" crate type. The
defaults are:
{==+==}
`crate-type` 字段定义目标将生成的 [crate 类型][crate types] 。
它是一个字符串数组，允许你为单个目标指定多个 crate 类型。这只能为库和实例指定。
二进制文件、测试和基准总是 "bin" crate 类型。默认值为：
{==+==}


{==+==}
Target | Crate Type
-------|-----------
Normal library | `"lib"`
Proc-macro library | `"proc-macro"`
Example | `"bin"`
{==+==}
构建目标 | Crate Type
-------|-----------
普通类库 | `"lib"`
Proc-macro 类库 | `"proc-macro"`
实例 | `"bin"`
{==+==}


{==+==}
The available options are `bin`, `lib`, `rlib`, `dylib`, `cdylib`,
`staticlib`, and `proc-macro`. You can read more about the different crate
types in the [Rust Reference Manual][crate types].
{==+==}
此字段可用的值有 `bin`, `lib`, `rlib`, `dylib`, `cdylib`, `staticlib` 和 `proc-macro` 。
关于各种 crate 类型的更多信息在 [Rust Reference Manual][crate types] 。
{==+==}


{==+==}
#### The `required-features` field
{==+==}
#### `required-features` 字段
{==+==}


{==+==}
The `required-features` field specifies which [features] the target needs in
order to be built. If any of the required features are not enabled, the
target will be skipped. This is only relevant for the `[[bin]]`, `[[bench]]`,
`[[test]]`, and `[[example]]` sections, it has no effect on `[lib]`.
{==+==}
`required-features` 字段指定目标构建所需的 [特性][features] 。
如果未启用所需特性中的任何一个，则会跳过构建该目标。
这仅适用于 `[[bin]]` 、 `[[bench]]` 、 `[[test]]` 和 `[[example]]` 部分，对 `[lib]` 没有影响。
{==+==}


{==+==}
```toml
[features]
# ...
postgres = []
sqlite = []
tools = []

[[bin]]
name = "my-pg-tool"
required-features = ["postgres", "tools"]
```
{==+==}

{==+==}


{==+==}
### Target auto-discovery
{==+==}
### 构建目标自动发现
{==+==}

{==+==}
By default, Cargo automatically determines the targets to build based on the
[layout of the files][package layout] on the filesystem. The target
configuration tables, such as `[lib]`, `[[bin]]`, `[[test]]`, `[[bench]]`, or
`[[example]]`, can be used to add additional targets that don't follow the
standard directory layout.
{==+==}
默认情况下，Cargo 会基于文件系统上的 [文件结构][package layout] 来自动确定需要构建的目标。
可以使用目标配置表，如 `[lib]` 、 `[[bin]]` 、 `[[test]]` 、 `[[bench]]` 或 `[[example]]` ，来添加不遵循标准目录布局的额外目标。
{==+==}

{==+==}
The automatic target discovery can be disabled so that only manually
configured targets will be built. Setting the keys `autobins`, `autoexamples`,
`autotests`, or `autobenches` to `false` in the `[package]` section will
disable auto-discovery of the corresponding target type.
{==+==}
自动目标发现可以禁用，这样只会构建手动配置的目标。
在 `[package]` 部分中将键 `autobins` ， `autoexamples` ， `autotests` 或 `autobenches` 设置为 `false` 将禁用相应目标类型的自动发现。
{==+==}

{==+==}
```toml
[package]
# ...
autobins = false
autoexamples = false
autotests = false
autobenches = false
```
{==+==}

{==+==}

{==+==}
Disabling automatic discovery should only be needed for specialized
situations. For example, if you have a library where you want a *module* named
`bin`, this would present a problem because Cargo would usually attempt to
compile anything in the `bin` directory as an executable. Here is a sample
layout of this scenario:
{==+==}
禁用自动发现功能通常只在特殊情况下需要。
例如，如果你想要一个名为 `bin` 的模块，这样是不行的，因为 Cargo 通常会尝试将 `bin `目录中的所有内容编译为可执行文件。以下是此场景的示例布局：
{==+==}


{==+==}
```text
├── Cargo.toml
└── src
    ├── lib.rs
    └── bin
        └── mod.rs
```
{==+==}

{==+==}

{==+==}
To prevent Cargo from inferring `src/bin/mod.rs` as an executable, set
`autobins = false` in `Cargo.toml` to disable auto-discovery:
{==+==}
在 `Cargo.toml` 中声明 `autobins = false` 禁用自动探测来防止 Cargo 将 `src/bin/mod.rs` 推断为可执行文件:
{==+==}

{==+==}
```toml
[package]
# …
autobins = false
```
{==+==}

{==+==}


{==+==}
> **Note**: For packages with the 2015 edition, the default for auto-discovery
> is `false` if at least one target is manually defined in `Cargo.toml`.
> Beginning with the 2018 edition, the default is always `true`.
{==+==}
> **注意**: 对于使用 2015 版的包，只要 `Cargo.toml` 中手动设置了构建目标，则自动发现的默认值为 `false` 。从 2018 版开始，默认值始终为 `true` 。
{==+==}


{==+==}
[Build cache]: ../guide/build-cache.md
[Rust Edition]: ../../edition-guide/index.html
[`--test` flag]: ../../rustc/command-line-arguments.html#option-test
[`cargo bench`]: ../commands/cargo-bench.md
[`cargo build`]: ../commands/cargo-build.md
[`cargo doc`]: ../commands/cargo-doc.md
[`cargo install`]: ../commands/cargo-install.md
[`cargo run`]: ../commands/cargo-run.md
[`cargo test`]: ../commands/cargo-test.md
[cfg-test]: ../../reference/conditional-compilation.html#test
[crate types]: ../../reference/linkage.html
[crates.io]: https://crates.io/
[customized]: #configuring-a-target
[dependencies]: specifying-dependencies.md
[dev-dependencies]: specifying-dependencies.md#development-dependencies
[documentation examples]: ../../rustdoc/documentation-tests.html
[features]: features.md
[nightly channel]: ../../book/appendix-07-nightly-rust.html
[package layout]: ../guide/project-layout.md
[package-edition]: manifest.md#the-edition-field
[proc-macro-reference]: ../../reference/procedural-macros.html
[procedural macro]: ../../book/ch19-06-macros.html
[test-attribute]: ../../reference/attributes/testing.html#the-test-attribute
{==+==}

{==+==}
