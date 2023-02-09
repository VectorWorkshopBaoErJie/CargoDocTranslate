{==+==}
# cargo-check(1)
{==+==}

{==+==}



{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-check - Check the current package
{==+==}
cargo-check - 检查当前包
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 简介
{==+==}


{==+==}
`cargo check` [_options_]
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}


{==+==}
Check a local package and all of its dependencies for errors. This will
essentially compile the packages without performing the final step of code
generation, which is faster than running `cargo build`. The compiler will save
metadata files to disk so that future runs will reuse them if the source has
not been modified. Some diagnostics and errors are only emitted during code
generation, so they inherently won't be reported with `cargo check`.
{==+==}
检查本地包及其所有依赖项是否有错误。这实际上将编译软件包，而不执行代码生成的最后一步，这比运行“Cargo构建”要快。
编译器会将元数据文件保存到磁盘上，这样，如果源文件没有被修改，以后运行时就可以重用它们。一些诊断和错误仅在代码生成期间发出，因此它们本质上不会在“Cargo检查”中报告。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Package Selection
{==+==}
### 包选择
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
<dt class="option-term" id="option-cargo-check--p"><a class="option-anchor" href="#option-cargo-check--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-check---package"><a class="option-anchor" href="#option-cargo-check---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">Check only the specified packages. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.</dd>


<dt class="option-term" id="option-cargo-check---workspace"><a class="option-anchor" href="#option-cargo-check---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">Check all members in the workspace.</dd>



<dt class="option-term" id="option-cargo-check---all"><a class="option-anchor" href="#option-cargo-check---all"></a><code>--all</code></dt>
<dd class="option-desc">Deprecated alias for <code>--workspace</code>.</dd>



<dt class="option-term" id="option-cargo-check---exclude"><a class="option-anchor" href="#option-cargo-check---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">Exclude the specified packages. Must be used in conjunction with the
<code>--workspace</code> flag. This flag may be specified multiple times and supports
common Unix glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.</dd>
{==+==}
<dt class="option-term" id="option-cargo-check--p"><a class="option-anchor" href="#option-cargo-check--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-check---package"><a class="option-anchor" href="#option-cargo-check---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅对指定的包进行基准测试。SPEC 格式请参考<a href="cargo-pkgid.html">cargo-pkgid(1)</a>。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >?</code >和 <code>[]</code > 。然而，为了避免您的shell在Cargo处理glob模式之前意外扩展它们，您必须在每个模式周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-check---workspace"><a class="option-anchor" href="#option-cargo-check---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">检查工作区中的所有成员。</dd>



<dt class="option-term" id="option-cargo-check---all"><a class="option-anchor" href="#option-cargo-check---all"></a><code>--all</code></dt>
<dd class="option-desc"><code>--workspace</code>已弃用的别名</dd>



<dt class="option-term" id="option-cargo-check---exclude"><a class="option-anchor" href="#option-cargo-check---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code >标志一起使用。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >？</code > 和 <code>[]</code >。然而，为了避免您的shell在Cargo处理glob模式之前意外扩展它们，您必须在每个模式周围使用单引号或双引号。</dd>
{==+==}


{==+==}
### Target Selection
{==+==}
### 目标选择
{==+==}

{==+==}
When no target selection options are given, `cargo check` will check all
binary and library targets of the selected packages. Binaries are skipped if
they have `required-features` that are missing.

Passing target selection flags will check only the specified
targets. 

Note that `--bin`, `--example`, `--test` and `--bench` flags also 
support common Unix glob patterns like `*`, `?` and `[]`. However, to avoid your 
shell accidentally expanding glob patterns before Cargo handles them, you must 
use single quotes or double quotes around each glob pattern.
{==+==}
当没有给出目标选择选项时，`Cargo检查` 将检查所选包的所有二进制和库目标。如果二进制文件缺少`必需的特性`,则跳过它们。

传递目标选择标志将只检查指定的目标。

注意`--bin`、`--example`、`--test`和`--bench`标志也支持常见的Unix全局模式，如`*`、`?`和`[]`。然而，为了避免您的 shell 在 Cargo 处理 glob 模式之前意外地扩展它们，您必须在每个 glob 模式周围使用单引号或双引号。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-check---lib"><a class="option-anchor" href="#option-cargo-check---lib"></a><code>--lib</code></dt>
<dd class="option-desc">Check the package's library.</dd>


