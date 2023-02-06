# cargo-run(1)


## 定义

cargo-run - 运行当前包

## 概要

`cargo run` [_options_] [`--` _args_]

### 说明

运行本地包的二进制程序或实例。

两个破折号(`--`)后的所有参数都传递给二进制程序运行。
如果同时向Cargo和二进制程序传递参数，那么 `--` 后面的参数将传递给二进制程序，前面的参数将传递给Cargo。

## 选项

### 包的选择

默认情况下，选中当前工作目录下的包。可以用 `-p` 标志来选择工作空间中不同的包。

<dl>

<dt class="option-term" id="option-cargo-run--p"><a class="option-anchor" href="#option-cargo-run--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-run---package"><a class="option-anchor" href="#option-cargo-run---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">运行包。 见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 了解 SPEC 规格。</dd>


</dl>


### 目标选择

当未给出目标选择选项时， `cargo run` 将运行二进制目标。如果有多个二进制目标，必须传递一个目标标志。或者，在 `Cargo.toml` 指定 `[package]` 表 `default-run` 字段。

<dl>

<dt class="option-term" id="option-cargo-run---bin"><a class="option-anchor" href="#option-cargo-run---bin"></a><code>--bin</code> <em>name</em></dt>
<dd class="option-desc">运行指定二进制。</dd>


<dt class="option-term" id="option-cargo-run---example"><a class="option-anchor" href="#option-cargo-run---example"></a><code>--example</code> <em>name</em></dt>
<dd class="option-desc">运行指定实例。</dd>


</dl>

### 特性选择

特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。

