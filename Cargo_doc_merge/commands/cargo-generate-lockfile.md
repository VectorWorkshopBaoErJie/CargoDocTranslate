# cargo-generate-lockfile(1)

## 名称

cargo-generate-lockfile - 为一个包生成 lockfile

## 概要

`cargo generate-lockfile` [_options_]

## 描述

这个命令会为当前的包 (package) 或工作空间 (workspace) 生成 `Cargo.lock`。如果 lockfile 已经存在，则会用各包的最新可用版本重新生成 `Cargo.lock` 。

另见 [cargo-update(1)](cargo-update.html) ，其也可以生成 `Cargo.lock` ，而且有更多针对更新策略的设置选项。

## 选项

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>


<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>


<dt class="option-term" id="option-cargo-install---color"><a class="option-anchor" href="#option-cargo-install---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-locate-project---manifest-path"><a class="option-anchor" href="#option-cargo-locate-project---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径。默认情况下，Cargo 会从当前目录或任意的上级目录搜索 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-install---frozen"><a class="option-anchor" href="#option-cargo-install---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-install---locked"><a class="option-anchor" href="#option-cargo-install---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-install---offline"><a class="option-anchor" href="#option-cargo-install---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-install-+toolchain"><a class="option-anchor" href="#option-cargo-install-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 创建或更新当前包 (package) 或工作空间 (workspace) 的 lockfile:

       cargo generate-lockfile

## 其他参考
[cargo(1)](cargo.html), [cargo-update(1)](cargo-update.html)
