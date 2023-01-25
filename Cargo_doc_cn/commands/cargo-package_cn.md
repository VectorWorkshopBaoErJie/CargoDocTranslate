{==+==}
# cargo-package(1)
{==+==}

{==+==}




{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-package - Assemble the local package into a distributable tarball
{==+==}
cargo-package - 将本地的 package 打包为可分发的 tarball (tar 打包的压缩文件)
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo package` [_options_]
{==+==}

{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command will create a distributable, compressed `.crate` file with the
source code of the package in the current directory. The resulting file will
be stored in the `target/package` directory. This performs the following
steps:
{==+==}
这个命令会创建一个可分发的，以 `.crate` 为后缀的压缩文件，其中包含当前目录下的 package 的源代码。该压缩文件会保存在 `target/package` 文件夹中。该命令具体会执行以下几步: 
{==+==}

{==+==}
1. Load and check the current workspace, performing some basic checks.
    - Path dependencies are not allowed unless they have a version key. Cargo
      will ignore the path key for dependencies in published packages.
      `dev-dependencies` do not have this restriction.
2. Create the compressed `.crate` file.
    - The original `Cargo.toml` file is rewritten and normalized.
    - `[patch]`, `[replace]`, and `[workspace]` sections are removed from the
      manifest.
    - `Cargo.lock` is automatically included if the package contains an
      executable binary or example target. [cargo-install(1)](cargo-install.html) will use the
      packaged lock file if the `--locked` flag is used.
    - A `.cargo_vcs_info.json` file is included that contains information
      about the current VCS checkout hash if available (not included with
      `--allow-dirty`).
3. Extract the `.crate` file and build it to verify it can build.
    - This will rebuild your package from scratch to ensure that it can be
      built from a pristine state. The `--no-verify` flag can be used to skip
      this step.
4. Check that build scripts did not modify any source files.
{==+==}
1. 加载并检查当前的工作空间，执行一些基础的检查。
    - 不允许 Path dependencies，除非其设置了 version 字段。Cargo 会忽略那些已发布的包的依赖的 path 字段。`dev-dependencies` e没有此限制。
2. 创建一个 `.crate` 压缩文件。
    - 原有的 `Cargo.toml` 被重写并格式化。
    - `[patch]`, `[replace]`, 和 `[workspace]` 部分会从清单文件中移除
    - 如果包中包含二进制 或 example target，`Cargo.lock` 会被打包进文件。 
       在指定 `--locked` 的情况下，[cargo-install(1)](cargo-install.html) 会使用该 lockfile。
    - 一个 `.cargo_vcs_info.json` 文件会被打包进去，其中包含了当前 VCS (Version Control System，如 git) 的checkout hash ( 没有使用 `--allow-dirty` 的情况下)。
3. 解压该 `.crate` 文件并构建，以确认其可以正常构建。
    - 这会从头重新构建你的包来保证其能从原始状态成功构建。 `--no-verify` 标志可以跳过这个步骤。
4. 检查确认构建脚本没有修改任何源文件。
{==+==}

{==+==}
The list of files included can be controlled with the `include` and `exclude`
fields in the manifest.
{==+==}
可以在清单文件的 `include` 和 `exclude` 字段中控制压缩包要包含的文件。
{==+==}

{==+==}
See [the reference](../reference/publishing.html) for more details about
packaging and publishing.
{==+==}
从 [the reference](../reference/publishing.html) 获取更多关于打包和发布的知识。
{==+==}

{==+==}
### .cargo_vcs_info.json format
{==+==}
### .cargo_vcs_info.json 的格式
{==+==}

{==+==}
Will generate a `.cargo_vcs_info.json` in the following format
{==+==}
`.cargo_vcs_info.json` 的格式为: 
{==+==}

{==+==}
```javascript
{
 "git": {
   "sha1": "aac20b6e7e543e6dd4118b246c77225e3a3a1302"
 },
 "path_in_vcs": ""
}
```
{==+==}

{==+==}

{==+==}
`path_in_vcs` will be set to a repo-relative path for packages
in subdirectories of the version control repository.
{==+==}
对于在版本控制仓库的子文件夹下的包，`path_in_vcs` 会被设置为以仓库为根的相对路径。
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Package Options
{==+==}
### Package 选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--l"><a class="option-anchor" href="#option-cargo-package--l"></a><code>-l</code></dt>
<dt class="option-term" id="option-cargo-package---list"><a class="option-anchor" href="#option-cargo-package---list"></a><code>--list</code></dt>
<dd class="option-desc">Print files included in a package without making one.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--l"><a class="option-anchor" href="#option-cargo-package--l"></a><code>-l</code></dt>
<dt class="option-term" id="option-cargo-package---list"><a class="option-anchor" href="#option-cargo-package---list"></a><code>--list</code></dt>
<dd class="option-desc">打印包中的所有文件，不创建任何新文件。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---no-verify"><a class="option-anchor" href="#option-cargo-package---no-verify"></a><code>--no-verify</code></dt>
<dd class="option-desc">Don't verify the contents by building them.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---no-verify"><a class="option-anchor" href="#option-cargo-package---no-verify"></a><code>--no-verify</code></dt>
<dd class="option-desc">不通过构建来检验压缩包中的内容</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---no-metadata"><a class="option-anchor" href="#option-cargo-package---no-metadata"></a><code>--no-metadata</code></dt>
<dd class="option-desc">Ignore warnings about a lack of human-usable metadata (such as the description
or the license).</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---no-metadata"><a class="option-anchor" href="#option-cargo-package---no-metadata"></a><code>--no-metadata</code></dt>
<dd class="option-desc">忽略因缺少人类可读的元数据(如 description 或 license)而产生的警告信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---allow-dirty"><a class="option-anchor" href="#option-cargo-package---allow-dirty"></a><code>--allow-dirty</code></dt>
<dd class="option-desc">Allow working directories with uncommitted VCS changes to be packaged.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---allow-dirty"><a class="option-anchor" href="#option-cargo-package---allow-dirty"></a><code>--allow-dirty</code></dt>
<dd class="option-desc">允许工作目录中有未提交的 VCS 修改。</dd>
{==+==}


{==+==}
### Package Selection
{==+==}
### 包的选择
{==+==}

{==+==}
By default, when no package selection options are given, the packages selected
depend on the selected manifest file (based on the current working directory if
`--manifest-path` is not given). If the manifest is the root of a workspace then
the workspaces default members are selected, otherwise only the package defined
by the manifest will be selected.
{==+==}
默认情况下，如果没有提供选择包的选项，那么会按照选择的配置清单文件来选择包(当没有指定 `--manifest-path` 时，按照当前工目录来查找配置清单文件)。
如果工作空间根目录的配置清单文件，则会选择该工作空间的默认成员，否则仅选取配置清单文件所在的那个包。
{==+==}

{==+==}
The default members of a workspace can be set explicitly with the
`workspace.default-members` key in the root manifest. If this is not set, a
virtual workspace will include all workspace members (equivalent to passing
`--workspace`), and a non-virtual workspace will include only the root crate itself.
{==+==}
可以通过 `workspace.default-members` 来显式设置一个工作空间的默认成员。如果没有设置，在虚拟工作空间下会选择所有的成员，在非虚拟工作空间下仅会选择根 package 。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--p"><a class="option-anchor" href="#option-cargo-package--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-package---package"><a class="option-anchor" href="#option-cargo-package---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">Package only the specified packages. See <a href="cargo-pkgid.html">cargo-pkgid(1)</a> for the
SPEC format. This flag may be specified multiple times and supports common Unix
glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell accidentally 
expanding glob patterns before Cargo handles them, you must use single quotes or
double quotes around each pattern.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--p"><a class="option-anchor" href="#option-cargo-package--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-package---package"><a class="option-anchor" href="#option-cargo-package---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅打包指定的 package。 见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 中关于 SPEC 格式的描述。此标志可以指定多次，而且支持 common Unix glob patterns ，如 <code>*</code>， <code>?</code> 和 <code>[]</code>。但是，为避免你的 shell 误在 Cargo 之前扩展这些 glob pattern，必须用单引号或双引号将每个 pattern 括起来。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---workspace"><a class="option-anchor" href="#option-cargo-package---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">Package all members in the workspace.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---workspace"><a class="option-anchor" href="#option-cargo-package---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">打包工作空间中的所有成员。</dd>
{==+==}




{==+==}
<dt class="option-term" id="option-cargo-package---exclude"><a class="option-anchor" href="#option-cargo-package---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">Exclude the specified packages. Must be used in conjunction with the
<code>--workspace</code> flag. This flag may be specified multiple times and supports
common Unix glob patterns like <code>*</code>, <code>?</code> and <code>[]</code>. However, to avoid your shell
accidentally expanding glob patterns before Cargo handles them, you must use
single quotes or double quotes around each pattern.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---exclude"><a class="option-anchor" href="#option-cargo-package---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code> 标志一起使用。 此标志可以指定多次，而且支持 common Unix glob patterns ，如 <code>*</code>， <code>?</code> 和 <code>[]</code>。但是，为避免你的 shell 误在 Cargo 之前扩展这些 glob pattern，必须用单引号或双引号将每个 pattern 括起来。</dd>
{==+==}


{==+==}
### Compilation Options
{==+==}
### 编译选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---target"><a class="option-anchor" href="#option-cargo-package---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">Package for the given architecture. The default is the host architecture. The general format of the triple is
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. Run <code>rustc --print target-list</code> for a
list of supported targets. This flag may be specified multiple times.</p>
<p>This may also be specified with the <code>build.target</code>
<a href="../reference/config.html">config value</a>.</p>
<p>Note that specifying this flag makes Cargo run in a different mode where the
target artifacts are placed in a separate directory. See the
<a href="../guide/build-cache.html">build cache</a> documentation for more details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---target"><a class="option-anchor" href="#option-cargo-package---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定的架构而打包，默认为宿主架构。triple 的格式为 
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。 执行 <code>rustc --print target-list</code> 可以展示支持的 target 的列表。该标志可以指定多次。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-package---target-dir"><a class="option-anchor" href="#option-cargo-package---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">Directory for all generated artifacts and intermediate files. May also be
specified with the <code>CARGO_TARGET_DIR</code> environment variable, or the
<code>build.target-dir</code> <a href="../reference/config.html">config value</a>.
Defaults to <code>target</code> in the root of the workspace.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---target-dir"><a class="option-anchor" href="#option-cargo-package---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc"> 存放构建产物和中间文件的文件夹。也可以用 <code>CARGO_TARGET_DIR</code> 环境变量来设置，或者 <code>build.target-dir</code> <a href="../reference/config.html">设置选项</a>。默认会放在工作空间的 <code>target</code> 下。</dd>
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
特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
查看 [the features documentation](../reference/features.html#command-line-feature-options) 获取更多信息。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--F"><a class="option-anchor" href="#option-cargo-package--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-package---features"><a class="option-anchor" href="#option-cargo-package---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--F"><a class="option-anchor" href="#option-cargo-package--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-package---features"><a class="option-anchor" href="#option-cargo-package---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">用空格或逗号来分隔多个启用的 feature。 工作空间成员的 feature 可以通过 <code>package-name/feature-name</code> 语法来启用。 该标志可以设置多次，最终将启用指定的所有 feature 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---all-features"><a class="option-anchor" href="#option-cargo-package---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---all-features"><a class="option-anchor" href="#option-cargo-package---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc"> 启用指定包的所有可用 feature。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---no-default-features"><a class="option-anchor" href="#option-cargo-package---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---no-default-features"><a class="option-anchor" href="#option-cargo-package---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不使用指定包的 <code>default</code> feature 。</dd>
{==+==}


{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---manifest-path"><a class="option-anchor" href="#option-cargo-package---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---manifest-path"><a class="option-anchor" href="#option-cargo-package---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。 默认情况下，Cargo 在当前目录或任意的父目录中查找 <code>Cargo.toml</code> 。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-package---frozen"><a class="option-anchor" href="#option-cargo-package---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-package---locked"><a class="option-anchor" href="#option-cargo-package---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---frozen"><a class="option-anchor" href="#option-cargo-package---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-package---locked"><a class="option-anchor" href="#option-cargo-package---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---offline"><a class="option-anchor" href="#option-cargo-package---offline"></a><code>--offline</code></dt>
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
<dt class="option-term" id="option-cargo-package---offline"><a class="option-anchor" href="#option-cargo-package---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>
{==+==}

{==+==}
### Miscellaneous Options
{==+==}
### 杂项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--j"><a class="option-anchor" href="#option-cargo-package--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-package---jobs"><a class="option-anchor" href="#option-cargo-package---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">Number of parallel jobs to run. May also be specified with the
<code>build.jobs</code> <a href="../reference/config.html">config value</a>. Defaults to
the number of logical CPUs. If negative, it sets the maximum number of
parallel jobs to the number of logical CPUs plus provided value.
Should not be 0.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--j"><a class="option-anchor" href="#option-cargo-package--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-package---jobs"><a class="option-anchor" href="#option-cargo-package---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置选项</a>来指定。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---keep-going"><a class="option-anchor" href="#option-cargo-package---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">Build as many crates in the dependency graph as possible, rather than aborting
the build on the first one that fails to build. Unstable, requires
<code>-Zunstable-options</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---keep-going"><a class="option-anchor" href="#option-cargo-package---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">依赖图中的 crate 能构建多少就构建多少，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--v"><a class="option-anchor" href="#option-cargo-package--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-package---verbose"><a class="option-anchor" href="#option-cargo-package---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--v"><a class="option-anchor" href="#option-cargo-package--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-package---verbose"><a class="option-anchor" href="#option-cargo-package---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--q"><a class="option-anchor" href="#option-cargo-package--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-package---quiet"><a class="option-anchor" href="#option-cargo-package---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--q"><a class="option-anchor" href="#option-cargo-package--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-package---quiet"><a class="option-anchor" href="#option-cargo-package---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---color"><a class="option-anchor" href="#option-cargo-package---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-package---color"><a class="option-anchor" href="#option-cargo-package---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package-+toolchain"><a class="option-anchor" href="#option-cargo-package-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package-+toolchain"><a class="option-anchor" href="#option-cargo-package-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package---config"><a class="option-anchor" href="#option-cargo-package---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package---config"><a class="option-anchor" href="#option-cargo-package---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--h"><a class="option-anchor" href="#option-cargo-package--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-package---help"><a class="option-anchor" href="#option-cargo-package---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--h"><a class="option-anchor" href="#option-cargo-package--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-package---help"><a class="option-anchor" href="#option-cargo-package---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-package--Z"><a class="option-anchor" href="#option-cargo-package--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-package--Z"><a class="option-anchor" href="#option-cargo-package--Z"></a><code>-Z</code> <em>flag</em></dt>
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
1. Create a compressed `.crate` file of the current package:

       cargo package
{==+==}
1. 创建当前包的 `.crate` 压缩文件:

       cargo package
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
