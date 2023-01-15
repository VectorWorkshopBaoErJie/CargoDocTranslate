{==+==}
# cargo-login(1)
{==+==}
{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-login - Save an API token from the registry locally
{==+==}
cargo-login - 将 registry 的 API token 保存到本地
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo login` [_options_] [_token_]
{==+==}
{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command will save the API token to disk so that commands that require
authentication, such as [cargo-publish(1)](cargo-publish.html), will be automatically
authenticated. The token is saved in `$CARGO_HOME/credentials.toml`. `CARGO_HOME`
defaults to `.cargo` in your home directory.
{==+==}
这个命令会将一个 API token 保存到本地磁盘，之后那些需要身份验证的命令 (比如 [cargo-publish(1)](cargo-publish.html)) 就会自动验证了。这个 token 保存在 `$CARGO_HOME/credentials.toml`。`CARGO_HOME` 默认为你 home 目录的 `.cargo` 文件夹。
{==+==}

{==+==}
If the _token_ argument is not specified, it will be read from stdin.

The API token for crates.io may be retrieved from <https://crates.io/me>.

Take care to keep the token secret, it should not be shared with anyone else.
{==+==}
如果没有带上 _token_ 参数，则会从 stdin 中读取。

crates.io 的 API token 可以从 <https://crates.io/me> 获取。

注意保护你的 token，不要将其泄露给他人。
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Login Options
{==+==}
### 登陆选项
{==+==}

{==+==}
<dl>
<dt class="option-term" id="option-cargo-login---registry"><a class="option-anchor" href="#option-cargo-login---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">Name of the registry to use. Registry names are defined in <a href="../reference/config.html">Cargo config
files</a>. If not specified, the default registry is used,
which is defined by the <code>registry.default</code> config key which defaults to
<code>crates-io</code>.</dd>


</dl>
{==+==}
<dl>
<dt class="option-term" id="option-cargo-login---registry"><a class="option-anchor" href="#option-cargo-login---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">使用的 registry 的名字。 Registry 的名字定义在 <a href="../reference/config.html">Cargo 配置文件</a>中。 如果没有指定，则使用默认的 registry，
其定义于 <code>registry.default</code> 配置选项中，其默认值为 <code>crates-io</code> 。</dd>


</dl>
{==+==}

{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}

{==+==}
<dl>
{==+==}
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-login--v"><a class="option-anchor" href="#option-cargo-login--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-login---verbose"><a class="option-anchor" href="#option-cargo-login---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-login--q"><a class="option-anchor" href="#option-cargo-login--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-login---quiet"><a class="option-anchor" href="#option-cargo-login---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-login---color"><a class="option-anchor" href="#option-cargo-login---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-install---color"><a class="option-anchor" href="#option-cargo-install---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>
{==+==}


{==+==}
</dl>
{==+==}
{==+==}

{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}

{==+==}
<dl>
{==+==}
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-login-+toolchain"><a class="option-anchor" href="#option-cargo-login-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install-+toolchain"><a class="option-anchor" href="#option-cargo-install-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-login---config"><a class="option-anchor" href="#option-cargo-login---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-login--h"><a class="option-anchor" href="#option-cargo-login--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-login---help"><a class="option-anchor" href="#option-cargo-login---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-login--Z"><a class="option-anchor" href="#option-cargo-login--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>
{==+==}


{==+==}
</dl>
{==+==}
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
1. Save the API token to disk:

       cargo login
{==+==}
1. 将 API token 保存到本地磁盘:

       cargo login
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-publish(1)](cargo-publish.html)
{==+==}
{==+==}
