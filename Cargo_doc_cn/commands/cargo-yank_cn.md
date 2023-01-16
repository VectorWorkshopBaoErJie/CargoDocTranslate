{==+==}
# cargo-yank(1)
{==+==}

{==+==}


{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-yank - Remove a pushed crate from the index
{==+==}
cargo-yank - 从索引中删除推送的crate
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo yank` [_options_] _crate_@_version_\
`cargo yank` [_options_] `--version` _version_ [_crate_]
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
The yank command removes a previously published crate's version from the
server's index. This command does not delete any data, and the crate will
still be available for download via the registry's download link.
{==+==}
yank命令从服务器的索引中删除先前发布的crate的版本。
该命令不会删除任何数据，该crate仍可通过注册中心的下载链接进行下载。
{==+==}


{==+==}
Note that existing crates locked to a yanked version will still be able to
download the yanked version to use it. Cargo will, however, not allow any new
crates to be locked to any yanked version.
{==+==}
请注意，crate的已锁死版本仍然能够下载使用。而Cargo将不允许新的crate使用锁死版本。
{==+==}


{==+==}
This command requires you to be authenticated with either the `--token` option
or using [cargo-login(1)](cargo-login.html).
{==+==}
该命令要求使用 `--token` 选项或使用 [cargo-login(1)](cargo-login.html)进行认证。
{==+==}


{==+==}
If the crate name is not specified, it will use the package name from the
current directory.
{==+==}
如果未指定crate名称，将使用当前目录包的名称。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Yank Options
{==+==}
### Yank 选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---vers"><a class="option-anchor" href="#option-cargo-yank---vers"></a><code>--vers</code> <em>version</em></dt>
<dt class="option-term" id="option-cargo-yank---version"><a class="option-anchor" 
href="#option-cargo-yank---version"></a><code>--version</code> <em>version</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">The version to yank or un-yank.</dd>
{==+==}
<dd class="option-desc">yank 或 un-yank 的版本。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---undo"><a class="option-anchor" href="#option-cargo-yank---undo"></a><code>--undo</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Undo a yank, putting a version back into the index.</dd>
{==+==}
<dd class="option-desc">撤消yank，将版本放回到索引中。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---token"><a class="option-anchor" href="#option-cargo-yank---token"></a><code>--token</code> <em>token</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">API token to use when authenticating. This overrides the token stored in
the credentials file (which is created by <a href="cargo-login.html">cargo-login(1)</a>).</p>
<p><a href="../reference/config.html">Cargo config</a> environment variables can be
used to override the tokens stored in the credentials file. The token for
crates.io may be specified with the <code>CARGO_REGISTRY_TOKEN</code> environment
variable. Tokens for other registries may be specified with environment
variables of the form <code>CARGO_REGISTRIES_NAME_TOKEN</code> where <code>NAME</code> is the name
of the registry in all capital letters.</dd>
{==+==}
<dd class="option-desc">认证时要使用的 API token。这将覆盖存储在证书文件中的令牌(由 <a href="cargo-login.html">cargo-login(1)</a>)。</p>
<p><a href="../reference/config.html">Cargo配置</a>环境变量可用于覆盖存储在证书文件中的令牌。
crates.io的令牌可以用<code>CARGO_REGISTRY_TOKEN</code>环境变量指定。其他注册中心的令牌可以用以下形式的环境变量来指定 <code>CARGO_REGISTRIES_NAME_TOKEN</code> 其 <code>NAME</code> 是注册中心的名称，全部大写字母。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---index"><a class="option-anchor" href="#option-cargo-yank---index"></a><code>--index</code> <em>index</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">The URL of the registry index to use.</dd>
{==+==}
<dd class="option-desc">要使用的注册中心索引的URL。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---registry"><a class="option-anchor" href="#option-cargo-yank---registry"></a><code>--registry</code> <em>registry</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Name of the registry to use. Registry names are defined in <a href="../reference/config.html">Cargo config
files</a>. If not specified, the default registry is used,
which is defined by the <code>registry.default</code> config key which defaults to
<code>crates-io</code>.</dd>
{==+==}
<dd class="option-desc">要使用的注册中心的名称。定义在 <a href="../reference/config.html">Cargo 配置文件中</a>。 如果没有指定，则使用默认，由 <code>registry.default</code> 键配置，默认为 <code>crates-io</code>。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank--v"><a class="option-anchor" href="#option-cargo-yank--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-yank---verbose"><a class="option-anchor" href="#option-cargo-yank---verbose"></a><code>--verbose</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">详细输出。 可以指定两次以 &quot;非常详细&quot; 输出，包含附加内容，如依赖警告和构建脚本输出。
也可以用 <code>term.verbose</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank--q"><a class="option-anchor" href="#option-cargo-yank--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-yank---quiet"><a class="option-anchor" href="#option-cargo-yank---quiet"></a><code>--quiet</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">不打印cargo日志信息。
也可以用 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---color"><a class="option-anchor" href="#option-cargo-yank---color"></a><code>--color</code> <em>when</em></dt>
{==+==}

{==+==}


{==+==}
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
<dd class="option-desc">使用彩色输出。有效值:</p>
<ul>
<li><code>auto</code> (默认):自动检测终端是否支持彩色。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 总不显示彩色。</li>
</ul>
<p>也可以用 <code>term.color</code>
<a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 常规选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank-+toolchain"><a class="option-anchor" href="#option-cargo-yank-+toolchain"></a><code>+</code><em>toolchain</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dd class="option-desc">如果Cargo已经和rustup一起安装，并且<code>cargo</code>的第一个参数为 <code>+</code>, 它将被解释为Rustup工具链的名称 (比如 <code>+stable</code> 或 <code>+nightly</code>).
见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a> 了解相关工具链覆盖的详细信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank---config"><a class="option-anchor" href="#option-cargo-yank---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dd class="option-desc">覆盖Cargo配置值。参数应是TOML语法中的 <code>KEY=VALUE</code>,
或作为一个额外的配置文件的路径提供。这个标志可以被多次指定。
见 <a href="../reference/config.html#command-line-overrides">command-line 覆盖部分</a> 了解详细信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank--h"><a class="option-anchor" href="#option-cargo-yank--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-yank---help"><a class="option-anchor" href="#option-cargo-yank---help"></a><code>--help</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-yank--Z"><a class="option-anchor" href="#option-cargo-yank--Z"></a><code>-Z</code> <em>flag</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dd class="option-desc">Cargo 不稳定 (每日构建) 的标志。 运行 <code>cargo -Z help</code> 获得详细信息。</dd>
{==+==}


{==+==}
## ENVIRONMENT
{==+==}

{==+==}


{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
见 [参考](../reference/environment-variables.html) 以了解Cargo所读取环境变量的详情。
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
* `0`: Cargo 成功。
* `101`: Cargo 未能完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Yank a crate from the index:

       cargo yank foo@1.0.7
{==+==}
1. 在索引Yank crate:

       cargo yank foo@1.0.7
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-login(1)](cargo-login.html), [cargo-publish(1)](cargo-publish.html)
{==+==}
## 参阅
[cargo(1)](cargo.html), [cargo-login(1)](cargo-login.html), [cargo-publish(1)](cargo-publish.html)
{==+==}