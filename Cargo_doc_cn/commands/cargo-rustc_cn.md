{==+==}
# cargo-rustc(1)
{==+==}

{==+==}



{==+==}
## NAME
{==+==}
## 定义
{==+==}

{==+==}
cargo-rustc - Compile the current package, and pass extra options to the compiler
{==+==}
cargo-rustc - 编译当前包，并将额外参数传递给编译器
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo rustc` [_options_] [`--` _args_]
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
The specified target for the current package (or package specified by `-p` if
provided) will be compiled along with all of its dependencies. The specified
_args_ will all be passed to the final compiler invocation, not any of the
dependencies. Note that the compiler will still unconditionally receive
arguments such as `-L`, `--extern`, and `--crate-type`, and the specified
_args_ will simply be added to the compiler invocation.
{==+==}
当前包的指定目标(或由 `-p` 指定的已有的包)将与它的所有依赖一起被编译。
指定的 _args_ 将全部传递给最终的编译器调用，而非依赖项的参数。
请注意，编译器仍然会无条件地接受参数，如 `-L` ， `-extern` ，和 `-crat-type` ，
而指定的的 _args_ 将被添加到编译器的调用中。
{==+==}


{==+==}
See <https://doc.rust-lang.org/rustc/index.html> for documentation on rustc
flags.
{==+==}
有关 rustc 的标志位的文档请查看 <https://doc.rust-lang.org/rustc/index.html>
{==+==}


{==+==}
This command requires that only one target is being compiled when additional
arguments are provided. If more than one target is available for the current
package the filters of `--lib`, `--bin`, etc, must be used to select which
target is compiled.
{==+==}
该命令要求在提供额外参数时，只有一个目标被编译。
如果当前的包有多个的目标，则必须使用 `--lib` 、 `--bin` 等过滤器来选择编译目标。
目标被编译。
{==+==}


{==+==}
To pass flags to all compiler processes spawned by Cargo, use the `RUSTFLAGS`
[environment variable](../reference/environment-variables.html) or the
`build.rustflags` [config value](../reference/config.html).
{==+==}
使用 `RUSTFLAGS` [environment variable](../reference/environment-variables.html)
或者 `build.rustflags` [config value](../reference/config.html)
来给 Cargo 创建的所有编译器进程传递标志位。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Package Selection
{==+==}
### 选择包
{==+==}


{==+==}
By default, the package in the current working directory is selected. The `-p`
flag can be used to choose a different package in a workspace.
{==+==}
当前工作目录下的包是默认选中的。可以使用 `-p` 选项来选择工作空间中不同的包。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc--p"><a class="option-anchor" href="#option-cargo-rustc--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-rustc---package"><a class="option-anchor" href="#option-cargo-rustc---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">The package to build. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the SPEC
format.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc--p"><a class="option-anchor" href="#option-cargo-rustc--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-rustc---package"><a class="option-anchor" href="#option-cargo-rustc---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">要构建的包。请在 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 查看 SPEC 格式</dd>
{==+==}


{==+==}
### Target Selection
{==+==}
### 选择构建目标
{==+==}


{==+==}
When no target selection options are given, `cargo rustc` will build all
binary and library targets of the selected package.
{==+==}
当没有提供构建目标选择的选项时， `cargo rustc` 会构建选中包的所有二进制程序和类库目标。
{==+==}


{==+==}
Binary targets are automatically built if there is an integration test or
benchmark being selected to build. This allows an integration
test to execute the binary to exercise and test its behavior. 
The `CARGO_BIN_EXE_<name>`
[environment variable](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates)
is set when the integration test is built so that it can use the
[`env` macro](https://doc.rust-lang.org/std/macro.env.html) to locate the
executable.
{==+==}
如果要构建集成测试或基准测试，二进制目标也会自动构建。
这允许集成测试执行二进制文件以测试其行为。
集成测试构建时会设置 `CARGO_BIN_EXE_<name>` [environment variable](.../reference/environment-variables.html#environment-variables-cargo-sets for-crates) ，
以便它可以使用 [`env` macro](https://doc.rust-lang.org/std/macro.env.html) 来定位可执行程序。
{==+==}


{==+==}
Passing target selection flags will build only the specified
targets.
{==+==}
传递目标选中标志可以仅编译指定的目标。
{==+==}

{==+==}
Note that `--bin`, `--example`, `--test` and `--bench` flags also 
support common Unix glob patterns like `*`, `?` and `[]`. However, to avoid your 
shell accidentally expanding glob patterns before Cargo handles them, you must 
use single quotes or double quotes around each glob pattern.
{==+==}
注意 `--bin` 、 `--example` 、 `--test` 和 `--bench` 标志也
支持常见的 Unix glob pattern，比如 `*` , `?` 和 `[]` 。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，
你必须在每个 glob pattern 周围使用单引号或双引号。
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-rustc---lib"><a class="option-anchor" href="#option-cargo-rustc---lib"></a><code>--lib</code></dt>
<dd class="option-desc">Build the package's library.</dd>


<dt class="option-term" id="option-cargo-rustc---bin"><a class="option-anchor" href="#option-cargo-rustc---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Build the specified binary. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-rustc---bins"><a class="option-anchor" href="#option-cargo-rustc---bins"></a><code>--bins</code></dt>
<dd class="option-desc">Build all binary targets.</dd>



<dt class="option-term" id="option-cargo-rustc---example"><a class="option-anchor" href="#option-cargo-rustc---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">Build the specified example. This flag may be specified multiple times
and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-rustc---examples"><a class="option-anchor" href="#option-cargo-rustc---examples"></a><code>--examples</code></dt>
<dd class="option-desc">Build all example targets.</dd>


<dt class="option-term" id="option-cargo-rustc---test"><a class="option-anchor" href="#option-cargo-rustc---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">Build the specified integration test. This flag may be specified
multiple times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-rustc---tests"><a class="option-anchor" href="#option-cargo-rustc---tests"></a><code>--tests</code></dt>
<dd class="option-desc">Build all targets in test mode that have the <code>test = true</code> manifest
flag set. By default this includes the library and binaries built as
unittests, and integration tests. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
unittest, and once as a dependency for binaries, integration tests, etc.).
Targets may be enabled or disabled by setting the <code>test</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-rustc---bench"><a class="option-anchor" href="#option-cargo-rustc---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">Build the specified benchmark. This flag may be specified multiple
times and supports common Unix glob patterns.</dd>


<dt class="option-term" id="option-cargo-rustc---benches"><a class="option-anchor" href="#option-cargo-rustc---benches"></a><code>--benches</code></dt>
<dd class="option-desc">Build all targets in benchmark mode that have the <code>bench = true</code>
manifest flag set. By default this includes the library and binaries built
as benchmarks, and bench targets. Be aware that this will also build any
required dependencies, so the lib target may be built twice (once as a
benchmark, and once as a dependency for binaries, benchmarks, etc.).
Targets may be enabled or disabled by setting the <code>bench</code> flag in the
manifest settings for the target.</dd>


<dt class="option-term" id="option-cargo-rustc---all-targets"><a class="option-anchor" href="#option-cargo-rustc---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">Build all targets. This is equivalent to specifying <code>--lib --bins --tests --benches --examples</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc---lib"><a class="option-anchor" href="#option-cargo-rustc---lib"></a><code>--lib</code></dt>
<dd class="option-desc">构建包的类库</dd>


<dt class="option-term" id="option-cargo-rustc---bin"><a class="option-anchor" href="#option-cargo-rustc---bin"></a><code>--bin</code> <em>名称</em>...</dt>
<dd class="option-desc">构建指定的二进制程序。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustc---bins"><a class="option-anchor" href="#option-cargo-rustc---bins"></a><code>--bins</code></dt>
<dd class="option-desc">构建所有二进制目标</dd>



<dt class="option-term" id="option-cargo-rustc---example"><a class="option-anchor" href="#option-cargo-rustc---example"></a><code>--example</code> <em>名称</em>...</dt>
<dd class="option-desc">构建指定的例子。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustc---examples"><a class="option-anchor" href="#option-cargo-rustc---examples"></a><code>--examples</code></dt>
<dd class="option-desc">构建所有例子目标</dd>


<dt class="option-term" id="option-cargo-rustc---test"><a class="option-anchor" href="#option-cargo-rustc---test"></a><code>--test</code> <em>名称</em>...</dt>
<dd class="option-desc">构建指定的集成测试。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustc---tests"><a class="option-anchor" href="#option-cargo-rustc---tests"></a><code>--tests</code></dt>
<dd class="option-desc">在清单文件中将 <code>test = true</code> 来在测试模式下构建所有目标。
默认情况下，这包括构建为
单元测试和集成测试的库和二进制文件。请注意，这也会构建任何
所需的依赖项，所以 lib 目标可能会被构建两次（一次是作为一个
单元测试，一次作为二进制文件、集成测试等的依赖项）。
可以在清单文件通过设置目标的 <code>test</code> 标志来启用或禁用此目标。</dd>


<dt class="option-term" id="option-cargo-rustc---bench"><a class="option-anchor" href="#option-cargo-rustc---bench"></a><code>--bench</code> <em>名称</em>...</dt>
<dd class="option-desc">构建指定的基准测试。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustc---benches"><a class="option-anchor" href="#option-cargo-rustc---benches"></a><code>--benches</code></dt>
<dd class="option-desc">在清单文件中将 <code>bench = true</code> 来在测试模式下构建所有目标。
默认情况下，这包括构建为
基准测试的库和二进制文件。请注意，这也会构建任何
所需的依赖项，所以 lib 目标可能会被构建两次（一次是作为一个
基准测试，一次作为二进制文件、基准测试等的依赖项）。
可以在清单文件通过设置目标的 <code>bench</code> 标志来启用或禁用此目标。</dd>


<dt class="option-term" id="option-cargo-rustc---all-targets"><a class="option-anchor" href="#option-cargo-rustc---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">构建所有目标。 相当于指定 <code>--lib --bins --tests --benches --examples</code>.</dd>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 选择特性
{==+==}


{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
feature 标志允许你有选择的启用特性。
当没有设置这个此标志时，将为所有已选的包启用 `defualt` 特性。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
更多细节查看 [the features documentation](../reference/features.html#command-line-feature-options)
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-rustc--F"><a class="option-anchor" href="#option-cargo-rustc--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-rustc---features"><a class="option-anchor" href="#option-cargo-rustc---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>


<dt class="option-term" id="option-cargo-rustc---all-features"><a class="option-anchor" href="#option-cargo-rustc---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>


<dt class="option-term" id="option-cargo-rustc---no-default-features"><a class="option-anchor" href="#option-cargo-rustc---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc--F"><a class="option-anchor" href="#option-cargo-rustc--F"></a><code>-F</code> <em>特性</em></dt>
<dt class="option-term" id="option-cargo-rustc---features"><a class="option-anchor" href="#option-cargo-rustc---features"></a><code>--features</code> <em>特性</em></dt>
<dd class="option-desc">要启用的特性列表，列表用空格或逗号分割。
工作空间中成员的特性可以通过 <code>package-name/feature-name</code> 语法启用。
此标志可以多次指定，会启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-rustc---all-features"><a class="option-anchor" href="#option-cargo-rustc---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">为全部选择的包启用所有可用的特性。</dd>


<dt class="option-term" id="option-cargo-rustc---no-default-features"><a class="option-anchor" href="#option-cargo-rustc---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要为选择的包 <code>默认</code> 启用默认特性。</dd>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc---target"><a class="option-anchor" href="#option-cargo-rustc---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Build for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>



<dt class="option-term" id="option-cargo-rustc--r"><a class="option-anchor" href="#option-cargo-rustc--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-rustc---release"><a class="option-anchor" href="#option-cargo-rustc---release"></a><code>--release</code></dt>
<dd class="option-desc">Build optimized artifacts with the <code>release</code> profile.
See also the <code>--profile</code> option for choosing a specific profile by name.</dd>



<dt class="option-term" id="option-cargo-rustc---profile"><a class="option-anchor" href="#option-cargo-rustc---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">Build with the given profile.</p>
<p>The <code>rustc</code> subcommand will treat the following named profiles with special behaviors:</p>
<ul>
<li><code>check</code> — Builds in the same way as the <a href="cargo-check.html">cargo-check(1)</a> command with
the <code>dev</code> profile.</li>
<li><code>test</code> — Builds in the same way as the <a href="cargo-test.html">cargo-test(1)</a> command,
enabling building in test mode which will enable tests and enable the <code>test</code>
cfg option. See <a href="https://doc.rust-lang.org/rustc/tests/index.html">rustc
tests</a> for more detail.</li>
<li><code>bench</code> — Builds in the same was as the <a href="cargo-bench.html">cargo-bench(1)</a> command,
similar to the <code>test</code> profile.</li>
</ul>
<p>See the <a href="../reference/profiles.html">the reference</a> for more details on profiles.</dd>


<dt class="option-term" id="option-cargo-rustc---ignore-rust-version"><a class="option-anchor" href="#option-cargo-rustc---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">Build the target even if the selected Rust compiler is older than the
required Rust version as configured in the project's <code>rust-version</code> field.</dd>



<dt class="option-term" id="option-cargo-rustc---timings=fmts"><a class="option-anchor" href="#option-cargo-rustc---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
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




<dt class="option-term" id="option-cargo-rustc---crate-type"><a class="option-anchor" href="#option-cargo-rustc---crate-type"></a><code>--crate-type</code> <em>crate-type</em></dt>
<dd class="option-desc">Build for the given crate type. This flag accepts a comma-separated list of
1 or more crate types, of which the allowed values are the same as <code>crate-type</code>
field in the manifest for configurating a Cargo target. See
<a href="../reference/cargo-targets.html#the-crate-type-field"><code>crate-type</code> field</a>
for possible values.</p>
<p>If the manifest contains a list, and <code>--crate-type</code> is provided,
the command-line argument value will override what is in the manifest.</p>
<p>This flag only works when building a <code>lib</code> or <code>example</code> library target.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc---target"><a class="option-anchor" href="#option-cargo-rustc---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">指定架构的构建。 默认为宿主机的架构。三元组的通用格式为
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。运行 <code>rustc --print target-list</code> 来获取支持的目标列表。
这个标志可以指定多次。</p>
<p>这也可以与 <code>build.target</code>
<a href="../reference/config.html">config value</a> 一起使用。</p>
<p>
注意，指定这个标志会使 Cargo 在不同的模式下运行，目标 artifacts 被放在一个单独的目录中。
更多细节请参见 <a href="../guide/build-cache.html">build cache</a> 文档。</dd>



<dt class="option-term" id="option-cargo-rustc--r"><a class="option-anchor" href="#option-cargo-rustc--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-rustc---release"><a class="option-anchor" href="#option-cargo-rustc---release"></a><code>--release</code></dt>
<dd class="option-desc">用 <code>release</code> 配置构建优化的 artifacts 。
请参阅 <code>--profile</code> 选项，通过名称选择一个特定的配置。</dd>



<dt class="option-term" id="option-cargo-rustc---profile"><a class="option-anchor" href="#option-cargo-rustc---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的配置进行测试。</p>
<p> <code>rustc</code> 子命令会对下列特殊名称的配置有特殊的行为: </p>
<ul>
<li><code>check</code> — 与 <a href="cargo-check.html">cargo-check(1)</a> 命令一样进行构建，使用 <code>dev</code> 配置。</li>
<li><code>test</code> — 与 <a href="cargo-test.html">cargo-test(1)</a> 命令一样进行构建，在测试模式下构建，这会启用测试并启用 <code>test</code> cfg配置。
更多信息请查看 <a href="https://doc.rust-lang.org/rustc/tests/index.html">rustc tests</a></li>
<li><code>bench</code> — 与 <a href="cargo-bench.html">cargo-bench(1)</a> 命令一样进行构建，与 <code>test</code> 配置类似。</li>
</ul>
<p>关于配置的更多细节，请参见 <a href="../reference/profiles.html">the reference</a> </dd>


<dt class="option-term" id="option-cargo-rustc---ignore-rust-version"><a class="option-anchor" href="#option-cargo-rustc---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使选择的 Rust 编译器比项目的 <code>rust-version</code> 字段中配置的所需的Rust版本要低，也要测试目标。</dd>



<dt class="option-term" id="option-cargo-rustc---timings=fmts"><a class="option-anchor" href="#option-cargo-rustc---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每次编译所需时间的信息，并跟踪一段时间的并发信息。
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




<dt class="option-term" id="option-cargo-rustc---crate-type"><a class="option-anchor" href="#option-cargo-rustc---crate-type"></a><code>--crate-type</code> <em>crate-type</em></dt>
<dd class="option-desc">按给定的 crate 类型进行构建。 这个标志接收逗号分割的 crate 类型列表，允许的 crate 类型与清单中配置 Cargo target 的 <code>crate-type</code> 字段相同。
在 <a href="../reference/cargo-targets.html#the-crate-type-field"><code>crate-type</code> 字段</a>查看可用的类型</p>
<p>如果清单中制定了列表, 并且提供了 <code>--crate-type</code>,
命令行参数会覆盖清单指定的列表。</p>
<p>此标志仅用于构建 <code>lib</code> 或 <code>example</code> 类库目标.</dd>
{==+==}


{==+==}
### Output Options
{==+==}
### 输出选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc---target-dir"><a class="option-anchor" href="#option-cargo-rustc---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to <code>target</code> in the root of the workspace.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc---target-dir"><a class="option-anchor" href="#option-cargo-rustc---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成的 artifacts 和中间文件的目录。 
也可以与 <code>CARGO_TARGET_DIR</code> 环境变量或 <code>build.target-dir</code> <a href="../reference/config.html">配置项</a> 一起指定。
默认是工作空间中 <code>target</code> 的根目录。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc--v"><a class="option-anchor" href="#option-cargo-rustc--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-rustc---verbose"><a class="option-anchor" href="#option-cargo-rustc---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-rustc--q"><a class="option-anchor" href="#option-cargo-rustc--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-rustc---quiet"><a class="option-anchor" href="#option-cargo-rustc---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>


<dt class="option-term" id="option-cargo-rustc---color"><a class="option-anchor" href="#option-cargo-rustc---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>



<dt class="option-term" id="option-cargo-rustc---message-format"><a class="option-anchor" href="#option-cargo-rustc---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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
<dt class="option-term" id="option-cargo-rustc--v"><a class="option-anchor" href="#option-cargo-rustc--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-rustc---verbose"><a class="option-anchor" href="#option-cargo-rustc---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用 verbose 级别输出详细信息。 指定两次此选项来输出 &quot;十分详细&quot; 的输出信息，
这会包含额外的输出信息，比如依赖警告和构建脚本输出。
也可以与 <code>term.verbose</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-rustc--q"><a class="option-anchor" href="#option-cargo-rustc--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-rustc---quiet"><a class="option-anchor" href="#option-cargo-rustc---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印任何 cargo 日志信息。
也可以与 <code>term.quiet</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-rustc---color"><a class="option-anchor" href="#option-cargo-rustc---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制的日志的颜色。 有效的值如下:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端颜色支持是否可用。</li>
<li><code>always</code>: 总是带颜色显示。</li>
<li><code>never</code>: 不带颜色显示.</li>
</ul>
<p>也可以与 <code>term.color</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>



<dt class="option-term" id="option-cargo-rustc---message-format"><a class="option-anchor" href="#option-cargo-rustc---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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
{==+==}


{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc---manifest-path"><a class="option-anchor" href="#option-cargo-rustc---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>



<dt class="option-term" id="option-cargo-rustc---frozen"><a class="option-anchor" href="#option-cargo-rustc---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-rustc---locked"><a class="option-anchor" href="#option-cargo-rustc---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>


<dt class="option-term" id="option-cargo-rustc---offline"><a class="option-anchor" href="#option-cargo-rustc---offline"></a><code>--offline</code></dt>
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
<dt class="option-term" id="option-cargo-rustc---manifest-path"><a class="option-anchor" href="#option-cargo-rustc---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径. 默认情况下，Cargo 会在当前目录或任何父目录下搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-rustc---frozen"><a class="option-anchor" href="#option-cargo-rustc---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-rustc---locked"><a class="option-anchor" href="#option-cargo-rustc---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果 .lock 文件缺失，或者需要更新，Cargo 将以错误退出。
<code>--frozen</code> 标志也可以防止 Cargo 访问网络以确定其是否过期。</p>
<p>
这些可以用于需要判断 <code>Cargo.lock</code> 文件是否最新（比如CI构建）或者想避免网络访问的环境中。</dd>


<dt class="option-term" id="option-cargo-rustc---offline"><a class="option-anchor" href="#option-cargo-rustc---offline"></a><code>--offline</code></dt>
<dd class="option-desc">禁止 Cargo 在任何情况下访问网络。
如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，它会以错误的方式停止。
有了这个标志，Cargo会尝试在没有网络的情况下进行。</p>

<p>请注意，这可能会导致与在线模式不同的依赖方案。Cargo 会将自己限制在本地的 crate 仓库上，
即使在本地拷贝的索引中可能有更新的版本也是如此。
参见 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令来在离线前下载依赖关系。</p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">config value</a> 来指定。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc-+toolchain"><a class="option-anchor" href="#option-cargo-rustc-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>


<dt class="option-term" id="option-cargo-rustc---config"><a class="option-anchor" href="#option-cargo-rustc---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>


<dt class="option-term" id="option-cargo-rustc--h"><a class="option-anchor" href="#option-cargo-rustc--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-rustc---help"><a class="option-anchor" href="#option-cargo-rustc---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>


<dt class="option-term" id="option-cargo-rustc--Z"><a class="option-anchor" href="#option-cargo-rustc--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc-+toolchain"><a class="option-anchor" href="#option-cargo-rustc-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 已经和 rustup 一起安装, 并且 <code>cargo</code> 的第一个参数以
<code>+</code> 开头, 它将被解释为一个rustup工具链的名字 (比如 <code>+stable</code> 或者 <code>+nightly</code>)。
更多关于工具链覆盖工作的信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a></dd>


<dt class="option-term" id="option-cargo-rustc---config"><a class="option-anchor" href="#option-cargo-rustc---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖一个 Cargo 配置值。参数应该使用 TOML 的 <code>KEY=VALUE</code> 语法，或者提供一个额外配置文件的路径。
这个标志可以被多次指定。更多信息请参见 <a href="../reference/config.html#command-line-overrides">command-line overrides section</a>。</dd>


<dt class="option-term" id="option-cargo-rustc--h"><a class="option-anchor" href="#option-cargo-rustc--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-rustc---help"><a class="option-anchor" href="#option-cargo-rustc---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-rustc--Z"><a class="option-anchor" href="#option-cargo-rustc--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (仅限 nightly 版本) 标志。 更多信息请运行 <code>cargo -Z help</code>。</dd>
{==+==}



{==+==}
### Miscellaneous Options
{==+==}
### 其他选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-rustc--j"><a class="option-anchor" href="#option-cargo-rustc--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-rustc---jobs"><a class="option-anchor" href="#option-cargo-rustc---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>


<dt class="option-term" id="option-cargo-rustc---keep-going"><a class="option-anchor" href="#option-cargo-rustc---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>


<dt class="option-term" id="option-cargo-rustc---future-incompat-report"><a class="option-anchor" href="#option-cargo-rustc---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">Displays a future-incompat report for any future-incompatible warnings
produced during execution of this command</p>
<p>See <a href="cargo-report.html">cargo-report(1)</a></dd>
{==+==}
<dt class="option-term" id="option-cargo-rustc--j"><a class="option-anchor" href="#option-cargo-rustc--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-rustc---jobs"><a class="option-anchor" href="#option-cargo-rustc---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">
要运行的并行作业的数量。
也可以通过 <code>build.jobs</code> <a href="../reference/config.html">config value</a> 配置值来指定。
默认为逻辑CPU的数量。如果是负数，它将最大的并行作业数量设置为逻辑CPU的数量加上所提供的值。不应该是0。</dd>


<dt class="option-term" id="option-cargo-rustc---keep-going"><a class="option-anchor" href="#option-cargo-rustc---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">尽可能多地构建依赖关系图中的 crates, 而不是有一个 crate 构建失败则中止构建。
不稳定，需要 <code>-Zunstable-options</code>。</dd>


<dt class="option-term" id="option-cargo-rustc---future-incompat-report"><a class="option-anchor" href="#option-cargo-rustc---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">展示一个未来兼容性报告(future-incompat report)，显示在执行此命令过程中产生的任何未来不兼容(future-incompatible)的警告</p>
<p>请参阅 <a href="cargo-report.html">cargo-report(1)</a></dd>
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
1. Check if your package (not including dependencies) uses unsafe code:

       cargo rustc --lib -- -D unsafe-code

2. Try an experimental flag on the nightly compiler, such as this which prints
   the size of every type:

       cargo rustc --lib -- -Z print-type-sizes

3. Override `crate-type` field in Cargo.toml with command-line option:

       cargo rustc --lib --crate-type lib,cdylib
{==+==}
1. 检查你的软件包(不包括依赖)是否使用了不安全代码:

       cargo rustc --lib -- -D unsafe-code

2. 在每日版编译器上尝试实验标志，比如这个标志打印了所有 type 的大小:

       cargo rustc --lib -- -Z print-type-sizes

3. 用命令行选项覆盖 Cargo.toml 中的 `crate-type` 字段:

       cargo rustc --lib --crate-type lib,cdylib
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html), [rustc(1)](https://doc.rust-lang.org/rustc/index.html)
{==+==}
## 另请参见
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html), [rustc(1)](https://doc.rust-lang.org/rustc/index.html)
{==+==}
