## 构建脚本示例

下面小节是一些编写的构建脚本的示例演示。

在[crates.io]的crates构建脚本中可以找到一些常见的功能。
查看 [`build-dependencies` keyword](https://crates.io/keywords/build-dependencies)，看看有那些可用。
下面是一些流行的 crates[^†] 示例。

* [`bindgen`](https://crates.io/crates/bindgen) — 自动生成Rust FFI与C库的绑定。
* [`cc`](https://crates.io/crates/cc) — 编译 C/C++/assembly 。
* [`pkg-config`](https://crates.io/crates/pkg-config) — 使用 `pkg-config` 工具检测系统库。
* [`cmake`](https://crates.io/crates/cmake) — 运行 `cmake` 构建工具来构建一个本地库。
* [`autocfg`](https://crates.io/crates/autocfg),
  [`rustc_version`](https://crates.io/crates/rustc_version),
  [`version_check`](https://crates.io/crates/version_check) — 这些crates提供了基于当前 `rustc` (如编译器的版本) 实现条件编译的方法。

[^†]: 这个列表并不仅是一种签注。它评估你的依赖，看哪一个是更适合你的项目。

### Code 生成

由于各种原因，有些Cargo包在编译前需要生成代码。
在这里，通过一个简单的例子，生成一个库调用将作为构建脚本的一部分。

首先，来看一下这个包的目录结构:

```text
.
├── Cargo.toml
├── build.rs
└── src
    └── main.rs

1 directory, 3 files
```

可以看到，有一个 `build.rs` 构建脚本和 `main.rs` 二进制文件。这个包有一个基本的配置清单:

```toml
# Cargo.toml

[package]
name = "hello-from-generated-code"
version = "0.1.0"
edition = "2021"
```

来看看构建脚本里面有什么内容:

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

这里有几个值得注意的地方:

* 脚本使用 `OUT_DIR` 环境变量来发现输出文件的位置。
  它可以使用进程的当前工作目录来寻找输入文件的位置，但在当前情况下我们没有任何输入文件。
* 一般来说，构建脚本不应该修改 `OUT_DIR` 以外的任何文件。
  乍一看，这似乎没什么问题，但当你使用这样的crate作为依赖时，却会产生问题，因为 *implicit* "隐式"不变性，即 `.cargo/registry` 中的源码应该是不可改变的。 `cargo` 在打包时不允许这样的脚本。
* 这个脚本相对简单，因为它只是写生成了一个小的文件。
  可以想象，还可以进行其他更多有趣的操作，例如从C头文件或其他语言定义中生成一个Rust模块。
* [`rerun-if-changed` instruction](build-scripts.md#rerun-if-changed) 告知Cargo，只有当构建脚本本身发生变化时才需要重新运行构建脚本。
  如果没有这一行，Cargo会在包中的任何文件发生变化时自动运行构建脚本。
  如果你的代码生成使用了一些输入文件，这里就应是你要打印每个文件列表的地方。

接下来，来看一下库本身:

```rust,ignore
// src/main.rs

include!(concat!(env!("OUT_DIR"), "/hello.rs"));

fn main() {
    println!("{}", message());
}
```

这就是真正奇妙的地方。该库使用rustc定义的 [`include!` macro][include-macro] 与 [`concat!`][concat-macro] 和 [`env!`][env-macro] 宏相结合，将生成的文件(`hello.rs`)纳入crate的编译。

使用这里显示的结构，crates可以include来自构建脚本本身任意数量的生成文件。

[include-macro]: ../../std/macro.include.html
[concat-macro]: ../../std/macro.concat.html
[env-macro]: ../../std/macro.env.html

### 构建本地库

有时有必要将一些本地C或C++代码作为包的一部分来构建。
这是利用构建脚本在Rust crate本身之前构建本地库的另一个很好的用例。
作为例子，我们将创建一个Rust库，调用C语言来打印 “Hello, World!” 。

像上面一样，来先看一下包的层次。

```text
.
├── Cargo.toml
├── build.rs
└── src
    ├── hello.c
    └── main.rs

1 directory, 4 files
```

与上面的相似，以下是配置清单:

```toml
# Cargo.toml

[package]
name = "hello-world-from-c"
version = "0.1.0"
edition = "2021"
```

现在我们不打算使用任何构建依赖，先来看一下构建脚本:

```rust,no_run
// build.rs

use std::process::Command;
use std::env;
use std::path::Path;

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();

    // Note that there are a number of downsides to this approach, the comments
    // below detail how to improve the portability of these commands.
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

这个编译脚本首先将C文件编译成object文件(通过调用`gcc`)，然后将这个object文件转换为静态库 (通过调用`ar`)。
最后一步是反馈给Cargo本身，告知输出在 `out_dir` ，编译器应该通过 `-l static=hello` 标志将crate静态链接到 `libhello.a` 。

注意，这种硬编码的方法有很多缺点:

* `gcc` 命令本身不能跨平台移植。例如，Windows平台不太可能有 `gcc` ，甚至不是所有Unix平台都可能有 `gcc` 。 `ar` 命令也是类似的情况。
* 这些命令没有考虑到交叉编译的问题。如果为Android这样的平台进行交叉编译，那么 `gcc` 不太可能产生ARM的可执行文件。

不过不用担心，这时 `build-dependencies` 条目会有帮助。Cargo生态系统有许多包，可以使这种任务变得更容易、便携、标准。
试试[crates.io]的[`cc` crate](https://crates.io/crates/cc)。首先，把它添加到 `Cargo.toml` 的 `build-dependencies` 中。

```toml
[build-dependencies]
cc = "1.0"
```

并重写构建脚本以使用这个crate。

```rust,ignore
// build.rs

fn main() {
    cc::Build::new()
        .file("src/hello.c")
        .compile("hello");
    println!("cargo:rerun-if-changed=src/hello.c");
}
```

[`cc` crate] 抽象了一系列对C代码构建的脚本需求:

* 它调用适当的编译器 (MSVC用于Windows， `gcc` 用于MinGW， `cc` 用于Unix平台，等等)。
* 它通过向正在使用的编译器传递适当的标志，将 `TARGET` 变量考虑在内。
* 其他环境变量，如 `OPT_LEVEL` 、 `DEBUG` 等，都是自动处理的。
* stdout输出和 `OUT_DIR` 位置也由 `cc` 库处理。

在这里，可以看到将尽可能多的功能移植到共同的构建依赖中，而不是在所有的构建脚本中重复逻辑的一些主要好处。

回到示例研究，来快速看一下 `src` 目录的内容:

```c
// src/hello.c

#include <stdio.h>

void hello() {
    printf("Hello, World!\n");
}
```

```rust,ignore
// src/main.rs

// 注意没有 `#[link]` 属性。把链接内容的责任交给了构建脚本，而不是在源文件中硬编码。
extern { fn hello(); }

fn main() {
    unsafe { hello(); }
}
```

那么开始! 这样就完成了从Cargo包中使用构建脚本本身构建一些C代码的例子。
这也说明为什么在很多情况下，使用构建依赖是非常关键的，甚至更加简洁!

我们也看到了这个简短的示例，说明构建脚本如何单纯将crate作为依赖，而不是在运行时将crate本身作为依赖。

[`cc` crate]: https://crates.io/crates/cc

### 链接到系统库

这个例子演示了如何链接系统库，以及如何支持使用构建脚本。

很多时候，Rust crate想要链接到系统上提供的本地库，绑定其功能，或者只是将其作为实现细节的一部分。
当涉及到以一种平台无关的方式执行时，这是相当细微的问题。
最好的办法是，如果可能的话，尽可能多地把这部分工作交给别人去做，让使用者更轻松。

对于这个例子，将创建一个与系统zlib库的绑定。
这是在大多数类Unix系统中常见的库，提供数据压缩。
这已经包含在[`libz-sys` crate]中了，但对于这个例子，我们将做一个极其简化的版本。请查看[libz源码][libz-source]以了解完整的用例。

为了方便找到库的位置，我们将使用[`pkg-config` crate]。这个crate使用系统的 `pkg-config` 工具来发现库的信息。
它将自动告诉Cargo需要什么来链接这个库。这可能只能在安装了 `pkg-config` 的类Unix系统上工作。先从设置配置清单开始:

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

请注意，我们在 `package` 表中加入了 `links` 键。
这告知Cargo，正在链接到 `libz` 库。
请看["使用另一个系统crate"](#using-another-sys-crate)中的例子，可以利用这点。

构建脚本相当简单:

```rust,ignore
// build.rs

fn main() {
    pkg_config::Config::new().probe("zlib").unwrap();
    println!("cargo:rerun-if-changed=build.rs");
}
```

那么用基本的FFI绑定来完善这个例子:

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

运行 `cargo build -vv` 来查看构建脚本的输出。在已经安装了 `libz` 的系统上，可能看起来像这样:

```text
[libz-sys 0.1.0] cargo:rustc-link-search=native=/usr/lib
[libz-sys 0.1.0] cargo:rustc-link-lib=z
[libz-sys 0.1.0] cargo:rerun-if-changed=build.rs
```

很好! `pkg-config` 做了所有寻找库的工作，并告知Cargo它的位置。

包包括库的源代码，如果在系统中找不到它，或者设置了某个特性或环境变量，就静态地构建它，这种情况并不罕见。
例如，实际的 [`libz-sys` crate] 检查环境变量 `LIBZ_SYS_STATIC` 或 `static` 特性，从源码构建而不是使用系统库。
请查看 [the source][libz-source] 以了解更完整的例子。

[`libz-sys` crate]: https://crates.io/crates/libz-sys
[`pkg-config` crate]: https://crates.io/crates/pkg-config
[libz-source]: https://github.com/rust-lang/libz-sys

### 使用另一个 `sys` crate

当使用 `links` 键时，crates可以设置元数据，这些元数据可以被其他依赖它的crates读取。这提供了一种在crates之间通信的机制。在这个例子中，我们将创建一个C语言库，利用实际的 [`libz-sys` crate] 中的zlib。

如果你有一个依赖于zlib的C库，你可以利用 [`libz-sys` crate] 来自动查找或构建它。这对于跨平台支持非常有用，比如通常不安装zlib的Windows。
`libz-sys`[设置 `include` 元数据](https://github.com/rust-lang/libz-sys/blob/3c594e677c79584500da673f918c4d2101ac97a1/build.rs#L156) ，告诉其他软件包在哪里可以找到zlib的头文件。
我们的构建脚本可以通过 `DEP_Z_INCLUDE` 环境变量读取该元数据。
下面是一个例子:

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

这里我们包含了 `libz-sys` ，这将确保在最终库中只有一个 `libz` ，并允许我们从构建脚本中访问它:

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

有了 `libz-sys` 做所有繁重的工作，C源码现在可以include zlib头文件，它应能找到这个头文件，即使在还没有安装它的系统上。

```c
// src/zuser.c

#include "zlib.h"

// … 使用zlib的其余代码。
```

### 条件编译

构建脚本可以发出 [`rustc-cfg` 指令] ，这些指令可以启用在编译时可以检查的条件。
在这个例子中，我们将看看 [`openssl` crate] 如何使用它来支持多个版本的OpenSSL库。

[`openssl-sys` crate] 实现了OpenSSL库的构建和链接。
它支持多种不同的实现方式 (如LibreSSL) 和多个版本。
它使用了 `links` 键，这样就可以向其他构建脚本传递信息。
它传递的信息之一是 `version_number` 键，这是检测到的OpenSSL的版本。
构建脚本中的代码看起来[像这样](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl-sys/build/main.rs#L216):

```rust,ignore
println!("cargo:version_number={:x}", openssl_version);
```

这条指令使 `DEP_OPENSSL_VERSION_NUMBER` 环境变量在任何直接依赖 `openssl-sys` 的crates中被设置。

`openssl` crate 提供了更高层次的接口，指定 `openssl-sys` 为依赖项。
`openssl` 构建脚本可以通过 `DEP_OPENSSL_VERSION_NUMBER` 环境变量读取由 `openssl-sys` 构建脚本生成的版本信息。
它用这个来生成一些 [`cfg` values](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/build.rs#L18-L36)。

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

这些 `cfg` 值可以与 [`cfg` attribute]  或 [`cfg` macro]一起使用，从而有条件地include代码。
例如，SHA3支持是在OpenSSL 1.1.1中添加的，所以对于旧版本它被[条件排除](https://github.com/sfackler/rust-openssl/blob/dc72a8e2c429e46c275e528b61a733a66e7877fc/openssl/src/hash.rs#L67-L85)。

```rust,ignore
// (portion of openssl crate)

#[cfg(ossl111)]
pub fn sha3_224() -> MessageDigest {
    unsafe { MessageDigest(ffi::EVP_sha3_224()) }
}
```

当然，使用这种方法时应该小心，因为它使生成的二进制文件更加依赖于构建环境。
在这个例子中，如果二进制文件被分发到另一个系统，它可能没有完全相同的共享库，这可能导致问题。

[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`cfg` macro]: ../../std/macro.cfg.html
[`rustc-cfg` 指令]: build-scripts.md#rustc-cfg
[`openssl` crate]: https://crates.io/crates/openssl
[`openssl-sys` crate]: https://crates.io/crates/openssl-sys

[crates.io]: https://crates.io/
