{==+==}
# cargo-install(1)
{==+==}

{==+==}



{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-install - Build and install a Rust binary
{==+==}
cargo-install - 构建和安装 Rust 二进制程序
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo install` [_options_] _crate_[@_version_]...\
`cargo install` [_options_] `--path` _path_\
`cargo install` [_options_] `--git` _url_ [_crate_...]\
`cargo install` [_options_] `--list`
{==+==}

{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command manages Cargo's local set of installed binary crates. Only
packages which have executable `[[bin]]` or `[[example]]` targets can be
installed, and all executables are installed into the installation root's
`bin` folder.
{==+==}
这个命令管理 Cargo 安装到本地的所有二进制crate。只有具有可执行的 `[[bin]]` 或 `[[example]]` 的包才能被安装，保存位置为安装根目录(root)的 `bin` 文件夹。
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
There are multiple sources from which a crate can be installed. The default
location is crates.io but the `--git`, `--path`, and `--registry` flags can
change this source. If the source contains more than one package (such as
crates.io or a git repository with multiple crates) the _crate_ argument is
required to indicate which crate should be installed.
{==+==}
可以从多种来源安装一个crate，默认是从 crates.io，使用 `--git`， `--path`，和  `--registry` 可以改变安装源。如果安装源包含多个包 (比如 crates.io 或有包含多个crate 的 git 仓库)，则需要 _crate_ 参数来指定具体安装哪个 crate 。
{==+==}

{==+==}
Crates from crates.io can optionally specify the version they wish to install
via the `--version` flags, and similarly packages from git repositories can
optionally specify the branch, tag, or revision that should be installed. If a
crate has multiple binaries, the `--bin` argument can selectively install only
one of them, and if you'd rather install examples the `--example` argument can
be used as well.
{==+==}
安装 crates.io 中的 crate 时，可以通过 `--version` 指定想要的版本。同样的，从 git 仓库安装时可以指定 branch、tag 或 revision (hash值)。如果一个 crate 有多个二进制程序(binary)，可以使用 `--bin` 来指定安装其中的一个。如果想安装 example，也可以使用 `--example` 参数。
{==+==}

{==+==}
If the package is already installed, Cargo will reinstall it if the installed
version does not appear to be up-to-date. If any of the following values
change, then Cargo will reinstall the package:
{==+==}
当这个包已经被安装，但看起来并不是最新版本时，Cargo 会重新安装它。如果以下的任何一个值发生改变，Cargo 就会重新安装该包:
{==+==}

{==+==}
- The package version and source.
- The set of binary names installed.
- The chosen features.
- The profile (`--profile`).
- The target (`--target`).
{==+==}
- 包的版本或者安装源
- 安装的二进制程序的名字集合
- 选择的特性(features)
- 编译配置 (`--profile`).
- 编译目标 (`--target`).
{==+==}

{==+==}
Installing with `--path` will always build and install, unless there are
conflicting binaries from another package. The `--force` flag may be used to
force Cargo to always reinstall the package.
{==+==}
使用 `--path` 时总会重新进行构建和安装，除非与其他包的程序发生了冲突。 `--force` 标志可以强制命令 Cargo 重新安装一个包。
{==+==}

{==+==}
If the source is crates.io or `--git` then by default the crate will be built
in a temporary target directory. To avoid this, the target directory can be
specified by setting the `CARGO_TARGET_DIR` environment variable to a relative
path. In particular, this can be useful for caching build artifacts on
continuous integration systems.
{==+==}
从 crates.io 或 `git` 仓库进行安装时，会默认在一个临时文件夹中构建该crate。如果要改变这种行为，可以设置 `CARGO_TARGET_DIR` 环境变量为一个相对路径 (译者注：经测试，这个相对路径是相对于执行 `cargo install` 命令的路径(cwd)，构建过程产生的文件会存在该目录中，而可执行文件还是会放到 `bin` 目录下)。这在持续集成中缓存(cache) 构建文件尤其有用。
{==+==}

{==+==}
By default, the `Cargo.lock` file that is included with the package will be
ignored. This means that Cargo will recompute which versions of dependencies
to use, possibly using newer versions that have been released since the
package was published. The `--locked` flag can be used to force Cargo to use
the packaged `Cargo.lock` file if it is available. This may be useful for
ensuring reproducible builds, to use the exact same set of dependencies that
were available when the package was published. It may also be useful if a
newer version of a dependency is published that no longer builds on your
system, or has other problems. The downside to using `--locked` is that you
will not receive any fixes or updates to any dependency. Note that Cargo did
not start publishing `Cargo.lock` files until version 1.37, which means
packages published with prior versions will not have a `Cargo.lock` file
available.
{==+==}
默认情况下，包自带的 `Cargo.lock` 文件会被忽略，这意味着 Cargo 会重新计算使用依赖的版本，很有可能使用到比发布该包时更新的依赖版本。可以使用 `--locked` 标志来强制要求 Cargo 使用包自带的 `Cargo.lock` (如果可行的话)。这对于保证构建的可重复性很有用，因为使用的是这个包发布时的那些保证可用的依赖版本。另一个有用之处在于该包发布后可能有某些依赖更新版本导致该包无法构建，或者依赖更新后出了问题，使用 `--locked` 可以避免这些麻烦。缺点就是你无法使用到依赖的任何修复或功能更新了。注意，Cargo 直到 `1.37` 版本才开始允许发布 `Cargo.lock` ，这意味着这之前发布的包中没有 `Cargo.lock`。
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
<dt class="option-term" id="option-cargo-install---vers"><a class="option-anchor" href="#option-cargo-install---vers"></a><code>--vers</code> <em>version</em></dt>
<dt class="option-term" id="option-cargo-install---version"><a class="option-anchor" href="#option-cargo-install---version"></a><code>--version</code> <em>version</em></dt>
<dd class="option-desc">Specify a version to install. This may be a <a href="../reference/specifying-dependencies.md">version
requirement</a>, like <code>~1.2</code>, to have Cargo
select the newest version from the given requirement. If the version does not
have a requirement operator (such as <code>^</code> or <code>~</code>), then it must be in the form
<em>MAJOR.MINOR.PATCH</em>, and will install exactly that version; it is <em>not</em>
treated as a caret requirement like Cargo dependencies are.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---vers"><a class="option-anchor" href="#option-cargo-install---vers"></a><code>--vers</code> <em>version</em></dt>
<dt class="option-term" id="option-cargo-install---version"><a class="option-anchor" href="#option-cargo-install---version"></a><code>--version</code> <em>version</em></dt>
<dd class="option-desc">指定安装的版本。可以是一个 <a href="../reference/specifying-dependencies.md"> 版本请求 </a>， 比如 <code>~1.2</code>，使Cargo选择满足请求的最新版本。 如果版本中没有操作符 (比如 <code>^</code> 或 <code>~</code>)， 那么格式必须为
<em>MAJOR.MINOR.PATCH</em>, 从而安装精确的版本； 这个行为
和Cargo toml文件中的版本请求 <em>不</em> 相同。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---git"><a class="option-anchor" href="#option-cargo-install---git"></a><code>--git</code> <em>url</em></dt>
<dd class="option-desc">Git URL to install the specified crate from.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---git"><a class="option-anchor" href="#option-cargo-install---git"></a><code>--git</code> <em>url</em></dt>
<dd class="option-desc">被安装的 crate 的 Git URL。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---branch"><a class="option-anchor" href="#option-cargo-install---branch"></a><code>--branch</code> <em>branch</em></dt>
<dd class="option-desc">Branch to use when installing from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---branch"><a class="option-anchor" href="#option-cargo-install---branch"></a><code>--branch</code> <em>branch</em></dt>
<dd class="option-desc"> 从 git 安装时使用的 branch。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---tag"><a class="option-anchor" href="#option-cargo-install---tag"></a><code>--tag</code> <em>tag</em></dt>
<dd class="option-desc">Tag to use when installing from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---tag"><a class="option-anchor" href="#option-cargo-install---tag"></a><code>--tag</code> <em>tag</em></dt>
<dd class="option-desc"> 从 git 安装时使用的 tag。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---rev"><a class="option-anchor" href="#option-cargo-install---rev"></a><code>--rev</code> <em>sha</em></dt>
<dd class="option-desc">Specific commit to use when installing from git.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---rev"><a class="option-anchor" href="#option-cargo-install---rev"></a><code>--rev</code> <em>sha</em></dt>
<dd class="option-desc"> 指定从git安装使用的具体commit。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---path"><a class="option-anchor" href="#option-cargo-install---path"></a><code>--path</code> <em>path</em></dt>
<dd class="option-desc">Filesystem path to local crate to install.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---path"><a class="option-anchor" href="#option-cargo-install---path"></a><code>--path</code> <em>path</em></dt>
<dd class="option-desc"> 本地文件系统中 crate 的路径。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---list"><a class="option-anchor" href="#option-cargo-install---list"></a><code>--list</code></dt>
<dd class="option-desc">List all installed packages and their versions.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---list"><a class="option-anchor" href="#option-cargo-install---list"></a><code>--list</code></dt>
<dd class="option-desc"> 列出所有已安装的包及其版本信息。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--f"><a class="option-anchor" href="#option-cargo-install--f"></a><code>-f</code></dt>
<dt class="option-term" id="option-cargo-install---force"><a class="option-anchor" href="#option-cargo-install---force"></a><code>--force</code></dt>
<dd class="option-desc">Force overwriting existing crates or binaries. This can be used if a package
has installed a binary with the same name as another package. This is also
useful if something has changed on the system that you want to rebuild with,
such as a newer version of <code>rustc</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--f"><a class="option-anchor" href="#option-cargo-install--f"></a><code>-f</code></dt>
<dt class="option-term" id="option-cargo-install---force"><a class="option-anchor" href="#option-cargo-install---force"></a><code>--force</code></dt>
<dd class="option-desc"> 强行覆盖现有的 crate 或 二进制文件，这可以用于已安装的二进制程序与另一个包的二进制程序重名时。如果你改变了系统中的某些东西 (比如 <code>rustc</code>  的版本)，想要以此重新进行构建该二进制程序，这个功能也会很有用。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---no-track"><a class="option-anchor" href="#option-cargo-install---no-track"></a><code>--no-track</code></dt>
<dd class="option-desc">By default, Cargo keeps track of the installed packages with a metadata file
stored in the installation root directory. This flag tells Cargo not to use or
create that file. With this flag, Cargo will refuse to overwrite any existing
files unless the <code>--force</code> flag is used. This also disables Cargo's ability to
protect against multiple concurrent invocations of Cargo installing at the
same time.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---no-track"><a class="option-anchor" href="#option-cargo-install---no-track"></a><code>--no-track</code></dt>
<dd class="option-desc"> 默认情况下，Cargo 会使用root目录下的一个元数据文件来跟踪已安装的包。`--no-track` 这个标志告诉 Cargo 不要使用或创建该文件。使用该标志后，Cargo 会拒绝覆盖任何已存在的文件，除非使用了 <code>--force</code> 标志。同时这也使得Cargo无法防止同时进行多个 Cargo install 的并发调用 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---bin"><a class="option-anchor" href="#option-cargo-install---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">Install only the specified binary.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---bin"><a class="option-anchor" href="#option-cargo-install---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc"> 仅安装指定的二进制程序。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---bins"><a class="option-anchor" href="#option-cargo-install---bins"></a><code>--bins</code></dt>
<dd class="option-desc">Install all binaries.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---bins"><a class="option-anchor" href="#option-cargo-install---bins"></a><code>--bins</code></dt>
<dd class="option-desc"> 安装所有的二进制程序。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---example"><a class="option-anchor" href="#option-cargo-install---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">Install only the specified example.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---example"><a class="option-anchor" href="#option-cargo-install---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc"> 仅安装指定的 example。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---examples"><a class="option-anchor" href="#option-cargo-install---examples"></a><code>--examples</code></dt>
<dd class="option-desc">Install all examples.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---examples"><a class="option-anchor" href="#option-cargo-install---examples"></a><code>--examples</code></dt>
<dd class="option-desc"> 安装所有的 example。 </dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---root"><a class="option-anchor" href="#option-cargo-install---root"></a><code>--root</code> <em>dir</em></dt>
<dd class="option-desc">Directory to install packages into.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---root"><a class="option-anchor" href="#option-cargo-install---root"></a><code>--root</code> <em>dir</em></dt>
<dd class="option-desc"> 将包安装到此文件夹。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---registry"><a class="option-anchor" href="#option-cargo-install---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">Name of the registry to use. Registry names are defined in <a href="../reference/config.html">Cargo config
files</a>. If not specified, the default registry is used,
which is defined by the <code>registry.default</code> config key which defaults to
<code>crates-io</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---registry"><a class="option-anchor" href="#option-cargo-install---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc"> 使用的注册机构 (registry) 的名字。注册机构定义在 <a href="../reference/config.html">Cargo config 文件</a> 中. 如果没有指定就使用默认的注册机构，其定义在 <code>registry.default</code> 字段中，该值的默认值为 <code>crates-io</code> 。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-install---index"><a class="option-anchor" href="#option-cargo-install---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc">The URL of the registry index to use.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---index"><a class="option-anchor" href="#option-cargo-install---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc"> 使用的注册机构的 index 地址。</dd>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 选择 feature
{==+==}

{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
feature 标志可以用于控制启用哪些 feature。当没有提供这个选项时，会使用 `default` feature。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
查看 [features 文档](../reference/features.html#command-line-feature-options) 获取更多信息。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--F"><a class="option-anchor" href="#option-cargo-install--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-install---features"><a class="option-anchor" href="#option-cargo-install---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--F"><a class="option-anchor" href="#option-cargo-install--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-install---features"><a class="option-anchor" href="#option-cargo-install---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">用空格或逗号来分隔多个启用的 feature。 工作空间成员的 feature 可以通过 <code>package-name/feature-name</code> 语法来启用。 该标志可以设置多次，最终将启用指定的所有 feature 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---all-features"><a class="option-anchor" href="#option-cargo-install---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---all-features"><a class="option-anchor" href="#option-cargo-install---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc"> 启用指定包的所有可用 feature。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---no-default-features"><a class="option-anchor" href="#option-cargo-install---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---no-default-features"><a class="option-anchor" href="#option-cargo-install---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不使用指定包的 <code>default</code> feature 。</dd>
{==+==}




{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---target"><a class="option-anchor" href="#option-cargo-install---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Install for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---target"><a class="option-anchor" href="#option-cargo-install---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定的架构安装，默认情况下是宿主架构。 通常的架构三元组格式为 <code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。 运行 <code>rustc --print target-list</code> 可以获取所有支持的架构的列表。</p>
<p>也可以在 <code>build.target</code> 
<a href="../reference/config.html"> 配置</a>。</p>
<p> 注意，指定此标志会让 Cargo 工作在另一种模式上，构建产物被放在单独的文件夹。查看 <a href="../guide/build-cache.html">build cache</a> 文档来获取更多信息。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-install---target-dir"><a class="option-anchor" href="#option-cargo-install---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to a new temporary folder located in the
temporary directory of the platform. </p>
<p>When using <code>--path</code>, by default it will use <code>target</code> directory in the workspace
of the local crate unless <code>--target-dir</code>
is specified.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---target-dir"><a class="option-anchor" href="#option-cargo-install---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc"> 存放构建产物和中间文件的文件夹。也可以用 <code>CARGO_TARGET_DIR</code> 环境变量来设置，或者 <code>build.target-dir</code> <a href="../reference/config.html">设置选项</a>。默认会放在该平台的的临时文件夹下。</p>
<p> 当使用 <code>--path</code> 标志时，默认会放在该本地crate的工作空间的 <code>target</code> 文件夹中，除非明确指定了 <code>--target-dir</code> 。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-install---debug"><a class="option-anchor" href="#option-cargo-install---debug"></a><code>--debug</code></dt>
<dd class="option-desc">Build with the <code>dev</code> profile instead the <code>release</code> profile.
See also the <code>--profile</code> option for choosing a specific profile by name.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---debug"><a class="option-anchor" href="#option-cargo-install---debug"></a><code>--debug</code></dt>
<dd class="option-desc"> 构建 <code>dev</code> profile 而不是 <code>release</code> profile。
另见 <code>--profile</code> 选项，可以用名字来指定一个 profile。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---profile"><a class="option-anchor" href="#option-cargo-install---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">Install with the given profile.
See the <a href="../reference/profiles.html">the reference</a> for more details on profiles.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---profile"><a class="option-anchor" href="#option-cargo-install---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">根据所给的 profile 进行安装。
参考 <a href="../reference/profiles.html">the reference</a> 查看关于 profile 的更多信息。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-install---timings=fmts"><a class="option-anchor" href="#option-cargo-install---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">Output information how long each compilation takes, and track concurrency
information over time. Accepts an optional comma-separated list of output
formats; <code>--timings</code> without an argument will default to <code>--timings=html</code>.
Specifying an output format (rather than the default) is unstable and requires
<code>-Zunstable-options</code>. Valid output formats:</p>
<ul>
<li><code>html</code> (unstable, requires <code>-Zunstable-options</code>): Write a human-readable file <code>cargo-timing.html</code> to the
<code>target/cargo-timings</code> directory with a report of the compilation. Also write
a report to the same directory with a timestamp in the filename if you want
to look at older runs. HTML output is suitable for human consumption only,
and does not provide machine-readable timing data.</li>
<li><code>json</code> (unstable, requires <code>-Zunstable-options</code>): Emit machine-readable JSON
information about timing information.</li>
</ul></dd>
{==+==}
<dt class="option-term" id="option-cargo-install---timings=fmts"><a class="option-anchor" href="#option-cargo-install---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc"> 输出编译所花费时间的信息，同时跟踪并发信息。接收一个由逗号分隔的输出格式；若 <code>--timings</code> 没有参数，则默认使用 <code>--timings=html</code>。
指定输出格式 (而不是使用默认格式) 是不稳定 (unstable) 的，需要设置 <code>-Zunstable-options</code>。 可用的输出格式选项有: </p>
<ul>
<li><code>html</code> (不稳定，需要 <code>-Zunstable-options</code>): 写入一个人类可读的 <code>cargo-timing.html</code> 文件到
<code>target/cargo-timings</code> 文件夹，其中包含关于编译过程的报告。 
同时也会写入一个文件名带着时间戳 (timestamp) 的报告文件，可以让你读取之前的编译报告。HTML 输出文件只适合人类阅读，不提供机器所需的 timing 数据。</li>
<li><code>json</code> (不稳定，需要 <code>-Zunstable-options</code>): 生成机器可读的 JSON timing 信息。</li>
</ul></dd>
{==+==}


{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---frozen"><a class="option-anchor" href="#option-cargo-install---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-install---locked"><a class="option-anchor" href="#option-cargo-install---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---frozen"><a class="option-anchor" href="#option-cargo-install---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-install---locked"><a class="option-anchor" href="#option-cargo-install---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---offline"><a class="option-anchor" href="#option-cargo-install---offline"></a><code>--offline</code></dt>
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
<dt class="option-term" id="option-cargo-install---offline"><a class="option-anchor" href="#option-cargo-install---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
### Miscellaneous Options
{==+==}
### 杂项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--j"><a class="option-anchor" href="#option-cargo-install--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-install---jobs"><a class="option-anchor" href="#option-cargo-install---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--j"><a class="option-anchor" href="#option-cargo-install--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-install---jobs"><a class="option-anchor" href="#option-cargo-install---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---keep-going"><a class="option-anchor" href="#option-cargo-install---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---keep-going"><a class="option-anchor" href="#option-cargo-install---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">依赖图中的 crate 能构建多少就构建多少，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install---color"><a class="option-anchor" href="#option-cargo-install---color"></a><code>--color</code> <em>when</em></dt>
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
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-install---message-format"><a class="option-anchor" href="#option-cargo-install---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">The output format for diagnostic messages. Can be specified multiple times
and consists of comma-separated values. Valid values:</p>
<ul>
<li><code>human</code> (default): Display in a human-readable text format. Conflicts with
<code>short</code> and <code>json</code>.</li>
<li><code>short</code>: Emit shorter, human-readable text messages. Conflicts with <code>human</code>
and <code>json</code>.</li>
<li><code>json</code>: Emit JSON messages to stdout. See
<a href="../reference/external-tools.html#json-messages">the reference</a>
for more details. Conflicts with <code>human</code> and <code>short</code>.</li>
<li><code>json-diagnostic-short</code>: Ensure the <code>rendered</code> field of JSON messages contains
the &quot;short&quot; rendering from rustc. Cannot be used with <code>human</code> or <code>short</code>.</li>
<li><code>json-diagnostic-rendered-ansi</code>: Ensure the <code>rendered</code> field of JSON messages
contains embedded ANSI color codes for respecting rustc's default color
scheme. Cannot be used with <code>human</code> or <code>short</code>.</li>
<li><code>json-render-diagnostics</code>: Instruct Cargo to not include rustc diagnostics
in JSON messages printed, but instead Cargo itself should render the
JSON diagnostics coming from rustc. Cargo's own JSON diagnostics and others
coming from rustc are still emitted. Cannot be used with <code>human</code> or <code>short</code>.</li>
</ul></dd>
{==+==}
<dt class="option-term" id="option-cargo-install---message-format"><a class="option-anchor" href="#option-cargo-install---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">诊断信息的输出格式。 可以指定多次，可以包含由逗号分隔的多个值。合法的值有:</p>
<ul>
<li><code>human</code> (默认值): 显示适合人类阅读的格式。与 <code>short</code> 和 <code>json</code> 互斥。</li>
<li><code>short</code>: 生成更短的适合人类阅读的格式。 与 <code>human</code> 和 <code>json</code> 互斥。</li>
<li><code>json</code>: 将 JSON 信息输出到 stdout。 从 <a href="../reference/external-tools.html#json-messages">the reference</a> 获取更多详细信息。 与 <code>human</code> 和 <code>short</code> 互斥。</li>
<li><code>json-diagnostic-short</code>: 使得 JSON 的 <code>rendered</code> 属性包含 rustc 渲染的 &quot;short&quot; 信息。不能与 <code>human</code> 和 <code>short</code> 一起使用。</li>
<li><code>json-diagnostic-rendered-ansi</code>: 使得 JSON 的 <code>rendered</code> 属性包含嵌入的 ANSI 颜色代码以符合 rustc 的默认颜色策略。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>
<li><code>json-render-diagnostics</code>: 命令 Cargo 在打印的 JSON 中不包含 rustc 的诊断信息，而是由 Cargo 自己渲染 rustc 提供的 JSON 诊断信息。Cargo 自己的 JSON 诊断信息和其他来自 rustc 的信息都会被生成。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>
</ul></dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install-+toolchain"><a class="option-anchor" href="#option-cargo-install-+toolchain"></a><code>+</code><em>toolchain</em></dt>
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
<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
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
1. Install or upgrade a package from crates.io:

       cargo install ripgrep

2. Install or reinstall the package in the current directory:

       cargo install --path .

3. View the list of installed packages:

       cargo install --list
{==+==}
1. 从 crates.io 安装或更新一个包: 

       cargo install ripgrep

2. 从当前的文件夹中安装或重装一个包: 

       cargo install --path .

3. 查看已安装的包的列表: 

       cargo install --list
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-uninstall(1)](cargo-uninstall.html), [cargo-search(1)](cargo-search.html), [cargo-publish(1)](cargo-publish.html)
{==+==}

{==+==}
