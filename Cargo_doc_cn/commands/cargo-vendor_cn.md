{==+==}
# cargo-vendor(1)
{==+==}

{==+==}


{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-vendor - Vendor all dependencies locally
{==+==}
cargo-vendor - 管理所有本地依赖
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo vendor` [_options_] [_path_]
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
This cargo subcommand will vendor all crates.io and git dependencies for a
project into the specified directory at `<path>`. After this command completes
the vendor directory specified by `<path>` will contain all remote sources from
dependencies specified. Additional manifests beyond the default one can be
specified with the `-s` option.
{==+==}
此cargo子命令将把项目crates.io和git所有依赖放到指定的 `<path>` 目录下。
命令完成后，由 `<path>` 指定的vendor目录将包含所有来自指定依赖的远程资源。
除默认配置清单，还可以用 `-s` 选项指定其他配置清单。
{==+==}


{==+==}
The `cargo vendor` command will also print out the configuration necessary
to use the vendored sources, which you will need to add to `.cargo/config.toml`.
{==+==}
`cargo vendor` 命令也会打印出使用外部资源所需的配置，需要将其添加到 `.cargo/config.toml` 中。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Vendor Options
{==+==}
### Vendor选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor--s"><a class="option-anchor" href="#option-cargo-vendor--s"></a><code>-s</code> <em>manifest</em></dt>
<dt class="option-term" id="option-cargo-vendor---sync"><a class="option-anchor" href="#option-cargo-vendor---sync"></a><code>--sync</code> <em>manifest</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Specify an extra <code>Cargo.toml</code> manifest to workspaces which should also be
vendored and synced to the output. May be specified multiple times.</dd>
{==+==}
<dd class="option-desc">为工作空间指定一个额外的<code>Cargo.toml</code>配置清单，将统一管理并同步输出。可以指定多次。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---no-delete"><a class="option-anchor" href="#option-cargo-vendor---no-delete"></a><code>--no-delete</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Don't delete the &quot;vendor&quot; directory when vendoring, but rather keep all
existing contents of the vendor directory</dd>
{==+==}
<dd class="option-desc">当进行vendor，不删除&quot;vendor&quot;目录，保留vendor目录的所有内容。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---respect-source-config"><a class="option-anchor" href="#option-cargo-vendor---respect-source-config"></a><code>--respect-source-config</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Instead of ignoring <code>[source]</code> configuration by default in <code>.cargo/config.toml</code>
read it and use it when downloading crates from crates.io, for example</dd>
{==+==}
<dd class="option-desc">在<code>.cargo/config.toml</code>中默认忽略<code>[source]</code>配置，而是从crates.io下载crate时读取并使用, 比如</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---versioned-dirs"><a class="option-anchor" href="#option-cargo-vendor---versioned-dirs"></a><code>--versioned-dirs</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Normally versions are only added to disambiguate multiple versions of the
same package. This option causes all directories in the &quot;vendor&quot; directory
to be versioned, which makes it easier to track the history of vendored
packages over time, and can help with the performance of re-vendoring when
only a subset of the packages have changed.</dd>
{==+==}
<dd class="option-desc">通常，添加版本是为了消除同一包的多版本歧义。这个选项使&quot;vendor&quot;目录中的所有目录都版本化，使得追踪包的历史更容易，当只有一部分包发生变化时，可以提升重新版本化的性能。</dd>
{==+==}


{==+==}
### Manifest Options
{==+==}
### 配置选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---manifest-path"><a class="option-anchor" href="#option-cargo-vendor---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>
{==+==}
<dd class="option-desc"><code>Cargo.toml</code>文件路径。
默认情况下，Cargo会在当前目录或任何父目录下搜索<code>Cargo.toml</code>文件。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---frozen"><a class="option-anchor" href="#option-cargo-vendor---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-vendor---locked"><a class="option-anchor" href="#option-cargo-vendor---locked"></a><code>--locked</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>
{==+==}
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---offline"><a class="option-anchor" href="#option-cargo-vendor---offline"></a><code>--offline</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prevents Cargo from accessing the network for any reason. Without this
flag, Cargo will stop with an error if it needs to access the network and
the network is not available. With this flag, Cargo will attempt to
proceed without the network if possible.</p>
{==+==}
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
{==+==}


{==+==}
<p>Beware that this may result in different dependency resolution than online
mode. Cargo will restrict itself to crates that are downloaded locally, even
if there might be a newer version as indicated in the local copy of the index.
See the <a href="cargo-fetch.html">cargo-fetch(1)</a> command to download dependencies before going
offline.</p>
{==+==}
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
{==+==}


{==+==}
<p>May also be specified with the <code>net.offline</code> <a href="../reference/config.html">config value</a>.</dd>
{==+==}
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor--v"><a class="option-anchor" href="#option-cargo-vendor--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-vendor---verbose"><a class="option-anchor" href="#option-cargo-vendor---verbose"></a><code>--verbose</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">进行详细输出。可以指定两次来开启 &quot;非常详细&quot; ，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor--q"><a class="option-anchor" href="#option-cargo-vendor--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-vendor---quiet"><a class="option-anchor" href="#option-cargo-vendor---quiet"></a><code>--quiet</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">不打印 cargo 日志信息。
也可以用 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---color"><a class="option-anchor" href="#option-cargo-vendor---color"></a><code>--color</code> <em>when</em></dt>
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

{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor-+toolchain"><a class="option-anchor" href="#option-cargo-vendor-+toolchain"></a><code>+</code><em>toolchain</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor---config"><a class="option-anchor" href="#option-cargo-vendor---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor--h"><a class="option-anchor" href="#option-cargo-vendor--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-vendor---help"><a class="option-anchor" href="#option-cargo-vendor---help"></a><code>--help</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-vendor--Z"><a class="option-anchor" href="#option-cargo-vendor--Z"></a><code>-Z</code> <em>flag</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>
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
查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。
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
* `101`: Cargo 未执行完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Vendor all dependencies into a local "vendor" folder

       cargo vendor
{==+==}
1. 将所有的依赖放到本地的 "vendor" 文件夹中。

       cargo vendor
{==+==}


{==+==}
2. Vendor all dependencies into a local "third-party/vendor" folder

       cargo vendor third-party/vendor
{==+==}
2. 将所有依赖放到本地的 "third-party/vendor" 文件夹中

       cargo vendor third-party/vendor
{==+==}


{==+==}
3. Vendor the current workspace as well as another to "vendor"

       cargo vendor -s ../path/to/Cargo.toml
{==+==}
3. 将当前工作空间以及另一个工作空间改为 "vendor" 。

       cargo vendor -s ../path/to/Cargo.toml
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html)
{==+==}
## 参阅
[cargo(1)](cargo.html)
{==+==}
