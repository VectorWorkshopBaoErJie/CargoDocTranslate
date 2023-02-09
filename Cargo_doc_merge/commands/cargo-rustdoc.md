# cargo-rustdoc(1)



## 定义

cargo-rustdoc - 使用指定标志构建包的文档

## 概要

`cargo rustdoc` [_options_] [`--` _args_]

## 说明

当前包的指定目标(或由 `-p` 指定的已有的包)将与传递给最终 rustdoc 调用的指定 _args_ 参数一起生成文档。
依赖不会作为此命令的一部分，依赖不会生成文档。
请注意，rustdoc 仍然会无条件地接受参数，如 `-L` ， `-extern` ，和 `-crat-type` ，
而指定的的 _args_ 将被添加到 rustdoc 的调用中。

有关 rustdoc 的标志位的文档请查看 <https://doc.rust-lang.org/rustdoc/index.html>

该命令要求在提供额外参数时，只有一个目标被编译。
如果当前的包有多个的目标，则必须使用 `--lib` 、 `--bin` 等过滤器来选择编译目标。
目标被编译。

使用 `RUSTDOCFLAGS` [environment variable](../reference/environment-variables.html)
或者 `build.rustdocflags` [config value](../reference/config.html)
来给 Cargo 创建的所有 rustdoc 进程传递标志位。

## 选项

### 文档选项

<dl>

<dt class="option-term" id="option-cargo-rustdoc---open"><a class="option-anchor" href="#option-cargo-rustdoc---open"></a><code>--open</code></dt>
<dd class="option-desc">
文档生成后将在浏览器中打开。
命令会使用默认浏览器，除非在环境变量中使用 <code>BROWSER</code> 或
使用 <a href="../reference/config.html#docbrowser"><code>doc.browser</code></a> 配置项定义了其他浏览器。
</dd>


</dl>

### 选择包

当前工作目录下的包是默认选中的。可以使用 `-p` 选项来选择工作空间中不同的包。

<dl>

<dt class="option-term" id="option-cargo-rustdoc--p"><a class="option-anchor" href="#option-cargo-rustdoc--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-rustdoc---package"><a class="option-anchor" href="#option-cargo-rustdoc---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">要生成文档的包。请在 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 查看 SPEC 格式</dd>


</dl>


### 选择构建目标

当没有提供构建目标选择的选项时， `cargo rustdoc` 会为选中包的所有二进制程序和类库目标生成文档。
与类库名称相同的二进制目标将被跳过。
缺少 `required-features` 的二进制目标将被跳过。

传递目标选中标志可以仅为指定的目标生产文档。

注意 `--bin` 、 `--example` 、 `--test` 和 `--bench` 标志也
支持常见的 Unix glob pattern，比如 `*` , `?` 和 `[]` 。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，
你必须在每个 glob pattern 周围使用单引号或双引号。

<dl>

<dt class="option-term" id="option-cargo-rustdoc---lib"><a class="option-anchor" href="#option-cargo-rustdoc---lib"></a><code>--lib</code></dt>
<dd class="option-desc">为包的类库生成文档</dd>


<dt class="option-term" id="option-cargo-rustdoc---bin"><a class="option-anchor" href="#option-cargo-rustdoc---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">为指定二进制目标生成文档。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustdoc---bins"><a class="option-anchor" href="#option-cargo-rustdoc---bins"></a><code>--bins</code></dt>
<dd class="option-desc">为所有二进制目标生成文档</dd>



<dt class="option-term" id="option-cargo-rustdoc---example"><a class="option-anchor" href="#option-cargo-rustdoc---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">为指定例子生成文档。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustdoc---examples"><a class="option-anchor" href="#option-cargo-rustdoc---examples"></a><code>--examples</code></dt>
<dd class="option-desc">为所有例子目标生成文档</dd>


<dt class="option-term" id="option-cargo-rustdoc---test"><a class="option-anchor" href="#option-cargo-rustdoc---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">为指定集成测试生成文档。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustdoc---tests"><a class="option-anchor" href="#option-cargo-rustdoc---tests"></a><code>--tests</code></dt>
<dd class="option-desc">
在清单文件中将 <code>test = true</code> 来在测试模式下为所有目标生成文档。
默认情况下，这包括构建为
单元测试和集成测试的库和二进制文件。请注意，这也会构建任何
所需的依赖项，所以 lib 目标可能会被构建两次（一次是作为一个
单元测试，一次作为二进制文件、集成测试等的依赖项）。
可以在清单文件通过设置目标的 <code>test</code> 标志来启用或禁用此目标。</dd>


<dt class="option-term" id="option-cargo-rustdoc---bench"><a class="option-anchor" href="#option-cargo-rustdoc---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">为指定的基准测试生成文档。这个标志位可以多次指定并且支持通用的 Unix glob pattern 格式。</dd>