参阅 [特性文档](../reference/features.html#command-line-feature-options) 了解更多内容。

<dl>

<dt class="option-term" id="option-cargo-run--F"><a class="option-anchor" href="#option-cargo-run--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-run---features"><a class="option-anchor" href="#option-cargo-run---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的特性列表用空格或逗号分隔。
工作空间成员的特性可以用<code>package-name/feature-name</code>语法启用。
这个标志可以被多次指定，以启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-run---all-features"><a class="option-anchor" href="#option-cargo-run---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定包的所有可用特性。</dd>


<dt class="option-term" id="option-cargo-run---no-default-features"><a class="option-anchor" href="#option-cargo-run---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不要激活所选包的<code>default</code>特性。</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-run---target"><a class="option-anchor" href="#option-cargo-run---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">运行给定的架构。默认是主机架构。三元组的常规格式是 <code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。
运行 <code>rustc --print target-list</code> 以获得支持的目标列表。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>



<dt class="option-term" id="option-cargo-run--r"><a class="option-anchor" href="#option-cargo-run--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-run---release"><a class="option-anchor" href="#option-cargo-run---release"></a><code>--release</code></dt>
<dd class="option-desc">用<code>release</code> 编译设置运行优化的制品。
参见 <code>--profile</code> 选项，以按名称选择特定的编译设置。</dd>



<dt class="option-term" id="option-cargo-run---profile"><a class="option-anchor" href="#option-cargo-run---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">以给定的编译设置运行。
见 <a href="../reference/profiles.html">参考</a> 了解编译设置详情。</dd>



<dt class="option-term" id="option-cargo-run---ignore-rust-version"><a class="option-anchor" href="#option-cargo-run---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使所选的Rust编译器比项目<code>rust-version</code>字段中配置所需的Rust版本更早，仍运行目标。</dd>



<dt class="option-term" id="option-cargo-run---timings=fmts"><a class="option-anchor" href="#option-cargo-run---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每次编译需要多长时间的信息，并跟踪时间段的并发信息。
接受可选的逗号分隔的输出格式列表；没有参数的<code>--timings</code>将默认为<code>--timings=html</code>。
指定未稳定的输出格式(而不是默认)，需要<code>-Zunstable-options</code>。 有效的输出格式:</p>
<ul>
<li><code>html</code> (未稳定, 要求 <code>-Zunstable-options</code>): 在<code>target/cargo-timings</code>目录下生成可阅读的 cargo-timing.html 文件，并附编译报告。
如果你想查看更早的运行情况，也可以将报告写到同一目录下，文件名带有时间戳。
HTML输出适合人类阅读，机器不可读。</li>
<li><code>json</code> (未稳定, 要求 <code>-Zunstable-options</code>): 发送机器可读的关于时间信息的JSON。</li>
</ul></dd>




</dl>

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-run---target-dir"><a class="option-anchor" href="#option-cargo-run---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成制品和中间文件的目录。 也可以用 <code>CARGO_TARGET_DIR</code> 环境变量, 或 <code>build.target-dir</code> <a href="../reference/config.html">配置</a>。
默认为工作空间的根<code>target</code>。</dd>


</dl>

### 显示选项

<dl>

<dt class="option-term" id="option-cargo-run--v"><a class="option-anchor" href="#option-cargo-run--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-run---verbose"><a class="option-anchor" href="#option-cargo-run---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>


<dt class="option-term" id="option-cargo-run--q"><a class="option-anchor" href="#option-cargo-run--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-run---quiet"><a class="option-anchor" href="#option-cargo-run---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-run---color"><a class="option-anchor" href="#option-cargo-run---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>



<dt class="option-term" id="option-cargo-run---message-format"><a class="option-anchor" href="#option-cargo-run---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">特征信息的输出格式。可以多次指定，数值由逗号分隔。有效值:</p>
<ul>
<li><code>human</code> (默认): 以人可阅读的文本格式显示。 <code>short</code> 和 <code>json</code> 冲突。</li>
<li><code>short</code>: 发出更短的、人可阅读的文本信息。 <code>human</code> 和 <code>json</code> 冲突。</li>
<li><code>json</code>: 向标准输出发送JSON信息。 见 <a href="../reference/external-tools.html#json-messages">参考</a> 了解详情.  <code>human</code> 和 <code>short</code> 冲突。</li>
<li><code>json-diagnostic-short</code>: 确保JSON消息的<code>rendered</code>字段包含rustc的&quot;short&quot;渲染。不能和 <code>human</code> <code>short</code>。</li>
<li><code>json-diagnostic-rendered-ansi</code>: 确保JSON消息的<code>rendered</code>字段包含嵌入式ANSI颜色代码，以遵从rustc的默认颜色方案。 不能和 <code>human</code> <code>short</code>。</li>
<li><code>json-render-diagnostics</code>: 指示Cargo在打印的JSON信息中不包含rustc的特征信息，而是由Cargo来渲染来自rustc的JSON信息。Cargo自身的JSON和其他来自rustc的信息仍会发送。不能和 <code>human</code> <code>short</code>。</li>
</ul></dd>



</dl>

### 配置选项

<dl>

<dt class="option-term" id="option-cargo-run---manifest-path"><a class="option-anchor" href="#option-cargo-run---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。默认, Cargo 在当前目录和任意父目录搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-run---frozen"><a class="option-anchor" href="#option-cargo-run---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-run---locked"><a class="option-anchor" href="#option-cargo-run---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-run---offline"><a class="option-anchor" href="#option-cargo-run---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>



</dl>

### 常规选项

<dl>

<dt class="option-term" id="option-cargo-run-+toolchain"><a class="option-anchor" href="#option-cargo-run-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-run---config"><a class="option-anchor" href="#option-cargo-run---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-run--h"><a class="option-anchor" href="#option-cargo-run--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-run---help"><a class="option-anchor" href="#option-cargo-run---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-run--Z"><a class="option-anchor" href="#option-cargo-run--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


### 其他选项

<dl>
<dt class="option-term" id="option-cargo-run--j"><a class="option-anchor" href="#option-cargo-run--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-run---jobs"><a class="option-anchor" href="#option-cargo-run---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>


<dt class="option-term" id="option-cargo-run---keep-going"><a class="option-anchor" href="#option-cargo-run---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">尽可能的构建依赖图中的 crate ，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>


</dl>

## 环境

查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有成功完成。


## 示例

1. 构建本地包并运行其主要目标(假设仅有一个二进制文件):

       cargo run

2. 运行附带参数的实例:

       cargo run --example exname -- --exoption exarg1 exarg2

## 参阅
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html)
