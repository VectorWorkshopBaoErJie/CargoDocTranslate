{==+==}
## Build Scripts
{==+==}
## 构建脚本
{==+==}

{==+==}
Some packages need to compile third-party non-Rust code, for example C
libraries. Other packages need to link to C libraries which can either be
located on the system or possibly need to be built from source. Others still
need facilities for functionality such as code generation before building (think
parser generators).
{==+==}
有些包需要编译第三方的非Rust代码，例如C库。
有些包需要链接到C库，这些库可能位于系统中，也可能需要从源代码构建。
还有包需要一些功能性工具，比如在构建前生成代码(想想语法分析生成器)。
{==+==}

{==+==}
Cargo does not aim to replace other tools that are well-optimized for these
tasks, but it does integrate with them with custom build scripts. Placing a
file named `build.rs` in the root of a package will cause Cargo to compile
that script and execute it just before building the package.
{==+==}
Cargo的目的并不是要取代为这些任务而优化的其他工具，Cargo可以通过定制构建脚本与这些工具进行整合。
在包的根目录下放置一个名为 `build.rs` 的文件，就会使Cargo在构建包之前编译该脚本并执行。
{==+==}

{==+==}
```rust,ignore
// Example custom build script.
fn main() {
    // Tell Cargo that if the given file changes, to rerun this build script.
    println!("cargo:rerun-if-changed=src/hello.c");
    // Use the `cc` crate to build a C file and statically link it.
    cc::Build::new()
        .file("src/hello.c")
        .compile("hello");
}
```
{==+==}
```rust,ignore
// 自定义构建脚本实例
fn main() {
    // 告诉Cargo，如果给定的文件发生更改，则重新运行此构建脚本。
    println!("cargo:rerun-if-changed=src/hello.c");
    // 使用 `cc` crate 构建一个C文件并静态链接它。
    cc::Build::new()
        .file("src/hello.c")
        .compile("hello");
}
```
{==+==}

{==+==}
Some example use cases of build scripts are:
{==+==}
构建脚本的一些用例如下:
{==+==}

{==+==}
* Building a bundled C library.
* Finding a C library on the host system.
* Generating a Rust module from a specification.
* Performing any platform-specific configuration needed for the crate.
{==+==}
* 构建C库绑定。
* 在主机系统上查找C库。
* 根据规范生成Rust模块。
* 执行crate所需的任意平台特定配置。
{==+==}

{==+==}
The sections below describe how build scripts work, and the [examples
chapter](build-script-examples.md) shows a variety of examples on how to write
scripts.
{==+==}
下面的章节描述了构建脚本的工作方式，[示例章节](build-script-examples.md) 展示了关于如何编写脚本的各种示例。
{==+==}

