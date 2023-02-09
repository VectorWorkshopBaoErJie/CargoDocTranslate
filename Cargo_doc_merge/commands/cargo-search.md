# cargo-search(1)

## 定义

cargo-search - 在 crates.io 上搜索包

## 概要

`cargo search` [_options_] [_query_...]

## 说明

这将对 <https://crates.io> 上的 crates 进行文本搜索。匹配的
的 crates 将被显示出来，crates 的描述也会以 TOML 格式显示出来，以便复制到
 `Cargo.toml` 中。

## 选项

### 搜索选项

<dl>

<dt class="option-term" id="option-cargo-search---limit"><a class="option-anchor" href="#option-cargo-search---limit"></a><code>--limit</code> <em>limit</em></dt>
<dd class="option-desc">限制结果显示数量 (默认: 10, 最大: 100).</dd>


<dt class="option-term" id="option-cargo-search---index"><a class="option-anchor" href="#option-cargo-search---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc">registry 索引使用的地址.</dd>



<dt class="option-term" id="option-cargo-search---registry"><a class="option-anchor" href="#option-cargo-search---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">使用的 registry 的名称。 Registry 的名称定义在 <a href="../reference/config.html">Cargo config
files</a>。 若此选项未指定，则使用默认 registry，
默认 registry 由 <code>registry.default</code> 定义。它默认为 <code>crates-io</code>。 </dd>



</dl>

### 展示选项

<dl>
<dt class="option-term" id="option-cargo-search--v"><a class="option-anchor" href="#option-cargo-search--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-search---verbose"><a class="option-anchor" href="#option-cargo-search---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用 verbose 级别输出详细信息。 指定两次此选项来输出 &quot;十分详细&quot; 的输出信息，
这会包含额外的输出信息，比如依赖警告和构建脚本输出。
也可以与 <code>term.verbose</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-search--q"><a class="option-anchor" href="#option-cargo-search--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-search---quiet"><a class="option-anchor" href="#option-cargo-search---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印任何 cargo 日志信息。
也可以与 <code>term.quiet</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-search---color"><a class="option-anchor" href="#option-cargo-search---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制的日志的颜色。 有效的值如下:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端颜色支持是否可用。</li>
<li><code>always</code>: 总是带颜色显示。</li>
<li><code>never</code>: 不带颜色显示.</li>
</ul>
<p>也可以与 <code>term.color</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-search-+toolchain"><a class="option-anchor" href="#option-cargo-search-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经和rustup一起安装, 并且 <code>cargo</code> 的第一个参数以 
<code>+</code> 开头, 它将被解释为一个rustup工具链的名字 (比如 <code>+stable</code> 或者 <code>+nightly</code>)。
更多关于工具链覆盖工作的信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
</dd>


<dt class="option-term" id="option-cargo-search---config"><a class="option-anchor" href="#option-cargo-search---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖一个 Cargo 配置值。参数应该使用 TOML 的 <code>KEY=VALUE</code> 语法，或者提供一个额外配置文件的路径。
这个标志可以被多次指定。更多信息请参见 <a href="../reference/config.html#command-line-overrides">command-line overrides section</a>。</dd>


<dt class="option-term" id="option-cargo-search--h"><a class="option-anchor" href="#option-cargo-search--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-search---help"><a class="option-anchor" href="#option-cargo-search---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-search--Z"><a class="option-anchor" href="#option-cargo-search--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (仅限 nightly 版本) 标志。 更多信息请运行 <code>cargo -Z help</code>。</dd>


</dl>


## 环境

参见[the reference](../reference/environment-variables.html)
获取关于 Cargo 所读取的环境变量的细节。


## 额外状态

* `0`: Cargo 成功完成某项任务.
* `101`: Cargo 未能完成某项任务.


## 例子

1. 在 crates.io 上搜索一个包:
       cargo search serde

## 另请参见
[cargo(1)](cargo.html), [cargo-install(1)](cargo-install.html), [cargo-publish(1)](cargo-publish.html)
