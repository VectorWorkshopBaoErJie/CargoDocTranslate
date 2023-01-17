{==+==}
# cargo-owner(1)
{==+==}
{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-owner - Manage the owners of a crate on the registry
{==+==}
cargo-owner - 管理一个 crate 在 registry 上的所有者
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo owner` [_options_] `--add` _login_ [_crate_]\
`cargo owner` [_options_] `--remove` _login_ [_crate_]\
`cargo owner` [_options_] `--list` [_crate_]
{==+==}
{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command will modify the owners for a crate on the registry. Owners of a
crate can upload new versions and yank old versions. Non-team owners can also
modify the set of owners, so take care!
{==+==}
该命令会修改一个 crate 在 registry 上的所有者。crate 的所有者可以上传新版本和 yank 旧的版本。非团队成员的所有者(non-team owners)也可以修改所有者，所以授权时要小心。
{==+==}

{==+==}
This command requires you to be authenticated with either the `--token` option
or using [cargo-login(1)](cargo-login.html).
{==+==}
这个命令需要你经过身份验证，要么通过提供 `--token` 选项，要么使用 [cargo-login(1)](cargo-login.html) 命令。
{==+==}

{==+==}
If the crate name is not specified, it will use the package name from the
current directory.
{==+==}
如果没有指定 crate 的名称，则会使用当前目录下的包的名字。
{==+==}

{==+==}
See [the reference](../reference/publishing.html#cargo-owner) for more
information about owners and publishing.
{==+==}
从 [the reference](../reference/publishing.html#cargo-owner) 中获取更多关于所有者和发布的知识。
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Owner Options
{==+==}
### 所有者选项
{==+==}

{==+==}
<dl>
{==+==}
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-owner--a"><a class="option-anchor" href="#option-cargo-owner--a"></a><code>-a</code></dt>
<dt class="option-term" id="option-cargo-owner---add"><a class="option-anchor" href="#option-cargo-owner---add"></a><code>--add</code> <em>login</em>...</dt>
<dd class="option-desc">Invite the given user or team as an owner.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner--a"><a class="option-anchor" href="#option-cargo-owner--a"></a><code>-a</code></dt>
<dt class="option-term" id="option-cargo-owner---add"><a class="option-anchor" href="#option-cargo-owner---add"></a><code>--add</code> <em>login</em>...</dt>
<dd class="option-desc">添加指定的用户或团队为所有者。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner--r"><a class="option-anchor" href="#option-cargo-owner--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-owner---remove"><a class="option-anchor" href="#option-cargo-owner---remove"></a><code>--remove</code> <em>login</em>...</dt>
<dd class="option-desc">Remove the given user or team as an owner.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner--r"><a class="option-anchor" href="#option-cargo-owner--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-owner---remove"><a class="option-anchor" href="#option-cargo-owner---remove"></a><code>--remove</code> <em>login</em>...</dt>
<dd class="option-desc">在所有者中移除所指定的用户或团队。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner--l"><a class="option-anchor" href="#option-cargo-owner--l"></a><code>-l</code></dt>
<dt class="option-term" id="option-cargo-owner---list"><a class="option-anchor" href="#option-cargo-owner---list"></a><code>--list</code></dt>
<dd class="option-desc">List owners of a crate.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner--l"><a class="option-anchor" href="#option-cargo-owner--l"></a><code>-l</code></dt>
<dt class="option-term" id="option-cargo-owner---list"><a class="option-anchor" href="#option-cargo-owner---list"></a><code>--list</code></dt>
<dd class="option-desc">展示一个 crate 的全部所有者。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner---token"><a class="option-anchor" href="#option-cargo-owner---token"></a><code>--token</code> <em>token</em></dt>
<dd class="option-desc">API token to use when authenticating. This overrides the token stored in
the credentials file (which is created by <a href="cargo-login.html">cargo-login(1)</a>).</p>
<p><a href="../reference/config.html">Cargo config</a> environment variables can be
used to override the tokens stored in the credentials file. The token for
crates.io may be specified with the <code>CARGO_REGISTRY_TOKEN</code> environment
variable. Tokens for other registries may be specified with environment
variables of the form <code>CARGO_REGISTRIES_NAME_TOKEN</code> where <code>NAME</code> is the name
of the registry in all capital letters.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner---token"><a class="option-anchor" href="#option-cargo-owner---token"></a><code>--token</code> <em>token</em></dt>
<dd class="option-desc">用于身份验证的 API token 。这会覆盖保存在 credentials file (由 <a href="cargo-login.html">cargo-login(1)</a> 命令创建) 中的 token。</p>
<p><a href="../reference/config.html">Cargo config</a> 环境变量也可以覆盖 credentials file 中的 token。crates.io 的 token 可以用 <code>CARGO_REGISTRY_TOKEN</code> 环境变量来指定。其他 registry 的 token 可以用 <code>CARGO_REGISTRIES_NAME_TOKEN</code> 环境变量指定，其中 <code>NAME</code> 是 registry 名字的全大写字母表示。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-owner---index"><a class="option-anchor" href="#option-cargo-owner---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc">The URL of the registry index to use.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner---index"><a class="option-anchor" href="#option-cargo-owner---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc"> 使用的注册机构的 index 地址。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-owner---registry"><a class="option-anchor" href="#option-cargo-owner---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">Name of the registry to use. Registry names are defined in <a href="../reference/config.html">Cargo config
files</a>. If not specified, the default registry is used,
which is defined by the <code>registry.default</code> config key which defaults to
<code>crates-io</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner---registry"><a class="option-anchor" href="#option-cargo-owner---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc"> 使用的注册机构 (registry) 的名字。注册机构定义在 <a href="../reference/config.html">Cargo config 文件</a> 中. 如果没有指定就使用默认的注册机构，其定义在 <code>registry.default</code> 字段中，该值的默认值为 <code>crates-io</code> 。</dd>
{==+==}



{==+==}
</dl>
{==+==}
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
<dt class="option-term" id="option-cargo-owner--v"><a class="option-anchor" href="#option-cargo-owner--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-owner---verbose"><a class="option-anchor" href="#option-cargo-owner---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner--v"><a class="option-anchor" href="#option-cargo-owner--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-owner---verbose"><a class="option-anchor" href="#option-cargo-owner---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner--q"><a class="option-anchor" href="#option-cargo-owner--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-owner---quiet"><a class="option-anchor" href="#option-cargo-owner---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner--q"><a class="option-anchor" href="#option-cargo-owner--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-owner---quiet"><a class="option-anchor" href="#option-cargo-owner---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner---color"><a class="option-anchor" href="#option-cargo-owner---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-owner---color"><a class="option-anchor" href="#option-cargo-owner---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-owner-+toolchain"><a class="option-anchor" href="#option-cargo-owner-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner-+toolchain"><a class="option-anchor" href="#option-cargo-owner-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner---config"><a class="option-anchor" href="#option-cargo-owner---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-owner---config"><a class="option-anchor" href="#option-cargo-owner---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner--h"><a class="option-anchor" href="#option-cargo-owner--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-owner---help"><a class="option-anchor" href="#option-cargo-owner---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-owner--Z"><a class="option-anchor" href="#option-cargo-owner--Z"></a><code>-Z</code> <em>flag</em></dt>
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
1. List owners of a package:

       cargo owner --list foo

2. Invite an owner to a package:

       cargo owner --add username foo

3. Remove an owner from a package:

       cargo owner --remove username foo
{==+==}
1. 显示一个包的所有者:

       cargo owner --list foo

2. 给一个包添加一个所有者:

       cargo owner --add username foo

3. 给一个包移除一个所有者:

       cargo owner --remove username foo
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-login(1)](cargo-login.html), [cargo-publish(1)](cargo-publish.html)
{==+==}
{==+==}
