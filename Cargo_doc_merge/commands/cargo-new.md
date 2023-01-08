# cargo-new(1)

## 定义

cargo-new - 创建一个新的cargo package

## 概要

`cargo new` [_options_] _path_

## 说明

该命令会在给定的目录下新建一个cargo package，将创建一个简单的名为`Cargo.toml`的清单文件模板，
示例源文件，以及一个版本控制系统的忽略清单文件，如果该目录不在版本控制系统仓库下，那么将会创建一个仓库(详情查看下文中的 `--vcs` 说明)

查阅 [cargo-init(1)](cargo-init.html) 来了解类似的命令，用它可以在一个已经存在的目录下创建一个清单文件。

## 选项

### 新建选项

<dl>

<dt class="option-term" id="option-cargo-new---bin"><a class="option-anchor" href="#option-cargo-new---bin"></a><code>--bin</code></dt>
<dd class="option-desc">创建一个以binary为目标的package (<code>src/main.rs</code>).
This is the default behavior.</dd>


<dt class="option-term" id="option-cargo-new---lib"><a class="option-anchor" href="#option-cargo-new---lib"></a><code>--lib</code></dt>
<dd class="option-desc">创建一个以library为目标的package (<code>src/lib.rs</code>).</dd>


<dt class="option-term" id="option-cargo-new---edition"><a class="option-anchor" href="#option-cargo-new---edition"></a><code>--edition</code> <em>edition</em></dt>
<dd class="option-desc">指定使用的Rust的版本. 默认是 2021，
可能的值有: 2015, 2018, 2021</dd>


<dt class="option-term" id="option-cargo-new---name"><a class="option-anchor" href="#option-cargo-new---name"></a><code>--name</code> <em>name</em></dt>
<dd class="option-desc">设置package的名称，默认为给定的目录的名称。</dd>


<dt class="option-term" id="option-cargo-new---vcs"><a class="option-anchor" href="#option-cargo-new---vcs"></a><code>--vcs</code> <em>vcs</em></dt>
<dd class="option-desc">为版本控制系统(git, hg, pijul, 或者fossil)初始化一个仓库，否则将不会使用任何版本控制(none)。
如果该选项未被指定，则默认为 <code>git</code> 或者是在配置文件
<code>cargo-new.vcs</code>中指定的值，如果已经在一个版本控制系统仓库下面则相当于传入了 <code>none</code> 。</dd>


<dt class="option-term" id="option-cargo-new---registry"><a class="option-anchor" href="#option-cargo-new---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">指定该选项将找指定的注册项，并将 <code>Cargo.toml</code> 中的 <code>publish</code> 字段设置成它的值。</p>
<p>注册项的定义在 <a href="../reference/config.html">Cargo 配置文件</a>中。
如果未指定该选项，那么配置文件中 <code>registry.default</code> 块中的配置项将会被采用，
如果 <code>registry.default</code> 未被配置，并且 <code>--registry</code> 也未被指定, 那么 <code>publish</code> 就不会被设置，
这意味着发布将不受限制。
</dd>


</dl>


### 输出选项

<dl>
<dt class="option-term" id="option-cargo-new--v"><a class="option-anchor" href="#option-cargo-new--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-new---verbose"><a class="option-anchor" href="#option-cargo-new---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">采用冗长的输出. 可以被设置两次用来表示 &quot;非常冗长&quot; ，这将包含额外的输出信息，例如依赖的警告以及构建脚本的输出。
也可以通过 <code>term.verbose</code> 来配置 <a href="../reference/config.html">可选值</a>。</dd>


<dt class="option-term" id="option-cargo-new--q"><a class="option-anchor" href="#option-cargo-new--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-new---quiet"><a class="option-anchor" href="#option-cargo-new---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">表示不输出任何cargo日志信息，
也可以通过 <code>term.quiet</code> 来配置<a href="../reference/config.html">可选值</a>。</dd>


<dt class="option-term" id="option-cargo-new---color"><a class="option-anchor" href="#option-cargo-new---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">用来控制何时使用彩色的输出，有效值有:</p>
<ul>
<li><code>auto</code> (默认): 自动检测该终端是否支持彩色输出。</li>
<li><code>always</code>: 总是使用彩色输出。</li>
<li><code>never</code>: 从不使用彩色输出。</li>
</ul>
<p>也可以通过 <code>term.color</code> 来配置<a href="../reference/config.html">可选值</a>。</dd>


</dl>

### 一般选项

<dl>

<dt class="option-term" id="option-cargo-new-+toolchain"><a class="option-anchor" href="#option-cargo-new-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo是通过rustup安装的，如果第一个传给 <code>cargo</code> 的参数是以 <code>+</code> 开头的话，
它将被理解为rustup的工具链名称(例如 <code>+stable</code> 或者 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup文档</a>获取更多关于重载工具链的工作原理的信息</dd>


<dt class="option-term" id="option-cargo-new---config"><a class="option-anchor" href="#option-cargo-new---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">表示覆盖一个Cargo配置项的值. 传入的参数应当遵循 <code>KEY=VALUE</code> 的TOML语法或者是
一个额外的配置文件的路径。 该选项可以被配置多次.
查阅 <a href="../reference/config.html#command-line-overrides">命令行重写部分</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-new--h"><a class="option-anchor" href="#option-cargo-new--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-new---help"><a class="option-anchor" href="#option-cargo-new---help"></a><code>--help</code></dt>
<dd class="option-desc">输出帮助信息。</dd>


<dt class="option-term" id="option-cargo-new--Z"><a class="option-anchor" href="#option-cargo-new--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定的 (只在nightly下可用) 标识，执行 <code>cargo -Z help</code> 获取更多信息。</dd>


</dl>


## 环境

查阅 [参考手册](../reference/environment-variables.html) 获取Cargo将读取的环境变量的资料 


## 退出状态

* `0`: Cargo 成功退出.
* `101`: Cargo 错误退出.


## 示例

1. 在给定的目录下创建一个cargo package:

       cargo new foo

## 另请参见
[cargo(1)](cargo.html), [cargo-init(1)](cargo-init.html)
