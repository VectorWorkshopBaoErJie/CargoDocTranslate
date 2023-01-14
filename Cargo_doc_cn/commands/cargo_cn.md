{==+==}
# cargo(1)

## NAME
{==+==}

{==+==}


{==+==}
cargo - The Rust package manager
{==+==}
cargo - Rust包管理器
{==+==}


{==+==}
## SYNOPSIS
{==+==}

{==+==}


{==+==}
`cargo` [_options_] _command_ [_args_]\
`cargo` [_options_] `--version`\
`cargo` [_options_] `--list`\
`cargo` [_options_] `--help`\
`cargo` [_options_] `--explain` _code_
{==+==}

{==+==}


{==+==}
## DESCRIPTION
{==+==}

{==+==}


{==+==}
This program is a package manager and build tool for the Rust language,
available at <https://rust-lang.org>.
{==+==}
这个程序是Rust语言的包管理器和构建工具，可在<https://rust-lang.org>上获得。
{==+==}


{==+==}
## COMMANDS
{==+==}

{==+==}


{==+==}
### Build Commands
{==+==}
### 构建命令
{==+==}


{==+==}
[cargo-bench(1)](cargo-bench.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Execute benchmarks of a package.
{==+==}
[cargo-bench(1)](cargo-bench.html)\
&nbsp;&nbsp;&nbsp;&nbsp;执行包的基准测试。
{==+==}


{==+==}
[cargo-build(1)](cargo-build.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Compile a package.
{==+==}
[cargo-build(1)](cargo-build.html)\
&nbsp;&nbsp;&nbsp;&nbsp;编译包
{==+==}


{==+==}
[cargo-check(1)](cargo-check.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Check a local package and all of its dependencies for errors.
{==+==}
[cargo-check(1)](cargo-check.html)\
&nbsp;&nbsp;&nbsp;&nbsp;检查本地包及其所有依赖是否有错误。
{==+==}


{==+==}
[cargo-clean(1)](cargo-clean.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Remove artifacts that Cargo has generated in the past.
{==+==}
[cargo-clean(1)](cargo-clean.html)\
&nbsp;&nbsp;&nbsp;&nbsp;移除Cargo曾生成的制品。
{==+==}


{==+==}
[cargo-doc(1)](cargo-doc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Build a package's documentation.
{==+==}
[cargo-doc(1)](cargo-doc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;构建包的文档。
{==+==}


{==+==}
[cargo-fetch(1)](cargo-fetch.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Fetch dependencies of a package from the network.
{==+==}
[cargo-fetch(1)](cargo-fetch.html)\
&nbsp;&nbsp;&nbsp;&nbsp;从网络中获取包的依赖。
{==+==}


{==+==}
[cargo-fix(1)](cargo-fix.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Automatically fix lint warnings reported by rustc.
{==+==}
[cargo-fix(1)](cargo-fix.html)\
&nbsp;&nbsp;&nbsp;&nbsp;自动修复rustc报告的lint警告。
{==+==}


{==+==}
[cargo-run(1)](cargo-run.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Run a binary or example of the local package.
{==+==}
[cargo-run(1)](cargo-run.html)\
&nbsp;&nbsp;&nbsp;&nbsp;运行本地包的二进制文件或示例文件。
{==+==}


{==+==}
[cargo-rustc(1)](cargo-rustc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Compile a package, and pass extra options to the compiler.
{==+==}
[cargo-rustc(1)](cargo-rustc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;编译包，并传递附加选项给编译器。
{==+==}


{==+==}
[cargo-rustdoc(1)](cargo-rustdoc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Build a package's documentation, using specified custom flags.
{==+==}
[cargo-rustdoc(1)](cargo-rustdoc.html)\
&nbsp;&nbsp;&nbsp;&nbsp;使用指定的自定义标志构建包的文档。
{==+==}


{==+==}
[cargo-test(1)](cargo-test.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Execute unit and integration tests of a package.
{==+==}
[cargo-test(1)](cargo-test.html)\
&nbsp;&nbsp;&nbsp;&nbsp;执行包的单元测试和集成测试。
{==+==}


{==+==}
### Manifest Commands
{==+==}
### 配置清单命令
{==+==}


{==+==}
[cargo-generate-lockfile(1)](cargo-generate-lockfile.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Generate `Cargo.lock` for a project.
{==+==}
[cargo-generate-lockfile(1)](cargo-generate-lockfile.html)\
&nbsp;&nbsp;&nbsp;&nbsp;为项目生成 `Cargo.lock` .
{==+==}


{==+==}
[cargo-locate-project(1)](cargo-locate-project.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Print a JSON representation of a `Cargo.toml` file's location.
{==+==}
[cargo-locate-project(1)](cargo-locate-project.html)\
&nbsp;&nbsp;&nbsp;&nbsp;打印 `Cargo.toml` 文件位置的JSON表示。
{==+==}


{==+==}
[cargo-metadata(1)](cargo-metadata.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Output the resolved dependencies of a package in machine-readable format.
{==+==}
[cargo-metadata(1)](cargo-metadata.html)\
&nbsp;&nbsp;&nbsp;&nbsp;以机器可读的格式输出已解决的包的依赖。
{==+==}


{==+==}
[cargo-pkgid(1)](cargo-pkgid.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Print a fully qualified package specification.
{==+==}
[cargo-pkgid(1)](cargo-pkgid.html)\
&nbsp;&nbsp;&nbsp;&nbsp;打印完全合格的包规范。
{==+==}


{==+==}
[cargo-tree(1)](cargo-tree.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Display a tree visualization of a dependency graph.
{==+==}
[cargo-tree(1)](cargo-tree.html)\
&nbsp;&nbsp;&nbsp;&nbsp;显示依赖图的可视化树。
{==+==}


{==+==}
[cargo-update(1)](cargo-update.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Update dependencies as recorded in the local lock file.
{==+==}
[cargo-update(1)](cargo-update.html)\
&nbsp;&nbsp;&nbsp;&nbsp;更新本地lock file中记录的依赖。
{==+==}


{==+==}
[cargo-vendor(1)](cargo-vendor.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Vendor all dependencies locally.
{==+==}
[cargo-vendor(1)](cargo-vendor.html)\
&nbsp;&nbsp;&nbsp;&nbsp;在本地提供所有依赖。
{==+==}


{==+==}
[cargo-verify-project(1)](cargo-verify-project.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Check correctness of crate manifest.
{==+==}
[cargo-verify-project(1)](cargo-verify-project.html)\
&nbsp;&nbsp;&nbsp;&nbsp;检查crate配置是否正确。
{==+==}


{==+==}
### Package Commands
{==+==}
### 包命令
{==+==}


{==+==}
[cargo-init(1)](cargo-init.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Create a new Cargo package in an existing directory.
{==+==}
[cargo-init(1)](cargo-init.html)\
&nbsp;&nbsp;&nbsp;&nbsp;在现有目录中创建新的Cargo包。
{==+==}


{==+==}
[cargo-install(1)](cargo-install.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Build and install a Rust binary.
{==+==}
[cargo-install(1)](cargo-install.html)\
&nbsp;&nbsp;&nbsp;&nbsp;构建并安装Rust二进制文件。
{==+==}


{==+==}
[cargo-new(1)](cargo-new.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Create a new Cargo package.
{==+==}
[cargo-new(1)](cargo-new.html)\
&nbsp;&nbsp;&nbsp;&nbsp;创建新的Cargo包。
{==+==}


{==+==}
[cargo-search(1)](cargo-search.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Search packages in crates.io.
{==+==}
[cargo-search(1)](cargo-search.html)\
&nbsp;&nbsp;&nbsp;&nbsp;在 crates.io 搜索包。
{==+==}


{==+==}
[cargo-uninstall(1)](cargo-uninstall.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Remove a Rust binary.
{==+==}
[cargo-uninstall(1)](cargo-uninstall.html)\
&nbsp;&nbsp;&nbsp;&nbsp;移除Rust二进制文件。
{==+==}


{==+==}
### Publishing Commands
{==+==}
### 发布命令
{==+==}


{==+==}
[cargo-login(1)](cargo-login.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Save an API token from the registry locally.
{==+==}
[cargo-login(1)](cargo-login.html)\
&nbsp;&nbsp;&nbsp;&nbsp;在本地注册中心保存API令牌。
{==+==}


{==+==}
[cargo-owner(1)](cargo-owner.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Manage the owners of a crate on the registry.
{==+==}
[cargo-owner(1)](cargo-owner.html)\
&nbsp;&nbsp;&nbsp;&nbsp;在注册中心管理crate的所有者。
{==+==}


{==+==}
[cargo-package(1)](cargo-package.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Assemble the local package into a distributable tarball.
{==+==}
[cargo-package(1)](cargo-package.html)\
&nbsp;&nbsp;&nbsp;&nbsp;将本地包打包成可分发的压缩包。
{==+==}


{==+==}
[cargo-publish(1)](cargo-publish.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Upload a package to the registry.
{==+==}
[cargo-publish(1)](cargo-publish.html)\
&nbsp;&nbsp;&nbsp;&nbsp;上传一个包到注册中心。
{==+==}


{==+==}
[cargo-yank(1)](cargo-yank.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Remove a pushed crate from the index.
{==+==}
[cargo-yank(1)](cargo-yank.html)\
&nbsp;&nbsp;&nbsp;&nbsp;从索引中移除已推送的crate。
{==+==}


{==+==}
### General Commands
{==+==}
### 常规命令
{==+==}


{==+==}
[cargo-help(1)](cargo-help.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Display help information about Cargo.
{==+==}
[cargo-help(1)](cargo-help.html)\
&nbsp;&nbsp;&nbsp;&nbsp;显示有关Cargo的帮助信息。
{==+==}


{==+==}
[cargo-version(1)](cargo-version.html)\
&nbsp;&nbsp;&nbsp;&nbsp;Show version information.
{==+==}
[cargo-version(1)](cargo-version.html)\
&nbsp;&nbsp;&nbsp;&nbsp;显示版本信息。
{==+==}


{==+==}
## OPTIONS
{==+==}

{==+==}


{==+==}
### Special Options
{==+==}
### 特定选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo--V"><a class="option-anchor" href="#option-cargo--V"></a><code>-V</code></dt>
<dt class="option-term" id="option-cargo---version"><a class="option-anchor" href="#option-cargo---version"></a><code>--version</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Print version info and exit. If used with <code>--verbose</code>, prints extra
information.</dd>
{==+==}
<dd class="option-desc">打印版本信息并退出。如果有 <code>--verbose</code>, 打印额外的信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo---list"><a class="option-anchor" href="#option-cargo---list"></a><code>--list</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">List all installed Cargo subcommands. If used with <code>--verbose</code>, prints extra
information.</dd>
{==+==}
<dd class="option-desc">列出所有已安装的Cargo子命令。如果有 <code>--verbose</code>, 打印额外的信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo---explain"><a class="option-anchor" href="#option-cargo---explain"></a><code>--explain</code> <em>code</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Run <code>rustc --explain CODE</code> which will print out a detailed explanation of an
error message (for example, <code>E0004</code>).</dd>
{==+==}
<dd class="option-desc">运行 <code>rustc --explain CODE</code> 这将打印错误信息的详细解释 (例如, <code>E0004</code>).</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo--v"><a class="option-anchor" href="#option-cargo--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo---verbose"><a class="option-anchor" href="#option-cargo---verbose"></a><code>--verbose</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
{==+==}
<dd class="option-desc">使用详细输出。可能指定两次，&quot;非常冗长&quot; 包含额外的输出，如依赖警告和构建脚本输出。也可以用 <code>term.verbose</code>
{==+==}


{==+==}

<dt class="option-term" id="option-cargo--q"><a class="option-anchor" href="#option-cargo--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo---quiet"><a class="option-anchor" href="#option-cargo---quiet"></a><code>--quiet</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
{==+==}
<dd class="option-desc">不要打印cargo日志信息。也可以用 <code>term.quiet</code>
{==+==}


{==+==}
<a href="../reference/config.html">config value</a>.</dd>
{==+==}

{==+==}


{==+==}
<dt class="option-term" id="option-cargo---color"><a class="option-anchor" href="#option-cargo---color"></a><code>--color</code> <em>when</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Control when colored output is used. Valid values:</p>
{==+==}
<dd class="option-desc">控制何时使用彩色输出。有效值:</p>
{==+==}


{==+==}
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
{==+==}
<li><code>auto</code> (默认): 自动检测终端上是否有颜色支持。</li>
<li><code>always</code>: 总是显示颜色。</li>
<li><code>never</code>: 总不显示颜色。</li>
</ul>
<p> 也可以用 <code>term.color</code>
{==+==}



{==+==}
### Manifest Options
{==+==}
### 配置选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo---frozen"><a class="option-anchor" href="#option-cargo---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo---locked"><a class="option-anchor" href="#option-cargo---locked"></a><code>--locked</code></dt>
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
<dd class="option-desc">这些标志中的任何一个都要求<code>Cargo.lock</code>文件是最新的。 如果lock file丢失，或者需要更新，Cargo将以错误退出。
 <code>--frozen</code> 标志还可以防止Cargo试图访问网络以确定其是否过时。</p>
<p>这可能用于你想断言 <code>Cargo.lock</code> 文件是最新的环境(如CI构建)或想避免网络访问。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo---offline"><a class="option-anchor" href="#option-cargo---offline"></a><code>--offline</code></dt>
{==+==}

{==+==}


{==+==}
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
<dd class="option-desc">阻止Cargo访问网络。如果没有这个标志，Cargo在需要访问网络而网络不可用的情况下会以错误方式停止。
有了这个标志，如果可能的话，Cargo将尝试在没有网络的情况下进行。</p>
<p>请注意，这可能会导致与在线模式不同的依赖解决。
Cargo会将自己限制在本地下载的crate上，即使在本地拷贝的索引中可能有一个较新的版本。
参见 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令在离线前下载依赖。</p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置值</a>。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-+toolchain"><a class="option-anchor" href="#option-cargo-+toolchain"></a><code>+</code><em>toolchain</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dd class="option-desc">如果Cargo已经安装了rustup。 <code>cargo</code>的第一个参数以<code>+</code>开始, 它将被解释为一个rustup工具链名称 (比如 <code>+stable</code> 或 <code>+nightly</code>)。
参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a> 有关工具链覆盖如何工作的详细信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo---config"><a class="option-anchor" href="#option-cargo---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dd class="option-desc">覆盖Cargo配置值。参数应该是TOML语法中的 <code>KEY=VALUE</code>,
或作为一个额外的配置文件的路径提供。这个标志可以被多次指定。
参见 <a href="../reference/config.html#command-line-overrides">command-line 覆盖部分</a> 了解详细信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo--h"><a class="option-anchor" href="#option-cargo--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo---help"><a class="option-anchor" href="#option-cargo---help"></a><code>--help</code></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo--Z"><a class="option-anchor" href="#option-cargo--Z"></a><code>-Z</code> <em>flag</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dd class="option-desc"> Cargo 不稳定的 (每日构建) 标记 。运行 <code>cargo -Z 获得</code> 详细帮助。</dd>
{==+==}


{==+==}
## ENVIRONMENT
{==+==}

{==+==}


{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
关于Cargo读取的环境变量的详情，参阅 [参考](../reference/environment-variables.html) 。
{==+==}


{==+==}
## EXIT STATUS
{==+==}

{==+==}


{==+==}
* `0`: Cargo succeeded.
* `101`: Cargo failed to complete.
{==+==}
* `0`: Cargo 成功。
* `101`: Cargo 未能完成。
{==+==}


{==+==}
## FILES
{==+==}

{==+==}


{==+==}
`~/.cargo/`\
&nbsp;&nbsp;&nbsp;&nbsp;Default location for Cargo's "home" directory where it
stores various files. The location can be changed with the `CARGO_HOME`
environment variable.
{==+==}
`~/.cargo/`\
&nbsp;&nbsp;&nbsp;&nbsp;Cargo "home" 目录的默认位置，存储各种文件。这个位置可以通过 `CARGO_HOME` 环境变量来改变。
{==+==}


{==+==}
`$CARGO_HOME/bin/`\
&nbsp;&nbsp;&nbsp;&nbsp;Binaries installed by [cargo-install(1)](cargo-install.html) will be located here. If using
[rustup], executables distributed with Rust are also located here.
{==+==}
`$CARGO_HOME/bin/`\
&nbsp;&nbsp;&nbsp;&nbsp;由 [cargo-install(1)](cargo-install.html) 安装的二进制文件会放在这里。如果使用 [rustup]，随 Rust 分布的可执行文件也位于这里。
{==+==}


{==+==}
`$CARGO_HOME/config.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;The global configuration file. See [the reference](../reference/config.html)
for more information about configuration files.
{==+==}
`$CARGO_HOME/config.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;全局配置文件。见[参考](../reference/config.html)了解更多关于配置文件的信息。
{==+==}


{==+==}
`.cargo/config.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;Cargo automatically searches for a file named `.cargo/config.toml` in the
current directory, and all parent directories. These configuration files
will be merged with the global configuration file.
{==+==}
`.cargo/config.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;Cargo会自动在当前目录和所有父目录下搜索名为 `.cargo/config.toml` 的文件。这些配置文件将合并到全局配置文件中。
{==+==}


{==+==}
`$CARGO_HOME/credentials.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;Private authentication information for logging in to a registry.
{==+==}
`$CARGO_HOME/credentials.toml`\
&nbsp;&nbsp;&nbsp;&nbsp;用于登录注册中心的私人认证信息。
{==+==}


{==+==}
`$CARGO_HOME/registry/`\
&nbsp;&nbsp;&nbsp;&nbsp;This directory contains cached downloads of the registry index and any
downloaded dependencies.
{==+==}
`$CARGO_HOME/registry/`\
&nbsp;&nbsp;&nbsp;&nbsp;这个目录包含注册中心索引的缓存下载和任何下载的依赖。
{==+==}


{==+==}
`$CARGO_HOME/git/`\
&nbsp;&nbsp;&nbsp;&nbsp;This directory contains cached downloads of git dependencies.
{==+==}
`$CARGO_HOME/git/`\
&nbsp;&nbsp;&nbsp;&nbsp;这个目录包含了git依赖的缓存下载。
{==+==}


{==+==}
Please note that the internal structure of the `$CARGO_HOME` directory is not
stable yet and may be subject to change.
{==+==}
请注意， `$CARGO_HOME` 目录的内部结构还不稳定，可能会有变化。
{==+==}


{==+==}
[rustup]: https://rust-lang.github.io/rustup/
{==+==}

{==+==}


{==+==}
## EXAMPLES
{==+==}

{==+==}


{==+==}
1. Build a local package and all of its dependencies:

       cargo build
{==+==}
1. 构建本地包和它的所有依赖:

       cargo build
{==+==}


{==+==}
2. Build a package with optimizations:

       cargo build --release
{==+==}
2. 构建优化后的包:

       cargo build --release
{==+==}


{==+==}
3. Run tests for a cross-compiled target:

       cargo test --target i686-unknown-linux-gnu
{==+==}
3. 为交叉编译的目标运行测试:

       cargo test --target i686-unknown-linux-gnu
{==+==}


{==+==}
4. Create a new package that builds an executable:

       cargo new foobar
{==+==}
4. 创建新的包，构建可执行文件:

       cargo new foobar
{==+==}


{==+==}
5. Create a package in the current directory:

       mkdir foo && cd foo
       cargo init .
{==+==}
5. 在当前目录下创建包:

       mkdir foo && cd foo
       cargo init .
{==+==}


{==+==}
6. Learn about a command's options and usage:

       cargo help clean
{==+==}
6. 了解命令的选项和用法:

       cargo help clean
{==+==}


{==+==}
## BUGS
{==+==}

{==+==}


{==+==}
See <https://github.com/rust-lang/cargo/issues> for issues.
{==+==}
对于问题见 <https://github.com/rust-lang/cargo/issues> 。
{==+==}


{==+==}
## SEE ALSO
[rustc(1)](https://doc.rust-lang.org/rustc/index.html), [rustdoc(1)](https://doc.rust-lang.org/rustdoc/index.html)
{==+==}

{==+==}