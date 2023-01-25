{==+==}
# cargo-uninstall(1)
{==+==}

{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-uninstall - Remove a Rust binary
{==+==}
cargo-uninstall - 移除一个 Rust 二进制程序
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo uninstall` [_options_] [_spec_...]
{==+==}

{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command removes a package installed with [cargo-install(1)](cargo-install.html). The _spec_
argument is a package ID specification of the package to remove (see
[cargo-pkgid(1)](cargo-pkgid.html)).
{==+==}
这个命令会移除一个用 [cargo-install(1)](cargo-install.html) 安装的包。 _spec_ 参数是被移除的包的 package ID specification (见 [cargo-pkgid(1)](cargo-pkgid.html) )。
{==+==}

{==+==}
By default all binaries are removed for a crate but the `--bin` and
`--example` flags can be used to only remove particular binaries.
{==+==}
默认会移除该 crate 的所有可执行程序，但可以用 `--bin` 和 `--example` 标志来移除指定的二进制程序。
{==+==}

{==+==}
The installation root is determined, in order of precedence:
{==+==}
安装根目录位置按以下的优先级进行检测:
{==+==}

{==+==}
- `--root` option
- `CARGO_INSTALL_ROOT` environment variable
- `install.root` Cargo [config value](../reference/config.html)
- `CARGO_HOME` environment variable
- `$HOME/.cargo`
{==+==}
- 命令中的 `--root` 选项
- `CARGO_INSTALL_ROOT` 环境变量
- `install.root` Cargo [配置选项](../reference/config.html)
- `CARGO_HOME` 环境变量
- `$HOME/.cargo`
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Install Options
{==+==}
### 安装选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall--p"><a class="option-anchor" href="#option-cargo-uninstall--p"></a><code>-p</code></dt>
<dt class="option-term" id="option-cargo-uninstall---package"><a class="option-anchor" href="#option-cargo-uninstall---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">Package to uninstall.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall--p"><a class="option-anchor" href="#option-cargo-uninstall--p"></a><code>-p</code></dt>
<dt class="option-term" id="option-cargo-uninstall---package"><a class="option-anchor" href="#option-cargo-uninstall---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">要卸载的包。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall---bin"><a class="option-anchor" href="#option-cargo-uninstall---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Only uninstall the binary <em>name</em>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall---bin"><a class="option-anchor" href="#option-cargo-uninstall---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">只卸载名为 <em>name</em> 的二进制程序。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall---root"><a class="option-anchor" href="#option-cargo-uninstall---root"></a><code>--root</code> <em>dir</em></dt>
<dd class="option-desc">Directory to uninstall packages from.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall---root"><a class="option-anchor" href="#option-cargo-uninstall---root"></a><code>--root</code> <em>dir</em></dt>
<dd class="option-desc">从哪个文件夹中移除该包。</dd>
{==+==}

{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-uninstall--v"><a class="option-anchor" href="#option-cargo-uninstall--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-uninstall---verbose"><a class="option-anchor" href="#option-cargo-uninstall---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall--v"><a class="option-anchor" href="#option-cargo-uninstall--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-uninstall---verbose"><a class="option-anchor" href="#option-cargo-uninstall---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall--q"><a class="option-anchor" href="#option-cargo-uninstall--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-uninstall---quiet"><a class="option-anchor" href="#option-cargo-uninstall---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall--q"><a class="option-anchor" href="#option-cargo-uninstall--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-uninstall---quiet"><a class="option-anchor" href="#option-cargo-uninstall---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall---color"><a class="option-anchor" href="#option-cargo-uninstall---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall---color"><a class="option-anchor" href="#option-cargo-uninstall---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}

{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall-+toolchain"><a class="option-anchor" href="#option-cargo-uninstall-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall-+toolchain"><a class="option-anchor" href="#option-cargo-uninstall-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall---config"><a class="option-anchor" href="#option-cargo-uninstall---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall---config"><a class="option-anchor" href="#option-cargo-uninstall---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall--h"><a class="option-anchor" href="#option-cargo-uninstall--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-uninstall---help"><a class="option-anchor" href="#option-cargo-uninstall---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall--h"><a class="option-anchor" href="#option-cargo-uninstall--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-uninstall---help"><a class="option-anchor" href="#option-cargo-uninstall---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-uninstall--Z"><a class="option-anchor" href="#option-cargo-uninstall--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-uninstall--Z"><a class="option-anchor" href="#option-cargo-uninstall--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>
{==+==}



{==+==}
## ENVIRONMENT
{==+==}
## 环境
{==+==}

{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。
{==+==}


{==+==}
## EXIT STATUS
{==+==}
## 退出状态
{==+==}

{==+==}
* `0`: Cargo succeeded.
* `101`: Cargo failed to complete.
{==+==}
* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 使用案例
{==+==}

{==+==}
1. Uninstall a previously installed package.

       cargo uninstall ripgrep
{==+==}
1. 卸载一个之前安装的包: 

       cargo uninstall ripgrep
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-install(1)](cargo-install.html)
{==+==}

{==+==}