<dt class="option-term" id="option-cargo-check---bin"><a class="option-anchor" href="#option-cargo-check---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Check the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-check---bins"><a class="option-anchor" href="#option-cargo-check---bins"></a><code>--bins</code></dt>
<dd class="option-desc">Check all binary targets.</dd>



<dt class="option-term" id="option-cargo-check---example"><a class="option-anchor" href="#option-cargo-check---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">Check the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-check---examples"><a class="option-anchor" href="#option-cargo-check---examples"></a><code>--examples</code></dt>
<dd class="option-desc">Check all example targets.</dd>


<dt class="option-term" id="option-cargo-check---test"><a class="option-anchor" href="#option-cargo-check---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">Check the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-check---tests"><a class="option-anchor" href="#option-cargo-check---tests"></a><code>--tests</code></dt>
<dd class="option-desc">Check all targets in test mode that have the <code>test = true</code> manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the <code>test</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-check---bench"><a class="option-anchor" href="#option-cargo-check---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">Check the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-check---benches"><a class="option-anchor" href="#option-cargo-check---benches"></a><code>--benches</code></dt>
<dd class="option-desc">Check all targets in benchmark mode that have the <code>bench = true</code>
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the <code>bench</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-check---all-targets"><a class="option-anchor" href="#option-cargo-check---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">Check all targets. This is equivalent to specifying <code>--lib --bins --tests --benches --examples</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-check---lib"><a class="option-anchor" href="#option-cargo-check---lib"></a><code>--lib</code></dt>
<dd class="option-desc">检查包的库。</dd>


<dt class="option-term" id="option-cargo-check---bin"><a class="option-anchor" href="#option-cargo-check---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">检查指定的二进制文件。可以多次指定该标志
并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-check---bins"><a class="option-anchor" href="#option-cargo-check---bins"></a><code>--bins</code></dt>
<dd class="option-desc">检查所有二进制目标。</dd>



<dt class="option-term" id="option-cargo-check---example"><a class="option-anchor" href="#option-cargo-check---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">检查指定的示例。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-check---examples"><a class="option-anchor" href="#option-cargo-check---examples"></a><code>--examples</code></dt>
<dd class="option-desc">检查所有示例目标。</dd>


<dt class="option-term" id="option-cargo-check---test"><a class="option-anchor" href="#option-cargo-check---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">检查指定的集成测试。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-check---tests"><a class="option-anchor" href="#option-cargo-check---tests"></a><code>--tests</code></dt>
<dd class="option-desc">检查测试模式中设置了<code>test = true</code> 清单标志的所有目标。默认情况下，这包括作为单元测试和集成测试构建的库和二进制文件。请注意，这也将构建任何所需的依赖项，因此lib目标可能会构建两次(一次作为
unittest，一次作为二进制、集成测试等的依赖项。).
可以通过在目标的清单设置中设置<code>test</code>标志来启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-check---bench"><a class="option-anchor" href="#option-cargo-check---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">检查指定的基准。该标志可以多次指定，并支持常见的Unix glob模式。</dd>


<dt class="option-term" id="option-cargo-check---benches"><a class="option-anchor" href="#option-cargo-check---benches"></a><code>--benches</code></dt>
<dd class="option-desc">在基准模式下检查设置了<code>bench = true</code> 清单标志的所有目标。默认情况下，这包括作为基准构建的库和二进制文件，以及基准目标。请注意，这也将构建任何所需的依赖项，因此lib目标可能会构建两次(一次作为基准，一次作为二进制文件、基准等的依赖项。).
可以通过在目标的清单设置中设置<code>bench</code>标志来启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-check---all-targets"><a class="option-anchor" href="#option-cargo-check---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">检查所有目标。这相当于指定<code>--lib --bins --tests --benches --examples</code>。</dd>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 特性选择
{==+==}


