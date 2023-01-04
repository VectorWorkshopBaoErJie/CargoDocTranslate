{==+==}
# cargo-new(1)
{==+==}
{==+==}

{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-new - Create a new Cargo package
{==+==}
cargo-new - 创建一个新的cargo package
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo new` [_options_] _path_
{==+==}
{==+==}


{==+==}
## DESCRIPTION
{==+==}
## 说明
{==+==}


{==+==}
This command will create a new Cargo package in the given directory. This
includes a simple template with a `Cargo.toml` manifest, sample source file,
and a VCS ignore file. If the directory is not already in a VCS repository,
then a new repository is created (see `--vcs` below).
{==+==}
该命令会在给定的目录下新建一个cargo package，将创建一个简单的名为`Cargo.toml`的清单文件模板，
示例源文件，以及一个版本控制系统的忽略清单文件，如果该目录不在版本控制系统仓库下，那么将会创建一个仓库(详情查看下文中的 `--vcs` 说明)
{==+==}


{==+==}
See [cargo-init(1)](cargo-init.html) for a similar command which will create a new manifest
in an existing directory.
{==+==}
查阅 [cargo-init(1)](cargo-init.html) 来了解类似的命令，用它可以在一个已经存在的目录下创建一个清单文件。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
### New Options
{==+==}
### 新建选项
{==+==}


{==+==}
<dl>
{==+==}
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---bin"><a class="option-anchor" href="#option-cargo-new---bin"></a><code>--bin</code></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Create a package with a binary target (<code>src/main.rs</code>).
This is the default behavior.</dd>
{==+==}
<dd class="option-desc">创建一个以binary为目标的package (<code>src/main.rs</code>).
This is the default behavior.</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---lib"><a class="option-anchor" href="#option-cargo-new---lib"></a><code>--lib</code></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Create a package with a library target (<code>src/lib.rs</code>).</dd>
{==+==}
<dd class="option-desc">创建一个以library为目标的package (<code>src/lib.rs</code>).</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---edition"><a class="option-anchor" href="#option-cargo-new---edition"></a><code>--edition</code> <em>edition</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Specify the Rust edition to use. Default is 2021.
Possible values: 2015, 2018, 2021</dd>
{==+==}
<dd class="option-desc">指定使用的Rust的版本. 默认是 2021，
可能的值有: 2015, 2018, 2021</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---name"><a class="option-anchor" href="#option-cargo-new---name"></a><code>--name</code> <em>name</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Set the package name. Defaults to the directory name.</dd>
{==+==}
<dd class="option-desc">设置package的名称，默认为给定的目录的名称。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---vcs"><a class="option-anchor" href="#option-cargo-new---vcs"></a><code>--vcs</code> <em>vcs</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Initialize a new VCS repository for the given version control system (git,
hg, pijul, or fossil) or do not initialize any version control at all
(none). If not specified, defaults to <code>git</code> or the configuration value
<code>cargo-new.vcs</code>, or <code>none</code> if already inside a VCS repository.</dd>
{==+==}
<dd class="option-desc">为版本控制系统(git, hg, pijul, 或者fossil)初始化一个仓库，否则将不会使用任何版本控制(none)。
如果该选项未被指定，则默认为 <code>git</code> 或者是在配置文件
<code>cargo-new.vcs</code>中指定的值，如果已经在一个版本控制系统仓库下面则相当于传入了 <code>none</code> 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---registry"><a class="option-anchor" href="#option-cargo-new---registry"></a><code>--registry</code> <em>registry</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">This sets the <code>publish</code> field in <code>Cargo.toml</code> to the given registry name
which will restrict publishing only to that registry.</p>
<p>Registry names are defined in <a href="../reference/config.html">Cargo config files</a>.
If not specified, the default registry defined by the <code>registry.default</code>
config key is used. If the default registry is not set and <code>--registry</code> is not
used, the <code>publish</code> field will not be set which means that publishing will not
be restricted.</dd>
{==+==}
<dd class="option-desc">指定该选项将找指定的注册项，并将 <code>Cargo.toml</code> 中的 <code>publish</code> 字段设置成它的值。</p>
<p>注册项的定义在 <a href="../reference/config.html">Cargo 配置文件</a>中。
如果未指定该选项，那么配置文件中 <code>registry.default</code> 块中的配置项将会被采用，
如果 <code>registry.default</code> 未被配置，并且 <code>--registry</code> 也未被指定, 那么 <code>publish</code> 就不会被设置，
这意味着发布将不受限制。
</dd>
{==+==}


{==+==}
</dl>
{==+==}
{==+==}


{==+==}
### Display Options
{==+==}
### 输出选项
{==+==}


{==+==}
<dl>
<dt class="option-term" id="option-cargo-new--v"><a class="option-anchor" href="#option-cargo-new--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-new---verbose"><a class="option-anchor" href="#option-cargo-new---verbose"></a><code>--verbose</code></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">采用冗长的输出. 可以被设置两次用来表示 &quot;非常冗长&quot; ，这将包含额外的输出信息，例如依赖的警告以及构建脚本的输出。
也可以通过 <code>term.verbose</code> 来配置 <a href="../reference/config.html">可选值</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new--q"><a class="option-anchor" href="#option-cargo-new--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-new---quiet"><a class="option-anchor" href="#option-cargo-new---quiet"></a><code>--quiet</code></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dd class="option-desc">表示不输出任何cargo日志信息，
也可以通过 <code>term.quiet</code> 来配置<a href="../reference/config.html">可选值</a>。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---color"><a class="option-anchor" href="#option-cargo-new---color"></a><code>--color</code> <em>when</em></dt>
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
<dd class="option-desc">用来控制何时使用彩色的输出，有效值有:</p>
<ul>
<li><code>auto</code> (默认): 自动检测该终端是否支持彩色输出。</li>
<li><code>always</code>: 总是使用彩色输出。</li>
<li><code>never</code>: 从不使用彩色输出。</li>
</ul>
<p>也可以通过 <code>term.color</code> 来配置<a href="../reference/config.html">可选值</a>。</dd>
{==+==}


{==+==}
</dl>
{==+==}
{==+==}


{==+==}
### Common Options
{==+==}
### 一般选项
{==+==}


{==+==}
<dl>
{==+==}
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new-+toolchain"><a class="option-anchor" href="#option-cargo-new-+toolchain"></a><code>+</code><em>toolchain</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dd class="option-desc">如果Cargo是通过rustup安装的，如果第一个传给 <code>cargo</code> 的参数是以 <code>+</code> 开头的话，
它将被理解为rustup的工具链名称(例如 <code>+stable</code> 或者 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup文档</a>获取更多关于重载工具链的工作原理的信息</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new---config"><a class="option-anchor" href="#option-cargo-new---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dd class="option-desc">表示覆盖一个Cargo配置项的值. 传入的参数应当遵循 <code>KEY=VALUE</code> 的TOML语法或者是
一个额外的配置文件的路径。 该选项可以被配置多次.
查阅 <a href="../reference/config.html#command-line-overrides">命令行重写部分</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new--h"><a class="option-anchor" href="#option-cargo-new--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-new---help"><a class="option-anchor" href="#option-cargo-new---help"></a><code>--help</code></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dd class="option-desc">输出帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-new--Z"><a class="option-anchor" href="#option-cargo-new--Z"></a><code>-Z</code> <em>flag</em></dt>
{==+==}
{==+==}


{==+==}
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dd class="option-desc">不稳定的 (只在nightly下可用) 标识，执行 <code>cargo -Z help</code> 获取更多信息。</dd>
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
查阅 [参考手册](../reference/environment-variables.html) 获取Cargo将读取的环境变量的资料 
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
* `0`: Cargo 成功退出.
* `101`: Cargo 错误退出.
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Create a binary Cargo package in the given directory:

       cargo new foo
{==+==}
1. 在给定的目录下创建一个cargo package:

       cargo new foo
{==+==}


{==+==}
## SEE ALSO
[cargo(1)](cargo.html), [cargo-init(1)](cargo-init.html)
{==+==}
## 另请参见
[cargo(1)](cargo.html), [cargo-init(1)](cargo-init.html)
{==+==}
