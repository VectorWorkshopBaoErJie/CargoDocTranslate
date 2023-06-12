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
Cargo 会将构建的输出存储在 "target" 目录中。默认情况下，默认情况下是 [*workspace*][def-workspace] 根目录下的 `target` 目录。
如果要更改此目录的位置，可以设置 `CARGO_TARGET_DIR` [环境变量][environment variable] 、 [`build.target-dir`] 配置值或通过 `--target-dir` 命令行标志。
{==+==}


{==+==}
The directory layout depends on whether or not you are using the `--target`
flag to build for a specific platform. If `--target` is not specified, Cargo
runs in a mode where it builds for the host architecture. The output goes into
the root of the target directory, with each [profile] stored in a separate
subdirectory:
{==+==}
如果没有使用 `--target` 标志来构建特定平台的程序，则目录结构会有所不同。
在这种情况下，Cargo 会以构建时主机的架构模式运行。
输出结果会存储在目标目录的根目录中，而每个 [编译设置][profile] 则会存储在单独的子目录中：
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
由于历史原因， `dev` 和 `test` 编译设置存储在 `debug` 目录中，而 `release` 和 `bench` 编译设置则存储在 `release` 目录中。
用户自定义的编译设置将存储在与编译设置同名的目录中。
{==+==}


{==+==}
When building for another target with `--target`, the output is placed in a
directory with the name of the target:
{==+==}
当使用 `--target` 为其它目标构建时，输出文件将被放置在名称为目标名称的目录中。
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
> **注意**: 注意：当未使用 `--target` 选项时， Cargo 会共享依赖的构建脚本和过程宏。
> [`RUSTFLAGS`] 每次 `rustc` 调用会共享。
> 使用 `--target` 选项时，构建脚本和过程宏会单独构建 (针对主机架构) ，并且不共享 `RUSTFLAGS` 。
{==+==}


{==+==}
Within the profile directory (such as `debug` or `release`), artifacts are
placed into the following directories:
{==+==}
在编译目录 (如 `debug` 或 `release` )下，制品被放置在以下目录中:
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
有些命令会将其输出放在 `target` 目录的顶层的专用目录中：
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
Cargo 还会在构建过程创建一些其他的目录和文件。由 Cargo 内部使用，可能会发生更改。其中一些目录包括：
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
对于每个编译好的制品，相应的会有一个名为 ".d" 后缀的 "dep info" 文件。
该文件使用类似 Makefile 的语法，指示重新构建该制品所需的所有文件依赖项。
这些文件旨在与外部构建系统一起使用，以检测是否需要重新执行 Cargo 。
默认情况下，文件中的路径是绝对路径。请参阅 [`build.dep-info-basedir`] 配置选项，以使用相对路径。
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
[sccache] 是第三方工具，可用于在不同的工作空间之间共享构建的依赖项。
{==+==}


{==+==}
To setup `sccache`, install it with `cargo install sccache` and set
`RUSTC_WRAPPER` environmental variable to `sccache` before invoking Cargo. If
you use bash, it makes sense to add `export RUSTC_WRAPPER=sccache` to
`.bashrc`. Alternatively, you can set [`build.rustc-wrapper`] in the [Cargo
configuration][config]. Refer to sccache documentation for more details.
{==+==}
需要通过 `cargo install sccache` 安装 `sccache` ，然后在运行 Cargo 前将 `RUSTC_WRAPPER` 环境变量设置为 `sccache`。
如果你使用的是 bash ，可以在 `.bashrc` 中添加 `export RUSTC_WRAPPER=sccache`。
还可以在 [Cargo 配置文件][config] 中设置 [`build.rustc-wrapper`] 。更多细节请参考 sccache 文档。
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
