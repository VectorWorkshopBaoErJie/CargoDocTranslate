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
Cargo 包由 *构建目标* 组成，构建目标对应着可以编译成 crate 的源文件。
包中可以包含 [library](#library), [binary](#binaries),
[example](#examples), [test](#tests) 和 [benchmark](#benchmarks) 的构建目标。
构建目标列表可以在 `Cargo.toml` 清单中配置，但总是由源文件的 [目录结构][package layout]
[inferred automatically](#target-auto-discovery)
{==+==}

{==+==}
See [Configuring a target](#configuring-a-target) below for details on
configuring the settings for a target.
{==+==}
关于构建目标的配置，查看下面的 [Configuring a target](#configuring-a-target)。
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
库的构建目标定义了 "库" ，从而被其他库和可执行程序使用和链接。
默认文件名是 `src/lib.rs` ，库的名称默认为包的名称。
包可以只有一个库。可以在 `Cargo.toml` 的 `[lib]` 标签下 [自定义] 库的设置。
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
### 二进制构建目标
{==+==}

{==+==}
Binary targets are executable programs that can be run after being compiled.
The default binary filename is `src/main.rs`, which defaults to the name of
the package. Additional binaries are stored in the [`src/bin/`
directory][package layout]. The settings for each binary can be [customized]
in the `[[bin]]` tables in `Cargo.toml`.
{==+==}
二进制构建目标为编译后可以运行的可执行程序。
默认的二进制文件名为 `src/main.rs` ，默认是包的名称。
额外的二进制文件会放在 [`src/bin/` 目录][package layout]。
你可以在 `Cargo.toml` 的 `[[bin]]` 标签下为每个二进制文件 [自定义] 设置。
{==+==}


{==+==}
Binaries can use the public API of the package's library. They are also linked
with the [`[dependencies]`][dependencies] defined in `Cargo.toml`.
{==+==}
二进制文件可以使用包的库提供的公共 API。
它们通过 `Cargo.toml` 中定义的 [`[dependencies]`][dependencies] 链接起来。
{==+==}


{==+==}
You can run individual binaries with the [`cargo run`] command with the `--bin
<bin-name>` option. [`cargo install`] can be used to copy the executable to a
common location.
{==+==}
你可以使用带 `--bin <bin-name>` 参数的 [`cargo run`] 命令来运行单个二进制文件。
可以使用 [`cargo install`] 将可执行文件复制到常规目录。
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
# 在 Cargo.toml 自定义二进制文件设置的示例。
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
### 示例
{==+==}

{==+==}
Files located under the [`examples` directory][package layout] are example
uses of the functionality provided by the library. When compiled, they are
placed in the [`target/debug/examples` directory][build cache].
{==+==}
[`examples` 目录][package layout] 下的文件便是使用库功能的例子。
编译后，文件会生成在 [`target/debug/examples` 目录][build cache]。
{==+==}

{==+==}
Examples can use the public API of the package's library. They are also linked
with the [`[dependencies]`][dependencies] and
[`[dev-dependencies]`][dev-dependencies] defined in `Cargo.toml`.
{==+==}
示例可以使用包中库的公共 API 。它们通过 `Cargo.toml` 中定义的 [`[dependencies]`][dependencies] 和
[`[dev-dependencies]`][dev-dependencies] 链接起来。
{==+==}

{==+==}
By default, examples are executable binaries (with a `main()` function). You
can specify the [`crate-type` field](#the-crate-type-field) to make an example
be compiled as a library:
{==+==}
示例默认是二进制可执行文件(带有 `main()` 函数)。
你可以指定 [`crate-type` 字段](#the-crate-type-field) 另一个示例编译为库:
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
你可以使用带 `--example <示例名>` 参数的 [`cargo run`] 命令来运行单个示例。
使用带 `--example <示例名>` 参数的 [`cargo install`] 命令来将二进制可执行文件复制到常规目录。
使用 [`cargo test`] 命令编译示例可以防止单元损坏。
如果你想运行 [`cargo test`] 示例的中存在的 `#[test]` 函数，需要 [ `test` 字段](#the-test-field) 为 `true` 。
{==+==}

{==+==}
### Tests
{==+==}
### 测试
{==+==}

{==+==}
There are two styles of tests within a Cargo project:
{==+==}
Cargo 项目中有两种测试的方式:
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
* *单元测试* 为在库或二进制(或任何启用了 [ `test` 字段](#the-test-field) 的构建目标)中
使用 [`#[test]` 属性][test-attribute] 标记的函数，这种测试可以访问构建目标中定义的私有 API 。
* *集成测试* 为单独的与项目类库链接的二进制可执行文件。
它也包含了 `#[test]` 函数并且仅能访问 *公有* API 。
{==+==}

{==+==}
Tests are run with the [`cargo test`] command. By default, Cargo and `rustc`
use the [libtest harness] which is responsible for collecting functions
annotated with the [`#[test]` attribute][test-attribute] and executing them in
parallel, reporting the success and failure of each test. See [the `harness`
field](#the-harness-field) if you want to use a different harness or test
strategy.
{==+==}
使用 [`cargo test`] 命令运行测试。默认情况下，Cargo 和 `rustc` 使用 [libtest harness] ，
它负责收集和并行执行带有 [`#[test]` 属性][test-attribute] 标记的函数，并报告所有测试的成功或失败情况。
如果你想使用不同的使用或测试策略可以查看 [ `harness` 字段](#the-harness-field) 。
{==+==}

{==+==}
> **Note**: There is another special style of test in Cargo:
> [documentation tests][documentation examples].
> They are handled by `rustdoc` and have a slightly different execution model.
> For more information, please see [`cargo test`][cargo-test-documentation-tests].
{==+==}
> **注意**: Cargo 有另一种特殊的测试方式:
> [文档测试][documentation examples]。
> 它们通过 `rustdoc` 处理并且使用略有不同的执行模型。
> 你可以在 [`cargo test`][cargo-test-documentation-tests] 查看更多信息。
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
[`tests` 目录][package layout] 目录下的文件便是集成测试。
当你运行 [`cargo test`] 时，Cargo 会将该目录下的每个文件编译为单独的 crate 并执行。
{==+==}

{==+==}
Integration tests can use the public API of the package's library. They are
also linked with the [`[dependencies]`][dependencies] and
[`[dev-dependencies]`][dev-dependencies] defined in `Cargo.toml`.
{==+==}
集成测试可以使用包中库的公有 API 。
它们也通过 `Cargo.toml` 中定义的 [`[dependencies]`][dependencies] 和
[`[dev-dependencies]`][dev-dependencies] 链接起来。
{==+==}

{==+==}
If you want to share code among multiple integration tests, you can place it
in a separate module such as `tests/common/mod.rs` and then put `mod common;`
in each test to import it.
{==+==}
如果你想在多个集成测试中复用代码，你可以将代码放在一个单独的模块中，
比如 `tests/common/mod.rs` 并在测试中使用 `mod common;` 导入这个模块。
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
每个单独二进制可执行文件产生一个集成测试结果，[`cargo test`] 命令会串行执行集成测试。
在某些情况下可能效率较低，比如编译耗时较长或运行时没有充分利用CPU多个核心。
如果你需要进行大量集成测试，推荐创建单个集成测试，并将测试分割成多个模块。
库测试harness"控制"会自动寻找和并行执行所有 `#[test]` 标记的函数。
你可以将模块名传递给 [`cargo test`] 来将测试的范围限定在模块内。
{==+==}

{==+==}
Binary targets are automatically built if there is an integration test. This
allows an integration test to execute the binary to exercise and test its
behavior. The `CARGO_BIN_EXE_<name>` [environment variable] is set when the
integration test is built so that it can use the [`env` macro] to locate the
executable.
{==+==}
二进制构建目标的集成测试是自动构建的。
这样集成测试可以检验二进制文件执行的行为。
集成测试在构建时会设置 `CARGO_BIN_EXE_<name>` [environment variable] ，这样它可以使用 [`env` macro] 来确定可执行文件的位置。
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
使用 [`cargo bench`] 命令来测试代码的性能。它与 [tests](#tests) 遵循相同的结构，
需要性能测试的函数要用 `#[bench]` 标记。
以下几点与测试相似:
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
* 性能测试的文件放置在 [`benches` 目录][package layout] 目录下。
* 类库和二进制文件中定义的性能测试可以访问构建目标中定义的 *私有* API。
`benches` 目录下的性能测试仅能访问 *公有* API 。
* [ `bench` 字段](#the-bench-field) 可以用来定义默认对哪个构建目标进行性能测试。
* [ `harness` 字段](#the-harness-field) 可以用来禁用内置的 harness 。
{==+==}

{==+==}
> **Note**: The [`#[bench]`
> attribute](../../unstable-book/library-features/test.html) is currently
> unstable and only available on the [nightly channel]. There are some
> packages available on [crates.io](https://crates.io/keywords/benchmark) that
> may help with running benchmarks on the stable channel, such as
> [Criterion](https://crates.io/crates/criterion).
{==+==}
> **注意**: [`#[bench]`
> attribute](../../unstable-book/library-features/test.html) 目前还不稳定并且仅在 [nightly channel] 中提供。
> [crates.io](https://crates.io/keywords/benchmark) 提供的一些包也许有助于在 stable channel 中运行性能测试，
> 比如 [Criterion](https://crates.io/crates/criterion)。
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
对于指定构建目标应该如何构建，`Cargo.toml` 中所有的 `[lib]`, `[[bin]]`,
`[[example]]`, `[[test]]` 和 `[[bench]]` 标记都支持相似的配置。
比如 `[[bin]]` 这种双层括号标记代表 [array-of-table of TOML](https://toml.io/en/v1.0.0-rc.3#array-of-tables)，
意味着你可以在 crate 添加多个 `[[bin]]` 来生成多个可执行文件。
比如 `[lib]` 代表普通 TOML 列表，意味着你仅可以制定一个库。
{==+==}

{==+==}
The following is an overview of the TOML settings for each target, with each
field described in detail below.
{==+==}
下面是 TOML 中构建目标设置的概览，针对每个字段都有详细介绍。
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
required-features = [] # 构建此目标需要使用的特性 (类库不适用)
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
`name` 字段指定构建目标的名称，它对应着自动生成的制品的文件名。
对库来说，这个字段是它的 crate 名称，其他依赖会使用这个名称来引用它。
{==+==}

{==+==}
For the `[lib]` and the default binary (`src/main.rs`), this defaults to the
name of the package, with any dashes replaced with underscores. For other
[auto discovered](#target-auto-discovery) targets, it defaults to the
directory or file name.
{==+==}
对于 `[lib]` 和默认的二进制程序(`src/main.rs`)来说，这个字段默认就是包的名称，
其中的破折号会被替换成下划线。对于其他 [auto discovered](#target-auto-discovery) 构建目标，
它默认是目录或文件的名称。
{==+==}

{==+==}
This is required for all targets except `[lib]`.
{==+==}
这个字段对所有构建目标是必填的，除了 `[lib]` 。
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
`path` 字段指定 crate 的源代码相对于 `Cargo.toml` 的相对路径。
{==+==}

{==+==}
If not specified, the [inferred path](#target-auto-discovery) is used based on
the target name.
{==+==}
若此字段未指定，则默认会使用 [inferred path](#target-auto-discovery) 基于构建目标的名称自动填充。
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
对类库、可执行程序和测试来说，默认为 `true` 。
{==+==}

{==+==}
> **Note**: Examples are built by [`cargo test`] by default to ensure they
> continue to compile, but they are not *tested* by default. Setting `test =
> true` for an example will also build it as a test and run any
> [`#[test]`][test-attribute] functions defined in the example.
{==+==}
> **注意**: 默认会使用 [`cargo test`] 构建例子来保证它们可以通过编译，
> 但是默认情况下，它们没有 *测试* 过运行时是否符合预期。
> 为例子设置 `test = true` 也会将它构建为测试并且运行例子中所有带 [`#[test]`][test-attribute] 标记的方法。
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
`doctest` 字段指明 [documentation examples] 是否默认使用 [`cargo test`] 测试。
这个字段只与类库有关，它对其他部分的配置没有任何作用。
对类库来说，此字段默认为 `true` 。
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
`bench` 字段指明构建目标是否默认使用 [`cargo bench`] 进行性能测试。
对类库、二进制程序和性能测试程序来说，此字段默认为 `true` 。
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
`doc` 字段指明构建目标是否包括在 [`cargo doc`] 默认生成的文档中。
对库和二进制程序来说，此字段默认为 `true` 。
{==+==}

{==+==}
> **Note**: The binary will be skipped if its name is the same as the lib
> target.
{==+==}
> **注意**: 若二进制程序的名称与库的名称相同，则会跳过二进制程序。
{==+==}

{==+==}
#### The `plugin` field
{==+==}
#### `plugin` 字段
{==+==}

{==+==}
This field is used for `rustc` plugins, which are being deprecated.
{==+==}
此字段用于 `rustc` 的插件，现在已被弃用。
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
`proc-macro` 字段指明类库是 [procedural macro]([reference][proc-macro-reference]) 。
此字段仅适用于 `[lib]` 构建目标。
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
`harness` 字段指明 [`--test` 参数] 会传递给 `rustc` 令其自动包含libtest类库。
libtest 库用来收集并运行标有 [`#[test]` 属性][test-attribute] 的测试或标有 `#[bench]` 属性的性能测试。
对所有构建目标来说，此字段默认为 `true` 。
{==+==}

{==+==}
If set to `false`, then you are responsible for defining a `main()` function
to run tests and benchmarks.
{==+==}
如果此字段设置为 `false` ，则你需要负责定义 `main()` 函数来运行测试和性能测试。
{==+==}

{==+==}
Tests have the [`cfg(test)` conditional expression][cfg-test] enabled whether
or not the harness is enabled.
{==+==}
无论 harness 字段是否启用，测试都会启用 [`cfg(test)` 条件表达式][cfg-test] 字段。
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
`edition` 字段定义了构建目标将会使用的 [Rust edition] 。
若未指定，默认会使用 `[package]` 的 [`edition` 字段][package-edition] 。
此字段通常不需设置，它只用于类似大型包增量迁移到一个新版本这样的高级场景。
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
`crate-type` 字段定义了构建目标将生成的 [crate types] 。
它是字符串数组，用于在一个构建目标中指定多个 crate 类型 。
此字段仅用于类库和例子。对于二进制程序，测试和性能测试，此字段总是为 "bin" crate 类型。
默认值为:
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
示例 | `"bin"`
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
`required-features` 字段指定了构建目标完成构建所需要的 [features] 。
如果要求的特性都没有启用，则跳过此构建目标。
此字段仅与 `[[bin]]`, `[[bench]]`, `[[test]]` 和 `[[example]]` 有关。
此字段对 `[lib]` 没有影响。
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
### 构建目标自动探测
{==+==}

{==+==}
By default, Cargo automatically determines the targets to build based on the
[layout of the files][package layout] on the filesystem. The target
configuration tables, such as `[lib]`, `[[bin]]`, `[[test]]`, `[[bench]]`, or
`[[example]]`, can be used to add additional targets that don't follow the
standard directory layout.
{==+==}
Cargo 默认会根据文件系统上的 [文件结构][package layout] 推断构建目标。
可以在构建目标的配置表中添加不同于标准目录结构的额外构建目标，比如使用
`[lib]`, `[[bin]]`, `[[test]]`, `[[bench]]` 或 `[[example]]` 标记。
{==+==}

{==+==}
The automatic target discovery can be disabled so that only manually
configured targets will be built. Setting the keys `autobins`, `autoexamples`,
`autotests`, or `autobenches` to `false` in the `[package]` section will
disable auto-discovery of the corresponding target type.
{==+==}
可以禁用目标探测，这样只有手动配置的构建目标会进行构建。
要禁用对应构建目标类型的自动探测，需在 `[package]` 部分将 `autobins`, `autoexamples`, `autotests` 或 `autobenches` 设置为 `false` 。
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
禁用自动探测应该仅用于一些特殊场景。
比如，如果你想在库中给一个 *模块* 命名为 `bin` ，
这样是不行的，因为 Cargo 通常会将 `bin` 目录下的文件编译为可执行文件。
这个例子的文件结构如下:
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
> **注意**: 对于 2015 版本的包，如果 `Cargo.toml` 中手动设置了构建目标，
> 则自动推断字段默认会设置为 `false` 。
> 自从 2018 版本，此字段默认设置为 `true` 。
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
