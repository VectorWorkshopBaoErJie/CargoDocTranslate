{==+==}
# cargo-bench(1)
{==+==}
# cargo-bench(1)
{==+==}




{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-bench - Execute benchmarks of a package
{==+==}
cargo-bench - 执行包的基准测试
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 简介
{==+==}

{==+==}
`cargo bench` [_options_] [_benchname_] [`--` _bench-options_]
{==+==}
`cargo bench` [_options_] [_benchname_] [`--` _bench-options_]
{==+==}

{==+==}
## DESCRIPTION
{==+==}
{==+==}

{==+==}
Compile and execute benchmarks.
{==+==}
编译和执行基准。
{==+==}

{==+==}
The benchmark filtering argument _benchname_ and all the arguments following
the two dashes (`--`) are passed to the benchmark binaries and thus to
_libtest_ (rustc's built in unit-test and micro-benchmarking framework). If
you are passing arguments to both Cargo and the binary, the ones after `--` go
to the binary, the ones before go to Cargo. For details about libtest's
arguments see the output of `cargo bench -- --help` and check out the rustc
book's chapter on how tests work at
<https://doc.rust-lang.org/rustc/tests/index.html>.
{==+==}
基准过滤参数 _benchname_ 及其后的所有参数两个破折号(`--`)被传递给基准二进制文件，从而传递给 _libtest_ （rustc的内置单元测试和微基准框架）。如果您同时向 Cargo 和二进制文件传递参数，那么 `--` 之后的参数将转到二进制文件，转到 Cargo 之前的参数将转到 Cargo。有关libtest的详细信息参数查看 `cargo bench -- --help` 的输出，并检查rustc书中关于测试如何工作的章节
<https://doc.rust-lang.org/rustc/tests/index.html>.
{==+==}

{==+==}
As an example, this will run only the benchmark named `foo` (and skip other
similarly named benchmarks like `foobar`):
{==+==}
例如，这将只运行名为 `foo` 的基准测试（并跳过其他类似名称的基准测试，如 `foobar `）：
{==+==}

{==+==}
    cargo bench -- foo --exact
{==+==}
    cargo bench -- foo --exact
{==+==}

{==+==}
Benchmarks are built with the `--test` option to `rustc` which creates a
special executable by linking your code with libtest. The executable
automatically runs all functions annotated with the `#[bench]` attribute.
Cargo passes the `--bench` flag to the test harness to tell it to run
only benchmarks.
{==+==}
基准测试是使用 `rustc` 的 `- test` 选项构建的，它通过将您的代码与 libtest 链接来创建一个特殊的可执行文件。可执行文件自动运行所有用 `#[bench]` 属性注释的函数。Cargo 将 `bench` 标志传递给测试工具，告诉它只运行基准测试。
{==+==}

{==+==}
The libtest harness may be disabled by setting `harness = false` in the target
manifest settings, in which case your code will need to provide its own `main`
function to handle running benchmarks.
{==+==}
可以通过在目标清单设置中设置 `harness = false` 来禁用 libtest 工具，在这种情况下，您的代码将需要提供自己的 `main` 函数来处理运行基准。
{==+==}

{==+==}
> **Note**: The
> [`#[bench]` attribute](https://doc.rust-lang.org/nightly/unstable-book/library-features/test.html)
> is currently unstable and only available on the
> [nightly channel](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html).
> There are some packages available on
> [crates.io](https://crates.io/keywords/benchmark) that may help with
> running benchmarks on the stable channel, such as
> [Criterion](https://crates.io/crates/criterion).
By default, `cargo bench` uses the [`bench` profile], which enables
optimizations and disables debugging information. If you need to debug a
benchmark, you can use the `--profile=dev` command-line option to switch to
the dev profile. You can then run the debug-enabled benchmark within a
debugger.
{==+==}
[`#[bench]属性`](https://doc.rust-lang.org/nightly/unstable-book/library-features/test.html) 目前不稳定，仅在 [nightly channel](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html). 可用。[crates.io](https://crates.io/keywords/benchmark) 上有一些软件包可以帮助在稳定通道上运行基准，例如[Criterion](https://crates.io/crates/criterion)。
默认情况下，货物台架使用台架配置文件，这样可以优化和禁用调试信息。如果您需要调试一个基准，您可以使用 `--profile=dev` 命令行选项切换到dev配置文件。然后，您可以在调试器中运行启用调试的基准。
{==+==}

{==+==}
[`bench` profile]: ../reference/profiles.html#bench
{==+==}
[`bench` profile]: ../reference/profiles.html#bench
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Benchmark Options
{==+==}
### Benchmark 选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---no-run"><a class="option-anchor" href="#option-cargo-bench---no-run"></a><code>--no-run</code></dt>
<dd class="option-desc">Compile, but don't run benchmarks.</dd>


<dt class="option-term" id="option-cargo-bench---no-fail-fast"><a class="option-anchor" href="#option-cargo-bench---no-fail-fast"></a><code>--no-fail-fast</code></dt>
<dd class="option-desc">Run all benchmarks regardless of failure. Without this flag, Cargo will exit
after the first executable fails. The Rust test harness will run all benchmarks
within the executable to completion, this flag only applies to the executable
as a whole.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---no-run"><a class="option-anchor" href="#option-cargo-bench---no-run"></a><code>--no-run</code></dt>
<dd class="option-desc">编译，但是不要运行基准测试。</dd>


<dt class="option-term" id="option-cargo-bench---no-fail-fast"><a class="option-anchor" href="#option-cargo-bench---no-fail-fast"></a><code>--no-fail-fast</code></dt>
<dd class="option-desc">不管失败与否，运行所有基准测试。如果没有这个标志，Cargo将在第一个可执行文件失败后退出。Rust test harness 将运行可执行文件中的所有基准直到完成，这个标志只适用于整个可执行文件。</dd>


</dl>
{==+==}


{==+==}
### Package Selection
{==+==}
### Package 选择
{==+==}

{==+==}
By default, when no package selection options are given, the packages selected
depend on the selected manifest file (based on the current working directory if
`--manifest-path` is not given). If the manifest is the root of a workspace then
the workspaces default members are selected, otherwise only the package defined
by the manifest will be selected.
{==+==}
缺省情况下，当没有给出包选择选项时，所选择的包取决于所选择的清单文件(如果没有给出 `- manifest-path ` ，则基于当前工作目录)。如果清单是工作区的根，则选择工作区的默认成员，否则只选择清单定义的包。
{==+==}

{==+==}
The default members of a workspace can be set explicitly with the
`workspace.default-members` key in the root manifest. If this is not set, a
virtual workspace will include all workspace members (equivalent to passing
`--workspace`), and a non-virtual workspace will include only the root crate itself.
{==+==}
可以使用根清单中的 `workspace.default-members` 键显式设置工作区的默认成员。如果未设置此项，虚拟工作区将包括所有工作区成员（相当于传递 `- workspace ` ），而非虚拟工作区将只包括根机箱本身。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--p"><a class="option-anchor" href="#option-cargo-bench--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-bench---package"><a class="option-anchor" href="#option-cargo-bench---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">Benchmark only the specified packages. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.</dd>


<dt class="option-term" id="option-cargo-bench---workspace"><a class="option-anchor" href="#option-cargo-bench---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">Benchmark all members in the workspace.</dd>



<dt class="option-term" id="option-cargo-bench---all"><a class="option-anchor" href="#option-cargo-bench---all"></a><code>--all</code></dt>
<dd class="option-desc">Deprecated alias for <code>--workspace</code>.</dd>



<dt class="option-term" id="option-cargo-bench---exclude"><a class="option-anchor" href="#option-cargo-bench---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">Exclude the specified packages. Must be used in conjunction with the
<code>--workspace</code> flag. This flag may be specified multiple times and supports
common Unix glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--p"><a class="option-anchor" href="#option-cargo-bench--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-bench---package"><a class="option-anchor" href="#option-cargo-bench---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅对指定的包进行基准测试。SPEC 格式请参考<a href="cargo-pkgid.html">cargo-pkgid(1)</a>。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >?</code >和 <code>[]</code > 。然而，为了避免您的shell在Cargo处理glob模式之前意外扩展它们，您必须在每个模式周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-bench---workspace"><a class="option-anchor" href="#option-cargo-bench---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">Benchmark all members in the workspace.</dd>



<dt class="option-term" id="option-cargo-bench---all"><a class="option-anchor" href="#option-cargo-bench---all"></a><code>--all</code></dt>
<dd class="option-desc"><code>--workspace</code>已弃用的别名</dd>



<dt class="option-term" id="option-cargo-bench---exclude"><a class="option-anchor" href="#option-cargo-bench---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code >标志一起使用。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >？</code > 和 <code>[]</code >。然而，为了避免您的shell在Cargo处理glob模式之前意外扩展它们，您必须在每个模式周围使用单引号或双引号。</dd>


</dl>
{==+==}


{==+==}
### Target Selection
{==+==}
### 目标选择
{==+==}

{==+==}
When no target selection options are given, `cargo bench` will build the
following targets of the selected packages:
{==+==}
当没有给出目标选择选项时，`cargo bench` 将建立所选包装的以下目标:
{==+==}

{==+==}
- lib — used to link with binaries and benchmarks
- bins (only if benchmark targets are built and required features are
  available)
- lib as a benchmark
- bins as benchmarks
- benchmark targets
{==+==}
- lib — 用于链接二进制文件和基准
- bins (仅当构建了基准目标并且所需的特性可用时)
- lib 作为基准
- bins 作为基准
- 基准目标
{==+==}

{==+==}
The default behavior can be changed by setting the `bench` flag for the target
in the manifest settings. Setting examples to `bench = true` will build and
run the example as a benchmark. Setting targets to `bench = false` will stop
them from being benchmarked by default. Target selection options that take a
target by name ignore the `bench` flag and will always benchmark the given
target.
{==+==}
可以通过在清单设置中为目标设置 `bench` 标志来更改默认行为。将示例设置为 `bench = true` 将构建并运行该示例作为基准。默认情况下，将目标设置为 `bench = false` 将会阻止它们进行基准测试。通过名称获取目标的目标选择选项会忽略“bench”标志，并始终以给定目标为基准。
{==+==}

{==+==}
Binary targets are automatically built if there is an integration test or
benchmark being selected to benchmark. This allows an integration
test to execute the binary to exercise and test its behavior. 
The `CARGO_BIN_EXE_<name>`
[environment variable](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates)
is set when the integration test is built so that it can use the
[`env` macro](https://doc.rust-lang.org/std/macro.env.html) to locate the
executable.
{==+==}
如果有一个集成测试或基准被选择来进行基准测试，那么二进制目标将被自动构建。这允许集成测试执行二进制代码来测试它的行为。
 `CARGO_BIN_EXE_<name>` [环境变量](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates) 是在构建集成测试时设置的，以便它可以使用 [`env` macro](https://doc.rust-lang.org/std/macro.env.html) 来定位可执行文件。
{==+==}


{==+==}
Passing target selection flags will benchmark only the specified
targets. 
{==+==}
传递目标选择标志将只对指定的目标进行基准测试。
{==+==}

{==+==}
Note that `--bin`, `--example`, `--test` and `--bench` flags also 
support common Unix glob patterns like `*`, `?` and `[]`. However, to avoid your 
shell accidentally expanding glob patterns before Cargo handles them, you must 
use single quotes or double quotes around each glob pattern.
{==+==}
注意 `--bin`、`--example`、`--test` 和 `--bench` 标志也支持常见的 Unix 全局模式，如 ` *`、`?` 和 `[]`。然而，为了避免您的 shell 在 Cargo 处理 glob 模式之前意外地扩展它们，您必须在每个 glob 模式周围使用单引号或双引号。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---lib"><a class="option-anchor" href="#option-cargo-bench---lib"></a><code>--lib</code></dt>
<dd class="option-desc">Benchmark the package's library.</dd>


<dt class="option-term" id="option-cargo-bench---bin"><a class="option-anchor" href="#option-cargo-bench---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Benchmark the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-bench---bins"><a class="option-anchor" href="#option-cargo-bench---bins"></a><code>--bins</code></dt>
<dd class="option-desc">Benchmark all binary targets.</dd>



<dt class="option-term" id="option-cargo-bench---example"><a class="option-anchor" href="#option-cargo-bench---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">Benchmark the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-bench---examples"><a class="option-anchor" href="#option-cargo-bench---examples"></a><code>--examples</code></dt>
<dd class="option-desc">Benchmark all example targets.</dd>


<dt class="option-term" id="option-cargo-bench---test"><a class="option-anchor" href="#option-cargo-bench---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">Benchmark the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-bench---tests"><a class="option-anchor" href="#option-cargo-bench---tests"></a><code>--tests</code></dt>
<dd class="option-desc">Benchmark all targets in test mode that have the <code>test = true</code> manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the <code>test</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-bench---bench"><a class="option-anchor" href="#option-cargo-bench---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">Benchmark the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-bench---benches"><a class="option-anchor" href="#option-cargo-bench---benches"></a><code>--benches</code></dt>
<dd class="option-desc">Benchmark all targets in benchmark mode that have the <code>bench = true</code>
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the <code>bench</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-bench---all-targets"><a class="option-anchor" href="#option-cargo-bench---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">Benchmark all targets. This is equivalent to specifying <code>--lib --bins --tests --benches --examples</code>.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---lib"><a class="option-anchor" href="#option-cargo-bench---lib"></a><code>--lib</code></dt>
<dd class="option-desc">对软件包的库进行基准测试。</dd>


<dt class="option-term" id="option-cargo-bench---bin"><a class="option-anchor" href="#option-cargo-bench---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">测试指定的二进制文件。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-bench---bins"><a class="option-anchor" href="#option-cargo-bench---bins"></a><code>--bins</code></dt>
<dd class="option-desc">对所有二进制目标进行基准测试。</dd>



<dt class="option-term" id="option-cargo-bench---example"><a class="option-anchor" href="#option-cargo-bench---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">对指定的示例进行基准测试。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-bench---examples"><a class="option-anchor" href="#option-cargo-bench---examples"></a><code>--examples</code></dt>
<dd class="option-desc">对所有示例目标进行基准测试。</dd>


<dt class="option-term" id="option-cargo-bench---test"><a class="option-anchor" href="#option-cargo-bench---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">对指定的集成测试进行基准测试。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-bench---tests"><a class="option-anchor" href="#option-cargo-bench---tests"></a><code>--tests</code></dt>
<dd class="option-desc">在测试模式下对设置了<code>test = true</code > 清单标志的所有目标进行基准测试。默认情况下，这包括作为单元测试和集成测试构建的库和二进制文件。请注意，这也将构建任何所需的依赖项，因此lib目标可以构建两次(一次作为单元测试，一次作为二进制文件、集成测试等的依赖项。).
可以通过在目标的清单设置中设置 <code>test</code> 标志来启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-bench---bench"><a class="option-anchor" href="#option-cargo-bench---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">基准测试指定的基准。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-bench---benches"><a class="option-anchor" href="#option-cargo-bench---benches"></a><code>--benches</code></dt>
<dd class="option-desc">在基准模式下对设置了 <code>bench = true</code> 清单标志的所有目标进行基准测试。默认情况下，这包括作为基准构建的库和二进制文件，以及基准目标。请注意，这也将构建任何所需的依赖项，因此lib目标可能会构建两次(一次作为基准，一次作为二进制文件、基准等的依赖项。).
可以通过在目标的清单设置中设置 <code>bench</code> 标志来启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-bench---all-targets"><a class="option-anchor" href="#option-cargo-bench---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">基准测试所有目标。这相当于指定 <code>--lib --bins --tests --benches --examples</code>。</dd>


</dl>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 特征选项
{==+==}

{==+==}
功能标志允许您控制启用哪些功能。当未给出功能选项时，为每个选定的包激活“默认”功能。
{==+==}
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
请参见 [the features documentation](../reference/features.html#command-line-feature-options) 了解更多详情。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--F"><a class="option-anchor" href="#option-cargo-bench--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-bench---features"><a class="option-anchor" href="#option-cargo-bench---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>


<dt class="option-term" id="option-cargo-bench---all-features"><a class="option-anchor" href="#option-cargo-bench---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>


<dt class="option-term" id="option-cargo-bench---no-default-features"><a class="option-anchor" href="#option-cargo-bench---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--F"><a class="option-anchor" href="#option-cargo-bench--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-bench---features"><a class="option-anchor" href="#option-cargo-bench---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的以空格或逗号分隔的功能列表。可以使用 <code>package-name/feature-name</code> 语法来启用工作区成员的功能。可以多次指定该标志，从而启用所有指定的功能。</dd>


<dt class="option-term" id="option-cargo-bench---all-features"><a class="option-anchor" href="#option-cargo-bench---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定软件包的所有可用功能。</dd>


<dt class="option-term" id="option-cargo-bench---no-default-features"><a class="option-anchor" href="#option-cargo-bench---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要激活所选软件包的 <code>default</code> 功能。</dd>


</dl>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---target"><a class="option-anchor" href="#option-cargo-bench---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Benchmark for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>



<dt class="option-term" id="option-cargo-bench---profile"><a class="option-anchor" href="#option-cargo-bench---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">Benchmark with the given profile.
See the <a href="../reference/profiles.html">the reference</a> for more details on profiles.</dd>



<dt class="option-term" id="option-cargo-bench---ignore-rust-version"><a class="option-anchor" href="#option-cargo-bench---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">Benchmark the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's <code>rust-version</code> field.</dd>



<dt class="option-term" id="option-cargo-bench---timings=fmts"><a class="option-anchor" href="#option-cargo-bench---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">Output information how long each compilation takes, and track concurrency
information over time. Accepts an optional comma-separated list of output
formats; <code>--timings</code> without an argument will default to <code>--timings=html</code>.
Specifying an output format (rather than the default) is unstable and requires
<code>-Zunstable-options</code>. Valid output formats:</p>
<ul>
<li><code>html</code> (unstable, requires <code>-Zunstable-options</code>): Write a human-readable file <code>cargo-timing.html</code> to the
<code>target/cargo-timings</code> directory with a report of the compilation. Also write
a report to the same directory with a timestamp in the filename if you want
to look at older runs. HTML output is suitable for human consumption only,
and does not provide machine-readable timing data.</li>
<li><code>json</code> (unstable, requires <code>-Zunstable-options</code>): Emit machine-readable JSON
information about timing information.</li>
</ul></dd>




</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench---target"><a class="option-anchor" href="#option-cargo-bench---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">给定架构的基准。默认为主机架构。三元组的一般格式是<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。运行 <code>rustc --print target-list</code> 以获取支持的目标列表。可以多次指定该标志.</p>
<p>这也可以用 <code>build.target</code> 来指定
<a href="../reference/config.html">配置值</a>。</p>
<p>注意，指定这个标志会使Cargo以不同的模式运行，其中目标工件被放在一个单独的目录中。有关更多详细信息，请参见 <a href="../guide/build-cache.html">build cache</a> 文档。</dd>



<dt class="option-term" id="option-cargo-bench---profile"><a class="option-anchor" href="#option-cargo-bench---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的 profile 文件进行基准测试。
请参见<a href="../reference/profiles.html ">the reference</a >，了解有关配置文件的更多详细信息。</dd>



<dt class="option-term" id="option-cargo-bench---ignore-rust-version"><a class="option-anchor" href="#option-cargo-bench---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">对目标进行基准测试，即使选择的Rust编译器比
项目的<code>rust-version</code>字段中配置的所需Rust版本。</dd>



<dt class="option-term" id="option-cargo-bench---timings=fmts"><a class="option-anchor" href="#option-cargo-bench---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每次编译需要多长时间的信息，并随着时间的推移跟踪并发信息。接受可选的逗号分隔的输出格式列表；不带参数的 <code>--timings</code> 将默认为 <code>--timings=html</code> 。指定输出格式(而不是默认格式)不稳定，需要 <code>-Zunstable-options</code>。有效的输出格式:</p>
<ul>
<li><code>html</code >(不稳定，需要 <code>-Zunstable-options</code> ):将一个可读的文件 <code>cargo-timing.html</code> 写入 <code>target/cargo-timings</code> 目录，并附上编译报告。如果您想查看以前的运行，也可以在相同的目录下写一个带有时间戳的报告。HTML输出只适合人类使用，不提供机器可读的计时数据。</li>
<li><code>json</code >(不稳定，需要 <code>-Zunstable-options</code> ):发出有关计时信息的机器可读json信息。</li>
</ul></dd>




</dl>
{==+==}

{==+==}
### Output Options
{==+==}
### 输出选项
{==+==}

{==+==}
<dl>
<dt class="option-term" id="option-cargo-bench---target-dir"><a class="option-anchor" href="#option-cargo-bench---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成的工件和中间文件的目录。也可以用<code>CARGO_TARGET_DIR</code>环境变量或<code>build.target-dir</code> <a  ref="../reference/config.html">config value</a>。
默认为工作区根目录中的< code>target</code >。</dd>


</dl>
{==+==}
{==+==}

{==+==}
### Display Options
{==+==}
### 显式选项
{==+==}

{==+==}
By default the Rust test harness hides output from benchmark execution to keep
results readable. Benchmark output can be recovered (e.g., for debugging) by
passing `--nocapture` to the benchmark binaries:
{==+==}
默认情况下，Rust test harness隐藏了基准执行的输出，以保持结果的可读性。通过向基准二进制文件传递  `--nocapture` ,可以恢复基准输出(例如，用于调试):
{==+==}

{==+==}
    cargo bench -- --nocapture
{==+==}
    cargo bench -- --nocapture
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--v"><a class="option-anchor" href="#option-cargo-bench--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-bench---verbose"><a class="option-anchor" href="#option-cargo-bench---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-bench--q"><a class="option-anchor" href="#option-cargo-bench--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-bench---quiet"><a class="option-anchor" href="#option-cargo-bench---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-bench---color"><a class="option-anchor" href="#option-cargo-bench---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>



<dt class="option-term" id="option-cargo-bench---message-format"><a class="option-anchor" href="#option-cargo-bench---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">The output format for diagnostic messages. Can be specified multiple times
and consists of comma-separated values. Valid values:</p>
<ul>
<li><code>human</code> (default): Display in a human-readable text format. Conflicts with
<code>short</code> and <code>json</code>.</li>
<li><code>short</code>: Emit shorter, human-readable text messages. Conflicts with <code>human</code>
and <code>json</code>.</li>
<li><code>json</code>: Emit JSON messages to stdout. See
<a href="../reference/external-tools.html#json-messages">the reference</a>
for more details. Conflicts with <code>human</code> and <code>short</code>.</li>
<li><code>json-diagnostic-short</code>: Ensure the <code>rendered</code> field of JSON messages contains
the &quot;short&quot; rendering from rustc. Cannot be used with <code>human</code> or <code>short</code>.</li>
<li><code>json-diagnostic-rendered-ansi</code>: Ensure the <code>rendered</code> field of JSON messages
contains embedded ANSI color codes for respecting rustc's default color
scheme. Cannot be used with <code>human</code> or <code>short</code>.</li>
<li><code>json-render-diagnostics</code>: Instruct Cargo to not include rustc diagnostics
in JSON messages printed, but instead Cargo itself should render the
JSON diagnostics coming from rustc. Cargo's own JSON diagnostics and others
coming from rustc are still emitted. Cannot be used with <code>human</code> or <code>short</code>.</li>
</ul></dd>



</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench--v"><a class="option-anchor" href="#option-cargo-bench--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-bench---verbose"><a class="option-anchor" href="#option-cargo-bench---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用详细输出。 对于 &quot;非常详细&quot;的输出，可以指定两次，非常详细的输出包括额外的输出，如依赖项警告和构建脚本输出。

也可以用<code>term.verbose</code> <a href="../reference/config.html">配置值</a >.</dd>


<dt class="option-term" id="option-cargo-bench--q"><a class="option-anchor" href="#option-cargo-bench--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-bench---quiet"><a class="option-anchor" href="#option-cargo-bench---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印货物日志信息。也可以用 <code>term.quiet</code> 来指定
<a href= "../reference/config.html " >配置值</a>。</dd>


<dt class="option-term" id="option-cargo-bench---color"><a class="option-anchor" href="#option-cargo-bench---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制何时使用彩色输出。有效值:</p>
<ul>
<li><code>auto</code> (默认):自动检测上是否支持颜色
终端。</li>
<li><code>always</code>:始终显示颜色。</li>
<li><code>never</code>: 从不显示颜色</li>
</ul>
<p>也可以用 <code>term.color</code> 指定
<a href="../reference/config.html">配置值</a>.</dd>



<dt class="option-term" id="option-cargo-bench---message-format"><a class="option-anchor" href="#option-cargo-bench---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">诊断消息的输出格式。可以多次指定，由逗号分隔的值组成。有效值:</p>
<ul>
<li><code>human</code>(默认):以人类可读的文本格式显示。与< code>short</code >和< code>json</code >冲突。</li>
<li><code>short</code>: 发出更短的、人类可读的文本消息。与< code>human</code >和< code>json</code >冲突。</li>
<li><code>json</code>: 向stdout发出JSON消息。 
请参见 <a href= "../reference/external-tools . html # JSON-messages ">the reference</a>
了解更多详情。 与 <code>human</code> 和 <code>short</code> 冲突。</li>
<li><code> json-diagnostic-short </code>:确保JSON消息的<code>rendered</code>字段包含来自rustc的&quot;简短&quot;呈现。不能与<code>human</code> 或 <code>short</code> 一起使用。</li>
<li><code>json-diagnostic-rendered-ansi</code>: Ensure the <code>rendered</code> field of JSON messages
contains embedded ANSI color codes for respecting rustc's default color
scheme. Cannot be used with <code>human</code> or <code>short</code>.</li>
<li><code> json-render-diagnostics </code>:指示Cargo不要在打印的JSON消息中包含rustc诊断，而是Cargo本身应该呈现来自rustc的JSON诊断。Cargo自己的JSON诊断和来自rustc的其他诊断仍然会发出。不能与<code>human</code>或<code>short</code>一起使用。</li>
</ul></dd>



</dl>
{==+==}

{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}

{==+==}
<dl>
<dt class="option-term" id="option-cargo-bench---manifest-path"><a class="option-anchor" href="#option-cargo-bench---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>



<dt class="option-term" id="option-cargo-bench---frozen"><a class="option-anchor" href="#option-cargo-bench---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-bench---locked"><a class="option-anchor" href="#option-cargo-bench---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>


<dt class="option-term" id="option-cargo-bench---offline"><a class="option-anchor" href="#option-cargo-bench---offline"></a><code>--offline</code></dt>
<dd class="option-desc">Prevents Cargo from accessing the network for any reason. Without this
flag, Cargo will stop with an error if it needs to access the network and
the network is not available. With this flag, Cargo will attempt to
proceed without the network if possible.</p>
<p>Beware that this may result in different dependency resolution than online
mode. Cargo will restrict itself to crates that are downloaded locally, even
if there might be a newer version as indicated in the local copy of the index.
See the <a href="cargo-fetch.html">cargo-fetch(1)</a> command to download dependencies before going
offline.</p>
<p>May also be specified with the <code>net.offline</code> <a href="../reference/config.html">config value</a>.</dd>


</dl>
{==+==}
<dl>
<dt class="option-term" id="option-cargo-bench---manifest-path"><a class="option-anchor" href="#option-cargo-bench---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径。默认情况下，Cargo在当前目录或任何父目录中搜索 <code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-bench---frozen"><a class="option-anchor" href="#option-cargo-bench---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-bench---locked"><a class="option-anchor" href="#option-cargo-bench---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求<code>Cargo.lock</code>文件是最新的。如果锁文件丢失，或者需要更新，Cargo将出错退出。<code>--frozen</code>标志还防止 Cargo 试图访问网络以确定其是否过期。</p>
<p>在您希望断言<code>Cargo.lock</code >文件是最新的(如CI构建)或希望避免网络访问的环境中，可以使用这些文件。</dd>


<dt class="option-term" id="option-cargo-bench---offline"><a class="option-anchor" href="#option-cargo-bench---offline"></a><code>--offline</code></dt>
<dd class="option-desc">防止货物以任何理由访问网络。如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，Cargo 将出错停止。有了这个标志，如果可能的话，Cargo将试图在没有网络的情况下前进。</p>
<p>请注意，这可能会导致与在线模式不同的依赖关系解析。Cargo 将自己限制在本地下载的 crate 中，即使在索引的本地副本中可能有更新的版本。
请参阅<a href=" cargo-fetch . html "> cargo-fetch(1)</a>命令，以便在脱机之前下载依赖项。</p>
<p>也可以用<code>net.offline</code> <a ref= "../reference/config.html ">配置值</a>指定。</dd>


</dl>
{==+==}

{==+==}
### Common Options
{==+==}
### 命令选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench-+toolchain"><a class="option-anchor" href="#option-cargo-bench-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>


<dt class="option-term" id="option-cargo-bench---config"><a class="option-anchor" href="#option-cargo-bench---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>


<dt class="option-term" id="option-cargo-bench--h"><a class="option-anchor" href="#option-cargo-bench--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-bench---help"><a class="option-anchor" href="#option-cargo-bench---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>


<dt class="option-term" id="option-cargo-bench--Z"><a class="option-anchor" href="#option-cargo-bench--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-bench-+toolchain"><a class="option-anchor" href="#option-cargo-bench-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经与rustup一起安装，并且<code>cargo</code >的第一个参数以<code>+</code >开头，它将被解释为rustup工具链名称(例如<code>+stable</code >或<code>+nightly</code >)。
有关工具链覆盖如何工作的详细信息，请参阅<a href="https://rust-lang.github.io/rustup/overrides.html">。</dd>


<dt class="option-term" id="option-cargo-bench---config"><a class="option-anchor" href="#option-cargo-bench---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖 Cargo 配置值。参数应该采用<code>KEY=VALUE</code >的TOML语法，或者作为额外配置文件的路径提供。可以多次指定该标志。
请参见< a href="../reference/config.html#command-line-overrides"> 命令行重写部分</a >，了解更多信息。</dd>


<dt class="option-term" id="option-cargo-bench--h"><a class="option-anchor" href="#option-cargo-bench--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-bench---help"><a class="option-anchor" href="#option-cargo-bench---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-bench--Z"><a class="option-anchor" href="#option-cargo-bench--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定(night-only)标志。运行<code>cargo -Z help</code >获取详细信息。</dd>


</dl>
{==+==}


{==+==}
### Miscellaneous Options
{==+==}
{==+==}

{==+==}
The `--jobs` argument affects the building of the benchmark executable but
does not affect how many threads are used when running the benchmarks. The
Rust test harness runs benchmarks serially in a single thread.
{==+==}
`--jobs` 参数影响基准可执行文件的构建，但不影响运行基准时使用的线程数量。Rust test harness在单线程中连续运行基准测试。
{==+==}

{==+==}
<dl>
<dt class="option-term" id="option-cargo-bench--j"><a class="option-anchor" href="#option-cargo-bench--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-bench---jobs"><a class="option-anchor" href="#option-cargo-bench---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>


<dt class="option-term" id="option-cargo-bench---keep-going"><a class="option-anchor" href="#option-cargo-bench---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>


</dl>
{==+==}
<dl>
<dt class="option-term" id="option-cargo-bench--j"><a class="option-anchor" href="#option-cargo-bench--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-bench---jobs"><a class="option-anchor" href="#option-cargo-bench---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">要运行的并行作业的数量。也可以用<code>build.jobs</code> <a href= "../reference/config.html " >配置值</a>指定。 默认为逻辑CPU的数量。如果为负，它将并行作业的最大数量设置为逻辑CPU的数量加上提供的值。不应为0。</dd>


<dt class="option-term" id="option-cargo-bench---keep-going"><a class="option-anchor" href="#option-cargo-bench---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">在依赖图中构建尽可能多的板条箱，而不是在第一个构建失败时中止构建。不稳定，需要< code>-Zunstable-options</code >。</dd>


</dl>
{==+==}

{==+==}
## ENVIRONMENT
{==+==}
## 环境
{==+==}

{==+==}
参见 [参考文献](../reference/environment-variables . html) 以了解Cargo读取的环境变量的详细信息。
{==+==}
{==+==}


{==+==}
## EXIT STATUS
{==+==}
## 退出状态
{==+==}

{==+==}
* `0`: Cargo succeeded.
* `101`: Cargo failed to complete.
{==+==}
* `0 `: Cargo 成功。
* `101 `: Cargo 未能完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}

{==+==}
1. Build and execute all the benchmarks of the current package:

       cargo bench

2. Run only a specific benchmark within a specific benchmark target:

       cargo bench --bench bench_name -- modname::some_benchmark
{==+==}
1. 构建并执行当前包的所有基准:

       cargo bench

2. 仅运行特定基准目标中的特定基准:

       cargo bench --bench bench_name -- modname::some_benchmark
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 另见
{==+==}
{==+==}
[cargo(1)](cargo.html), [cargo-test(1)](cargo-test.html)
{==+==}
[cargo(1)](cargo.html), [cargo-test(1)](cargo-test.html)
{==+==}
