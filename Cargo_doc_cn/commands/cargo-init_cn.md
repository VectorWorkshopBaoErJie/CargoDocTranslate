{==+==}
# cargo-init(1)
{==+==}

{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-init - Create a new Cargo package in an existing directory
{==+==}
cargo-init - 在一个已存在的文件夹中创建一个新的包 (package)
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo init` [_options_] [_path_]
{==+==}

{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
This command will create a new Cargo manifest in the current directory. Give a
path as an argument to create in the given directory.

If there are typically-named Rust source files already in the directory, those
will be used. If not, then a sample `src/main.rs` file will be created, or
`src/lib.rs` if `--lib` is passed.

If the directory is not already in a VCS repository, then a new repository
is created (see `--vcs` below).

See [cargo-new(1)](cargo-new.html) for a similar command which will create a new package in
a new directory.
{==+==}
这个命令会在当前文件夹中创建一个新的 Cargo 清单文件。如果指定一个路径作为参数，则会在给定的文件夹中创建。

如果文件夹中已存在典型命名的 Rust 源代码文件，则会被使用。如果没有，则会创建样板 `src/main.rs`，如果指定了 `--lib`，则创建的是 `src/lib.rs` 。
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Init Options
{==+==}
### 创建选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---bin"><a class="option-anchor" href="#option-cargo-init---bin"></a><code>--bin</code></dt>
<dd class="option-desc">Create a package with a binary target (<code>src/main.rs</code>).
This is the default behavior.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---bin"><a class="option-anchor" href="#option-cargo-init---bin"></a><code>--bin</code></dt>
<dd class="option-desc">创建含有一个二进制 target (<code>src/main.rs</code>) 的包。这是默认行为。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---lib"><a class="option-anchor" href="#option-cargo-init---lib"></a><code>--lib</code></dt>
<dd class="option-desc">Create a package with a library target (<code>src/lib.rs</code>).</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---lib"><a class="option-anchor" href="#option-cargo-init---lib"></a><code>--lib</code></dt>
<dd class="option-desc">创建含有一个库 target (<code>src/lib.rs</code>) 的包。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---edition"><a class="option-anchor" href="#option-cargo-init---edition"></a><code>--edition</code> <em>edition</em></dt>
<dd class="option-desc">Specify the Rust edition to use. Default is 2021.
Possible values: 2015, 2018, 2021</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---edition"><a class="option-anchor" href="#option-cargo-init---edition"></a><code>--edition</code> <em>edition</em></dt>
<dd class="option-desc">指定使用的 Rust 版本。默认为 2021。可选值有：2015、2018、2021。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---name"><a class="option-anchor" href="#option-cargo-init---name"></a><code>--name</code> <em>name</em></dt>
<dd class="option-desc">Set the package name. Defaults to the directory name.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---name"><a class="option-anchor" href="#option-cargo-init---name"></a><code>--name</code> <em>name</em></dt>
<dd class="option-desc">设置包的名字。默认为文件夹名。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---vcs"><a class="option-anchor" href="#option-cargo-init---vcs"></a><code>--vcs</code> <em>vcs</em></dt>
<dd class="option-desc">Initialize a new VCS repository for the given version control system (git,
hg, pijul, or fossil) or do not initialize any version control at all
(none). If not specified, defaults to <code>git</code> or the configuration value
<code>cargo-new.vcs</code>, or <code>none</code> if already inside a VCS repository.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---vcs"><a class="option-anchor" href="#option-cargo-init---vcs"></a><code>--vcs</code> <em>vcs</em></dt>
<dd class="option-desc">初始化一个新的 VCS 仓库 (git，hg，pijul 或 fossil)，或不初始化任何版本控制 (none)。如果没有指定，默认使用  <code>git</code> ，或者 <code>cargo-new.vcs</code> 中设置的值，或者为 <code>none</code> (如果已经在一个 VSC 库中)。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---registry"><a class="option-anchor" href="#option-cargo-init---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">This sets the <code>publish</code> field in <code>Cargo.toml</code> to the given registry name
which will restrict publishing only to that registry.</p>
<p>Registry names are defined in <a href="../reference/config.html">Cargo config files</a>.
If not specified, the default registry defined by the <code>registry.default</code>
config key is used. If the default registry is not set and <code>--registry</code> is not
used, the <code>publish</code> field will not be set which means that publishing will not
be restricted.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---registry"><a class="option-anchor" href="#option-cargo-init---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">这会设置 <code>Cargo.toml</code> 中的 <code>publish</code> 字段，指定一个 registry 的名字，使得包只能发布到这个 registry 。</p>
<p>Registry 的名称定义在 <a href="../reference/config.html">Cargo config files</a>.
如果没有指定，则使用<code>registry.default</code> 中设置的默认 registry 。
如果没有设置默认 registry 且没有指定 <code>--registry</code> ，则 <code>publish</code> 字段不会被设置，这意味着发布没有任何限制。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init--v"><a class="option-anchor" href="#option-cargo-init--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-init---verbose"><a class="option-anchor" href="#option-cargo-init---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init--v"><a class="option-anchor" href="#option-cargo-init--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-init---verbose"><a class="option-anchor" href="#option-cargo-init---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init--q"><a class="option-anchor" href="#option-cargo-init--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-init---quiet"><a class="option-anchor" href="#option-cargo-init---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init--q"><a class="option-anchor" href="#option-cargo-init--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-init---quiet"><a class="option-anchor" href="#option-cargo-init---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---color"><a class="option-anchor" href="#option-cargo-init---color"></a><code>--color</code> <em>when</em></dt>
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
<dt class="option-term" id="option-cargo-init---color"><a class="option-anchor" href="#option-cargo-init---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
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
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init-+toolchain"><a class="option-anchor" href="#option-cargo-init-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init-+toolchain"><a class="option-anchor" href="#option-cargo-init-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init---config"><a class="option-anchor" href="#option-cargo-init---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init---config"><a class="option-anchor" href="#option-cargo-init---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init--h"><a class="option-anchor" href="#option-cargo-init--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-init---help"><a class="option-anchor" href="#option-cargo-init---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init--h"><a class="option-anchor" href="#option-cargo-init--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-init---help"><a class="option-anchor" href="#option-cargo-init---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-init--Z"><a class="option-anchor" href="#option-cargo-init--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-init--Z"><a class="option-anchor" href="#option-cargo-init--Z"></a><code>-Z</code> <em>flag</em></dt>
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
1. Create a binary Cargo package in the current directory:

       cargo init
{==+==}
1. 在当前文件夹中创建一个二进制 Cargo 包: 

       cargo init
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html), [cargo-new(1)](cargo-new.html)
{==+==}

{==+==}
