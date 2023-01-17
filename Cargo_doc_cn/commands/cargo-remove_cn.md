{==+==}
# cargo-remove(1)
{==+==}

{==+==}


{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-remove - Remove dependencies from a Cargo.toml manifest file
{==+==}
cargo-remove - 移除Cargo.toml配置清单文件中的依赖项
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo remove` [_options_] _dependency_...
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
Remove one or more dependencies from a `Cargo.toml` manifest.
{==+==}
从 `Cargo.toml` 配置清单中移除一个或多个依赖项。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Section options
{==+==}
### 条目选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---dev"><a class="option-anchor" href="#option-cargo-remove---dev"></a><code>--dev</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Remove as a <a href="../reference/specifying-dependencies.html#development-dependencies">development dependency</a>.</dd>
{==+==}
<dd class="option-desc">移除 <a href="../reference/specifying-dependencies.html#development-dependencies">开发依赖</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---build"><a class="option-anchor" href="#option-cargo-remove---build"></a><code>--build</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Remove as a <a href="../reference/specifying-dependencies.html#build-dependencies">build dependency</a>.</dd>
{==+==}
<dd class="option-desc">移除 <a href="../reference/specifying-dependencies.html#build-dependencies">构建依赖</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---target"><a class="option-anchor" href="#option-cargo-remove---target"></a><code>--target</code> <em>target</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Remove as a dependency to the <a href="../reference/specifying-dependencies.html#platform-specific-dependencies">given target platform</a>.</dd>
{==+==}
<dd class="option-desc">移除<a href="../reference/specifying-dependencies.html#platform-specific-dependencies">指定目标平台的依赖</a>。</dd>
{==+==}


{==+==}
### Miscellaneous Options
{==+==}
### 其他选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---dry-run"><a class="option-anchor" href="#option-cargo-remove---dry-run"></a><code>--dry-run</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Don't actually write to the manifest.</dd>
{==+==}
<dd class="option-desc">非实际写入配置清单。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove--v"><a class="option-anchor" href="#option-cargo-remove--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-remove---verbose"><a class="option-anchor" href="#option-cargo-remove---verbose"></a><code>--verbose</code></dt>
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
<dt class="option-term" id="option-cargo-remove--q"><a class="option-anchor" href="#option-cargo-remove--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-remove---quiet"><a class="option-anchor" href="#option-cargo-remove---quiet"></a><code>--quiet</code></dt>
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
<dt class="option-term" id="option-cargo-remove---color"><a class="option-anchor" href="#option-cargo-remove---color"></a><code>--color</code> <em>when</em></dt>
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
### Manifest Options
{==+==}
### 配置选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---manifest-path"><a class="option-anchor" href="#option-cargo-remove---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>
{==+==}
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。默认, Cargo 在当前目录和任意父目录搜索
<code>Cargo.toml</code> 文件。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove---frozen"><a class="option-anchor" href="#option-cargo-remove---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-remove---locked"><a class="option-anchor" href="#option-cargo-remove---locked"></a><code>--locked</code></dt>
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
<dt class="option-term" id="option-cargo-remove---offline"><a class="option-anchor" href="#option-cargo-remove---offline"></a><code>--offline</code></dt>
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
### Package Selection
{==+==}
### 包的选择
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove--p"><a class="option-anchor" href="#option-cargo-remove--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-remove---package"><a class="option-anchor" href="#option-cargo-remove---package"></a><code>--package</code> <em>spec</em>...</dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Package to remove from.</dd>
{==+==}
<dd class="option-desc">移除包。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 常规选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove-+toolchain"><a class="option-anchor" href="#option-cargo-remove-+toolchain"></a><code>+</code><em>toolchain</em></dt>
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
<dt class="option-term" id="option-cargo-remove---config"><a class="option-anchor" href="#option-cargo-remove---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
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
<dt class="option-term" id="option-cargo-remove--h"><a class="option-anchor" href="#option-cargo-remove--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-remove---help"><a class="option-anchor" href="#option-cargo-remove---help"></a><code>--help</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-remove--Z"><a class="option-anchor" href="#option-cargo-remove--Z"></a><code>-Z</code> <em>flag</em></dt>
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
* `101`: Cargo 没有执行完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Remove `regex` as a dependency

       cargo remove regex
{==+==}
1. 移除 `regex` 依赖

       cargo remove regex
{==+==}


{==+==}
2. Remove `trybuild` as a dev-dependency

       cargo remove --dev trybuild
{==+==}
2. 移除 `trybuild`  dev-依赖

       cargo remove --dev trybuild
{==+==}


{==+==}
3. Remove `nom` from the `x86_64-pc-windows-gnu` dependencies table

       cargo remove --target x86_64-pc-windows-gnu nom
{==+==}
3. 在 `x86_64-pc-windows-gnu` 依赖表移除 `nom` 

       cargo remove --target x86_64-pc-windows-gnu nom
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-add(1)](cargo-add.html)
{==+==}
## 参阅
[cargo(1)](cargo.html), [cargo-add(1)](cargo-add.html)
{==+==}