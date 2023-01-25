# cargo-verify-project(1)

## 定义

cargo-verify-project - 检查crate配置清单的正确性

## 概要

`cargo verify-project` [_options_]

## 说明

该命令将解析本地配置清单并检查其有效性。发送包含结果的JSON对象。如果验证成功，将显示:

    {"success":"true"}

一个无效的工作空间将显示:

    {"invalid":"human-readable error message"}

## 选项

### 显示选项

<dl>

<dt class="option-term" id="option-cargo-verify-project--v"><a class="option-anchor" href="#option-cargo-verify-project--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-verify-project---verbose"><a class="option-anchor" href="#option-cargo-verify-project---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两次来开启 &quot;非常详细&quot; ，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-verify-project--q"><a class="option-anchor" href="#option-cargo-verify-project--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-verify-project---quiet"><a class="option-anchor" href="#option-cargo-verify-project---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以用 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-verify-project---color"><a class="option-anchor" href="#option-cargo-verify-project---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">使用彩色输出。有效值:</p>
<ul>
<li><code>auto</code> (默认):自动检测终端是否支持彩色。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 总不显示彩色。</li>
</ul>
<p>也可以用 <code>term.color</code>
<a href="../reference/config.html">配置</a>。</dd>



</dl>

### 配置选项

<dl>

<dt class="option-term" id="option-cargo-verify-project---manifest-path"><a class="option-anchor" href="#option-cargo-verify-project---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。默认, Cargo 在当前目录和任意父目录搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-verify-project---frozen"><a class="option-anchor" href="#option-cargo-verify-project---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-verify-project---locked"><a class="option-anchor" href="#option-cargo-verify-project---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-verify-project---offline"><a class="option-anchor" href="#option-cargo-verify-project---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>



</dl>

### 常规选项

<dl>

<dt class="option-term" id="option-cargo-verify-project-+toolchain"><a class="option-anchor" href="#option-cargo-verify-project-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-verify-project---config"><a class="option-anchor" href="#option-cargo-verify-project---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-verify-project--h"><a class="option-anchor" href="#option-cargo-verify-project--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-verify-project---help"><a class="option-anchor" href="#option-cargo-verify-project---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-verify-project--Z"><a class="option-anchor" href="#option-cargo-verify-project--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


## ENVIRONMENT

查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。


## 退出状态

* `0`: 工作空间正常。
* `1`: 工作空间失效。

## 示例

1. 检查当前工作空间错误:

       cargo verify-project

## 参阅
[cargo(1)](cargo.html), [cargo-package(1)](cargo-package.html)
