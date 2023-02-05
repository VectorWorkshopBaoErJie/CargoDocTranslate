{==+==}
## Build Script Examples
{==+==}
## 构建脚本示例
{==+==}


{==+==}
The following sections illustrate some examples of writing build scripts.
{==+==}
下面小节是一些编写的构建脚本的举例。
{==+==}


{==+==}
Some common build script functionality can be found via crates on [crates.io].
Check out the [`build-dependencies`
keyword](https://crates.io/keywords/build-dependencies) to see what is
available. The following is a sample of some popular crates[^†]:
{==+==}
通过 [crates.io] 中的crate，能找到一些构建脚本的常见功能。
查看 [`build-dependencies` 键](https://crates.io/keywords/build-dependencies)，看看有那些可用。
下面是一些流行的 crates[^†] 示例:
{==+==}


{==+==}
* [`bindgen`](https://crates.io/crates/bindgen) — Automatically generate Rust
  FFI bindings to C libraries.
* [`cc`](https://crates.io/crates/cc) — Compiles C/C++/assembly.
* [`pkg-config`](https://crates.io/crates/pkg-config) — Detect system
  libraries using the `pkg-config` utility.
* [`cmake`](https://crates.io/crates/cmake) — Runs the `cmake` build tool to build a native library.
* [`autocfg`](https://crates.io/crates/autocfg),
  [`rustc_version`](https://crates.io/crates/rustc_version),
  [`version_check`](https://crates.io/crates/version_check) — These crates
  provide ways to implement conditional compilation based on the current
  `rustc` such as the version of the compiler.
{==+==}
* [`bindgen`](https://crates.io/crates/bindgen) — 自动生成Rust FFI与C库的绑定。
* [`cc`](https://crates.io/crates/cc) — 编译 C/C++/assembly 。
* [`pkg-config`](https://crates.io/crates/pkg-config) — 使用 `pkg-config` 工具检测系统库。
* [`cmake`](https://crates.io/crates/cmake) — 运行 `cmake` 构建工具来构建一个本地库。
* [`autocfg`](https://crates.io/crates/autocfg),
  [`rustc_version`](https://crates.io/crates/rustc_version),
  [`version_check`](https://crates.io/crates/version_check) — 这些crates提供了基于当前 `rustc` (如编译器的版本) 实现条件编译的方法。
{==+==}


{==+==}
[^†]: This list is not an endorsement. Evaluate your dependencies to see which
is right for your project.
{==+==}
[^†]: 这个列表并不是一种宣传，你需要评估依赖，选择更适合你的项目。
{==+==}


{==+==}
### Code generation
{==+==}
### Code 生成
{==+==}


{==+==}
Some Cargo packages need to have code generated just before they are compiled
for various reasons. Here we’ll walk through a simple example which generates a
library call as part of the build script.
{==+==}
由于各种原因，有些Cargo包在编译前需要生成代码。
在这里，通过一个简单的例子，生成一个库，作为构建脚本的一部分调用。
{==+==}


{==+==}
First, let’s take a look at the directory structure of this package:
{==+==}
首先，来看一下这个包的目录结构:
{==+==}


{==+==}
```text
.
├── Cargo.toml
├── build.rs
└── src
    └── main.rs

1 directory, 3 files
```
{==+==}

{==+==}


{==+==}
Here we can see that we have a `build.rs` build script and our binary in
`main.rs`. This package has a basic manifest:
{==+==}
可以看到，有一个 `build.rs` 构建脚本和 `main.rs` 二进制文件。这个包有一个基本的配置清单:
{==+==}


{==+==}
```toml
# Cargo.toml

[package]
name = "hello-from-generated-code"
version = "0.1.0"
edition = "2021"
```
{==+==}

{==+==}


{==+==}
Let’s see what’s inside the build script:
{==+==}
来看看构建脚本里面有什么内容:
{==+==}


{==+==}
```rust,no_run
// build.rs

use std::env;
use std::fs;
use std::path::Path;

fn main() {
    let out_dir = env::var_os("OUT_DIR").unwrap();
    let dest_path = Path::new(&out_dir).join("hello.rs");
    fs::write(
        &dest_path,
        "pub fn message() -> &'static str {
            \"Hello, World!\"
        }
        "
    ).unwrap();
    println!("cargo:rerun-if-changed=build.rs");
}
```
{==+==}

{==+==}


{==+==}
There’s a couple of points of note here:
{==+==}
这里有几个值得注意的地方:
{==+==}


{==+==}
* The script uses the `OUT_DIR` environment variable to discover where the
  output files should be located. It can use the process’ current working
  directory to find where the input files should be located, but in this case we
  don’t have any input files.
{==+==}
* 脚本使用 `OUT_DIR` 环境变量来发现输出文件的位置。
  它可以使用进程的当前工作目录来寻找输入文件的位置，但在当前情况下我们没有任何输入文件。
{==+==}


{==+==}
* In general, build scripts should not modify any files outside of `OUT_DIR`.
  It may seem fine on the first blush, but it does cause problems when you use
  such crate as a dependency, because there's an *implicit* invariant that
  sources in `.cargo/registry` should be immutable. `cargo` won't allow such
  scripts when packaging.
{==+==}
* 一般来说，构建脚本不应该修改 `OUT_DIR` 以外的任何文件。
  乍一看，这似乎没什么问题，但当你使用这样的crate作为依赖时，却会产生问题，因为 *implicit* "隐式"不变性，即 `.cargo/registry` 中的源码应该是不可改变的。 `cargo` 在打包时不允许这样的脚本。
{==+==}


{==+==}
* This script is relatively simple as it just writes out a small generated file.
  One could imagine that other more fanciful operations could take place such as
  generating a Rust module from a C header file or another language definition,
  for example.
{==+==}
* 这个脚本相对简单，因为它只是写生成了一个小的文件。
  可以想象，还可以进行其他更多有趣的操作，例如从C头文件或其他语言定义中生成一个Rust模块。
{==+==}


{==+==}
* The [`rerun-if-changed` instruction](build-scripts.md#rerun-if-changed)
  tells Cargo that the build script only needs to re-run if the build script
  itself changes. Without this line, Cargo will automatically run the build
  script if any file in the package changes. If your code generation uses some
  input files, this is where you would print a list of each of those files.
{==+==}
* [`rerun-if-changed` instruction](build-scripts.md#rerun-if-changed) 告知Cargo，只有当构建脚本本身发生变化时才需要重新运行构建脚本。
  如果没有这一行，Cargo会在包中的任何文件发生变化时自动运行构建脚本。
  如果你的代码生成使用了一些输入文件，这里就应是你要打印每个文件列表的地方。
{==+==}


{==+==}
Next, let’s peek at the library itself:
{==+==}
接下来，来看一下库本身:
{==+==}


{==+==}
```rust,ignore
// src/main.rs

include!(concat!(env!("OUT_DIR"), "/hello.rs"));

fn main() {
    println!("{}", message());
}
```
{==+==}

{==+==}


{==+==}
This is where the real magic happens. The library is using the rustc-defined
[`include!` macro][include-macro] in combination with the
[`concat!`][concat-macro] and [`env!`][env-macro] macros to include the
generated file (`hello.rs`) into the crate’s compilation.
{==+==}
这就是真正奇妙的地方。该库使用rustc定义的 [`include!` macro][include-macro] 与 [`concat!`][concat-macro] 和 [`env!`][env-macro] 宏相结合，将生成的文件(`hello.rs`)纳入crate的编译。
{==+==}


{==+==}
Using the structure shown here, crates can include any number of generated files
from the build script itself.
{==+==}
使用这里展示的结构，crate可以include来自构建脚本所生成的任意数量的文件。
{==+==}


{==+==}
[include-macro]: ../../std/macro.include.html
[concat-macro]: ../../std/macro.concat.html
[env-macro]: ../../std/macro.env.html
{==+==}

{==+==}


{==+==}
### Building a native library
{==+==}
### 构建本地库
{==+==}


{==+==}
Sometimes it’s necessary to build some native C or C++ code as part of a
package. This is another excellent use case of leveraging the build script to
build a native library before the Rust crate itself. As an example, we’ll create
a Rust library which calls into C to print “Hello, World!”.
{==+==}
有时有必要将一些本地C或C++代码作为包的一部分来构建。
这是利用构建脚本在Rust crate本身之前构建本地库的另一个很好的用例。
作为例子，我们将创建一个Rust库，调用C语言来打印 “Hello, World!” 。
{==+==}


{==+==}
Like above, let’s first take a look at the package layout:
{==+==}
像上面一样，来先看一下包的层次:
{==+==}


{==+==}
```text
.
├── Cargo.toml
├── build.rs
└── src
    ├── hello.c
    └── main.rs

1 directory, 4 files
```
{==+==}

{==+==}


{==+==}
Pretty similar to before! Next, the manifest:
{==+==}
与上面的相似，以下是配置清单:
{==+==}


{==+==}
```toml
# Cargo.toml

[package]
name = "hello-world-from-c"
version = "0.1.0"
edition = "2021"
```
{==+==}

{==+==}


{==+==}
For now we’re not going to use any build dependencies, so let’s take a look at
the build script now:
{==+==}
现在我们不打算使用任何构建依赖，先来看一下构建脚本:
{==+==}


{==+==}
```rust,no_run
// build.rs

use std::process::Command;
use std::env;
use std::path::Path;

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
{==+==}

{==+==}


{==+==}
    // Note that there are a number of downsides to this approach, the comments
    // below detail how to improve the portability of these commands.
{==+==}
    // 注意，这种方法有一些缺点，下面的注解详细说明了如何提高这些命令的可移植性。
{==+==}


{==+==}
    Command::new("gcc").args(&["src/hello.c", "-c", "-fPIC", "-o"])
                       .arg(&format!("{}/hello.o", out_dir))
                       .status().unwrap();
    Command::new("ar").args(&["crus", "libhello.a", "hello.o"])
                      .current_dir(&Path::new(&out_dir))
                      .status().unwrap();

    println!("cargo:rustc-link-search=native={}", out_dir);
    println!("cargo:rustc-link-lib=static=hello");
    println!("cargo:rerun-if-changed=src/hello.c");
}
```
{==+==}

{==+==}


{==+==}
This build script starts out by compiling our C file into an object file (by
invoking `gcc`) and then converting this object file into a static library (by
invoking `ar`). The final step is feedback to Cargo itself to say that our
output was in `out_dir` and the compiler should link the crate to `libhello.a`
statically via the `-l static=hello` flag.
{==+==}
这个编译脚本首先将C文件编译成object文件(通过调用`gcc`)，然后将这个object文件转换为静态库 (通过调用 `ar` )。
最后一步是反馈给Cargo本身，告知输出在 `out_dir` ，编译器应该通过 `-l static=hello` 标志将crate静态链接到 `libhello.a` 。
{==+==}


{==+==}
Note that there are a number of drawbacks to this hard-coded approach:
{==+==}
注意，这种硬编码的方法有很多缺点:
{==+==}


{==+==}
* The `gcc` command itself is not portable across platforms. For example it’s
  unlikely that Windows platforms have `gcc`, and not even all Unix platforms
  may have `gcc`. The `ar` command is also in a similar situation.
* These commands do not take cross-compilation into account. If we’re cross
  compiling for a platform such as Android it’s unlikely that `gcc` will produce
  an ARM executable.
{==+==}
* `gcc` 命令本身不能跨平台移植。例如，Windows平台不太可能有 `gcc` ，甚至不是所有Unix平台都可能有 `gcc` 。 `ar` 命令也是类似的情况。
* 这些命令没有考虑到交叉编译的问题。如果为Android这样的平台进行交叉编译，那么 `gcc` 不太可能产生ARM的可执行文件。
{==+==}


{==+==}
Not to fear, though, this is where a `build-dependencies` entry would help!
The Cargo ecosystem has a number of packages to make this sort of task much
easier, portable, and standardized. Let's try the [`cc`
crate](https://crates.io/crates/cc) from [crates.io]. First, add it to the
`build-dependencies` in `Cargo.toml`:
{==+==}
不过不用担心，这时 `build-dependencies` 条目会有帮助。Cargo生态系统有许多包，可以使这种任务变得更容易、便携、标准。
试试 [crates.io] 的 [`cc` crate](https://crates.io/crates/cc) 。首先，把它添加到 `Cargo.toml` 的 `build-dependencies` 中。
{==+==}


{==+==}
```toml
[build-dependencies]
cc = "1.0"
```
{==+==}

{==+==}


{==+==}
And rewrite the build script to use this crate:
{==+==}
并重写构建脚本以使用这个crate:
{==+==}


{==+==}
```rust,ignore
// build.rs

fn main() {
    cc::Build::new()
        .file("src/hello.c")
        .compile("hello");
    println!("cargo:rerun-if-changed=src/hello.c");
}
```
{==+==}

{==+==}


{==+==}
The [`cc` crate] abstracts a range of build script requirements for C code:
{==+==}
[`cc` crate] 抽象了一系列对C代码构建的脚本需求:
{==+==}


{==+==}
* It invokes the appropriate compiler (MSVC for windows, `gcc` for MinGW, `cc`
  for Unix platforms, etc.).
* It takes the `TARGET` variable into account by passing appropriate flags to
  the compiler being used.
* Other environment variables, such as `OPT_LEVEL`, `DEBUG`, etc., are all
  handled automatically.
* The stdout output and `OUT_DIR` locations are also handled by the `cc`
  library.
{==+==}
* 它调用适当的编译器 (MSVC用于Windows， `gcc` 用于MinGW， `cc` 用于Unix平台，等等)。
* 它通过向正在使用的编译器传递适当的标志，将 `TARGET` 变量考虑在内。
* 其他环境变量，如 `OPT_LEVEL` 、 `DEBUG` 等，都是自动处理的。
* 标准输出和 `OUT_DIR` 位置也由 `cc` 库处理。
{==+==}


{==+==}
Here we can start to see some of the major benefits of farming as much
functionality as possible out to common build dependencies rather than
duplicating logic across all build scripts!
{==+==}
在这里，可以看到将尽可能多的功能移植到共同的构建依赖中，而不是在所有的构建脚本中重复逻辑的一些主要好处。
{==+==}


{==+==}
Back to the case study though, let’s take a quick look at the contents of the
`src` directory:
{==+==}
回到示例研究，来快速看一下 `src` 目录的内容:
{==+==}


{==+==}
```c
// src/hello.c

#include <stdio.h>

void hello() {
    printf("Hello, World!\n");
}
```
{==+==}

{==+==}


{==+==}
```rust,ignore
// src/main.rs

// Note the lack of the `#[link]` attribute. We’re delegating the responsibility
// of selecting what to link over to the build script rather than hard-coding
// it in the source file.
extern { fn hello(); }

fn main() {
    unsafe { hello(); }
}
```
{==+==}
```rust,ignore
// src/main.rs

// 注意没有 `#[link]` 属性。把链接内容的责任交给了构建脚本，而不是在源文件中硬编码。
extern { fn hello(); }

fn main() {
    unsafe { hello(); }
}
```
{==+==}


{==+==}
And there we go! This should complete our example of building some C code from a
Cargo package using the build script itself. This also shows why using a build
dependency can be crucial in many situations and even much more concise!
{==+==}
那么好了! 这样就完成了从Cargo包中使用构建脚本本身构建一些C代码的例子。
这也说明为什么在很多情况下，使用构建依赖是非常关键的，甚至更加简洁!
{==+==}


{==+==}
We’ve also seen a brief example of how a build script can use a crate as a
dependency purely for the build process and not for the crate itself at runtime.
{==+==}
我们也看到这个简短的示例，说明构建脚本如何单纯将crate作为依赖，而不是在运行时将crate本身作为依赖。
{==+==}


{==+==}
[`cc` crate]: https://crates.io/crates/cc
{==+==}

{==+==}


{==+==}
### Linking to system libraries
{==+==}
### 链接到系统库
{==+==}


{==+==}
This example demonstrates how to link a system library and how the build
script is used to support this use case.
{==+==}
这个例子演示了如何链接系统库，以及如何支持使用构建脚本。
{==+==}


{==+==}
Quite frequently a Rust crate wants to link to a native library provided on
the system to bind its functionality or just use it as part of an
implementation detail. This is quite a nuanced problem when it comes to
performing this in a platform-agnostic fashion. It is best, if possible, to
farm out as much of this as possible to make this as easy as possible for
consumers.
{==+==}
很多时候，Rust crate想要链接到系统上提供的本地库，绑定其功能，或者只是将其作为实现细节的一部分。
当涉及到以一种平台无关的方式执行时，这是相当细微的问题。
最好的办法是，如果可能的话，尽可能多地把这部分工作交给别人去做，让使用者更轻松。
{==+==}


{==+==}
For this example, we will be creating a binding to the system's zlib library.
This is a library that is commonly found on most Unix-like systems that
provides data compression. This is already wrapped up in the [`libz-sys`
crate], but for this example, we'll do an extremely simplified version. Check
out [the source code][libz-source] for the full example.
{==+==}
对于这个例子，将创建一个与系统zlib库的绑定。
这是在大多数类Unix系统中常见的库，提供数据压缩。
这已经包含在 [`libz-sys` crate] 中了，但对于这个例子，我们将做一个极其简化的版本。请查看 [libz源码][libz-source] 以了解完整的用例。
{==+==}


{==+==}
To make it easy to find the location of the library, we will use the
[`pkg-config` crate]. This crate uses the system's `pkg-config` utility to
discover information about a library. It will automatically tell Cargo what is
needed to link the library. This will likely only work on Unix-like systems
with `pkg-config` installed. Let's start by setting up the manifest:
{==+==}
为了方便找到库的位置，我们将使用 [`pkg-config` crate] 。这个crate使用系统的 `pkg-config` 工具来发现库的信息。
它将自动告诉Cargo需要什么来链接这个库。这可能只能在安装了 `pkg-config` 的类Unix系统上工作。先从设置配置清单开始:
{==+==}


{==+==}
```toml
# Cargo.toml

[package]
name = "libz-sys"
version = "0.1.0"
edition = "2021"
links = "z"

[build-dependencies]
pkg-config = "0.3.16"
```
{==+==}

{==+==}


{==+==}
Take note that we included the `links` key in the `package` table. This tells
Cargo that we are linking to the `libz` library. See ["Using another sys
crate"](#using-another-sys-crate) for an example that will leverage this.
{==+==}
请注意，我们在 `package` 表中加入了 `links` 键。
这告知Cargo，正在链接到 `libz` 库。
请看 ["使用另一个系统crate"](#using-another-sys-crate) 中的例子，可以利用这点。
{==+==}


{==+==}
The build script is fairly simple:
{==+==}
构建脚本相当简单:
{==+==}


{==+==}
```rust,ignore
// build.rs

fn main() {
    pkg_config::Config::new().probe("zlib").unwrap();
    println!("cargo:rerun-if-changed=build.rs");
}
```
{==+==}

{==+==}


{==+==}
Let's round out the example with a basic FFI binding:
{==+==}
那么用基本的FFI绑定来完善这个例子:
{==+==}



{==+==}
```rust,ignore
// src/lib.rs

use std::os::raw::{c_uint, c_ulong};

extern "C" {
    pub fn crc32(crc: c_ulong, buf: *const u8, len: c_uint) -> c_ulong;
}

#[test]
fn test_crc32() {
    let s = "hello";
    unsafe {
        assert_eq!(crc32(0, s.as_ptr(), s.len() as c_uint), 0x3610a686);
    }
}
```
{==+==}

{==+==}



{==+==}
Run `cargo build -vv` to see the output from the build script. On a system
with `libz` already installed, it may look something like this:
{==+==}
运行 `cargo build -vv` 来查看构建脚本的输出。在已经安装了 `libz` 的系统上，可能看起来像这样:
{==+==}


{==+==}
```text
[libz-sys 0.1.0] cargo:rustc-link-search=native=/usr/lib
[libz-sys 0.1.0] cargo:rustc-link-lib=z
[libz-sys 0.1.0] cargo:rerun-if-changed=build.rs
```
{==+==}

{==+==}


{==+==}
Nice! `pkg-config` did all the work of finding the library and telling Cargo
where it is.
{==+==}
很好! `pkg-config` 做了所有寻找库的工作，并告知Cargo它的位置。
{==+==}


{==+==}
It is not unusual for packages to include the source for the library, and
build it statically if it is not found on the system, or if a feature or
environment variable is set. For example, the real [`libz-sys` crate] checks the
environment variable `LIBZ_SYS_STATIC` or the `static` feature to build it
from source instead of using the system library. Check out [the
source][libz-source] for a more complete example.
{==+==}
包包含库的源代码，如果在系统中找不到它，或者设置了某个特性或环境变量，就静态地构建它，这种情况并不罕见。
例如，实际的 [`libz-sys` crate] 检查环境变量 `LIBZ_SYS_STATIC` 或 `static` 特性，从源码构建而不是使用系统库。
请查看 [the source][libz-source] 以了解更完整的例子。
{==+==}


{==+==}
[`libz-sys` crate]: https://crates.io/crates/libz-sys
[`pkg-config` crate]: https://crates.io/crates/pkg-config
[libz-source]: https://github.com/rust-lang/libz-sys
{==+==}

{==+==}


{==+==}
### Using another `sys` crate
{==+==}
### 使用另一个 `sys` crate
{==+==}


{==+==}
When using the `links` key, crates may set metadata that can be read by other
crates that depend on it. This provides a mechanism to communicate information
between crates. In this example, we'll be creating a C library that makes use
of zlib from the real [`libz-sys` crate].
{==+==}
当使用 `links` 键时，crates可以设置metadata，其他依赖它的crates可以读取这些元数据。这提供了一种在crate之间通信的机制。
在这个例子中，我们将创建一个C语言库，利用实际的 [`libz-sys` crate] 中的zlib。
{==+==}


{==+==}
If you have a C library that depends on zlib, you can leverage the [`libz-sys`
crate] to automatically find it or build it. This is great for cross-platform
support, such as Windows where zlib is not usually installed. `libz-sys` [sets
the `include`
metadata](https://github.com/rust-lang/libz-sys/blob/3c594e677c79584500da673f918c4d2101ac97a1/build.rs#L156)
to tell other packages where to find the header files for zlib. Our build
script can read that metadata with the `DEP_Z_INCLUDE` environment variable.
Here's an example:
{==+==}
如果你有一个依赖于zlib的C库，你可以利用 [`libz-sys` crate] 来自动查找或构建它。这对于跨平台支持非常有用，比如在通常不安装zlib的Windows。
 `libz-sys` [设置 `include` 元数据](https://github.com/rust-lang/libz-sys/blob/3c594e677c79584500da673f918c4d2101ac97a1/build.rs#L156) ，告诉其他包在哪里可以找到zlib的头文件。
我们的构建脚本可以通过 `DEP_Z_INCLUDE` 环境变量读取该元数据。
下面是一个例子:
{==+==}


{==+==}
```toml
# Cargo.toml

[package]
name = "zuser"
version = "0.1.0"
edition = "2021"

[dependencies]
libz-sys = "1.0.25"

[build-dependencies]
cc = "1.0.46"
```
{==+==}

{==+==}


{==+==}
Here we have included `libz-sys` which will ensure that there is only one
`libz` used in the final library, and give us access to it from our build
script:
{==+==}
这里我们包含了 `libz-sys` ，这将确保在最终库中只有一个 `libz` ，并允许我们从构建脚本中访问它:
{==+==}


{==+==}
```rust,ignore
// build.rs

fn main() {
    let mut cfg = cc::Build::new();
    cfg.file("src/zuser.c");
    if let Some(include) = std::env::var_os("DEP_Z_INCLUDE") {
        cfg.include(include);
    }
    cfg.compile("zuser");
    println!("cargo:rerun-if-changed=src/zuser.c");
}
```
{==+==}

{==+==}


{==+==}
With `libz-sys` doing all the heavy lifting, the C source code may now include
the zlib header, and it should find the header, even on systems where it isn't
already installed.
{==+==}
有了 `libz-sys` 做所有繁重的工作，C源码现在可以include zlib头文件，它应能找到这个头文件，即使在还没有安装它的系统上。
{==+==}


{==+==}
```c
// src/zuser.c

#include "zlib.h"

// … rest of code that makes use of zlib.
```
{==+==}
```c
// src/zuser.c

#include "zlib.h"

// … 使用zlib的其余代码。
```
{==+==}


{==+==}
### Conditional compilation
{==+==}
### 条件编译
{==+==}


{==+==}
A build script may emit [`rustc-cfg` instructions] which can enable conditions
that can be checked at compile time. In this example, we'll take a look at how
the [`openssl` crate] uses this to support multiple versions of the OpenSSL
library.
{==+==}
构建脚本可以发出 [`rustc-cfg` 指令] ，这些指令可以启用在编译时可以检查的条件。
在这个例子中，我们将看看 [`openssl` crate] 如何使用它来支持多个版本的OpenSSL库。
{==+==}


{==+==}
The [`openssl-sys` crate] implements building and linking the OpenSSL library.
It supports multiple different implementations (like LibreSSL) and multiple
versions. It makes use of the `links` key so that it may pass information to
other build scripts. One of the things it passes is the `version_number` key,
which is the version of OpenSSL that was detected. The code in the build
script looks something [like
this](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl-sys/build/main.rs#L216):
{==+==}
[`openssl-sys` crate] 实现了OpenSSL库的构建和链接。
它支持多种不同的实现方式 (如LibreSSL) 和多个版本。
它使用了 `links` 键，这样就可以向其他构建脚本传递信息。
它传递的信息之一是 `version_number` 键，这是检测到的OpenSSL的版本。
构建脚本中的代码看起来 [像这样](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl-sys/build/main.rs#L216):
{==+==}


{==+==}
```rust,ignore
println!("cargo:version_number={:x}", openssl_version);
```
{==+==}

{==+==}


{==+==}
This instruction causes the `DEP_OPENSSL_VERSION_NUMBER` environment variable
to be set in any crates that directly depend on `openssl-sys`.
{==+==}
这条指令使 `DEP_OPENSSL_VERSION_NUMBER` 环境变量在任何直接依赖 `openssl-sys` 的crate中被设置。
{==+==}


{==+==}
The `openssl` crate, which provides the higher-level interface, specifies
`openssl-sys` as a dependency. The `openssl` build script can read the
version information generated by the `openssl-sys` build script with the
`DEP_OPENSSL_VERSION_NUMBER` environment variable. It uses this to generate
some [`cfg`
values](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/build.rs#L18-L36):
{==+==}
`openssl` crate 提供了更高层次的接口，指定 `openssl-sys` 为依赖项。
`openssl` 构建脚本可以通过 `DEP_OPENSSL_VERSION_NUMBER` 环境变量读取由 `openssl-sys` 构建脚本生成的版本信息。
它用这个来生成一些 [`cfg` values](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/build.rs#L18-L36)。
{==+==}


{==+==}
```rust,ignore
// (portion of build.rs)

if let Ok(version) = env::var("DEP_OPENSSL_VERSION_NUMBER") {
    let version = u64::from_str_radix(&version, 16).unwrap();

    if version >= 0x1_00_01_00_0 {
        println!("cargo:rustc-cfg=ossl101");
    }
    if version >= 0x1_00_02_00_0 {
        println!("cargo:rustc-cfg=ossl102");
    }
    if version >= 0x1_01_00_00_0 {
        println!("cargo:rustc-cfg=ossl110");
    }
    if version >= 0x1_01_00_07_0 {
        println!("cargo:rustc-cfg=ossl110g");
    }
    if version >= 0x1_01_01_00_0 {
        println!("cargo:rustc-cfg=ossl111");
    }
}
```
{==+==}

{==+==}


{==+==}
These `cfg` values can then be used with the [`cfg` attribute] or the [`cfg`
macro] to conditionally include code. For example, SHA3 support was added in
OpenSSL 1.1.1, so it is [conditionally
excluded](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/src/hash.rs#L67-L85)
for older versions:
{==+==}
这些 `cfg` 值可以与 [`cfg` attribute]  或 [`cfg` macro]一起使用，从而有条件地include代码。
例如，SHA3支持是在OpenSSL 1.1.1中添加的，所以对于旧版本它被 [条件排除](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/src/hash.rs#L67-L85) 。
{==+==}


{==+==}
```rust,ignore
// (portion of openssl crate)

#[cfg(ossl111)]
pub fn sha3_224() -> MessageDigest {
    unsafe { MessageDigest(ffi::EVP_sha3_224()) }
}
```
{==+==}

{==+==}


{==+==}
Of course, one should be careful when using this, since it makes the resulting
binary even more dependent on the build environment. In this example, if the
binary is distributed to another system, it may not have the exact same shared
libraries, which could cause problems.
{==+==}
当然，使用这种方法时应该小心，因为它使生成的二进制文件更加依赖于构建环境。
在这个例子中，如果二进制文件被分发到另一个系统，它可能没有完全相同的共享库，这可能导致问题。
{==+==}


{==+==}
[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`cfg` macro]: ../../std/macro.cfg.html
[`rustc-cfg` instructions]: build-scripts.md#rustc-cfg
[`openssl` crate]: https://crates.io/crates/openssl
[`openssl-sys` crate]: https://crates.io/crates/openssl-sys
{==+==}
[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`cfg` macro]: ../../std/macro.cfg.html
[`rustc-cfg` 指令]: build-scripts.md#rustc-cfg
[`openssl` crate]: https://crates.io/crates/openssl
[`openssl-sys` crate]: https://crates.io/crates/openssl-sys
{==+==}


{==+==}
[crates.io]: https://crates.io/
{==+==}

{==+==}
