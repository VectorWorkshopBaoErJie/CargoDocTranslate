{==+==}
## Build cache
{==+==}
## 构建缓存
{==+==}


{==+==}
Cargo stores the output of a build into the "target" directory. By default,
this is the directory named `target` in the root of your
[*workspace*][def-workspace]. To change the location, you can set the
`CARGO_TARGET_DIR` [environment variable], the [`build.target-dir`] config
value, or the `--target-dir` command-line flag.
{==+==}
Cargo会把构建输出保存在 "target" 文件夹中。默认情况下这个文件夹是你的 [*workspace*][def-workspace] 根目录下的 `target` 文件夹。
如果要改变输出位置，可以设置 `CARGO_TARGET_DIR` [environment variable] "环境变量"、 [`build.target-dir`] config参数，或者 `--target-dir` 命令行标志(flag)。
{==+==}


{==+==}
The directory layout depends on whether or not you are using the `--target`
flag to build for a specific platform. If `--target` is not specified, Cargo
runs in a mode where it builds for the host architecture. The output goes into
the root of the target directory, with each [profile] stored in a separate
subdirectory:
{==+==}
这个文件夹的布局取决于你是否使用 `--target` 标志来为特定平台构建。如果没有设置 `--target` 标志，Cargo 会按宿主机的架构进行构建。
输出文件保存在target文件夹，每个特定编译设置 ([profile]) 的输出文件会在放在单独的子文件夹中。
{==+==}


{==+==}
Directory | Description
----------|------------
<code style="white-space: nowrap">target/debug/</code> | Contains output for the `dev` profile.
<code style="white-space: nowrap">target/release/</code> | Contains output for the `release` profile (with the `--release` option).
<code style="white-space: nowrap">target/foo/</code> | Contains build output for the `foo` profile (with the `--profile=foo` option).
{==+==}
文件夹 | 描述
----------|------------
<code style="white-space: nowrap">target/debug/</code> | 包含 `dev` 编译设置的输出文件。
<code style="white-space: nowrap">target/release/</code> | 包含 `release` 编译设置 (构建时带 `--release` 选项) 的输出文件。
<code style="white-space: nowrap">target/foo/</code> | 包含 `foo` 编译设置 (构建时带 `--profile=foo` 选项) 的输出文件。
{==+==}


{==+==}
For historical reasons, the `dev` and `test` profiles are stored in the
`debug` directory, and the `release` and `bench` profiles are stored in the
`release` directory. User-defined profiles are stored in a directory with the
same name as the profile.
{==+==}
由于历史原因， `dev` 和 `test` 编译设置的输出文件被放在 `debug` 文件夹中， `release` 和 `bench` 编译设置的输出文件被放在 `release` 文件夹。用户自定义编译设置的输出文件放在同名的文件夹中。
{==+==}


{==+==}
When building for another target with `--target`, the output is placed in a
directory with the name of the target:
{==+==}
当为另一种架构 (非宿主架构，命令行带 `--target` 参数) 而构建，输出文件会放在带有目标架构名字的文件夹中:
{==+==}

{==+==}
Directory | Example
----------|--------
<code style="white-space: nowrap">target/&lt;triple&gt;/debug/</code> | <code style="white-space: nowrap">target/thumbv7em-none-eabihf/debug/</code>
<code style="white-space: nowrap">target/&lt;triple&gt;/release/</code> | <code style="white-space: nowrap">target/thumbv7em-none-eabihf/release/</code>
{==+==}
文件夹 | 例子
----------|--------
<code style="white-space: nowrap">target/&lt;triple&gt;/debug/</code> | <code style="white-space: nowrap">target/thumbv7em-none-eabihf/debug/</code>
<code style="white-space: nowrap">target/&lt;triple&gt;/release/</code> | <code style="white-space: nowrap">target/thumbv7em-none-eabihf/release/</code>
{==+==}

{==+==}
> **Note**: When not using `--target`, this has a consequence that Cargo will
> share your dependencies with build scripts and proc macros. [`RUSTFLAGS`]
> will be shared with every `rustc` invocation. With the `--target` flag,
> build scripts and proc macros are built separately (for the host
> architecture), and do not share `RUSTFLAGS`.
{==+==}
> **注意**: 如果没有使用 `--target`，Cargo会把你的依赖共享给构建脚本(build scripts)和过程宏(proc macros)使用。
> [`RUSTFLAGS`] 会在每次 `rustc` 调用时使用。
> 如果使用了 `--target` 标志，构建脚本和过程宏会为宿主架构单独构建，不会获取 `RUSTFLAGS` 中的参数。
{==+==}


{==+==}
Within the profile directory (such as `debug` or `release`), artifacts are
placed into the following directories:
{==+==}
在每个编译设置(profile)的输出文件夹中 (比如 `debug` 或 `release`)，制品会被放在以下几个文件夹中:
{==+==}


{==+==}
Directory | Description
----------|------------
<code style="white-space: nowrap">target/debug/</code> | Contains the output of the package being built (the [binary executables] and [library targets]).
<code style="white-space: nowrap">target/debug/examples/</code> | Contains [example targets].
{==+==}
文件夹 | 描述
----------|------------
<code style="white-space: nowrap">target/debug/</code> | 包含该包的制品 ([二进制可执行文件][binary executables] 和 [库文件][library targets]).
<code style="white-space: nowrap">target/debug/examples/</code> | 包含示例的制品 [example targets].
{==+==}


