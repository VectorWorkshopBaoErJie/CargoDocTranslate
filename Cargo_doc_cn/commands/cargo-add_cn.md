{==+==}
# cargo-add(1)
{==+==}
# cargo-add(1)
{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-add - Add dependencies to a Cargo.toml manifest file
{==+==}
cargo-add -向Cargo.toml清单文件添加依赖项
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 摘要
{==+==}

{==+==}
`cargo add` [_options_] _crate_...\
`cargo add` [_options_] `--path` _path_\
`cargo add` [_options_] `--git` _url_ [_crate_...]\
{==+==}
`cargo add` [_options_] _crate_...\
`cargo add` [_options_] `--path` _path_\
`cargo add` [_options_] `--git` _url_ [_crate_...]\
{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command can add or modify dependencies.
{==+==}
此命令可以添加或修改依赖关系。
{==+==}

{==+==}
The source for the dependency can be specified with:
{==+==}
依赖项的源可以通过以下内容指定：
{==+==}

{==+==}
* _crate_`@`_version_: Fetch from a registry with a version constraint of "_version_"
* `--path` _path_: Fetch from the specified _path_
* `--git` _url_: Pull from a git repo at _url_
{==+==}
* _crate_`@`_version_: 以"_version_"的约束从注册中心取（包）
* `--path` _path_: 从指定的 _path_ 取（包）
* `--git` _url_: 从给定 _url_ 的git仓库拉取
{==+==}

{==+==}
If no source is specified, then a best effort will be made to select one, including:
{==+==}
如果没有指定源，那么尽最大努力选择一个，包括：
{==+==}

{==+==}
* Existing dependencies in other tables (like `dev-dependencies`)
* Workspace members
* Latest release in the registry
{==+==}
* 其他表中存在的依赖 (例如 `dev-dependencies`)
* 工作空间成员
* 注册中心中的最新发行版
{==+==}

{==+==}
When you add a package that is already present, the existing entry will be updated with the flags specified.
{==+==}
当您添加一个已经存在的包时，将使用指定的标志更新现有条目。
{==+==}

{==+==}
Upon successful invocation, the enabled (`+`) and disabled (`-`) [features] of the specified
dependency will be listed in the command's output.
{==+==}
一旦成功调用，指定的依赖中的启用的 (`+`) 和 禁用的 (`-`) [特性]  将在命令输出中被列出
{==+==}

{==+==}
[features]: ../reference/features.md
{==+==}
[特性]: ../reference/features.md
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Source options
{==+==}
### 源选项
{==+==}

<dl>

{==+==}
<dt class="option-term" id="option-cargo-add---git"><a class="option-anchor" href="#option-cargo-add---git"></a><code>--git</code> <em>url</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#specifying-dependencies-from-git-repositories">Git URL to add the specified crate from</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---git"><a class="option-anchor" href="#option-cargo-add---git"></a><code>--git</code> <em>url</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#specifying-dependencies-from-git-repositories">从Git URL添加指定的crate</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---branch"><a class="option-anchor" href="#option-cargo-add---branch"></a><code>--branch</code> <em>branch</em></dt>
<dd class="option-desc">Branch to use when adding from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---branch"><a class="option-anchor" href="#option-cargo-add---branch"></a><code>--branch</code> <em>branch</em></dt>
<dd class="option-desc">从git添加时使用的分支。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---tag"><a class="option-anchor" href="#option-cargo-add---tag"></a><code>--tag</code> <em>tag</em></dt>
<dd class="option-desc">Tag to use when adding from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---tag"><a class="option-anchor" href="#option-cargo-add---tag"></a><code>--tag</code> <em>tag</em></dt>
<dd class="option-desc">从git添加时使用的标签。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---rev"><a class="option-anchor" href="#option-cargo-add---rev"></a><code>--rev</code> <em>sha</em></dt>
<dd class="option-desc">Specific commit to use when adding from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---rev"><a class="option-anchor" href="#option-cargo-add---rev"></a><code>--rev</code> <em>sha</em></dt>
<dd class="option-desc">从git添加时使用的特定提交</dd>
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-add---path"><a class="option-anchor" href="#option-cargo-add---path"></a><code>--path</code> <em>path</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#specifying-path-dependencies">Filesystem path</a> to local crate to add.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---path"><a class="option-anchor" href="#option-cargo-add---path"></a><code>--path</code> <em>path</em></dt>
<dd class="option-desc">要添加的本地crate的<a href="../reference/specifying-dependencies.html#specifying-path-dependencies">文件系统路径</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---registry"><a class="option-anchor" href="#option-cargo-add---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">Name of the registry to use. Registry names are defined in <a href="../reference/config.html">Cargo config
files</a>. If not specified, the default registry is used,
which is defined by the <code>registry.default</code> config key which defaults to
<code>crates-io</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---registry"><a class="option-anchor" href="#option-cargo-add---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">注册中心所使用的名称。注册中心名称被定义在<a href="../reference/config.html">Cargo配置文件</a>中。如果未指定将会使用默认注册中心，该注册中心由registry.default配置项定义，默认为<code>crates-io</code>。</dd>
{==+==}



</dl>

{==+==}
### Section options
{==+==}
### 部分选项
{==+==}

<dl>

{==+==}
<dt class="option-term" id="option-cargo-add---dev"><a class="option-anchor" href="#option-cargo-add---dev"></a><code>--dev</code></dt>
<dd class="option-desc">Add as a <a href="../reference/specifying-dependencies.html#development-dependencies">development dependency</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---dev"><a class="option-anchor" href="#option-cargo-add---dev"></a><code>--dev</code></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#development-dependencies">开发依赖</a>添加。</dd>
{==+==}

{==+==}
<dt class="option-term" id="option-cargo-add---build"><a class="option-anchor" href="#option-cargo-add---build"></a><code>--build</code></dt>
<dd class="option-desc">Add as a <a href="../reference/specifying-dependencies.html#build-dependencies">build dependency</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---build"><a class="option-anchor" href="#option-cargo-add---build"></a><code>--build</code></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#build-dependencies">构建依赖</a>添加。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---target"><a class="option-anchor" href="#option-cargo-add---target"></a><code>--target</code> <em>target</em></dt>
<dd class="option-desc">Add as a dependency to the <a href="../reference/specifying-dependencies.html#platform-specific-dependencies">given target platform</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---target"><a class="option-anchor" href="#option-cargo-add---target"></a><code>--target</code> <em>target</em></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#platform-specific-dependencies">给定目标平台</a>的依赖添加。</dd>
{==+==}


</dl>


</dl>

{==+==}
### Dependency options
{==+==}
### 依赖选项
{==+==}

<dl>

{==+==}
<dt class="option-term" id="option-cargo-add---dry-run"><a class="option-anchor" href="#option-cargo-add---dry-run"></a><code>--dry-run</code></dt>
<dd class="option-desc">Don't actually write the manifest</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---dry-run"><a class="option-anchor" href="#option-cargo-add---dry-run"></a><code>--dry-run</code></dt>
<dd class="option-desc">不真的写入清单</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---rename"><a class="option-anchor" href="#option-cargo-add---rename"></a><code>--rename</code> <em>name</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#renaming-dependencies-in-cargotoml">Rename</a> the dependency.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---rename"><a class="option-anchor" href="#option-cargo-add---rename"></a><code>--rename</code> <em>name</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#renaming-dependencies-in-cargotoml">重命名</a>依赖项。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---optional"><a class="option-anchor" href="#option-cargo-add---optional"></a><code>--optional</code></dt>
<dd class="option-desc">Mark the dependency as <a href="../reference/features.html#optional-dependencies">optional</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---optional"><a class="option-anchor" href="#option-cargo-add---optional"></a><code>--optional</code></dt>
<dd class="option-desc">标记依赖为<a href="../reference/features.html#optional-dependencies">可选的</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---no-optional"><a class="option-anchor" href="#option-cargo-add---no-optional"></a><code>--no-optional</code></dt>
<dd class="option-desc">Mark the dependency as <a href="../reference/features.html#optional-dependencies">required</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---no-optional"><a class="option-anchor" href="#option-cargo-add---no-optional"></a><code>--no-optional</code></dt>
<dd class="option-desc">标记依赖为<a href="../reference/features.html#optional-dependencies">必需的</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---no-default-features"><a class="option-anchor" href="#option-cargo-add---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Disable the <a href="../reference/features.html#dependency-features">default features</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---no-default-features"><a class="option-anchor" href="#option-cargo-add---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">禁用<a href="../reference/features.html#dependency-features">默认特性</a></dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---default-features"><a class="option-anchor" href="#option-cargo-add---default-features"></a><code>--default-features</code></dt>
<dd class="option-desc">Re-enable the <a href="../reference/features.html#dependency-features">default features</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---default-features"><a class="option-anchor" href="#option-cargo-add---default-features"></a><code>--default-features</code></dt>
<dd class="option-desc">重新启用<a href="../reference/features.html#dependency-features">默认特性</a></dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---features"><a class="option-anchor" href="#option-cargo-add---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of <a href="../reference/features.html#dependency-features">features to
activate</a>. When adding multiple
crates, the features for a specific crate may be enabled with
<code>package-name/feature-name</code> syntax. This flag may be specified multiple times,
which enables all specified features.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---features"><a class="option-anchor" href="#option-cargo-add---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的以逗号或空格分隔的<a href="../reference/features.html#dependency-features">特性</a>。添加多个crate时，特定板条箱的功能可通过<code>包名称/功能名称</code>语法启用。可以多次指定该标志，从而启用所有指定的功能。</dd>
{==+==}


</dl>


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}

<dl>
<dt class="option-term" id="option-cargo-add--v"><a class="option-anchor" href="#option-cargo-add--v"></a><code>-v</code></dt>
{==+==}
<dt class="option-term" id="option-cargo-add---verbose"><a class="option-anchor" href="#option-cargo-add---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---verbose"><a class="option-anchor" href="#option-cargo-add---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用详细输出。对于包括额外输出(如依赖关系警告和构建脚本输出)的“非常详细”输出，可以指定两次。也可以用<code>term.verbose</code><a href="../reference/config.html">配置</a>指定。</dd>
{==+==}


<dt class="option-term" id="option-cargo-add--q"><a class="option-anchor" href="#option-cargo-add--q"></a><code>-q</code></dt>
{==+==}
<dt class="option-term" id="option-cargo-add---quiet"><a class="option-anchor" href="#option-cargo-add---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---quiet"><a class="option-anchor" href="#option-cargo-add---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印cargo日志信息。也可以用<code>term.quiet</code><a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---color"><a class="option-anchor" href="#option-cargo-add---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-add---color"><a class="option-anchor" href="#option-cargo-add---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制何时使用彩色输出。有效值：</p>
<ul>
<li><code>auto</code> (默认)：自动检测终端是否支持颜色。</li>
<li><code>always</code>: 总是显示颜色</li>
<li><code>never</code>: 从不显示颜色</li>
</ul>
<p>也可以用<code>term.quiet</code><a href="../reference/config.html">配置</a>。</dd>
{==+==}


</dl>

{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}

<dl>
{==+==}
<dt class="option-term" id="option-cargo-add---manifest-path"><a class="option-anchor" href="#option-cargo-add---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---manifest-path"><a class="option-anchor" href="#option-cargo-add---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code>文件的路径。默认情况下，Cargo在当前目录或任何父目录中搜索<code>Cargo.toml</code>文件。</dd>
{==+==}



<dt class="option-term" id="option-cargo-add--p"><a class="option-anchor" href="#option-cargo-add--p"></a><code>-p</code> <em>spec</em></dt>
{==+==}
<dt class="option-term" id="option-cargo-add---package"><a class="option-anchor" href="#option-cargo-add---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">Add dependencies to only the specified package.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---package"><a class="option-anchor" href="#option-cargo-add---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">仅向指定的包添加依赖项。</dd>
{==+==}


<dt class="option-term" id="option-cargo-add---frozen"><a class="option-anchor" href="#option-cargo-add---frozen"></a><code>--frozen</code></dt>
{==+==}
<dt class="option-term" id="option-cargo-add---locked"><a class="option-anchor" href="#option-cargo-add---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---locked"><a class="option-anchor" href="#option-cargo-add---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求<code>Cargo.lock</code>文件是最新的。如果lock文件丢失，或者需要更新，Cargo将出错退出。<code>--frozen</code>标志还防止cargo试图访问网络来确定它是否过期。
在您希望断言<code>Cargo.lock</code>文件是最新的(例如CI构建)或希望避免网络访问的环境中，可以使用这些文件。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---offline"><a class="option-anchor" href="#option-cargo-add---offline"></a><code>--offline</code></dt>
<dd class="option-desc">Prevents Cargo from accessing the network for any reason. Without this
flag, Cargo will stop with an error if it needs to access the network and
the network is not available. With this flag, Cargo will attempt to
proceed without the network if possible.</p>
<p>Beware that this may result in different dependency resolution than online
mode. Cargo will restrict itself to crates that are downloaded locally, even
if there might be a newer version as indicated in the local copy of the index.
See the <a href="cargo-fetch.html">cargo-fetch(1)</a> command to download dependencies before going
offline.</p>
<p>May also be specified with the <code>net.offline</code> <a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---offline"><a class="option-anchor" href="#option-cargo-add---offline"></a><code>--offline</code></dt>
<dd class="option-desc">防止 Cargo 以任何理由访问网络。如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，Cargo 将出错停止。有了这个标志，如果可能的话，Cargo 将试图在没有网络的情况下前进。</p>
请注意，这可能会导致与在线模式不同的依赖关系解析。Cargo 将自己限制在本地下载的 crate 中，即使在索引的本地副本中可能有更新的版本。请参阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，以便在脱机之前下载依赖项。</p>
也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


</dl>

### Common Options

<dl>

{==+==}
<dt class="option-term" id="option-cargo-add-+toolchain"><a class="option-anchor" href="#option-cargo-add-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add-+toolchain"><a class="option-anchor" href="#option-cargo-add-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果cargo已经安装了rustup，并且 <code>cargo</code> 的第一个参数以 <code>cargo</code> 开头，它将被解释为 rustup 工具链名称(例如 <code>+stable</code> 或 <code>+nightly</code> )。有关工具链覆盖如何工作的更多信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add---config"><a class="option-anchor" href="#option-cargo-add---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---config"><a class="option-anchor" href="#option-cargo-add---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖 Cargo 配置值。该参数应该采用 <code>KEY=VALUE</code> 的 TOML 语法，或者作为额外配置文件的路径提供。可以多次指定该标志。有关更多信息，请参见 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a>。</dd>
{==+==}


<dt class="option-term" id="option-cargo-add--h"><a class="option-anchor" href="#option-cargo-add--h"></a><code>-h</code></dt>
{==+==}
<dt class="option-term" id="option-cargo-add---help"><a class="option-anchor" href="#option-cargo-add---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add---help"><a class="option-anchor" href="#option-cargo-add---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-add--Z"><a class="option-anchor" href="#option-cargo-add--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-add--Z"><a class="option-anchor" href="#option-cargo-add--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (nightly-only) 标志。运行 <code>cargo -Z help</code> 获取详细信息。</dd>
{==+==}


</dl>


{==+==}
## ENVIRONMENT
{==+==}
## 环境
{==+==}

{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
有关Cargo读取的环境变量的详细信息，请参见 [the reference](../reference/environment-variables.html)。
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
* `0`: Cargo 成功.
* `101`: Cargo 未能完成.
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}

{==+==}
1. Add `regex` as a dependency

       cargo add regex

2. Add `trybuild` as a dev-dependency

       cargo add --dev trybuild

3. Add an older version of `nom` as a dependency

       cargo add nom@5

4. Add support for serializing data structures to json with `derive`s

       cargo add serde serde_json -F serde/derive
{==+==}
1. 添加 `regex` 作为依赖项

       cargo add regex

2. 添加 `trybuild` 作为开发依赖项

       cargo add --dev trybuild

3. 添加旧版本的 `nom` 作为依赖项

       cargo add nom@5

4. 添加对使用 `derive` 将数据结构序列化到json的支持

       cargo add serde serde_json -F serde/derive
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 另见
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-remove(1)](cargo-remove.html)
{==+==}
[cargo(1)](cargo.html), [cargo-remove(1)](cargo-remove.html)
{==+==}
