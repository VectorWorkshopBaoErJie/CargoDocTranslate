{==+==}
# cargo-test(1)
{==+==}
{==+==}




{==+==}
## NAME
{==+==}
## 定义
{==+==}

{==+==}
cargo-test - Execute unit and integration tests of a package
{==+==}
cargo-test - 对包执行单元测试和集成测试
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo test` [_options_] [_testname_] [`--` _test-options_]
{==+==}
{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}

{==+==}
Compile and execute unit, integration, and documentation tests.
{==+==}
编译并执行单元测试、集成测试以及文档测试。
{==+==}

{==+==}
The test filtering argument `TESTNAME` and all the arguments following the two
dashes (`--`) are passed to the test binaries and thus to _libtest_ (rustc's
built in unit-test and micro-benchmarking framework).  If you're passing
arguments to both Cargo and the binary, the ones after `--` go to the binary,
the ones before go to Cargo.  For details about libtest's arguments see the
output of `cargo test -- --help` and check out the rustc book's chapter on
how tests work at <https://doc.rust-lang.org/rustc/tests/index.html>.
{==+==}
测试会过滤参数 `TESTNAME` 和所有两个破折号(--)开头的参数，
并将它们被传递给测试二进制文件，进而传递给 _libtest_(rustc 的内置单元测试和宏基准框架)。
如果你同时向Cargo和二进制文件传递参数，那么 `--` 后面的参数会传给二进制文件，前面的参数会传给 Cargo。
关于 libtest 参数的细节，请参见 `cargo test --help` 的输出，并查看 the rustc book 中关于测试如何工作的章节
<https://doc.rust-lang.org/rustc/tests/index.html>。
{==+==}

{==+==}
As an example, this will filter for tests with `foo` in their name and run them
on 3 threads in parallel:
{==+==}
下面这个例子，将过滤名称中含有foo的测试，并在3个线程中并行运行:
{==+==}

{==+==}
    cargo test foo -- --test-threads 3
{==+==}
{==+==}

{==+==}
Tests are built with the `--test` option to `rustc` which creates a special
executable by linking your code with libtest. The executable automatically
runs all functions annotated with the `#[test]` attribute in multiple threads.
`#[bench]` annotated functions will also be run with one iteration to verify
that they are functional.
{==+==}
测试是用 `rustc` 的 `--test` 选项建立的，它通过将你的代码与 libtest 链接来创建一个特殊的可执行文件。
这个可执行文件会自动在多个线程中运行所有带有 `#[test]` 属性注释的函数。
`#[bench]` 注释的函数也将被运行一次，以验证它们是否正常。
{==+==}

{==+==}
If the package contains multiple test targets, each target compiles to a
special executable as aforementioned, and then is run serially.
{==+==}
如果软件包包含多个测试目标，每个目标都会像前面提到的那样编译成一个特殊的可执行文件，然后被串行地运行。
{==+==}

{==+==}
The libtest harness may be disabled by setting `harness = false` in the target
manifest settings, in which case your code will need to provide its own `main`
function to handle running tests.
{==+==}
可以在目标清单设置中设置 `harness = false` 来禁用 libtest harness ，
在这种情况下，你的代码需要提供自己的 `main` 函数来处理运行测试。
{==+==}

{==+==}
### Documentation tests
{==+==}
### 文档测试
{==+==}

{==+==}
Documentation tests are also run by default, which is handled by `rustdoc`. It
extracts code samples from documentation comments of the library target, and
then executes them.
{==+==}
文档测试也是默认运行的，这是由 `rustdoc` 处理的。
它从库目标的文档注释中提取代码样本，然后执行它们。
{==+==}

{==+==}
Different from normal test targets, each code block compiles to a doctest
executable on the fly with `rustc`. These executables run in parallel in
separate processes. The compilation of a code block is in fact a part of test
function controlled by libtest, so some options such as `--jobs` might not
take effect. Note that this execution model of doctests is not guaranteed
and may change in the future; beware of depending on it.
{==+==}
与普通的测试目标不同，每个代码块都通过 `rustc` 编译成一个 doctest 可执行文件。
这些可执行文件在不同的进程中并行运行。
代码块的编译实际上是由 libtest 控制的测试功能的一部分，所以一些选项如 `--job` 可能不会生效。
请注意，doctests 的这种执行模式是不被保证的，将来可能会发生变化;谨慎依赖它。
{==+==}

