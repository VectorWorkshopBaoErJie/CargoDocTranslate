# cargo-check(1)



## 名称

cargo-check - 检查当前包

## 简介

`cargo check` [_options_]

## 描述

检查本地包及其所有依赖项是否有错误。这实际上将编译软件包，而不执行代码生成的最后一步，这比运行“Cargo构建”要快。
编译器会将元数据文件保存到磁盘上，这样，如果源文件没有被修改，以后运行时就可以重用它们。一些诊断和错误仅在代码生成期间发出，因此它们本质上不会在“Cargo检查”中报告。

## 选项

### 包选择

缺省情况下，当没有给出包选择选项时，所选择的包取决于所选择的清单文件(如果没有给出 `- manifest-path ` ，则基于当前工作目录)。如果清单是工作区的根，则选择工作区的默认成员，否则只选择清单定义的包。

可以使用根清单中的 `workspace.default-members` 键显式设置工作区的默认成员。如果未设置此项，虚拟工作区将包括所有工作区成员（相当于传递 `- workspace ` ），而非虚拟工作区将只包括根机箱本身。

<dl>

<dt class="option-term" id="option-cargo-check--p"><a class="option-anchor" href="#option-cargo-check--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-check---package"><a class="option-anchor" href="#option-cargo-check---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅对指定的包进行基准测试。SPEC 格式请参考<a href="cargo-pkgid.html">cargo-pkgid(1)</a>。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >?</code >和 <code>[]</code > 。然而，为了避免你的shell在Cargo处理glob模式之前意外扩展它们，你必须在每个模式周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-check---workspace"><a class="option-anchor" href="#option-cargo-check---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">检查工作区中的所有成员。</dd>



<dt class="option-term" id="option-cargo-check---all"><a class="option-anchor" href="#option-cargo-check---all"></a><code>--all</code></dt>
<dd class="option-desc"><code>--workspace</code>已弃用的别名</dd>



<dt class="option-term" id="option-cargo-check---exclude"><a class="option-anchor" href="#option-cargo-check---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code >标志一起使用。该标志可以多次指定，并支持常见的Unix全局模式，如 <code>*</code >、<code >？</code > 和 <code>[]</code >。然而，为了避免你的shell在Cargo处理glob模式之前意外扩展它们，你必须在每个模式周围使用单引号或双引号。</dd>


</dl>


### 目标选择

当没有给出目标选择选项时，`Cargo检查` 将检查所选包的所有二进制和库目标。如果二进制文件缺少`必需的特性`,则跳过它们。

传递目标选择标志将只检查指定的目标。

注意`--bin`、`--example`、`--test`和`--bench`标志也支持常见的Unix全局模式，如`*`、`?`和`[]`。然而，为了避免你的 shell 在 Cargo 处理 glob 模式之前意外地扩展它们，你必须在每个 glob 模式周围使用单引号或双引号。

<dl>

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


</dl>


### 特性选择

功能标志允许你控制启用哪些功能。当未给出功能选项时，为每个选定的包激活“默认”功能。

请参见 [the features documentation](../reference/features.html#command-line-feature-options) 了解更多详细信息。

<dl>

<dt class="option-term" id="option-cargo-check--F"><a class="option-anchor" href="#option-cargo-check--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-check---features"><a class="option-anchor" href="#option-cargo-check---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的以空格或逗号分隔的功能列表。可以使用<code>package-name/feature-name</code>语法来启用工作区成员的功能。可以多次指定该标志，从而启用所有指定的功能。</dd>


<dt class="option-term" id="option-cargo-check---all-features"><a class="option-anchor" href="#option-cargo-check---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定软件包的所有可用功能。</dd>


<dt class="option-term" id="option-cargo-check---no-default-features"><a class="option-anchor" href="#option-cargo-check---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要激活所选软件包的<code>default</code>功能。</dd>


</dl>


### 编译选项

<dl>

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
<li><code>html</code >(不稳定，需要 <code>-Zunstable-options</code> ):将一个可读的文件 <code>cargo-timing.html</code> 写入 <code>target/cargo-timings</code> 目录，并附上编译报告。如果你想查看以前的运行，也可以在相同的目录下写一个带有时间戳的报告。HTML输出只适合人类使用，不提供机器可读的计时数据。</li>
<li><code>json</code >(不稳定，需要 <code>-Zunstable-options</code> ):发出有关计时信息的机器可读json信息。</li>
</ul></dd>




</dl>

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-check---target-dir"><a class="option-anchor" href="#option-cargo-check---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成的工件和中间文件的目录。也可以用<code>CARGO_TARGET_DIR</code>环境变量或<code>build.target-dir</code> <a  ref="../reference/config.html">config value</a>。
默认为工作区根目录中的< code>target</code >。</dd>


</dl>

### 显示选项

<dl>
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


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-check---manifest-path"><a class="option-anchor" href="#option-cargo-check---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code>文件的路径。默认情况下，Cargo在当前目录或任何父目录中搜索<code>Cargo.toml</code>文件。</dd>



<dt class="option-term" id="option-cargo-check---frozen"><a class="option-anchor" href="#option-cargo-check---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-check---locked"><a class="option-anchor" href="#option-cargo-check---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求<code>Cargo.lock</code>文件是最新的。如果锁文件丢失，或者需要更新，Cargo将出错退出。 <code>--freezed </code>标志还防止 Cargo 试图访问网络以确定其是否过期。</p>
<p>在你希望断言<code>Cargo.lock</code>文件是最新的(如CI构建)或希望避免网络访问的环境中，可以使用这些文件。</dd>


<dt class="option-term" id="option-cargo-check---offline"><a class="option-anchor" href="#option-cargo-check---offline"></a><code>--offline</code></dt>
<dd class="option-desc">防止Cargo以任何理由访问网络。如果没有这个标志，当Cargo需要访问网络而网络不可用时，Cargo将出错停止。有了这个标志，如果可能的话，Cargo将试图在没有网络的情况下前进。</p>
<p>请注意，这可能会导致与在线模式不同的依赖关系解析。Cargo将自己限制在本地下载的板条箱中，即使在索引的本地副本中可能有更新的版本。
请参阅<a href="cargo-fetch.html">cargo-fetch(1)</a >命令，以便在脱机之前下载依赖项。</p>
<p>也可以用<code>net.offline</code> <a href="../reference/config.html">配置值</a>。</dd>


</dl>

### 常见选项

<dl>

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


</dl>


### 其他选项

<dl>
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


</dl>

## 环境

参见 [the reference](../reference/environment-variables.html)
Cargo读取的环境变量的详细信息。


## 退出状态

* `0`: Cargo 成功。
* `101`: Cargo 未能完成。


## 示例

1. 检查本地包是否有错误:

       cargo check

2. 检查所有目标，包括单元测试:

       cargo check --all-targets --profile=test

## 另见
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html)
