{==+==}
# cargo-publish(1)
{==+==}

{==+==}


{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-publish - Upload a package to the registry
{==+==}
cargo-publish - 上传包到注册中心
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo publish` [_options_]
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
This command will create a distributable, compressed `.crate` file with the
source code of the package in the current directory and upload it to a
registry. The default registry is <https://crates.io>. This performs the
following steps:
{==+==}
该命令将在当前目录下创建一个待分发的、压缩的 `.crate` 文件，其中包含包的源代码，并将其上传到注册中心。
默认的注册中心是 <https://crates.io> 。将执行以下步骤:
{==+==}


{==+==}
1. Performs a few checks, including:
   - Checks the `package.publish` key in the manifest for restrictions on
     which registries you are allowed to publish to.
{==+==}
1. 进行一些检查，包括:
   - 检查配置清单中的 `package.publish` 键，看是否限制发布到哪些注册中心。
{==+==}


{==+==}
2. Create a `.crate` file by following the steps in [cargo-package(1)](cargo-package.html).
3. Upload the crate to the registry. Note that the server will perform
   additional checks on the crate.
{==+==}
2. 按照 [cargo-package(1)](cargo-package.html) 中的步骤，创建 `.crate` 文件。
3. 将crate上传到注册中心。需注意，服务器将对crate进行额外的检查。
{==+==}


{==+==}
This command requires you to be authenticated with either the `--token` option
or using [cargo-login(1)](cargo-login.html).
{==+==}
该命令要求您使用 `--token` 选项或使用 [cargo-login(1)](cargo-login.html) 进行认证。
{==+==}


{==+==}
See [the reference](../reference/publishing.html) for more details about
packaging and publishing.
{==+==}
见 [参考](../reference/publishing.html) 了解关于包和发布的详情。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### Publish Options
{==+==}
### 发布选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---dry-run"><a class="option-anchor" href="#option-cargo-publish---dry-run"></a><code>--dry-run</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Perform all checks without uploading.</dd>
{==+==}
<dd class="option-desc">在不上传的情况下执行所有检查。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---token"><a class="option-anchor" href="#option-cargo-publish---token"></a><code>--token</code> <em>token</em></dt>
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
<dt class="option-term" id="option-cargo-publish---no-verify"><a class="option-anchor" href="#option-cargo-publish---no-verify"></a><code>--no-verify</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Don't verify the contents by building them.</dd>
{==+==}
<dd class="option-desc">不通过构建来验证内容。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---allow-dirty"><a class="option-anchor" href="#option-cargo-publish---allow-dirty"></a><code>--allow-dirty</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Allow working directories with uncommitted VCS changes to be packaged.</dd>
{==+==}
<dd class="option-desc">允许将带有未提交修改内容的VCS工作目录打包。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---index"><a class="option-anchor" href="#option-cargo-publish---index"></a><code>--index</code> <em>index</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">The URL of the registry index to use.</dd>
{==+==}
<dd class="option-desc">使用的注册中心索引URL。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---registry"><a class="option-anchor" href="#option-cargo-publish---registry"></a><code>--registry</code> <em>registry</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Name of the registry to publish to. Registry names are defined in <a href="../reference/config.html">Cargo
config files</a>. If not specified, and there is a
<a href="../reference/manifest.html#the-publish-field"><code>package.publish</code></a> field in
<code>Cargo.toml</code> with a single registry, then it will publish to that registry.
Otherwise it will use the default registry, which is defined by the
<a href="../reference/config.html#registrydefault"><code>registry.default</code></a> config key
which defaults to <code>crates-io</code>.</dd>
{==+==}
<dd class="option-desc">要发布到的注册中心名称，定义在 <a href="../reference/config.html">Cargo 配置文件</a>。 如果未指定, 在<code>Cargo.toml</code> <a href="../reference/manifest.html#the-publish-field"><code>package.publish</code></a> 字段有单独的键, 那么将发布到该注册中心。
否则，将使用默认的注册中心， 由 <a href="../reference/config.html#registrydefault"><code>registry.default</code></a> 键定义， 默认为<code>crates-io</code>。</dd>
{==+==}


{==+==}
### Package Selection
{==+==}
### 包的选择
{==+==}


{==+==}
By default, the package in the current working directory is selected. The `-p`
flag can be used to choose a different package in a workspace.
{==+==}
默认情况下，选中当前工作目录下的包。可用 `-p` 标志选择工作空间中不同的包。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--p"><a class="option-anchor" href="#option-cargo-publish--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-publish---package"><a class="option-anchor" href="#option-cargo-publish---package"></a><code>--package</code> <em>spec</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">The package to publish. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the SPEC
format.</dd>
{==+==}
<dd class="option-desc">要发布的包，见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 了解 SPEC 规范。</dd>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---target"><a class="option-anchor" href="#option-cargo-publish---target"></a><code>--target</code> <em>triple</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Publish for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>
{==+==}
<dd class="option-desc">对于给定架构发布。默认是主机的架构。常规格式是三元组 <code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。
运行<code>rustc --print target-list</code>获得支持的目标列表。 这个标志可被多次指定。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---target-dir"><a class="option-anchor" href="#option-cargo-publish---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to <code>target</code> in the root of the workspace.</dd>
{==+==}
<dd class="option-desc">所有生成制品和中间文件的目录。 也可以用 <code>CARGO_TARGET_DIR</code> 环境变量, 或 <code>build.target-dir</code> <a href="../reference/config.html">配置</a>。
默认为工作空间的根<code>target</code>。</dd>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 特性选择
{==+==}


{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。
{==+==}


{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
见 [特性文档](../reference/features.html#command-line-feature-options) 了解更多内容。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--F"><a class="option-anchor" href="#option-cargo-publish--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-publish---features"><a class="option-anchor" href="#option-cargo-publish---features"></a><code>--features</code> <em>features</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>
{==+==}
<dd class="option-desc">激活的特性列表用空格或逗号分隔。可以用<code>package-name/feature-name</code>语法启用工作空间成员的特性。这个标志可以被多次指定，从而可以启用所有指定的特性。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---all-features"><a class="option-anchor" href="#option-cargo-publish---all-features"></a><code>--all-features</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Activate all available features of all selected packages.</dd>
{==+==}
<dd class="option-desc">激活所有选定包的所有可用特性。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---no-default-features"><a class="option-anchor" href="#option-cargo-publish---no-default-features"></a><code>--no-default-features</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dd class="option-desc">不激活所选包的<code>default</code>特性。</dd>
{==+==}


{==+==}
### Manifest Options
{==+==}
### 配置选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---manifest-path"><a class="option-anchor" href="#option-cargo-publish---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
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
<dt class="option-term" id="option-cargo-publish---frozen"><a class="option-anchor" href="#option-cargo-publish---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-publish---locked"><a class="option-anchor" href="#option-cargo-publish---locked"></a><code>--locked</code></dt>
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
<dt class="option-term" id="option-cargo-publish---offline"><a class="option-anchor" href="#option-cargo-publish---offline"></a><code>--offline</code></dt>
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
### Miscellaneous Options
{==+==}
### 其它选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--j"><a class="option-anchor" href="#option-cargo-publish--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-publish---jobs"><a class="option-anchor" href="#option-cargo-publish---jobs"></a><code>--jobs</code> <em>N</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>
{==+==}
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---keep-going"><a class="option-anchor" href="#option-cargo-publish---keep-going"></a><code>--keep-going</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>
{==+==}
<dd class="option-desc">尽可能的构建依赖图中的 crate ，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>
{==+==}


{==+==}
### Display Options
{==+==}

{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--v"><a class="option-anchor" href="#option-cargo-publish--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-publish---verbose"><a class="option-anchor" href="#option-cargo-publish---verbose"></a><code>--verbose</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--q"><a class="option-anchor" href="#option-cargo-publish--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-publish---quiet"><a class="option-anchor" href="#option-cargo-publish---quiet"></a><code>--quiet</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish---color"><a class="option-anchor" href="#option-cargo-publish---color"></a><code>--color</code> <em>when</em></dt>
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
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
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
### 常规选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish-+toolchain"><a class="option-anchor" href="#option-cargo-publish-+toolchain"></a><code>+</code><em>toolchain</em></dt>
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
<dt class="option-term" id="option-cargo-publish---config"><a class="option-anchor" href="#option-cargo-publish---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
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
<dt class="option-term" id="option-cargo-publish--h"><a class="option-anchor" href="#option-cargo-publish--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-publish---help"><a class="option-anchor" href="#option-cargo-publish---help"></a><code>--help</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-publish--Z"><a class="option-anchor" href="#option-cargo-publish--Z"></a><code>-Z</code> <em>flag</em></dt>
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
* `101`: Cargo 没有成功完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Publish the current package:

       cargo publish
{==+==}
1. 发而当前的包:

       cargo publish
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-package(1)](cargo-package.html), [cargo-login(1)](cargo-login.html)
{==+==}
## 参阅
[cargo(1)](cargo.html), [cargo-package(1)](cargo-package.html), [cargo-login(1)](cargo-login.html)
{==+==}