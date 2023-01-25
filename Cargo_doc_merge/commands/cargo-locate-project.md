# cargo-locate-project(1)

## 名称

cargo-locate-project - 以 JSON 格式打印 Cargo.toml 文件的位置

## 概要

`cargo locate-project` [_options_]

## 描述

这个命令会在 stdout 中以 JSON 格式打印清单文件的绝对地址。命令会从当前工作目录出发向上搜索 `Cargo.toml` 文件。

如果这个项目在一个工作空间 (workspace) 中，会打印该项目而不是工作空间的清单文件。这个行为可以通过 `--workspace` 标志来改变。工作空间根目录的查找是通过不断向上搜索或者从成员的清单文件中的 `package.workspace` 字段来得到。

## 选项

<dl>

<dt class="option-term" id="option-cargo-locate-project---workspace"><a class="option-anchor" href="#option-cargo-locate-project---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc"> 定位 <code>Cargo.toml</code>  workspace 根目录的位置，而不是当前的 workspace 成员.</dd>


</dl>

### 显示选项

<dl>

<dt class="option-term" id="option-cargo-locate-project---message-format"><a class="option-anchor" href="#option-cargo-locate-project---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">打印项目位置的格式。可选值有:</p>
<ul>
<li><code>json</code> (默认值): 带着 &quot;root&quot; 字段的 JSON 对象。</li>
<li><code>plain</code>: 仅路径字符串。</li>
</ul></dd>


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

1. 基于当前路径，显示清单文件(manifest)的路径。

       cargo locate-project

## 其他参考
[cargo(1)](cargo.html), [cargo-metadata(1)](cargo-metadata.html)