{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
功能标志允许您控制启用哪些功能。当未给出功能选项时，为每个选定的包激活“默认”功能。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
请参见 [the features documentation](../reference/features.html#command-line-feature-options) 了解更多详细信息。
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-check--F"><a class="option-anchor" href="#option-cargo-check--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-check---features"><a class="option-anchor" href="#option-cargo-check---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>


<dt class="option-term" id="option-cargo-check---all-features"><a class="option-anchor" href="#option-cargo-check---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>


<dt class="option-term" id="option-cargo-check---no-default-features"><a class="option-anchor" href="#option-cargo-check---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-check--F"><a class="option-anchor" href="#option-cargo-check--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-check---features"><a class="option-anchor" href="#option-cargo-check---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的以空格或逗号分隔的功能列表。可以使用<code>package-name/feature-name</code>语法来启用工作区成员的功能。可以多次指定该标志，从而启用所有指定的功能。</dd>


<dt class="option-term" id="option-cargo-check---all-features"><a class="option-anchor" href="#option-cargo-check---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定软件包的所有可用功能。</dd>


<dt class="option-term" id="option-cargo-check---no-default-features"><a class="option-anchor" href="#option-cargo-check---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要激活所选软件包的<code>default</code>功能。</dd>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-check---target"><a class="option-anchor" href="#option-cargo-check---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Check for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>



<dt class="option-term" id="option-cargo-check--r"><a class="option-anchor" href="#option-cargo-check--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-check---release"><a class="option-anchor" href="#option-cargo-check---release"></a><code>--release</code></dt>
<dd class="option-desc">Check optimized artifacts with the <code>release</code> profile.
See also the <code>--profile</code> option for choosing a specific profile by name.</dd>



<dt class="option-term" id="option-cargo-check---profile"><a class="option-anchor" href="#option-cargo-check---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">Check with the given profile.</p>
<p>As a special case, specifying the <code>test</code> profile will also enable checking in
test mode which will enable checking tests and enable the <code>test</code> cfg option.
See <a href="https://doc.rust-lang.org/rustc/tests/index.html">rustc tests</a> for more
detail.</p>
<p>See the <a href="../reference/profiles.html">the reference</a> for more details on profiles.</dd>



<dt class="option-term" id="option-cargo-check---ignore-rust-version"><a class="option-anchor" href="#option-cargo-check---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">Check the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's <code>rust-version</code> field.</dd>



<dt class="option-term" id="option-cargo-check---timings=fmts"><a class="option-anchor" href="#option-cargo-check---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
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
{==+==}
<dt class="option-term" id="option-cargo-check---target"><a class="option-anchor" href="#option-cargo-check---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">检查给定的体系结构。默认为主机架构。三元组的一般格式是<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。运行 <code>rustc --print target-list</code> 以获取支持的目标列表。可以多次指定该标志.</p>
<p>这也可以用 <code>build.target</code> 来指定
<a href="../reference/config.html">配置值</a>。</p>
<p>注意，指定这个标志会使Cargo以不同的模式运行，其中目标工件被放在一个单独的目录中。有关更多详细信息，请参见 <a href="../guide/build-cache.html">build cache</a> 文档。</dd>



<dt class="option-term" id="option-cargo-check--r"><a class="option-anchor" href="#option-cargo-check--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-check---release"><a class="option-anchor" href="#option-cargo-check---release"></a><code>--release</code></dt>
<dd class="option-desc">用 <code>release</code> 概要文件检查优化的工件。
另请参见 <code>--profile</code> 选项，以按名称选择特定的配置文件。</dd>



<dt class="option-term" id="option-cargo-check---profile"><a class="option-anchor" href="#option-cargo-check---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">使用给定的配置文件进行检查。</p >
<p>作为一个特例，指定<code>test</code>配置文件还将启用测试模式下的检查，这将启用检查测试并启用<code>test</code> cfg选项。
如需详细信息，请参阅<a href="https://doc.rust-lang.org/rustc/tests/index.html">rustc tests</a>。</p>
<p>请参见<a href="../reference/profiles.html">参考</a >，了解有关配置文件的更多详细信息。</dd>



<dt class="option-term" id="option-cargo-check---ignore-rust-version"><a class="option-anchor" href="#option-cargo-check---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使所选Rust编译器比项目的<code>rust-version</code >字段中配置的所需Rust版本旧，也要检查目标。</dd>



<dt class="option-term" id="option-cargo-check---timings=fmts"><a class="option-anchor" href="#option-cargo-check---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每次编译需要多长时间的信息，并随着时间的推移跟踪并发信息。接受可选的逗号分隔的输出格式列表；不带参数的 <code>--timings</code> 将默认为 <code>--timings=html</code> 。指定输出格式(而不是默认格式)不稳定，需要 <code>-Zunstable-options</code>。有效的输出格式:</p>
<ul>
<li><code>html</code >(不稳定，需要 <code>-Zunstable-options</code> ):将一个可读的文件 <code>cargo-timing.html</code> 写入 <code>target/cargo-timings</code> 目录，并附上编译报告。如果您想查看以前的运行，也可以在相同的目录下写一个带有时间戳的报告。HTML输出只适合人类使用，不提供机器可读的计时数据。</li>
<li><code>json</code >(不稳定，需要 <code>-Zunstable-options</code> ):发出有关计时信息的机器可读json信息。</li>
</ul></dd>
{==+==}


{==+==}
### Output Options
{==+==}
### 输出选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-check---target-dir"><a class="option-anchor" href="#option-cargo-check---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to <code>target</code> in the root of the workspace.</dd>
{==+==}
<dt class="option-term" id="option-cargo-check---target-dir"><a class="option-anchor" href="#option-cargo-check---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成的工件和中间文件的目录。也可以用<code>CARGO_TARGET_DIR</code>环境变量或<code>build.target-dir</code> <a  ref="../reference/config.html">config value</a>。
默认为工作区根目录中的< code>target</code >。</dd>
{==+==}

{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-check--v"><a class="option-anchor" href="#option-cargo-check--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-check---verbose"><a class="option-anchor" href="#option-cargo-check---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-check--q"><a class="option-anchor" href="#option-cargo-check--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-check---quiet"><a class="option-anchor" href="#option-cargo-check---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-check---color"><a class="option-anchor" href="#option-cargo-check---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>



<dt class="option-term" id="option-cargo-check---message-format"><a class="option-anchor" href="#option-cargo-check---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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
{==+==}
<dt class="option-term" id="option-cargo-check--v"><a class="option-anchor" href="#option-cargo-check--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-check---verbose"><a class="option-anchor" href="#option-cargo-check---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用详细输出。 对于 &quot;非常详细&quot;的输出，可以指定两次，非常详细的输出包括额外的输出，如依赖项警告和构建脚本输出。

也可以用<code>term.verbose</code> <a href="../reference/config.html">配置值</a >。</dd>


<dt class="option-term" id="option-cargo-check--q"><a class="option-anchor" href="#option-cargo-check--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-check---quiet"><a class="option-anchor" href="#option-cargo-check---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印Cargo日志信息。也可以用 <code>term.quiet</code> 来指定
<a href= "../reference/config.html " >配置值</a>。</dd>


<dt class="option-term" id="option-cargo-check---color"><a class="option-anchor" href="#option-cargo-check---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制何时使用彩色输出。有效值:</p>
<ul>
<li><code>auto</code> (默认):自动检测上是否支持颜色
终端。</li>
<li><code>always</code>:始终显示颜色。</li>
<li><code>never</code>: 从不显示颜色</li>
</ul>
<p>也可以用 <code>term.color</code> 指定
<a href="../reference/config.html">配置值</a>.</dd>



<dt class="option-term" id="option-cargo-check---message-format"><a class="option-anchor" href="#option-cargo-check---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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
{==+==}


{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-check---manifest-path"><a class="option-anchor" href="#option-cargo-check---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>



<dt class="option-term" id="option-cargo-check---frozen"><a class="option-anchor" href="#option-cargo-check---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-check---locked"><a class="option-anchor" href="#option-cargo-check---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>


<dt class="option-term" id="option-cargo-check---offline"><a class="option-anchor" href="#option-cargo-check---offline"></a><code>--offline</code></dt>
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
{==+==}
<dt class="option-term" id="option-cargo-check---manifest-path"><a class="option-anchor" href="#option-cargo-check---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code>文件的路径。默认情况下，Cargo在当前目录或任何父目录中搜索<code>Cargo.toml</code>文件。</dd>



<dt class="option-term" id="option-cargo-check---frozen"><a class="option-anchor" href="#option-cargo-check---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-check---locked"><a class="option-anchor" href="#option-cargo-check---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求<code>Cargo.lock</code>文件是最新的。如果锁文件丢失，或者需要更新，Cargo将出错退出。 <code>--freezed </code>标志还防止 Cargo 试图访问网络以确定其是否过期。</p>
<p>在您希望断言<code>Cargo.lock</code>文件是最新的(如CI构建)或希望避免网络访问的环境中，可以使用这些文件。</dd>


<dt class="option-term" id="option-cargo-check---offline"><a class="option-anchor" href="#option-cargo-check---offline"></a><code>--offline</code></dt>
<dd class="option-desc">防止Cargo以任何理由访问网络。如果没有这个标志，当Cargo需要访问网络而网络不可用时，Cargo将出错停止。有了这个标志，如果可能的话，Cargo将试图在没有网络的情况下前进。</p>
<p>请注意，这可能会导致与在线模式不同的依赖关系解析。Cargo将自己限制在本地下载的板条箱中，即使在索引的本地副本中可能有更新的版本。
请参阅<a href="cargo-fetch.html">cargo-fetch(1)</a >命令，以便在脱机之前下载依赖项。</p>
<p>也可以用<code>net.offline</code> <a href="../reference/config.html">配置值</a>。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 常见选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-check-+toolchain"><a class="option-anchor" href="#option-cargo-check-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>


<dt class="option-term" id="option-cargo-check---config"><a class="option-anchor" href="#option-cargo-check---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>


<dt class="option-term" id="option-cargo-check--h"><a class="option-anchor" href="#option-cargo-check--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-check---help"><a class="option-anchor" href="#option-cargo-check---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>


<dt class="option-term" id="option-cargo-check--Z"><a class="option-anchor" href="#option-cargo-check--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-check-+toolchain"><a class="option-anchor" href="#option-cargo-check-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经安装了rustup，并且<code>cargo</code>的第一个参数以 <code>+</code >开头，则它将被解释为rustup工具链名称 (例如 <code>+stable</code> 或 <code>+nightly</code>).
有关工具链覆盖如何工作的详细信息，请参阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a> rust up文档</a >。</dd>


<dt class="option-term" id="option-cargo-check---config"><a class="option-anchor" href="#option-cargo-check---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置值。该参数应该采用TOML语法<code>KEY=VALUE</code>，或者作为额外配置文件的路径提供。可以多次指定该标志。
请参见<a href="../reference/config.html#command-line-overrides">，了解更多信息。</dd>


<dt class="option-term" id="option-cargo-check--h"><a class="option-anchor" href="#option-cargo-check--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-check---help"><a class="option-anchor" href="#option-cargo-check---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-check--Z"><a class="option-anchor" href="#option-cargo-check--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc"> Cargo 不稳定(nightly-only)标志。运行<code>cargo -Z help</code>获取详细信息。</dd>
{==+==}


{==+==}
### Miscellaneous Options
{==+==}
### 其他选项
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-check--j"><a class="option-anchor" href="#option-cargo-check--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-check---jobs"><a class="option-anchor" href="#option-cargo-check---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>


<dt class="option-term" id="option-cargo-check---keep-going"><a class="option-anchor" href="#option-cargo-check---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>


<dt class="option-term" id="option-cargo-check---future-incompat-report"><a class="option-anchor" href="#option-cargo-check---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">Displays a future-incompat report for any future-incompatible warnings
produced during execution of this command</p>
<p>See <a href="cargo-report.html">cargo-report(1)</a></dd>
{==+==}
<dt class="option-term" id="option-cargo-check--j"><a class="option-anchor" href="#option-cargo-check--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-check---jobs"><a class="option-anchor" href="#option-cargo-check---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">要运行的并行作业的数量。也可以用<code>build.jobs</code> <a href="../reference/config.html">config value</a>指定。
 默认为逻辑CPU的数量。如果为负，它将并行作业的最大数量设置为逻辑CPU的数量加上提供的值。
不应为0。</dd>


<dt class="option-term" id="option-cargo-check---keep-going"><a class="option-anchor" href="#option-cargo-check---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">在依赖图中构建尽可能多的 crate ，而不是在第一个构建失败时中止构建。不稳定，需要 <code>-Zunstable-options</code>。</dd>


<dt class="option-term" id="option-cargo-check---future-incompat-report"><a class="option-anchor" href="#option-cargo-check---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">显示在执行此命令期间产生的任何未来不兼容警告的未来不兼容报告</p>
<p>请参阅 <a href="cargo-report.html"> cargo-report(1)</a></dd>
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
参见 [the reference](../reference/environment-variables.html)
Cargo读取的环境变量的详细信息。
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
* `0`: Cargo 成功。
* `101`: Cargo 未能完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}

{==+==}
1. Check the local package for errors:

       cargo check

2. Check all targets, including unit tests:

       cargo check --all-targets --profile=test
{==+==}
1. 检查本地包是否有错误:

       cargo check

2. 检查所有目标，包括单元测试:

       cargo check --all-targets --profile=test
{==+==}


{==+==}
## SEE ALSO
{==+==}
## 另见
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html)
{==+==}

{==+==}
