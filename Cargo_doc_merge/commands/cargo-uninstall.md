# cargo-uninstall(1)

## 名称

cargo-uninstall - 移除一个 Rust 二进制程序

## 概要

`cargo uninstall` [_options_] [_spec_...]

## 描述

这个命令会移除一个用 [cargo-install(1)](cargo-install.html) 安装的包。 _spec_ 参数是被移除的包的 package ID specification (见 [cargo-pkgid(1)](cargo-pkgid.html) )。

默认会移除该 crate 的所有可执行程序，但可以用 `--bin` 和 `--example` 标志来移除指定的二进制程序。

安装根目录位置按以下的优先级进行检测:

- 命令中的 `--root` 选项
- `CARGO_INSTALL_ROOT` 环境变量
- `install.root` Cargo [配置选项](../reference/config.html)
- `CARGO_HOME` 环境变量
- `$HOME/.cargo`


## 选项

### 安装选项

<dl>

<dt class="option-term" id="option-cargo-uninstall--p"><a class="option-anchor" href="#option-cargo-uninstall--p"></a><code>-p</code></dt>
<dt class="option-term" id="option-cargo-uninstall---package"><a class="option-anchor" href="#option-cargo-uninstall---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">要卸载的包。</dd>


<dt class="option-term" id="option-cargo-uninstall---bin"><a class="option-anchor" href="#option-cargo-uninstall---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">只卸载名为 <em>name</em> 的二进制程序。</dd>


<dt class="option-term" id="option-cargo-uninstall---root"><a class="option-anchor" href="#option-cargo-uninstall---root"></a><code>--root</code> <em>dir</em></dt>
<dd class="option-desc">从哪个文件夹中移除该包。</dd>


</dl>

### 显示选项

<dl>

<dt class="option-term" id="option-cargo-uninstall--v"><a class="option-anchor" href="#option-cargo-uninstall--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-uninstall---verbose"><a class="option-anchor" href="#option-cargo-uninstall---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>


<dt class="option-term" id="option-cargo-uninstall--q"><a class="option-anchor" href="#option-cargo-uninstall--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-uninstall---quiet"><a class="option-anchor" href="#option-cargo-uninstall---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-uninstall---color"><a class="option-anchor" href="#option-cargo-uninstall---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>



</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-uninstall-+toolchain"><a class="option-anchor" href="#option-cargo-uninstall-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-uninstall---config"><a class="option-anchor" href="#option-cargo-uninstall---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-uninstall--h"><a class="option-anchor" href="#option-cargo-uninstall--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-uninstall---help"><a class="option-anchor" href="#option-cargo-uninstall---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-uninstall--Z"><a class="option-anchor" href="#option-cargo-uninstall--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 卸载一个之前安装的包: 

       cargo uninstall ripgrep

## 其他参考
[cargo(1)](cargo.html), [cargo-install(1)](cargo-install.html)