{==+==}
Some commands place their output in dedicated directories in the top level of
the `target` directory:
{==+==}
一些命令会把生成文件放在 `target`目录的顶层:
{==+==}


{==+==}
Directory | Description
----------|------------
<code style="white-space: nowrap">target/doc/</code> | Contains rustdoc documentation ([`cargo doc`]).
<code style="white-space: nowrap">target/package/</code> | Contains the output of the [`cargo package`] and [`cargo publish`] commands.
{==+==}
目录 | 描述
----------|------------
<code style="white-space: nowrap">target/doc/</code> | 包含 rustdoc 生成的文档 ([`cargo doc`] 命令)。
<code style="white-space: nowrap">target/package/</code> | 包含 [`cargo package`] 和 [`cargo publish`] 命令生成的文件。
{==+==}

{==+==}
Cargo also creates several other directories and files needed for the build
process. Their layout is considered internal to Cargo, and is subject to
change. Some of these directories are:
{==+==}
Cargo还会生成构建过程需要的其他文件和文件夹，它们的组织结构看做Cargo内部项，可能会更改。其中几个文件夹:
{==+==}

{==+==}
Directory | Description
----------|------------
<code style="white-space: nowrap">target/debug/deps/</code> | Dependencies and other artifacts.
<code style="white-space: nowrap">target/debug/incremental/</code> | `rustc` [incremental output], a cache used to speed up subsequent builds.
<code style="white-space: nowrap">target/debug/build/</code> | Output from [build scripts].
{==+==}
目录 | 描述
----------|------------
<code style="white-space: nowrap">target/debug/deps/</code> | 依赖以及其他制品。
<code style="white-space: nowrap">target/debug/incremental/</code> | `rustc` [增量编译输出][incremental output]，加速构建过程的一些缓存文件。
<code style="white-space: nowrap">target/debug/build/</code> |  [构建脚本][build scripts] 的输出。
{==+==}

{==+==}
### Dep-info files
{==+==}
### Dep-info files
{==+==}

{==+==}
Next to each compiled artifact is a file called a "dep info" file with a `.d`
suffix. This file is a Makefile-like syntax that indicates all of the file
dependencies required to rebuild the artifact. These are intended to be used
with external build systems so that they can detect if Cargo needs to be
re-executed. The paths in the file are absolute by default. See the
[`build.dep-info-basedir`] config option to use relative paths.
{==+==}
还有一个后缀为 `.d` 的 "依赖信息" 文件(dep info)，类似Makefile，记录了再次构建所需的文件依赖。
这个文件用于提供给外部的构建系统，判断是否需要再次执行Cargo。文件中的文件路径在默认情况下都是绝对路径。如何设置为相对路径见 [`build.dep-info-basedir`]。
{==+==}

{==+==}
```Makefile
# Example dep-info file found in target/debug/foo.d
/path/to/myproj/target/debug/foo: /path/to/myproj/src/lib.rs /path/to/myproj/src/main.rs
```
{==+==}
```Makefile
# dep-info 文件的例子: target/debug/foo.d
/path/to/myproj/target/debug/foo: /path/to/myproj/src/lib.rs /path/to/myproj/src/main.rs
```
{==+==}


{==+==}
### Shared cache
{==+==}
### 共享缓存
{==+==}


{==+==}
A third party tool, [sccache], can be used to share built dependencies across
different workspaces.
{==+==}
第三方工具 [sccache] 可以跨工作空间共享构建依赖。
{==+==}


{==+==}
To setup `sccache`, install it with `cargo install sccache` and set
`RUSTC_WRAPPER` environmental variable to `sccache` before invoking Cargo. If
you use bash, it makes sense to add `export RUSTC_WRAPPER=sccache` to
`.bashrc`. Alternatively, you can set [`build.rustc-wrapper`] in the [Cargo
configuration][config]. Refer to sccache documentation for more details.
{==+==}
通过 `cargo install sccache` 下载 `sccache`。在执行Cargo前，将 `RUSTC_WRAPPER` 环境变量设置为 `sccache`。
如果你用的是bash，那么可以把 `export RUSTC_WRAPPER=sccache` 添加到 `.bashrc` 。
或者你可以在 [Cargo配置文件][config] 中设置 [`build.rustc-wrapper`] 。查看sccache的文档来获取更多细节。
{==+==}


{==+==}
[`RUSTFLAGS`]: ../reference/config.md#buildrustflags
[`build.dep-info-basedir`]: ../reference/config.md#builddep-info-basedir
[`build.rustc-wrapper`]: ../reference/config.md#buildrustc-wrapper
[`build.target-dir`]: ../reference/config.md#buildtarget-dir
[`cargo doc`]: ../commands/cargo-doc.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo publish`]: ../commands/cargo-publish.md
[build scripts]: ../reference/build-scripts.md
[config]: ../reference/config.md
[def-workspace]:  ../appendix/glossary.md#workspace  '"workspace" (glossary entry)'
[environment variable]: ../reference/environment-variables.md
[incremental output]: ../reference/profiles.md#incremental
[sccache]: https://github.com/mozilla/sccache
[profile]: ../reference/profiles.md
[binary executables]: ../reference/cargo-targets.md#binaries
[library targets]: ../reference/cargo-targets.md#library
[example targets]: ../reference/cargo-targets.md#examples
{==+==}

{==+==}