<dt class="option-term" id="option-cargo-rustdoc---benches"><a class="option-anchor" href="#option-cargo-rustdoc---benches"></a><code>--benches</code></dt>
<dd class="option-desc">
在清单文件中将 <code>bench = true</code> 来在基准模式下为所有目标生成文档。
默认情况下，这包括构建为
基准测试的库和二进制文件。请注意，这也会构建任何
所需的依赖项，所以 lib 目标可能会被构建两次（一次是作为一个
基准测试，一次作为二进制文件、基准测试等的依赖项）。
可以在清单文件通过设置目标的 <code>bench</code> 标志来启用或禁用此目标。</dd>


<dt class="option-term" id="option-cargo-rustdoc---all-targets"><a class="option-anchor" href="#option-cargo-rustdoc---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">为所有目标生成文档。 相当于指定 <code>--lib --bins --tests --benches --examples</code>.</dd>


</dl>


### 选择特性

feature 标志允许你有选择的启用特性。
当没有设置这个此标志时，将为所有已选的包启用 `defualt` 特性。

更多细节查看 [the features documentation](../reference/features.html#command-line-feature-options)

<dl>

<dt class="option-term" id="option-cargo-rustdoc--F"><a class="option-anchor" href="#option-cargo-rustdoc--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-rustdoc---features"><a class="option-anchor" href="#option-cargo-rustdoc---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要启用的特性列表，列表用空格或逗号分割。
工作空间中成员的特性可以通过 <code>package-name/feature-name</code> 语法启用。
此标志可以多次指定，会启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-rustdoc---all-features"><a class="option-anchor" href="#option-cargo-rustdoc---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">为全部选择的包启用所有可用的特性。</dd>


<dt class="option-term" id="option-cargo-rustdoc---no-default-features"><a class="option-anchor" href="#option-cargo-rustdoc---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要为选择的包 <code>默认</code> 启用默认特性。</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-rustdoc---target"><a class="option-anchor" href="#option-cargo-rustdoc---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定架构生成文档。 默认为宿主机的架构。三元组的通用格式为
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。运行 <code>rustc --print target-list</code> 来获取支持的目标列表。
这个标志可以指定多次。</p>
<p>这也可以与 <code>build.target</code>
<a href="../reference/config.html">config value</a> 一起使用。</p>
<p>
注意，指定这个标志会使 Cargo 在不同的模式下运行，目标 artifacts 被放在一个单独的目录中。
更多细节请参见 <a href="../guide/build-cache.html">build cache</a> 文档。</dd>



<dt class="option-term" id="option-cargo-rustdoc--r"><a class="option-anchor" href="#option-cargo-rustdoc--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-rustdoc---release"><a class="option-anchor" href="#option-cargo-rustdoc---release"></a><code>--release</code></dt>
<dd class="option-desc">用 <code>release</code> 配置为优化的 artifacts 生成文档。
请参阅 <code>--profile</code> 选项，通过名称选择一个特定的配置。</dd>



<dt class="option-term" id="option-cargo-rustdoc---profile"><a class="option-anchor" href="#option-cargo-rustdoc---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的配置生成文档。
更多关于配置的细节请查看  <a href="../reference/profiles.html">参考</a> 。</dd>



<dt class="option-term" id="option-cargo-rustdoc---ignore-rust-version"><a class="option-anchor" href="#option-cargo-rustdoc---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使选择的 Rust 编译器比项目的 <code>rust-version</code> 字段中配置的所需的Rust版本要低，也要生成文但。</dd>



<dt class="option-term" id="option-cargo-rustdoc---timings=fmts"><a class="option-anchor" href="#option-cargo-rustdoc---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">O输出每次编译所需时间的信息，并跟踪一段时间的并发信息。
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

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-rustdoc---target-dir"><a class="option-anchor" href="#option-cargo-rustdoc---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成的 artifacts 和中间文件的目录。 
也可以与 <code>CARGO_TARGET_DIR</code> 环境变量或 <code>build.target-dir</code> <a href="../reference/config.html">配置项</a> 一起指定。
默认是工作空间中 <code>target</code> 的根目录。</dd>


</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-rustdoc--v"><a class="option-anchor" href="#option-cargo-rustdoc--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-rustdoc---verbose"><a class="option-anchor" href="#option-cargo-rustdoc---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">
使用 verbose 级别输出详细信息。 指定两次此选项来输出 &quot;十分详细&quot; 的输出信息，
这会包含额外的输出信息，比如依赖警告和构建脚本输出。
也可以与 <code>term.verbose</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-rustdoc--q"><a class="option-anchor" href="#option-cargo-rustdoc--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-rustdoc---quiet"><a class="option-anchor" href="#option-cargo-rustdoc---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印任何 cargo 日志信息。
也可以与 <code>term.quiet</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-rustdoc---color"><a class="option-anchor" href="#option-cargo-rustdoc---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制的日志的颜色。 有效的值如下:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端颜色支持是否可用。</li>
<li><code>always</code>: 总是带颜色显示。</li>
<li><code>never</code>: 不带颜色显示.</li>
</ul>
<p>也可以与 <code>term.color</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>



<dt class="option-term" id="option-cargo-rustdoc---message-format"><a class="option-anchor" href="#option-cargo-rustdoc---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
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

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-rustdoc---manifest-path"><a class="option-anchor" href="#option-cargo-rustdoc---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径. 默认情况下，Cargo 会在当前目录或任何父目录下搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-rustdoc---frozen"><a class="option-anchor" href="#option-cargo-rustdoc---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-rustdoc---locked"><a class="option-anchor" href="#option-cargo-rustdoc---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果 .lock 文件缺失，或者需要更新，Cargo 将以错误退出。
<code>--frozen</code> 标志也可以防止 Cargo 访问网络以确定其是否过期。</p>
<p>
这些可以用于需要判断 <code>Cargo.lock</code> 文件是否最新（比如CI构建）或者想避免网络访问的环境中。</dd>


<dt class="option-term" id="option-cargo-rustdoc---offline"><a class="option-anchor" href="#option-cargo-rustdoc---offline"></a><code>--offline</code></dt>
<dd class="option-desc">禁止 Cargo 在任何情况下访问网络。
如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，它会以错误的方式停止。
有了这个标志，Cargo会尝试在没有网络的情况下进行。</p>

<p>请注意，这可能会导致与在线模式不同的依赖方案。Cargo 会将自己限制在本地的 crate 仓库上，
即使在本地拷贝的索引中可能有更新的版本也是如此。
参见 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令来在离线前下载依赖关系。</p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">config value</a> 来指定。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-rustdoc-+toolchain"><a class="option-anchor" href="#option-cargo-rustdoc-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 已经和 rustup 一起安装, 并且 <code>cargo</code> 的第一个参数以
<code>+</code> 开头, 它将被解释为一个rustup工具链的名字 (比如 <code>+stable</code> 或者 <code>+nightly</code>)。
更多关于工具链覆盖工作的信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a></dd>


<dt class="option-term" id="option-cargo-rustdoc---config"><a class="option-anchor" href="#option-cargo-rustdoc---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖一个 Cargo 配置值。参数应该使用 TOML 的 <code>KEY=VALUE</code> 语法，或者提供一个额外配置文件的路径。
这个标志可以被多次指定。更多信息请参见 <a href="../reference/config.html#command-line-overrides">command-line overrides section</a>。</dd>


<dt class="option-term" id="option-cargo-rustdoc--h"><a class="option-anchor" href="#option-cargo-rustdoc--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-rustdoc---help"><a class="option-anchor" href="#option-cargo-rustdoc---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-rustdoc--Z"><a class="option-anchor" href="#option-cargo-rustdoc--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (仅限 nightly 版本) 标志。 更多信息请运行 <code>cargo -Z help</code>。</dd>


</dl>


### 其他选项

<dl>
<dt class="option-term" id="option-cargo-rustdoc--j"><a class="option-anchor" href="#option-cargo-rustdoc--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-rustdoc---jobs"><a class="option-anchor" href="#option-cargo-rustdoc---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">要运行的并行作业的数量。
也可以通过 <code>build.jobs</code> <a href="../reference/config.html">config value</a> 配置值来指定。
默认为逻辑CPU的数量。如果是负数，它将最大的并行作业数量设置为逻辑CPU的数量加上所提供的值。不应该是0。</dd>


<dt class="option-term" id="option-cargo-rustdoc---keep-going"><a class="option-anchor" href="#option-cargo-rustdoc---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">尽可能多地构建依赖关系图中的 crates, 而不是有一个 crate 构建失败则中止构建。
不稳定，需要 <code>-Zunstable-options</code>。</dd>


</dl>

## 环境

更多关于 Cargo 读取的环境变量信息，请参见[the reference](../reference/environment-variables.html)。


## 退出状态

* `0`: Cargo 成功退出.
* `101`: Cargo 错误退出.


## 示例

1. 使用指定文件中的自定义 CSS 生成文档:

       cargo rustdoc --lib -- --extend-css extra.css

## 另请参见
[cargo(1)](cargo.html), [cargo-doc(1)](cargo-doc.html), [rustdoc(1)](https://doc.rust-lang.org/rustdoc/index.html)