{==+==}
> Note: The [`package.build` manifest key](manifest.md#package-build) can be
> used to change the name of the build script, or disable it entirely.
{==+==}
> 注意: 可以使用 [`package.build` 配置键](manifest.md#package-build) 来改变构建脚本的名称，或完全禁用它。
{==+==}

{==+==}
### Life Cycle of a Build Script
{==+==}
### 构建脚本的生命周期
{==+==}

{==+==}
Just before a package is built, Cargo will compile a build script into an
executable (if it has not already been built). It will then run the script,
which may perform any number of tasks. The script may communicate with Cargo
by printing specially formatted commands prefixed with `cargo:` to stdout.
{==+==}
在构建包之前，Cargo会将构建脚本编译成可执行文件(如果还没有构建的话)。
然后运行脚本，该脚本可以执行任意数量的任务。
脚本可以通过将带有 `cargo:` 前缀的特殊格式化命令打印到标准输出来与Cargo通信。
{==+==}

{==+==}
The build script will be rebuilt if any of its source files or dependencies
change.
{==+==}
如果构建脚本的任意源文件或依赖项发生更改，将重新构建脚本。
{==+==}

{==+==}
By default, Cargo will re-run the build script if any of the files in the
package changes. Typically it is best to use the `rerun-if` commands,
described in the [change detection](#change-detection) section below, to
narrow the focus of what triggers a build script to run again.
{==+==}
默认情况下，如果包中的任何文件发生变化，Cargo 会重新运行构建脚本。
通常，最好使用下面 [change detection](#change-detection) 一节中描述的 `rerun-if` 命令，以缩小触发构建脚本重新运行的关注点。
{==+==}

{==+==}
Once the build script successfully finishes executing, the rest of the package
will be compiled. Scripts should exit with a non-zero exit code to halt the
build if there is an error, in which case the build script's output will be
displayed on the terminal.
{==+==}
一旦构建脚本成功执行完毕，就会编译包的其他部分。
脚本应该以非零的退出代码退出，以便在出现错误时停止编译，在这种情况下，编译脚本的输出将显示在终端。
{==+==}

{==+==}
### Inputs to the Build Script
{==+==}
### 构建脚本的输入
{==+==}

{==+==}
When the build script is run, there are a number of inputs to the build script,
all passed in the form of [environment variables][build-env].
{==+==}
当构建脚本运行时，若有一些输入到构建脚本，则都是以 [环境变量][build-env] 的形式传递。
{==+==}

{==+==}
In addition to environment variables, the build script’s current directory is
the source directory of the build script’s package.
{==+==}
除了环境变量外，构建脚本的当前目录是构建脚本的包的源目录。
{==+==}

{==+==}
[build-env]: environment-variables.md#environment-variables-cargo-sets-for-build-scripts
{==+==}

{==+==}

{==+==}
### Outputs of the Build Script
{==+==}
### 构建脚本的输出
{==+==}

{==+==}
Build scripts may save any output files or intermediate artifacts in the
directory specified in the [`OUT_DIR` environment variable][build-env]. Scripts
should not modify any files outside of that directory.
{==+==}
构建脚本可以将任何输出文件或中间构件保存在 [`OUT_DIR` 环境变量][build-env] 指定的目录中。
脚本不应该修改该目录之外的任何文件。
{==+==}

{==+==}
Build scripts communicate with Cargo by printing to stdout. Cargo will
interpret each line that starts with `cargo:` as an instruction that will
influence compilation of the package. All other lines are ignored.
{==+==}
构建脚本通过打印到标准输出与Cargo交流。
Cargo会把每一行以 `cargo:` 开头的字解释为影响包编译的指令。忽略所有其他行。
{==+==}

{==+==}
> Note: The order of `cargo:` instructions printed by the build script *may*
> affect the order of arguments that `cargo` passes to `rustc`. In turn, the
> order of arguments passed to `rustc` may affect the order of arguments passed
> to the linker. Therefore, you will want to pay attention to the order of the
> build script's instructions. For example, if object `foo` needs to link against
> library `bar`, you may want to make sure that library `bar`'s
> [`cargo:rustc-link-lib`](#rustc-link-lib) instruction appears *after*
> instructions to link object `foo`.
{==+==}
> 注意：构建脚本打印的 `cargo:` 指令的顺序 *可能* 会影响 `cargo` 传递给 `rustc` 的参数的顺序。
> 反过来，传递给 `rustc` 的参数顺序也可能影响传递给链接器的参数顺序。
> 因此，你要注意构建脚本的指令顺序。
> 例如，如果对象 `foo` 需要与库 `bar` 链接，你可能需要确保库 `bar` 的 [`cargo:rustc-link-lib`](#rustc-link-lib) 指令出现在链接对象 `foo` 的指令 *之后* 。
{==+==}

{==+==}
The output of the script is hidden from the terminal during normal
compilation. If you would like to see the output directly in your terminal,
invoke Cargo as "very verbose" with the `-vv` flag. This only happens when the
build script is run. If Cargo determines nothing has changed, it will not
re-run the script, see [change detection](#change-detection) below for more.
{==+==}
在正常的编译过程中，脚本的输出被隐藏在终端中。
如果你想在终端上直接看到输出，可以用 `-vv` 标志来调用Cargo的 "very verbose" 。
这只发生在编译脚本运行的时候。
如果Cargo认为没有任何变化，它就不会重新运行脚本，更多信息请参见下面的 [变化检测](#change-detection) 。
{==+==}

{==+==}
All the lines printed to stdout by a build script are written to a file like
`target/debug/build/<pkg>/output` (the precise location may depend on your
configuration). The stderr output is also saved in that same directory.
{==+==}
构建脚本打印到标准输出的所有行都被写入一个文件，如 `target/debug/build/<pkg>/output`(确切位置可能取决于你的配置)。标准错误输出也保存在同一目录。
{==+==}

{==+==}
The following is a summary of the instructions that Cargo recognizes, with each
one detailed below.
{==+==}
以下是 Cargo 所认识的指令摘要，每条指令都在下面详细说明。
{==+==}

{==+==}
* [`cargo:rerun-if-changed=PATH`](#rerun-if-changed) — Tells Cargo when to
  re-run the script.
* [`cargo:rerun-if-env-changed=VAR`](#rerun-if-env-changed) — Tells Cargo when
  to re-run the script.
* [`cargo:rustc-link-arg=FLAG`](#rustc-link-arg) — Passes custom flags to a
  linker for benchmarks, binaries, `cdylib` crates, examples, and tests.
* [`cargo:rustc-link-arg-bin=BIN=FLAG`](#rustc-link-arg-bin) — Passes custom
  flags to a linker for the binary `BIN`.
* [`cargo:rustc-link-arg-bins=FLAG`](#rustc-link-arg-bins) — Passes custom
  flags to a linker for binaries.
* [`cargo:rustc-link-arg-tests=FLAG`](#rustc-link-arg-tests) — Passes custom
  flags to a linker for tests.
* [`cargo:rustc-link-arg-examples=FLAG`](#rustc-link-arg-examples) — Passes custom
  flags to a linker for examples.
* [`cargo:rustc-link-arg-benches=FLAG`](#rustc-link-arg-benches) — Passes custom
  flags to a linker for benchmarks.
{==+==}
* [`cargo:rerun-if-changed=PATH`](#rerun-if-changed) — 告诉Cargo何时重新运行脚本。
* [`cargo:rerun-if-env-changed=VAR`](#rerun-if-env-changed) — 告诉Cargo何时重新运行脚本。
* [`cargo:rustc-link-arg=FLAG`](#rustc-link-arg) — 为性能测试、二进制文件、`cdylib` crates、示例和测试的链接器传递自定义标志。
* [`cargo:rustc-link-arg-bin=BIN=FLAG`](#rustc-link-arg-bin) — 将自定义标志传递给二进制 `BIN` 的链接器。
* [`cargo:rustc-link-arg-bins=FLAG`](#rustc-link-arg-bins) — 将自定义标志传递给二进制文件的链接器。
* [`cargo:rustc-link-arg-tests=FLAG`](#rustc-link-arg-tests) —  将自定义标志传递给链接器进行测试。
* [`cargo:rustc-link-arg-examples=FLAG`](#rustc-link-arg-examples) — 将自定义标志传递给链接器的例子。
* [`cargo:rustc-link-arg-benches=FLAG`](#rustc-link-arg-benches) — 将自定义的标志传递给链接器，用于性能测试。
{==+==}

{==+==}
* [`cargo:rustc-link-lib=LIB`](#rustc-link-lib) — Adds a library to
  link.
* [`cargo:rustc-link-search=[KIND=]PATH`](#rustc-link-search) — Adds to the
  library search path.
* [`cargo:rustc-flags=FLAGS`](#rustc-flags) — Passes certain flags to the
  compiler.
* [`cargo:rustc-cfg=KEY[="VALUE"]`](#rustc-cfg) — Enables compile-time `cfg`
  settings.
* [`cargo:rustc-env=VAR=VALUE`](#rustc-env) — Sets an environment variable.
* [`cargo:rustc-cdylib-link-arg=FLAG`](#rustc-cdylib-link-arg) — Passes custom
  flags to a linker for cdylib crates.
* [`cargo:warning=MESSAGE`](#cargo-warning) — Displays a warning on the
  terminal.
* [`cargo:KEY=VALUE`](#the-links-manifest-key) — Metadata, used by `links`
  scripts.
{==+==}
* [`cargo:rustc-link-lib=LIB`](#rustc-link-lib) — 添加一个库到链接。
* [`cargo:rustc-link-search=[KIND=]PATH`](#rustc-link-search) — 添加到库的搜索路径。
* [`cargo:rustc-flags=FLAGS`](#rustc-flags) — 将特定标志传递给编译器。
* [`cargo:rustc-cfg=KEY[="VALUE"]`](#rustc-cfg) — 启用编译时的 `cfg` 设置。
* [`cargo:rustc-env=VAR=VALUE`](#rustc-env) — 设置一个环境变量。
* [`cargo:rustc-cdylib-link-arg=FLAG`](#rustc-cdylib-link-arg) — 为cdylib crate的链接器传递自定义标志。
* [`cargo:warning=MESSAGE`](#cargo-warning) — 在终端上显示一个警告。
* [`cargo:KEY=VALUE`](#the-links-manifest-key) —  `links` 脚本使用的Metadata。
{==+==}

{==+==}
<a id="rustc-link-arg"></a>
#### `cargo:rustc-link-arg=FLAG`
{==+==}

{==+==}

{==+==}
The `rustc-link-arg` instruction tells Cargo to pass the [`-C link-arg=FLAG`
option][link-arg] to the compiler, but only when building supported targets
(benchmarks, binaries, `cdylib` crates, examples, and tests). Its usage is
highly platform specific. It is useful to set the shared library version or
linker script.
{==+==}
`rustc-link-arg` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建支持的目标(性能测试、二进制文件、 `cdylib` crate、示例和测试)时使用。
它的使用是高度平台化的。对设置共享库版本或链接器脚本很有用。
{==+==}

{==+==}
[link-arg]: ../../rustc/codegen-options/index.md#link-arg
{==+==}

{==+==}


{==+==}
<a id="rustc-link-arg-bin"></a>
#### `cargo:rustc-link-arg-bin=BIN=FLAG`
{==+==}

{==+==}


{==+==}
The `rustc-link-arg-bin` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building
the binary target with name `BIN`. Its usage is highly platform specific. It is useful
to set a linker script or other linker options.
{==+==}
`rustc-link-arg-bin` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建名称为 `BIN` 的二进制目标时使用。
它的用法与平台高度相关。对设置链接器脚本或其他链接器选项很有用。
{==+==}


{==+==}
<a id="rustc-link-arg-bins"></a>
#### `cargo:rustc-link-arg-bins=FLAG`
{==+==}

{==+==}


{==+==}
The `rustc-link-arg-bins` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building a
binary target. Its usage is highly platform specific. It is useful
to set a linker script or other linker options.
{==+==}
`rustc-link-arg-bins` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建二进制目标时使用。
它的用法与平台高度相关。对于设置链接器脚本或其他链接器选项很有用。
{==+==}

{==+==}
<a id="rustc-link-lib"></a>
#### `cargo:rustc-link-lib=LIB`
{==+==}

{==+==}

{==+==}
The `rustc-link-lib` instruction tells Cargo to link the given library using
the compiler's [`-l` flag][option-link]. This is typically used to link a
native library using [FFI].
{==+==}
`rustc-link-lib` 指令告诉 Cargo 使用编译器的 [`-l` flag][option-link] 来链接指定的库。
这通常用于使用 [FFI] 来链接本地库。
{==+==}


{==+==}
The `LIB` string is passed directly to rustc, so it supports any syntax that
`-l` does. \
Currently the full supported syntax for `LIB` is `[KIND[:MODIFIERS]=]NAME[:RENAME]`.
{==+==}
`LIB` 字符串是直接传递给rustc的，所以它支持 `-l` 的任何语法。
目前， `LIB` 支持的全部语法是 `[KIND[:MODIFIERS]=]NAME[:RENAME]` 。
{==+==}


{==+==}
The `-l` flag is only passed to the library target of the package, unless
there is no library target, in which case it is passed to all targets. This is
done because all other targets have an implicit dependency on the library
target, and the given library to link should only be included once. This means
that if a package has both a library and a binary target, the *library* has
access to the symbols from the given lib, and the binary should access them
through the library target's public API.
{==+==}
`-l` 标志只传递给包的库目标，除非没有库目标，在这种情况下它会传递给所有目标。
这样做是因为所有其他目标都隐含着对库目标的依赖，而要链接的库只应该包含一次。
这意味着，如果一个包有一个库和一个二进制目标，那么 *库* 可以访问给定lib的标识符，而二进制应该通过库目标的公共API来访问它们。
{==+==}


{==+==}
The optional `KIND` may be one of `dylib`, `static`, or `framework`. See the
[rustc book][option-link] for more detail.
{==+==}
可选的 `KIND` 可以是 `dylib` 、 `static` 或` framework` 之一。
更多细节见 [rustc book][option-link] 。
{==+==}


{==+==}
[option-link]: ../../rustc/command-line-arguments.md#option-l-link-lib
[FFI]: ../../nomicon/ffi.md
{==+==}

{==+==}

{==+==}
<a id="rustc-link-arg-tests"></a>
#### `cargo:rustc-link-arg-tests=FLAG`
{==+==}

{==+==}

{==+==}
The `rustc-link-arg-tests` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building a
tests target.
{==+==}
`rustc-link-arg-tests` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建测试目标时使用。
{==+==}


{==+==}
<a id="rustc-link-arg-examples"></a>
#### `cargo:rustc-link-arg-examples=FLAG`
{==+==}

{==+==}


{==+==}
The `rustc-link-arg-examples` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building an examples
target.
{==+==}
`rustc-link-arg-examples` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建实例目标时传递。
{==+==}


{==+==}
<a id="rustc-link-arg-benches"></a>
#### `cargo:rustc-link-arg-benches=FLAG`
{==+==}

{==+==}


{==+==}
The `rustc-link-arg-benches` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building an benchmark
target.
{==+==}
`rustc-link-arg-benches` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建性能测试目标时使用。
{==+==}


{==+==}
<a id="rustc-link-search"></a>
#### `cargo:rustc-link-search=[KIND=]PATH`
{==+==}

{==+==}


{==+==}
The `rustc-link-search` instruction tells Cargo to pass the [`-L`
flag][option-search] to the compiler to add a directory to the library search
path.
{==+==}
`rustc-link-search` 指令告诉Cargo将 [`-L` flag][option-search] 传递给编译器，在库搜索路径中添加一个目录。
{==+==}


{==+==}
The optional `KIND` may be one of `dependency`, `crate`, `native`,
`framework`, or `all`. See the [rustc book][option-search] for more detail.
{==+==}
可选的 `KIND` 可以是 `dependency` 、 `crate` 、 `native` 、 `framework` 、 `all` 之一。更多细节见 [rustc book][option-search] 。
{==+==}

{==+==}
These paths are also added to the [dynamic library search path environment
variable](environment-variables.md#dynamic-library-paths) if they are within
the `OUT_DIR`. Depending on this behavior is discouraged since this makes it
difficult to use the resulting binary. In general, it is best to avoid
creating dynamic libraries in a build script (using existing system libraries
is fine).
{==+==}
如果这些路径在 `OUT_DIR` 内，它们也会被添加到 [动态库搜索路径环境变量](environment-variables.md#dynamic-library-paths) 。
不鼓励依赖这种行为，因为这使得，使用产生的二进制文件很困难。一般来说，最好避免在构建脚本中创建动态库(使用现有的系统库就可以了)。
{==+==}



{==+==}
[option-search]: ../../rustc/command-line-arguments.md#option-l-search-path
{==+==}

{==+==}


{==+==}
<a id="rustc-flags"></a>
#### `cargo:rustc-flags=FLAGS`
{==+==}

{==+==}


{==+==}
The `rustc-flags` instruction tells Cargo to pass the given space-separated
flags to the compiler. This only allows the `-l` and `-L` flags, and is
equivalent to using [`rustc-link-lib`](#rustc-link-lib) and
[`rustc-link-search`](#rustc-link-search).
{==+==}
`rustc-flags` 指令告诉Cargo将给定的以空格分隔的标志传递给编译器。
只允许使用 `-l `和 `-L` 标志，相当于使用 [`rustc-link-lib`](#rustc-link-lib) 和 [`rustc-link-search`](#rustc-link-search) 。
{==+==}


{==+==}
<a id="rustc-cfg"></a>
#### `cargo:rustc-cfg=KEY[="VALUE"]`
{==+==}

{==+==}


{==+==}
The `rustc-cfg` instruction tells Cargo to pass the given value to the
[`--cfg` flag][option-cfg] to the compiler. This may be used for compile-time
detection of features to enable [conditional compilation].
{==+==}
`rustc-cfg` 指令告诉Cargo将给定的[`--cfg` flag][option-cfg] 的值传递给编译器。
这可用于编译时检测功能，以启用 [条件编译] 。
{==+==}

{==+==}
Note that this does *not* affect Cargo's dependency resolution. This cannot be
used to enable an optional dependency, or enable other Cargo features.
{==+==}
请注意，这并 *不* 影响Cargo的依赖解析。
这不能用来启用一个可选的依赖，或启用其他Cargo特性。
{==+==}

{==+==}
Be aware that [Cargo features] use the form `feature="foo"`. `cfg` values
passed with this flag are not restricted to that form, and may provide just a
single identifier, or any arbitrary key/value pair. For example, emitting
`cargo:rustc-cfg=abc` will then allow code to use `#[cfg(abc)]` (note the lack
of `feature=`). Or an arbitrary key/value pair may be used with an `=` symbol
like `cargo:rustc-cfg=my_component="foo"`. The key should be a Rust
identifier, the value should be a string.
{==+==}
请注意，[Cargo features]使用的是 `feature="foo"` 的形式。
用这个标志传递的 `cfg` 值不限于这种形式，可以只提供一个标识符，或任意的键值对。例如，发送 `cargo:rustc-cfg=abc` 将允许代码使用 `#[cfg(abc)]` (注意缺少 `feature=` )。
或者可以使用一个任意的键值对与一个 `=` 号，如`cargo:rustc-cfg=my_component="foo"`。
键应该是一个Rust标识符，值应该是一个字符串。
{==+==}

{==+==}
[cargo features]: features.md
[conditional compilation]: ../../reference/conditional-compilation.md
[option-cfg]: ../../rustc/command-line-arguments.md#option-cfg
{==+==}
[cargo features]: features.md
[条件编译]: ../../reference/conditional-compilation.md
[option-cfg]: ../../rustc/command-line-arguments.md#option-cfg
{==+==}


{==+==}
<a id="rustc-env"></a>
#### `cargo:rustc-env=VAR=VALUE`
{==+==}

{==+==}


{==+==}
The `rustc-env` instruction tells Cargo to set the given environment variable
when compiling the package. The value can be then retrieved by the [`env!`
macro][env-macro] in the compiled crate. This is useful for embedding
additional metadata in crate's code, such as the hash of git HEAD or the
unique identifier of a continuous integration server.
{==+==}
`rustc-env` 指令告诉Cargo在编译包的时候设置指定的环境变量。
然后可以通过编译后的crate中的[`env!` macro][env-macro]来检索该值。
这对于在crate的代码中嵌入额外的元数据很有用，例如git HEAD的哈希值或持续集成服务器的唯一标识符。
{==+==}


{==+==}
See also the [environment variables automatically included by
Cargo][env-cargo].
{==+==}
参阅 [Cargo自动包含环境变量][env-cargo]。
{==+==}


{==+==}
> **Note**: These environment variables are also set when running an
> executable with `cargo run` or `cargo test`. However, this usage is
> discouraged since it ties the executable to Cargo's execution environment.
> Normally, these environment variables should only be checked at compile-time
> with the `env!` macro.
{==+==}
> **注意**: 当用 `cargo run` 或 `cargo test` 运行可执行文件时，也会设置这些环境变量。
> 然而，不鼓励这种用法，因为它将可执行文件与Cargo的执行环境关联在一起。
> 通常情况下，这些环境变量应该只在编译时用 `env!` 宏来检查。
{==+==}


{==+==}
[env-macro]: ../../std/macro.env.html
[env-cargo]: environment-variables.md#environment-variables-cargo-sets-for-crates
{==+==}

{==+==}


{==+==}
<a id="rustc-cdylib-link-arg"></a>
#### `cargo:rustc-cdylib-link-arg=FLAG`
{==+==}

{==+==}


{==+==}
The `rustc-cdylib-link-arg` instruction tells Cargo to pass the [`-C
link-arg=FLAG` option][link-arg] to the compiler, but only when building a
`cdylib` library target. Its usage is highly platform specific. It is useful
to set the shared library version or the runtime-path.
{==+==}
`rustc-dylib-link-arg` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建 `cdylib` 库目标时使用。
它的使用是高度平台特定的。对于设置共享库的版本或运行时路径很有用。
{==+==}

{==+==}
<a id="cargo-warning"></a>
#### `cargo:warning=MESSAGE`
{==+==}

{==+==}


{==+==}
The `warning` instruction tells Cargo to display a warning after the build
script has finished running. Warnings are only shown for `path` dependencies
(that is, those you're working on locally), so for example warnings printed
out in [crates.io] crates are not emitted by default. The `-vv` "very verbose"
flag may be used to have Cargo display warnings for all crates.
{==+==}
`warning` 指令告诉Cargo在构建脚本运行完毕后显示一个警告。
警告只针对 `path` 依赖(也就是你在本地的那些依赖)，所以比如在[crates.io]crate中打印出来的警告，默认是不会发送的。
`-vv` "very verbose" 标志可以用来让Cargo显示所有crate的警告。
{==+==}


{==+==}
### Build Dependencies
{==+==}
### 构建依赖
{==+==}

{==+==}
Build scripts are also allowed to have dependencies on other Cargo-based crates.
Dependencies are declared through the `build-dependencies` section of the
manifest.
{==+==}
构建脚本也可以依赖其他基于Cargo的crate。
依赖是通过配置清单中的 `build-dependencies` 部分来声明的。
{==+==}

{==+==}
```toml
[build-dependencies]
cc = "1.0.46"
```
{==+==}

{==+==}


{==+==}
The build script **does not** have access to the dependencies listed in the
`dependencies` or `dev-dependencies` section (they’re not built yet!). Also,
build dependencies are not available to the package itself unless also
explicitly added in the `[dependencies]` table.
{==+==}
构建脚本 *不* 访问列在 `dependencies` 或 `dev-dependencies` 部分的依赖项(它们还没有被构建！)。
另外，除非在 `[dependencies]` 表中明确添加，否则构建的依赖项对包本身是不可用的。
{==+==}


{==+==}
It is recommended to carefully consider each dependency you add, weighing
against the impact on compile time, licensing, maintenance, etc. Cargo will
attempt to reuse a dependency if it is shared between build dependencies and
normal dependencies. However, this is not always possible, for example when
cross-compiling, so keep that in consideration of the impact on compile time.
{==+==}
建议仔细考虑你添加的每个依赖，权衡对编译时间、许可、维护等的影响。
如果一个依赖是在构建依赖和正常依赖之间共享的，Cargo会尝试重用它。然而，这并不总是能用，例如在交叉编译时，所以要考虑到对编译时间的影响。
{==+==}


{==+==}
### Change Detection
{==+==}
### 变化检测
{==+==}


{==+==}
When rebuilding a package, Cargo does not necessarily know if the build script
needs to be run again. By default, it takes a conservative approach of always
re-running the build script if any file within the package is changed (or the
list of files controlled by the [`exclude` and `include` fields]). For most
cases, this is not a good choice, so it is recommended that every build script
emit at least one of the `rerun-if` instructions (described below). If these
are emitted, then Cargo will only re-run the script if the given value has
changed. If Cargo is re-running the build scripts of your own crate or a
dependency and you don't know why, see ["Why is Cargo rebuilding my code?" in the
FAQ](../faq.md#why-is-cargo-rebuilding-my-code).
{==+==}
当重建包时，Cargo不一定知道是否需要再次运行构建脚本。
默认情况下，它采取一种保守的方法，即如果包中的任意文件被改变(或由 [`exclude` 和 `include` 字段] 控制的文件列表被改变)，则总是重新运行构建脚本。
在大多数情况下，这不是一个好的选择，所以建议每个构建脚本至少发出一个 `rerun-if` 指令(如下所述)。
如果发出了这些指令，那么Cargo只会在给定值发生变化时重新运行脚本。
如果Cargo重新运行你自己的crate或依赖的构建脚本，而你又不知道为什么，请参见FAQ中的["为什么Cargo要重新构建我的代码？"](.../faq.md#why-is-cargo-rebuilding-my-code)。
{==+==}

{==+==}
[`exclude` and `include` fields]: manifest.md#the-exclude-and-include-fields
{==+==}
[`exclude` 和 `include` 字段]: manifest.md#the-exclude-and-include-fields
{==+==}

{==+==}
<a id="rerun-if-changed"></a>
#### `cargo:rerun-if-changed=PATH`
{==+==}

{==+==}

{==+==}
The `rerun-if-changed` instruction tells Cargo to re-run the build script if
the file at the given path has changed. Currently, Cargo only uses the
filesystem last-modified "mtime" timestamp to determine if the file has
changed. It compares against an internal cached timestamp of when the build
script last ran.
{==+==}
`rerun-if-changed` 指令告诉Cargo在指定路径的文件发生变化时重新运行构建脚本。
目前，Cargo只使用文件系统最后修改的 "mtime" 时间戳来确定文件是否有变化。
它与内部缓存的构建脚本最后运行的时间戳进行比较。
{==+==}


{==+==}
If the path points to a directory, it will scan the entire directory for
any modifications.
{==+==}
如果路径指向一个目录，它将扫描整个目录的任何修改。
{==+==}


{==+==}
If the build script inherently does not need to re-run under any circumstance,
then emitting `cargo:rerun-if-changed=build.rs` is a simple way to prevent it
from being re-run (otherwise, the default if no `rerun-if` instructions are
emitted is to scan the entire package directory for changes). Cargo
automatically handles whether or not the script itself needs to be recompiled,
and of course the script will be re-run after it has been recompiled.
Otherwise, specifying `build.rs` is redundant and unnecessary.
{==+==}
如果构建脚本在任何情况下都不需要重新运行，那么发送 `cargo:rerun-if-changed=build.rs` 防止其重新运行(否则，如果没有发送 `rerun-if` 指令，则默认为扫描整个包目录的变化)。
Cargo会自动处理脚本本身是否需要重新编译，当然，脚本在重新编译后会重新运行。否则，没有必要指定 `build.rs` 。
{==+==}


{==+==}
<a id="rerun-if-env-changed"></a>
#### `cargo:rerun-if-env-changed=NAME`
{==+==}

{==+==}


{==+==}
The `rerun-if-env-changed` instruction tells Cargo to re-run the build script
if the value of an environment variable of the given name has changed.
{==+==}
`rerun-if-env-changed` 指令告诉Cargo，如果给定名称的环境变量值发生变化，则重新运行构建脚本。
{==+==}


{==+==}
Note that the environment variables here are intended for global environment
variables like `CC` and such, it is not necessary to use this for environment
variables like `TARGET` that Cargo sets.
{==+==}
注意，这里的环境变量是针对全局环境变量如 `CC` 之类的，对于Cargo设置的 `TARGET` 之类的环境变量没有必要使用这个。
{==+==}


{==+==}
### The `links` Manifest Key
{==+==}
### `links` 配置清单Key
{==+==}

{==+==}
The `package.links` key may be set in the `Cargo.toml` manifest to declare
that the package links with the given native library. The purpose of this
manifest key is to give Cargo an understanding about the set of native
dependencies that a package has, as well as providing a principled system of
passing metadata between package build scripts.
{==+==}
`package.links` 键可以在 `Cargo.toml` 清单中设置，以声明该包与给定的本地库相链接。
这个清单键的目的是让Cargo了解一个包的本地依赖，以及提供在包构建脚本之间传递元数据的有条理的系统。
{==+==}


{==+==}
```toml
[package]
# ...
links = "foo"
```
{==+==}

{==+==}


{==+==}
This manifest states that the package links to the `libfoo` native library.
When using the `links` key, the package must have a build script, and the
build script should use the [`rustc-link-lib` instruction](#rustc-link-lib) to
link the library.
{==+==}
该清单表明，该包链接到 `libfoo` 本地库。
当使用 `links` 键时，包必须有一个构建脚本，而构建脚本应该使用 [`rustc-link-lib`指令](#rustc-link-lib) 来链接该库。
{==+==}


{==+==}
Primarily, Cargo requires that there is at most one package per `links` value.
In other words, it is forbidden to have two packages link to the same native
library. This helps prevent duplicate symbols between crates. Note, however,
that there are [conventions in place](#-sys-packages) to alleviate this.
{==+==}
主要的是，Cargo要求每个 `links` 值最多只能有一个包。
换句话说，禁止让两个包链接到同一个本地库。
这有助于防止crate之间的重复符号。注意，有一些[已有的惯例](#-sys-packages)可以缓解这个问题。
{==+==}


{==+==}
As mentioned above in the output format, each build script can generate an
arbitrary set of metadata in the form of key-value pairs. This metadata is
passed to the build scripts of **dependent** packages. For example, if the
package `bar` depends on `foo`, then if `foo` generates `key=value` as part of
its build script metadata, then the build script of `bar` will have the
environment variables `DEP_FOO_KEY=value`. See the ["Using another `sys`
crate"][using-another-sys] for an example of
how this can be used.
{==+==}
如上文在输出格式中提到的，每个构建脚本可以以键值对的形式生成一组任意的元数据。
这些元数据被传递给 **依赖的** 包的构建脚本。
例如，如果包 `bar` 依赖于 `foo` ，那么如果 `foo` 生成 `key=value` 作为其构建脚本元数据的一部分，那么 `bar` 的构建脚本将有 `DEP_FOO_KEY=value` 的环境变量。
参见 ["使用另一个 `sys` crate"][using-another-sys]，以了解如何使用这个例子。
{==+==}


{==+==}
Note that metadata is only passed to immediate dependents, not transitive
dependents.
{==+==}
请注意，元数据只传递给直接依赖，而不传递给过渡依赖。
{==+==}


{==+==}
[using-another-sys]: build-script-examples.md#using-another-sys-crate
{==+==}

{==+==}


{==+==}
### `*-sys` Packages
{==+==}
### `*-sys` 包
{==+==}

{==+==}
Some Cargo packages that link to system libraries have a naming convention of
having a `-sys` suffix. Any package named `foo-sys` should provide two major
pieces of functionality:
{==+==}
一些链接到系统库的Cargo包有后缀为 `-sys` 的命名惯例。
任何名为 `foo-sys` 的包都应该提供两个主要功能:
{==+==}

{==+==}
* The library crate should link to the native library `libfoo`. This will often
  probe the current system for `libfoo` before resorting to building from
  source.
* The library crate should provide **declarations** for types and functions in
  `libfoo`, but **not** higher-level abstractions.
{==+==}
* 库crate应该链接到本地库 `libfoo` 。这通常会在从源代码构建之前探测当前系统中的 `libfoo` 。
* 这个库应该为 `libfoo` 中的类型和函数提供 **声明**，而**不是**更高级别的抽象。
{==+==}


{==+==}
The set of `*-sys` packages provides a common set of dependencies for linking
to native libraries. There are a number of benefits earned from having this
convention of native-library-related packages:
{==+==}
`*-sys` 包的集合为连接本地库提供了通用的依赖。
有了这个本地库相关包的惯例，带来许多好处。
{==+==}


{==+==}
* Common dependencies on `foo-sys` alleviates the rule about one package per
  value of `links`.
* Other `-sys` packages can take advantage of the `DEP_NAME_KEY=value`
  environment variables to better integrate with other packages. See the
  ["Using another `sys` crate"][using-another-sys] example.
* A common dependency allows centralizing logic on discovering `libfoo` itself
  (or building it from source).
* These dependencies are easily [overridable](#overriding-build-scripts).
{==+==}
* 对 `foo-sys` 的共同依赖简便了对于每个 `links` 值一个包的规则。
* 其他 `sys` 包可以利用 `DEP_NAME_KEY=value` 环境变量的优势，更好地与其他包集成。参见 ["使用另一个 `sys` crate"][using-another-sys] 例子。
* 一个共同的依赖允许将逻辑集中在发现 `libfoo` 本身(或从源代码构建它)。
* 这些依赖很容易被 [覆盖](#overriding-build-scripts) 。
{==+==}

{==+==}
It is common to have a companion package without the `-sys` suffix that
provides a safe, high-level abstractions on top of the sys package. For
example, the [`git2` crate] provides a high-level interface to the
[`libgit2-sys` crate].
{==+==}
通常会有一个没有 `-sys` 后缀的配套包，在sys包的基础上提供安全的高级抽象。
例如，[`git2` crate] 为 [`libgit2-sys` crate] 提供了一个高级接口。
{==+==}


{==+==}
[`git2` crate]: https://crates.io/crates/git2
[`libgit2-sys` crate]: https://crates.io/crates/libgit2-sys
{==+==}

{==+==}


{==+==}
### Overriding Build Scripts
{==+==}
### 覆盖构建脚本
{==+==}

{==+==}
If a manifest contains a `links` key, then Cargo supports overriding the build
script specified with a custom library. The purpose of this functionality is to
prevent running the build script in question altogether and instead supply the
metadata ahead of time.
{==+==}
如果配置清单中包含 `links` 键，那么Cargo支持用自定义库覆盖指定的构建脚本。
这一功能的目的是为了防止完全运行相关的构建脚本，而是提前提供元数据。
{==+==}

{==+==}
To override a build script, place the following configuration in any acceptable [`config.toml`](config.md) file.
{==+==}
要覆盖一个构建脚本，在任意允许的 [`config.toml`](config.md) 文件中放置以下配置。
{==+==}


{==+==}
```toml
[target.x86_64-unknown-linux-gnu.foo]
rustc-link-lib = ["foo"]
rustc-link-search = ["/path/to/foo"]
rustc-flags = "-L /some/path"
rustc-cfg = ['key="value"']
rustc-env = {key = "value"}
rustc-cdylib-link-arg = ["…"]
metadata_key1 = "value"
metadata_key2 = "value"
```
{==+==}

{==+==}


{==+==}
With this configuration, if a package declares that it links to `foo` then the
build script will **not** be compiled or run, and the metadata specified will
be used instead.
{==+==}
在这种配置下，如果包声明它链接到 `foo` ，那么构建脚本将 **不** 被编译或运行，而将使用指定的元数据。
{==+==}

{==+==}
The `warning`, `rerun-if-changed`, and `rerun-if-env-changed` keys should not
be used and will be ignored.
{==+==}
不应使用 `warning` 、 `rerun-if-changed` 和 `rerun-if-env-changed` 键，将忽略它们。
{==+==}

{==+==}
### Jobserver
{==+==}

{==+==}


{==+==}
Cargo and `rustc` use the [jobserver protocol], developed for GNU make, to
coordinate concurrency across processes. It is essentially a semaphore that
controls the number of jobs running concurrently. The concurrency may be set
with the `--jobs` flag, which defaults to the number of logical CPUs.
{==+==}
Cargo和 `rustc` 使用为GNU制作开发的[jobserver 协议]来协调进程间的并发。
它本质上是信号，控制同时运行的作业数量。
并发性可以用 `--jobs` 标志来设置，默认为逻辑CPU的数量。
{==+==}


{==+==}
Each build script inherits one job slot from Cargo, and should endeavor to
only use one CPU while it runs. If the script wants to use more CPUs in
parallel, it should use the [`jobserver` crate] to coordinate with Cargo.
{==+==}
每个构建脚本都从Cargo那里继承一个作业槽，并试图运行时只使用一个CPU。
如果脚本想并行使用更多的CPU，应该使用[`jobserver` crate]来与Cargo协调。
{==+==}

{==+==}
As an example, the [`cc` crate] may enable the optional `parallel` feature
which will use the jobserver protocol to attempt to build multiple C files
at the same time.
{==+==}
举例来说，[`cc` crate] 可以启用可选的 `parallel` 特性，它将使用jobserver协议尝试同时构建多个C文件。
{==+==}

{==+==}
[`cc` crate]: https://crates.io/crates/cc
[`jobserver` crate]: https://crates.io/crates/jobserver
[jobserver protocol]: http://make.mad-scientist.net/papers/jobserver-implementation/
[crates.io]: https://crates.io/
{==+==}
[`cc` crate]: https://crates.io/crates/cc
[`jobserver` crate]: https://crates.io/crates/jobserver
[jobserver 协议]: http://make.mad-scientist.net/papers/jobserver-implementation/
[crates.io]: https://crates.io/
{==+==}