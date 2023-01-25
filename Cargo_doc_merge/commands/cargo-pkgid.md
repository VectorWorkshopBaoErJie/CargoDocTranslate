# cargo-pkgid(1)

## 名称

cargo-pkgid - 打印包的完整标准规格。

## 概要

`cargo pkgid` [_options_] [_spec_]

## 描述

提供一个 _spec_ 参数，打印出当前工作空间中的一个包或一个依赖的完整的 package ID 指定符 (specifier)。如果 _spec_ 指定的包在依赖图中不明确 (不存在) ，则会报错。如果没有提供 _spec_ 参数，则会打印本地包 (local package)  的指定符。 

该命令要求已存在一个可用的 lockfile，且依赖已经被下载。

一个包指定符由名称、版本和源 URL 组成。你可以使用部分指定符来简洁地指定一个包，只要它正好只匹配一个包。 _spec_ 的格式可以为下面一种: 

SPEC Structure             | Example SPEC
---------------------------|--------------
_name_                     | `bitflags`
_name_`@`_version_         | `bitflags@1.0.4`
_url_                      | `https://github.com/rust-lang/cargo`
_url_`#`_version_          | `https://github.com/rust-lang/cargo#0.33.0`
_url_`#`_name_             | `https://github.com/rust-lang/crates.io-index#bitflags`
_url_`#`_name_`:`_version_ | `https://github.com/rust-lang/cargo#crates-io@0.21.0`

## 选项

### 包的选择

<dl>

<dt class="option-term" id="option-cargo-pkgid--p"><a class="option-anchor" href="#option-cargo-pkgid--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-pkgid---package"><a class="option-anchor" href="#option-cargo-pkgid---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">获取指定包的 package ID ，而不是当前的包。</dd>


</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-pkgid--v"><a class="option-anchor" href="#option-cargo-pkgid--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-pkgid---verbose"><a class="option-anchor" href="#option-cargo-pkgid---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>


<dt class="option-term" id="option-cargo-pkgid--q"><a class="option-anchor" href="#option-cargo-pkgid--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-pkgid---quiet"><a class="option-anchor" href="#option-cargo-pkgid---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>


<dt class="option-term" id="option-cargo-pkgid---color"><a class="option-anchor" href="#option-cargo-pkgid---color"></a><code>--color</code> <em>when</em></dt>
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

<dt class="option-term" id="option-cargo-pkgid---manifest-path"><a class="option-anchor" href="#option-cargo-pkgid---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。 默认情况下，Cargo 在当前目录或任意的父目录中查找 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-pkgid---frozen"><a class="option-anchor" href="#option-cargo-pkgid---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-pkgid---locked"><a class="option-anchor" href="#option-cargo-pkgid---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-pkgid---offline"><a class="option-anchor" href="#option-cargo-pkgid---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>



</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-pkgid-+toolchain"><a class="option-anchor" href="#option-cargo-pkgid-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-pkgid---config"><a class="option-anchor" href="#option-cargo-pkgid---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-pkgid--h"><a class="option-anchor" href="#option-cargo-pkgid--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-pkgid---help"><a class="option-anchor" href="#option-cargo-pkgid---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-pkgid--Z"><a class="option-anchor" href="#option-cargo-pkgid--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 获取 `foo` 的包指定符:

       cargo pkgid foo

2. 获取 1.0.0 版 `foo` 的包指定符:

       cargo pkgid foo@1.0.0

3. 获取 crates.io 上的 `foo` 的包指定符:

       cargo pkgid https://github.com/rust-lang/crates.io-index#foo

4. 获取本地 `foo` 包的包指定符:

       cargo pkgid file:///path/to/local/package#foo

## 其他参考
[cargo(1)](cargo.html), [cargo-generate-lockfile(1)](cargo-generate-lockfile.html), [cargo-metadata(1)](cargo-metadata.html)
