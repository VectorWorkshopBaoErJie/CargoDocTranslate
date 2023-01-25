# cargo-owner(1)

## 名称

cargo-owner - 管理一个 crate 在 registry 上的所有者

## 概要

`cargo owner` [_options_] `--add` _login_ [_crate_]\
`cargo owner` [_options_] `--remove` _login_ [_crate_]\
`cargo owner` [_options_] `--list` [_crate_]

## 描述

该命令会修改一个 crate 在 registry 上的所有者。crate 的所有者可以上传新版本和 yank 旧的版本。非团队成员的所有者(non-team owners)也可以修改所有者，所以授权时要小心。

这个命令需要你经过身份验证，要么通过提供 `--token` 选项，要么使用 [cargo-login(1)](cargo-login.html) 命令。

如果没有指定 crate 的名称，则会使用当前目录下的包的名字。

从 [the reference](../reference/publishing.html#cargo-owner) 中获取更多关于所有者和发布的知识。

## 选项

### 所有者选项

<dl>

<dt class="option-term" id="option-cargo-owner--a"><a class="option-anchor" href="#option-cargo-owner--a"></a><code>-a</code></dt>
<dt class="option-term" id="option-cargo-owner---add"><a class="option-anchor" href="#option-cargo-owner---add"></a><code>--add</code> <em>login</em>...</dt>
<dd class="option-desc">添加指定的用户或团队为所有者。</dd>


<dt class="option-term" id="option-cargo-owner--r"><a class="option-anchor" href="#option-cargo-owner--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-owner---remove"><a class="option-anchor" href="#option-cargo-owner---remove"></a><code>--remove</code> <em>login</em>...</dt>
<dd class="option-desc">在所有者中移除所指定的用户或团队。</dd>


<dt class="option-term" id="option-cargo-owner--l"><a class="option-anchor" href="#option-cargo-owner--l"></a><code>-l</code></dt>
<dt class="option-term" id="option-cargo-owner---list"><a class="option-anchor" href="#option-cargo-owner---list"></a><code>--list</code></dt>
<dd class="option-desc">展示一个 crate 的全部所有者。</dd>


<dt class="option-term" id="option-cargo-owner---token"><a class="option-anchor" href="#option-cargo-owner---token"></a><code>--token</code> <em>token</em></dt>
<dd class="option-desc">用于身份验证的 API token 。这会覆盖保存在 credentials file (由 <a href="cargo-login.html">cargo-login(1)</a> 命令创建) 中的 token。</p>
<p><a href="../reference/config.html">Cargo config</a> 环境变量也可以覆盖 credentials file 中的 token。crates.io 的 token 可以用 <code>CARGO_REGISTRY_TOKEN</code> 环境变量来指定。其他 registry 的 token 可以用 <code>CARGO_REGISTRIES_NAME_TOKEN</code> 环境变量指定，其中 <code>NAME</code> 是 registry 名字的全大写字母表示。</dd>



<dt class="option-term" id="option-cargo-owner---index"><a class="option-anchor" href="#option-cargo-owner---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc"> 使用的注册机构的 index 地址。</dd>



<dt class="option-term" id="option-cargo-owner---registry"><a class="option-anchor" href="#option-cargo-owner---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc"> 使用的注册机构 (registry) 的名字。注册机构定义在 <a href="../reference/config.html">Cargo config 文件</a> 中. 如果没有指定就使用默认的注册机构，其定义在 <code>registry.default</code> 字段中，该值的默认值为 <code>crates-io</code> 。</dd>



</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-owner--v"><a class="option-anchor" href="#option-cargo-owner--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-owner---verbose"><a class="option-anchor" href="#option-cargo-owner---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>


<dt class="option-term" id="option-cargo-owner--q"><a class="option-anchor" href="#option-cargo-owner--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-owner---quiet"><a class="option-anchor" href="#option-cargo-owner---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>


<dt class="option-term" id="option-cargo-owner---color"><a class="option-anchor" href="#option-cargo-owner---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-owner-+toolchain"><a class="option-anchor" href="#option-cargo-owner-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-owner---config"><a class="option-anchor" href="#option-cargo-owner---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
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

1. 显示一个包的所有者:

       cargo owner --list foo

2. 给一个包添加一个所有者:

       cargo owner --add username foo

3. 给一个包移除一个所有者:

       cargo owner --remove username foo

## 其他参考
[cargo(1)](cargo.html), [cargo-login(1)](cargo-login.html), [cargo-publish(1)](cargo-publish.html)