{==+==}
See the [rustdoc book](https://doc.rust-lang.org/rustdoc/) for more information
on writing doc tests.
{==+==}
关于编写文档测试的更多信息，请参见 [rustdoc book](https://doc.rust-lang.org/rustdoc/)。
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Test Options
{==+==}
### 测试选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---no-run"><a class="option-anchor" href="#option-cargo-test---no-run"></a><code>--no-run</code></dt>
<dd class="option-desc">Compile, but don't run tests.</dd>


<dt class="option-term" id="option-cargo-test---no-fail-fast"><a class="option-anchor" href="#option-cargo-test---no-fail-fast"></a><code>--no-fail-fast</code></dt>
<dd class="option-desc">Run all tests regardless of failure. Without this flag, Cargo will exit
after the first executable fails. The Rust test harness will run all tests
within the executable to completion, this flag only applies to the executable
as a whole.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---no-run"><a class="option-anchor" href="#option-cargo-test---no-run"></a><code>--no-run</code></dt>
<dd class="option-desc">编译，但不运行测试。</dd>


<dt class="option-term" id="option-cargo-test---no-fail-fast"><a class="option-anchor" href="#option-cargo-test---no-fail-fast"></a><code>--no-fail-fast</code></dt>
<dd class="option-desc">运行所有的测试，无论是否失败。
如果没有这个标志，Cargo 会在第一个可执行程序失败后退出。
Rust test harness 会运行可执行文件中的所有测试，
这个标志只适用于整个可执行文件。</dd>


</dl>
{==+==}


{==+==}
### Package Selection
{==+==}
### 选择包
{==+==}

{==+==}
By default, when no package selection options are given, the packages selected
depend on the selected manifest file (based on the current working directory if
`--manifest-path` is not given). If the manifest is the root of a workspace then
the workspaces default members are selected, otherwise only the package defined
by the manifest will be selected.
{==+==}
默认情况下，当没有给出包选择选项时，选择的软件包取决于所选的清单文件
(如果没有给出 `--manifest-path` ，则基于当前工作目录)。
如果清单在工作空间的根目录，那么将选择工作空间的默认成员，否则将只选择清单定义的包。
{==+==}

{==+==}
The default members of a workspace can be set explicitly with the
`workspace.default-members` key in the root manifest. If this is not set, a
virtual workspace will include all workspace members (equivalent to passing
`--workspace`), and a non-virtual workspace will include only the root crate itself.
{==+==}
工作空间的默认成员可通过根清单中的 `workspace.default-members` 键显式设置。
如果没有设置，虚拟工作空间将包括所有工作空间成员(相当于通过 `--workspace`)，而非虚拟工作区将只包括根 crate 本身。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--p"><a class="option-anchor" href="#option-cargo-test--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-test---package"><a class="option-anchor" href="#option-cargo-test---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">Test only the specified packages. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell accidentally
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.</dd>


<dt class="option-term" id="option-cargo-test---workspace"><a class="option-anchor" href="#option-cargo-test---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">Test all members in the workspace.</dd>



<dt class="option-term" id="option-cargo-test---all"><a class="option-anchor" href="#option-cargo-test---all"></a><code>--all</code></dt>
<dd class="option-desc">Deprecated alias for <code>--workspace</code>.</dd>



<dt class="option-term" id="option-cargo-test---exclude"><a class="option-anchor" href="#option-cargo-test---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">Exclude the specified packages. Must be used in conjunction with the
<code>--workspace</code> flag. This flag may be specified multiple times and supports
common Unix glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--p"><a class="option-anchor" href="#option-cargo-test--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-test---package"><a class="option-anchor" href="#option-cargo-test---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只测试指定的软件包。 关于SPEC的格式，见<a href="cargo-pkgid.html">cargo-pkgid(1)</a>。
这个标志可以指定多次，并支持常见的 Unix glob pattern，比如
<code>*</code>, <code>?</code> 和 <code>[]</code>。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，你必须在每个 pattern 周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-test---workspace"><a class="option-anchor" href="#option-cargo-test---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">测试工作空间中的所有成员。</dd>



<dt class="option-term" id="option-cargo-test---all"><a class="option-anchor" href="#option-cargo-test---all"></a><code>--all</code></dt>
<dd class="option-desc"> <code>--workspace</code>的别名，已弃用。</dd>



<dt class="option-term" id="option-cargo-test---exclude"><a class="option-anchor" href="#option-cargo-test---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。 必须与<code>--workspace</code>标志一起使用。
这个标志可以被多次指定，并且支持常见的 Unix glob pattern，比如
<code>*</code>, <code>?</code> 和 <code>[]</code>。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，你必须在每个 pattern 周围使用单引号或双引号。</dd>



</dl>
{==+==}


{==+==}
### Target Selection
{==+==}
### 选择目标
{==+==}

{==+==}
When no target selection options are given, `cargo test` will build the
following targets of the selected packages:

- lib — used to link with binaries, examples, integration tests, and doc tests
- bins (only if integration tests are built and required features are
  available)
- examples — to ensure they compile
- lib as a unit test
- bins as unit tests
- integration tests
- doc tests for the lib target

The default behavior can be changed by setting the `test` flag for the target
in the manifest settings. Setting examples to `test = true` will build and run
the example as a test. Setting targets to `test = false` will stop them from
being tested by default. Target selection options that take a target by name
ignore the `test` flag and will always test the given target.
{==+==}
当没有给出目标选择选项时， `cargo test` 将构建所选软件包的以下目标。

- lib - 用于与二进制文件、示例、集成测试和文档测试链接
- bins (只有在集成测试已经建立并且所需 feature 可用的情况下)
- examples - 确保它们能编译
- lib 作为一个单元测试
- bins 作为单元测试
- integration tests 集成测试
- doc tests 对于类库构建目标的文档测试


可以通过在清单设置中为目标设置 `test` 标志来改变默认行为。
将 examples 设置为 `test = true` 会将 examples 作为测试来构建和运行。
将目标设置为 `test = false` 默认不会对其进行测试。
根据目标名称选择目标的选项会忽略 `test` 标志，并总是测试给定的目标。
{==+==}

Doc tests for libraries may be disabled by setting `doctest = false` for the
library in the manifest.

Binary targets are automatically built if there is an integration test or
benchmark being selected to test. This allows an integration
test to execute the binary to exercise and test its behavior.
The `CARGO_BIN_EXE_<name>`
[environment variable](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates)
is set when the integration test is built so that it can use the
[`env` macro](https://doc.rust-lang.org/std/macro.env.html) to locate the
executable.
{==+==}
可以通过在清单中为类库设置 `doctest = false` 来禁用类库的文档测试。


如果选择测试集成测试或性能测试，则自动构建二进制目标。
这样集成测试可以执行二进制文件来测试其行为。
环境变量 `CARGO_BIN_EXE_<name>` [environment variable](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates)
在集成测试构建时被设置，以便它能使用 [`env` macro](https://doc.rust-lang.org/std/macro.env.html)
来定位可执行文件。
{==+==}


{==+==}
Passing target selection flags will test only the specified
targets.

Note that `--bin`, `--example`, `--test` and `--bench` flags also
support common Unix glob patterns like `*`, `?` and `[]`. However, to avoid your
shell accidentally expanding glob patterns before Cargo handles them, you must
use single quotes or double quotes around each glob pattern.
{==+==}
传递目标选择标志将只测试指定的目标。

注意 `--bin`, `--example`, `--test` 和 `--bench` 标志也支持常见的 Unix glob pattern，如 `*`, `?` 和 `[]` 。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，你必须在每个 glob pattern 周围使用单引号或双引号。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---lib"><a class="option-anchor" href="#option-cargo-test---lib"></a><code>--lib</code></dt>
<dd class="option-desc">Test the package's library.</dd>


<dt class="option-term" id="option-cargo-test---bin"><a class="option-anchor" href="#option-cargo-test---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Test the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-test---bins"><a class="option-anchor" href="#option-cargo-test---bins"></a><code>--bins</code></dt>
<dd class="option-desc">Test all binary targets.</dd>



<dt class="option-term" id="option-cargo-test---example"><a class="option-anchor" href="#option-cargo-test---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">Test the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-test---examples"><a class="option-anchor" href="#option-cargo-test---examples"></a><code>--examples</code></dt>
<dd class="option-desc">Test all example targets.</dd>


<dt class="option-term" id="option-cargo-test---test"><a class="option-anchor" href="#option-cargo-test---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">Test the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-test---tests"><a class="option-anchor" href="#option-cargo-test---tests"></a><code>--tests</code></dt>
<dd class="option-desc">Test all targets in test mode that have the <code>test = true</code> manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the <code>test</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-test---bench"><a class="option-anchor" href="#option-cargo-test---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">Test the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-test---benches"><a class="option-anchor" href="#option-cargo-test---benches"></a><code>--benches</code></dt>
<dd class="option-desc">Test all targets in benchmark mode that have the <code>bench = true</code>
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the <code>bench</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-test---all-targets"><a class="option-anchor" href="#option-cargo-test---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">Test all targets. This is equivalent to specifying <code>--lib --bins --tests --benches --examples</code>.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---lib"><a class="option-anchor" href="#option-cargo-test---lib"></a><code>--lib</code></dt>
<dd class="option-desc">测试包的类库。</dd>


<dt class="option-term" id="option-cargo-test---bin"><a class="option-anchor" href="#option-cargo-test---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">测试指定的二进制文件。这个标志可以被多次指定，并且支持常见的 Unix glob pattern 。</dd>


<dt class="option-term" id="option-cargo-test---bins"><a class="option-anchor" href="#option-cargo-test---bins"></a><code>--bins</code></dt>
<dd class="option-desc">测试所有二进制目标。</dd>



<dt class="option-term" id="option-cargo-test---example"><a class="option-anchor" href="#option-cargo-test---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">测试指定的例子。这个标志可以被多次指定，并且支持常见的 Unix glob pattern 。</dd>


<dt class="option-term" id="option-cargo-test---examples"><a class="option-anchor" href="#option-cargo-test---examples"></a><code>--examples</code></dt>
<dd class="option-desc">测试所有的例子目标。</dd>


<dt class="option-term" id="option-cargo-test---test"><a class="option-anchor" href="#option-cargo-test---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">测试指定的集成测试。这个标志可以被多次指定，并且支持常见的 Unix glob pattern 。</dd>


<dt class="option-term" id="option-cargo-test---tests"><a class="option-anchor" href="#option-cargo-test---tests"></a><code>--tests</code></dt>
<dd class="option-desc">在测试模式下测试所有在清单中设置了 <code>test = true</code> 标志的目标。
默认情况下，这包括作为单元测试与集成测试构建的库和二进制文件。
请注意，这也会构建任何所需的依赖项，因此 lib 目标可能会被构建两次(一次作为单元测试，另一次作为二进制文件、集成测试等的依赖项)。
通过在目标的清单设置中设置 <code>test</code> 标志，可以启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-test---bench"><a class="option-anchor" href="#option-cargo-test---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">测试指定的性能测试。这个标志可以被多次指定，并且支持常见的 Unix glob pattern 。</dd>


<dt class="option-term" id="option-cargo-test---benches"><a class="option-anchor" href="#option-cargo-test---benches"></a><code>--benches</code></dt>
<dd class="option-desc">在性能测试模式下测试所有设置了 <code>bench = true</code> 清单标志的目标。
默认情况下，这包括作为性能测试构建的库和二进制文件，以及性能测试目标。
请注意，这也会构建任何所需的依赖项，因此lib目标可能会被构建两次(一次是作为基准，一次是作为二进制文件、性能测试等的依赖项)。
通过在目标的清单设置中设置 <code>bench</code> 标志，可以启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-test---all-targets"><a class="option-anchor" href="#option-cargo-test---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">测试所有目标。 相当于指定 <code>--lib --bins --tests --benches --examples</code>.</dd>


</dl>
{==+==}


{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---doc"><a class="option-anchor" href="#option-cargo-test---doc"></a><code>--doc</code></dt>
<dd class="option-desc">Test only the library's documentation. This cannot be mixed with other
target options.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---doc"><a class="option-anchor" href="#option-cargo-test---doc"></a><code>--doc</code></dt>
<dd class="option-desc">只测试库的文档。这不能与其他目标选项混合使用。</dd>


</dl>
{==+==}

{==+==}
### Feature Selection
{==+==}
### 选择 Feature
{==+==}

{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
feature 标志允许你控制哪些功能被启用。当没有给出特性选项时，每个选定的包都会激活 `default` 的 feature 。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
更多细节请参见[the features documentation](../reference/features.html#command-line-feature-options)。
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--F"><a class="option-anchor" href="#option-cargo-test--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-test---features"><a class="option-anchor" href="#option-cargo-test---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>


<dt class="option-term" id="option-cargo-test---all-features"><a class="option-anchor" href="#option-cargo-test---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>


<dt class="option-term" id="option-cargo-test---no-default-features"><a class="option-anchor" href="#option-cargo-test---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--F"><a class="option-anchor" href="#option-cargo-test--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-test---features"><a class="option-anchor" href="#option-cargo-test---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">
要激活的 feature 用空格或逗号分隔的列表指定。工作空间成员的 feature 可以用 <code>package-name/feature-name</code> 的语法来启用。
这个标志可以被多次指定，这样可以启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-test---all-features"><a class="option-anchor" href="#option-cargo-test---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定包的所有可用 feature 。</dd>


<dt class="option-term" id="option-cargo-test---no-default-features"><a class="option-anchor" href="#option-cargo-test---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不激活所选包的 <code>default</code> 特性。</dd>


</dl>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test---target"><a class="option-anchor" href="#option-cargo-test---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Test for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>



<dt class="option-term" id="option-cargo-test--r"><a class="option-anchor" href="#option-cargo-test--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-test---release"><a class="option-anchor" href="#option-cargo-test---release"></a><code>--release</code></dt>
<dd class="option-desc">Test optimized artifacts with the <code>release</code> profile.
See also the <code>--profile</code> option for choosing a specific profile by name.</dd>



<dt class="option-term" id="option-cargo-test---profile"><a class="option-anchor" href="#option-cargo-test---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">Test with the given profile.
See the <a href="../reference/profiles.html">the reference</a> for more details on profiles.</dd>



<dt class="option-term" id="option-cargo-test---ignore-rust-version"><a class="option-anchor" href="#option-cargo-test---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">Test the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's <code>rust-version</code> field.</dd>



<dt class="option-term" id="option-cargo-test---timings=fmts"><a class="option-anchor" href="#option-cargo-test---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
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

<dt class="option-term" id="option-cargo-test---target"><a class="option-anchor" href="#option-cargo-test---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">指定架构的测试。 默认为宿主机的架构。三元组的通用格式为
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。运行 <code>rustc --print target-list</code> 来获取支持的目标列表。
这个标志可以指定多次。</p>
<p>这也可以与 <code>build.target</code>
<a href="../reference/config.html">config value</a> 一起使用。</p>
<p>
注意，指定这个标志会使 Cargo 在不同的模式下运行，目标 artifacts 被放在一个单独的目录中。
更多细节请参见 <a href="../guide/build-cache.html">build cache</a> 文档。</dd>



<dt class="option-term" id="option-cargo-test--r"><a class="option-anchor" href="#option-cargo-test--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-test---release"><a class="option-anchor" href="#option-cargo-test---release"></a><code>--release</code></dt>
<dd class="option-desc">
用 <code>release</code> 配置文件测试优化的 artifacts 。
请参阅 <code>--profile</code> 选项，通过名称选择一个特定的配置文件。</dd>



<dt class="option-term" id="option-cargo-test---profile"><a class="option-anchor" href="#option-cargo-test---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的配置文件进行测试。
关于配置文件的更多细节，请参见 <a href="../reference/profiles.html">the reference</a> 。</dd>



<dt class="option-term" id="option-cargo-test---ignore-rust-version"><a class="option-anchor" href="#option-cargo-test---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">
即使选择的 Rust 编译器比项目的 <code>rust-version</code> 字段中配置的所需的Rust版本要低，也要测试目标。</dd>



<dt class="option-term" id="option-cargo-test---timings=fmts"><a class="option-anchor" href="#option-cargo-test---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">
输出每次编译所需时间的信息，并跟踪一段时间的并发信息。
接受一个可选的逗号分隔的输出格式列表;
没有参数的 <code>--timings</code> 将默认为 <code>--timings=html</code> 。
指定一个输出格式(而不是默认的)是不稳定的，需要 <code>-Zunstable-options</code> 。
有效的输出格式:</p>
<ul>
<li><code>html</code> (不稳定，需要 <code>-Zunstable-options</code>):
在 <code>target/cargo-timings</code> 目录下写一个方便阅读的文件 <code>cargo-timing.html</code> ，并附上编译报告 。
如果你想查看更早的运行情况，也可以在同一目录下写一份文件名中带有时间戳报告。
HTML输出只适合用户使用，并不提供机器可读的计时数据。</li>
<li><code>json</code> (不稳定，需要 <code>-Zunstable-options</code>):
发出机器可读的JSON格式的计时信息。</li>
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
<dt class="option-term" id="option-cargo-test---target-dir"><a class="option-anchor" href="#option-cargo-test---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to <code>target</code> in the root of the workspace.</dd>


</dl>
{==+==}
<dl>
<dt class="option-term" id="option-cargo-test---target-dir"><a class="option-anchor" href="#option-cargo-test---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">
所有生成的 artifacts 和中间文件的目录。
也可以用 <code>CARGO_TARGET_DIR</code> 环境变量或
<code>build.target-dir</code> <a href="../reference/config.html">config value</a> 来指定。
默认为工作空间根目录下的 <code>target</code> 。</dd>


</dl>
{==+==}

{==+==}
### Display Options
{==+==}
### 输出选项
{==+==}

{==+==}
By default the Rust test harness hides output from test execution to keep
results readable. Test output can be recovered (e.g., for debugging) by passing
`--nocapture` to the test binaries:

    cargo test -- --nocapture
{==+==}
默认情况下，Rust test harness 会隐藏测试执行的输出，以保持结果的可读性。
测试输出可以通过向测试二进制文件传递 `--nocapture` 来恢复(例如，用于调试):

    cargo test -- --nocapture
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--v"><a class="option-anchor" href="#option-cargo-test--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-test---verbose"><a class="option-anchor" href="#option-cargo-test---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-test--q"><a class="option-anchor" href="#option-cargo-test--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-test---quiet"><a class="option-anchor" href="#option-cargo-test---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-test---color"><a class="option-anchor" href="#option-cargo-test---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>



<dt class="option-term" id="option-cargo-test---message-format"><a class="option-anchor" href="#option-cargo-test---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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

<dt class="option-term" id="option-cargo-test--v"><a class="option-anchor" href="#option-cargo-test--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-test---verbose"><a class="option-anchor" href="#option-cargo-test---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用 verbose 级别输出详细信息。 指定两次此选项来输出 &quot;十分详细&quot; 的输出信息，
这会包含额外的输出信息，比如依赖警告和构建脚本输出。
也可以与 <code>term.verbose</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-test--q"><a class="option-anchor" href="#option-cargo-test--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-test---quiet"><a class="option-anchor" href="#option-cargo-test---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印任何 cargo 日志信息。
也可以与 <code>term.quiet</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-test---color"><a class="option-anchor" href="#option-cargo-test---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制的日志的颜色。 有效的值如下:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端颜色支持是否可用。</li>
<li><code>always</code>: 总是带颜色显示。</li>
<li><code>never</code>: 不带颜色显示.</li>
</ul>
<p>也可以与 <code>term.color</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>



<dt class="option-term" id="option-cargo-test---message-format"><a class="option-anchor" href="#option-cargo-test---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">诊断信息的输出格式。可以多次指定，由逗号分隔的数值组成。有效值:</p>
<ul>

<li><code>human</code> (默认): 以人类可读的文本格式显示。与
<code>short</code> 和 <code>json</code>冲突。</li>

<li><code>short</code>: 生成更短的、人类可读的文本信息。 与<code>human</code>
和 <code>json</code> 冲突。</li>

<li><code>json</code>: 生成 JSON 信息输出到 stdout. 更多细节请参见
<a href="../reference/external-tools.html#json-messages">the reference</a>。
与 <code>human</code> 和 <code>short</code>冲突。</li>

<li><code>json-diagnostic-short</code>: 确保 JSON 信息的 <code>rendered</code> 包含来自 rustc 的 &quot;short&quot; 渲染。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>

<li><code>json-diagnostic-rendered-ansi</code>: 确保 JSON 信息的 <code>rendered</code> 包含
嵌入式ANSI颜色代码来兼容 rustc 的默认颜色方案。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>

<li><code>json-render-diagnostics</code>: 指示 Cargo 在打印的JSON信息中不包含 rustc 的诊断信息，
而是由 Cargo 自己来渲染来自 rustc 的 JSON 诊断信息。
Cargo 自己的 JSON 诊断程序和其他来自 rustc 的诊断程序仍然会被生成出来。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>
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

<dt class="option-term" id="option-cargo-test---manifest-path"><a class="option-anchor" href="#option-cargo-test---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>



<dt class="option-term" id="option-cargo-test---frozen"><a class="option-anchor" href="#option-cargo-test---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-test---locked"><a class="option-anchor" href="#option-cargo-test---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>


<dt class="option-term" id="option-cargo-test---offline"><a class="option-anchor" href="#option-cargo-test---offline"></a><code>--offline</code></dt>
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

<dt class="option-term" id="option-cargo-test---manifest-path"><a class="option-anchor" href="#option-cargo-test---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径. 默认情况下，Cargo 会在当前目录或任何父目录下搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-test---frozen"><a class="option-anchor" href="#option-cargo-test---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-test---locked"><a class="option-anchor" href="#option-cargo-test---locked"></a><code>--locked</code></dt>

<dd class="option-desc">这两个标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果 .lock 文件缺失，或者需要更新，Cargo 将以错误退出。
<code>--frozen</code> 标志也可以防止 Cargo 访问网络以确定其是否过期。</p>
<p>
这些可以用于需要判断 <code>Cargo.lock</code> 文件是否最新（比如CI构建）或者想避免网络访问的环境中。</dd>


<dt class="option-term" id="option-cargo-test---offline"><a class="option-anchor" href="#option-cargo-test---offline"></a><code>--offline</code></dt>


<dd class="option-desc">
禁止 Cargo 在任何情况下访问网络。
如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，它会以错误的方式停止。
有了这个标志，Cargo会尝试在没有网络的情况下进行。</p>

<p>请注意，这可能会导致与在线模式不同的依赖方案。Cargo 会将自己限制在本地的 crate 仓库上，
即使在本地拷贝的索引中可能有更新的版本也是如此。
参见 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令来在离线前下载依赖关系。</p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">config value</a> 来指定。</dd>



</dl>
{==+==}

{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test-+toolchain"><a class="option-anchor" href="#option-cargo-test-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>


<dt class="option-term" id="option-cargo-test---config"><a class="option-anchor" href="#option-cargo-test---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>


<dt class="option-term" id="option-cargo-test--h"><a class="option-anchor" href="#option-cargo-test--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-test---help"><a class="option-anchor" href="#option-cargo-test---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>


<dt class="option-term" id="option-cargo-test--Z"><a class="option-anchor" href="#option-cargo-test--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>


</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test-+toolchain"><a class="option-anchor" href="#option-cargo-test-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 已经和 rustup 一起安装, 并且 <code>cargo</code> 的第一个参数以
<code>+</code> 开头, 它将被解释为一个rustup工具链的名字 (比如 <code>+stable</code> 或者 <code>+nightly</code>)。
更多关于工具链覆盖工作的信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
</dd>


<dt class="option-term" id="option-cargo-test---config"><a class="option-anchor" href="#option-cargo-test---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖一个 Cargo 配置值。参数应该使用 TOML 的 <code>KEY=VALUE</code> 语法，或者提供一个额外配置文件的路径。
这个标志可以被多次指定。更多信息请参见 <a href="../reference/config.html#command-line-overrides">command-line overrides section</a>。</dd>


<dt class="option-term" id="option-cargo-test--h"><a class="option-anchor" href="#option-cargo-test--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-test---help"><a class="option-anchor" href="#option-cargo-test---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-test--Z"><a class="option-anchor" href="#option-cargo-test--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (仅限 nightly 版本) 标志。 更多信息请运行 <code>cargo -Z help</code>。</dd>


</dl>
{==+==}


{==+==}
### Miscellaneous Options
{==+==}
### 其他选项
{==+==}

{==+==}
The `--jobs` argument affects the building of the test executable but does not
affect how many threads are used when running the tests. The Rust test harness
includes an option to control the number of threads used:

    cargo test -j 2 -- --test-threads=2
{==+==}
`--jobs` 参数会影响测试可执行文件的构建，但不影响运行测试时使用多少个线程。
Rust test harness 包括一个选项来控制使用的线程数:

    cargo test -j 2 -- --test-threads=2
{==+==}

{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--j"><a class="option-anchor" href="#option-cargo-test--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-test---jobs"><a class="option-anchor" href="#option-cargo-test---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>


<dt class="option-term" id="option-cargo-test---keep-going"><a class="option-anchor" href="#option-cargo-test---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>


<dt class="option-term" id="option-cargo-test---future-incompat-report"><a class="option-anchor" href="#option-cargo-test---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">Displays a future-incompat report for any future-incompatible warnings
produced during execution of this command</p>
<p>See <a href="cargo-report.html">cargo-report(1)</a></dd>



</dl>
{==+==}
<dl>

<dt class="option-term" id="option-cargo-test--j"><a class="option-anchor" href="#option-cargo-test--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-test---jobs"><a class="option-anchor" href="#option-cargo-test---jobs"></a><code>--jobs</code> <em>N</em></dt>
要运行的并行作业的数量。也可以通过 build.jobs 配置值来指定。默认为逻辑CPU的数量。如果是负数，它将最大的并行作业数量设置为逻辑CPU的数量加上所提供的值。不应该是0。
<dd class="option-desc">要运行的并行作业的数量。
也可以通过 <code>build.jobs</code> <a href="../reference/config.html">config value</a> 配置值来指定。
默认为逻辑CPU的数量。如果是负数，它将最大的并行作业数量设置为逻辑CPU的数量加上所提供的值。不应该是0。
</dd>


<dt class="option-term" id="option-cargo-test---keep-going"><a class="option-anchor" href="#option-cargo-test---keep-going"></a><code>--keep-going</code></dt>
尽可能多地构建依赖关系图中的板块，而不是在第一个失败的板块上中止构建。不稳定，需要 -Zunstable-options。
<dd class="option-desc">尽可能多地构建依赖关系图中的 crates, 而不是有一个 crate 构建失败则中止构建。
不稳定，需要 <code>-Zunstable-options</code>。</dd>


<dt class="option-term" id="option-cargo-test---future-incompat-report"><a class="option-anchor" href="#option-cargo-test---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">展示一个未来兼容性报告(future-incompat report)，显示在执行此命令过程中产生的任何未来不兼容(future-incompatible)的警告</p>
<p>请参阅 <a href="cargo-report.html">cargo-report(1)</a></dd>



</dl>
{==+==}

{==+==}
## ENVIRONMENT
{==+==}
## 环境
{==+==}

{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
更多关于 Cargo 读取的环境变量信息，请参见[the reference](../reference/environment-variables.html)。
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
* `0`: Cargo 成功退出.
* `101`: Cargo 错误退出.
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}

{==+==}
1. Execute all the unit and integration tests of the current package:

       cargo test

2. Run only tests whose names match against a filter string:

       cargo test name_filter

3. Run only a specific test within a specific integration test:

       cargo test --test int_test_name -- modname::test_name
{==+==}
1. 执行当前包的所有单元和集成测试:

       cargo test

2. 只运行名称与过滤字符串匹配的测试:

       cargo test name_filter

3. 在一个特定的集成测试中只运行一个特定的测试:

       cargo test --test int_test_name -- modname::test_name
{==+==}

{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-bench(1)](cargo-bench.html), [types of tests](../reference/cargo-targets.html#tests), [how to write tests](https://doc.rust-lang.org/rustc/tests/index.html)
{==+==}
## 另请参见
[cargo(1)](cargo.html), [cargo-bench(1)](cargo-bench.html), [types of tests](../reference/cargo-targets.html#tests), [how to write tests](https://doc.rust-lang.org/rustc/tests/index.html)
{==+==}
