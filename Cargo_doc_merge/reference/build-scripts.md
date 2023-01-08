## 构建脚本

有些包需要编译第三方的非Rust代码，例如C库。
有些包需要链接到C库，这些库可能位于系统中，也可能需要从源代码中构建。
还有包需要一些功能性工具，比如在构建前生成代码(想想语法分析生成器)。

Cargo的目的并不是要取代其他为这些任务而优化的工具，但它可以通过定制构建脚本与这些工具进行整合。
在软件包的根目录下放置一个名为 `build.rs` 的文件，就会使Cargo在构建软件包之前编译该脚本并执行。

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

构建脚本的一些用例如下:

* 构建C库绑定。
* 在主机系统上查找C库。
* 根据规范生成Rust模块。
* 执行crate所需的任意平台特定配置。

下面的章节描述了构建脚本的工作方式，[示例章节](build-script-examples.md) 展示了关于如何编写脚本的各种示例。

> 注意: 可以使用 [`package.build` 配置清单key](manifest.md#package-build) 来改变构建脚本的名称，或完全禁用它。

### 构建脚本的生命周期

在构建包之前，Cargo会将构建脚本编译成可执行文件(如果还没有构建的话)。
然后它将运行脚本，该脚本可以执行任意数量的任务。
脚本可以通过将带有 `cargo:` 前缀的特殊格式化命令打印到标准输出来与Cargo通信。

如果构建脚本的任意源文件或依赖项发生更改，将重新构建脚本。

默认情况下，如果软件包中的任何文件发生变化，Cargo 会重新运行构建脚本。
通常情况下，最好使用下面 [change detection](#change-detection) 一节中描述的 `rerun-if` 命令，以缩小触发构建脚本重新运行的关注点。

一旦构建脚本成功执行完毕，包的其他部分就会被编译。
脚本应该以非零的退出代码退出，以便在出现错误时停止编译，在这种情况下，编译脚本的输出将显示在终端。

### 构建脚本的输入

当构建脚本运行时，若有一些输入到构建脚本，则都是以 [环境变量][build-env] 的形式传递。

除了环境变量外，构建脚本的当前目录是构建脚本的包的源目录。

[build-env]: environment-variables.md#environment-variables-cargo-sets-for-build-scripts

### 构建脚本的输出

构建脚本可以将任何输出文件或中间构件保存在 [`OUT_DIR` 环境变量][build-env] 指定的目录中。
脚本不应该修改该目录之外的任何文件。

构建脚本通过打印到 stdout 来与Cargo交流。
Cargo会把每一行以 `cargo:` 开头的字解释为影响包编译的指令。所有其他的行都会被忽略。

> 注意：构建脚本打印的 `cargo:` 指令的顺序 *可能* 会影响 `cargo` 传递给 `rustc` 的参数的顺序。
> 反过来，传递给 `rustc` 的参数顺序也可能影响传递给链接器的参数顺序。
> 因此，你要注意构建脚本的指令顺序。
> 例如，如果对象 `foo` 需要与库 `bar` 链接，你可能需要确保库 `bar` 的 [`cargo:rustc-link-lib`](#rustc-link-lib) 指令出现在链接对象 `foo` 的指令 *之后* 。

在正常的编译过程中，脚本的输出被隐藏在终端中。
如果你想在终端上直接看到输出，可以用 `-vv` 标志来调用Cargo的 "very verbose" 。
这只发生在编译脚本运行的时候。
如果Cargo认为没有任何变化，它就不会重新运行脚本，更多信息请参见下面的 [变化检测](#change-detection) 。

构建脚本打印到stdout的所有行都被写入一个文件，如 `target/debug/build/<pkg>/output`(确切位置可能取决于你的配置)。stderr输出也被保存在同一目录中。

以下是 Cargo 所认识的指令摘要，每条指令都在下面详细说明。

* [`cargo:rerun-if-changed=PATH`](#rerun-if-changed) — 告诉Cargo何时重新运行脚本。
* [`cargo:rerun-if-env-changed=VAR`](#rerun-if-env-changed) — 告诉Cargo何时重新运行脚本。
* [`cargo:rustc-link-arg=FLAG`](#rustc-link-arg) — 为基准、二进制文件、`cdylib` crates、例子和测试的链接器传递自定义标志。
* [`cargo:rustc-link-arg-bin=BIN=FLAG`](#rustc-link-arg-bin) — 为二进制 `BIN` 的链接器传递自定义标志。
* [`cargo:rustc-link-arg-bins=FLAG`](#rustc-link-arg-bins) — 向二进制文件的链接器传递自定义标志。
* [`cargo:rustc-link-arg-tests=FLAG`](#rustc-link-arg-tests) —  将自定义标志传递给链接器进行测试。
* [`cargo:rustc-link-arg-examples=FLAG`](#rustc-link-arg-examples) — 将自定义标志传递给链接器的例子。
* [`cargo:rustc-link-arg-benches=FLAG`](#rustc-link-arg-benches) — 将自定义的标志传递给链接器，用于基准测试。
* [`cargo:rustc-link-lib=LIB`](#rustc-link-lib) — 添加一个库到链接。
* [`cargo:rustc-link-search=[KIND=]PATH`](#rustc-link-search) — 添加到库的搜索路径。
* [`cargo:rustc-flags=FLAGS`](#rustc-flags) — 将特定标志传递给编译器。
* [`cargo:rustc-cfg=KEY[="VALUE"]`](#rustc-cfg) — 启用编译时的 `cfg` 设置。
* [`cargo:rustc-env=VAR=VALUE`](#rustc-env) — 设置一个环境变量。
* [`cargo:rustc-cdylib-link-arg=FLAG`](#rustc-cdylib-link-arg) — 为cdylib crates的链接器传递自定义标志。
* [`cargo:warning=MESSAGE`](#cargo-warning) — 在终端上显示一个警告。
* [`cargo:KEY=VALUE`](#the-links-manifest-key) — 元数据，由 `links` 脚本使用。


<a id="rustc-link-arg"></a>
#### `cargo:rustc-link-arg=FLAG`

`rustc-link-arg` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建支持的目标(基准、二进制文件、`cdylib`板条、例子和测试)时使用。
它的使用是高度平台化的。对设置共享库版本或链接器脚本很有用。

[link-arg]: ../../rustc/codegen-options/index.md#link-arg

<a id="rustc-link-arg-bin"></a>
#### `cargo:rustc-link-arg-bin=BIN=FLAG`

`rustc-link-arg-bin` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建名称为 `BIN` 的二进制目标时使用。
它的用法与平台高度相关。对设置链接器脚本或其他链接器选项很有用。


<a id="rustc-link-arg-bins"></a>
#### `cargo:rustc-link-arg-bins=FLAG`

`rustc-link-arg-bins` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建二进制目标时使用。
它的用法与平台高度相关。对于设置链接器脚本或其他链接器选项很有用。


<a id="rustc-link-lib"></a>
#### `cargo:rustc-link-lib=LIB`

`rustc-link-lib` 指令告诉 Cargo 使用编译器的 [`-l` flag][option-link] 来链接指定的库。
这通常用于使用 [FFI] 来链接本地库。

`LIB` 字符串是直接传递给rustc的，所以它支持 `-l` 的任何语法。
目前， `LIB` 支持的全部语法是 `[KIND[:MODIFIERS]=]NAME[:RENAME]` 。

`-l` 标志只传递给包的库目标，除非没有库目标，在这种情况下它会传递给所有目标。
这样做是因为所有其他目标都隐含着对库目标的依赖，而要链接的库只应该包含一次。
这意味着，如果一个包有一个库和一个二进制目标，那么 *库* 可以访问给定lib的标识符，而二进制应该通过库目标的公共API来访问它们。

可选的 `KIND` 可以是 `dylib` 、 `static` 或` framework` 之一。
更多细节见 [rustc book][option-link] 。

[option-link]: ../../rustc/command-line-arguments.md#option-l-link-lib
[FFI]: ../../nomicon/ffi.md


<a id="rustc-link-arg-tests"></a>
#### `cargo:rustc-link-arg-tests=FLAG`

`rustc-link-arg-tests` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建测试目标时使用。


<a id="rustc-link-arg-examples"></a>
#### `cargo:rustc-link-arg-examples=FLAG`

`rustc-link-arg-examples` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建实例目标时传递。

<a id="rustc-link-arg-benches"></a>
#### `cargo:rustc-link-arg-benches=FLAG`

`rustc-link-arg-benches` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建基准目标时使用。

<a id="rustc-link-search"></a>
#### `cargo:rustc-link-search=[KIND=]PATH`

`rustc-link-search` 指令告诉Cargo将 [`-L` flag][option-search] 传递给编译器，在库搜索路径中添加一个目录。

可选的 `KIND` 可以是 `dependency` 、 `crate` 、 `native` 、 `framework` 、 `all` 之一。更多细节见 [rustc book][option-search] 。

如果这些路径在 `OUT_DIR` 内，它们也会被添加到 [动态库搜索路径环境变量](environment-variables.md#dynamic-library-paths) 。
不鼓励依赖这种行为，因为这使得使用产生的二进制文件很困难。一般来说，最好避免在构建脚本中创建动态库(使用现有的系统库就可以了)。

[option-search]: ../../rustc/command-line-arguments.md#option-l-search-path

<a id="rustc-flags"></a>
#### `cargo:rustc-flags=FLAGS`

`rustc-flags` 指令告诉Cargo将给定的以空格分隔的标志传递给编译器。
这只允许使用 `-l `和 `-L` 标志，相当于使用 [`rustc-link-lib`](#rustc-link-lib) 和 [`rustc-link-search`](#rustc-link-search) 。

<a id="rustc-cfg"></a>
#### `cargo:rustc-cfg=KEY[="VALUE"]`

`rustc-cfg` 指令告诉Cargo将给定的[`--cfg` flag][option-cfg] 的值传递给编译器。
这可用于编译时检测功能，以启用 [条件编译] 。

请注意，这并 *不* 影响Cargo的依赖解析。
这不能用来启用一个可选的依赖，或启用其他Cargo功能。

请注意，[Cargo features]使用的是 `feature="foo"` 的形式。
用这个标志传递的 `cfg` 值不限于这种形式，可以只提供一个标识符，或任意的键/值对。例如，发送 `cargo:rustc-cfg=abc` 将允许代码使用 `#[cfg(abc)]` (注意缺少 `feature=` )。
或者可以使用一个任意的键/值对与一个 `=` 号，如`cargo:rustc-cfg=my_component="foo"`。
键应该是一个Rust标识符，值应该是一个字符串。

[cargo features]: features.md
[条件编译]: ../../reference/conditional-compilation.md
[option-cfg]: ../../rustc/command-line-arguments.md#option-cfg

<a id="rustc-env"></a>
#### `cargo:rustc-env=VAR=VALUE`

`rustc-env` 指令告诉Cargo在编译包的时候设置指定的环境变量。
然后可以通过编译后的crate中的[`env!` macro][env-macro]来检索该值。
这对于在crate的代码中嵌入额外的元数据很有用，例如git HEAD的哈希值或持续集成服务器的唯一标识符。

参阅 [Cargo自动包含环境变量][env-cargo]。

> **注意**: 当用 `cargo run` 或 `cargo test` 运行可执行文件时，也会设置这些环境变量。
> 然而，不鼓励这种用法，因为它将可执行文件与Cargo的执行环境关联在一起。
> 通常情况下，这些环境变量应该只在编译时用 `env!` 宏来检查。

[env-macro]: ../../std/macro.env.html
[env-cargo]: environment-variables.md#environment-variables-cargo-sets-for-crates

<a id="rustc-cdylib-link-arg"></a>
#### `cargo:rustc-cdylib-link-arg=FLAG`

`rustc-dylib-link-arg` 指令告诉Cargo将 [`-C link-arg=FLAG` option][link-arg] 传递给编译器，但只在构建 `cdylib` 库目标时使用。
它的使用是高度平台特定的。对于设置共享库的版本或运行时路径很有用。


<a id="cargo-warning"></a>
#### `cargo:warning=MESSAGE`

`warning` 指令告诉Cargo在构建脚本运行完毕后显示一个警告。
警告只针对 `path` 依赖(也就是你在本地工作的那些依赖)，所以例如在[crates.io]crates中打印出来的警告，默认是不会发送的。
`-vv` "very verbose" 标志可以用来让Cargo显示所有crate的警告。

### 构建依赖

构建脚本也可以依赖其他基于Cargo的crates。
依赖是通过配置清单中的 `build-dependencies` 部分来声明的。

```toml
[build-dependencies]
cc = "1.0.46"
```

构建脚本*不*访问列在 `dependencies` 或 `dev-dependencies` 部分的依赖项(它们还没有被构建！)。
另外，除非在 `[dependencies]` 表中明确添加，否则构建的依赖项对包本身是不可用的。

建议仔细考虑你添加的每个依赖，权衡对编译时间、许可、维护等的影响。
如果一个依赖是在构建依赖和正常依赖之间共享的，Cargo会尝试重用它。然而，这并不总是能用，例如在交叉编译时，所以要考虑到对编译时间的影响。

### 变化检测

当重建包时，Cargo不一定知道是否需要再次运行构建脚本。
默认情况下，它采取一种保守的方法，即如果包中的任何文件被改变(或由 [`exclude` 和 `include` 字段] 控制的文件列表被改变)，则总是重新运行构建脚本。
在大多数情况下，这不是一个好的选择，所以建议每个构建脚本至少发出一个 `rerun-if` 指令(如下所述)。
如果发出了这些指令，那么Cargo只会在给定值发生变化时重新运行脚本。
如果Cargo重新运行你自己的crate或依赖的构建脚本，而你又不知道为什么，请参见FAQ中的["为什么Cargo要重新构建我的代码？"](.../faq.md#why-is-cargo-rebuilding-my-code)。

[`exclude` 和 `include` 字段]: manifest.md#the-exclude-and-include-fields

<a id="rerun-if-changed"></a>
#### `cargo:rerun-if-changed=PATH`

`rerun-if-changed` 指令告诉Cargo在指定路径的文件发生变化时重新运行构建脚本。
目前，Cargo只使用文件系统最后修改的 "mtime" 时间戳来确定文件是否有变化。
它与内部缓存的构建脚本最后运行的时间戳进行比较。

如果路径指向一个目录，它将扫描整个目录的任何修改。

如果构建脚本在任何情况下都不需要重新运行，那么发出 `cargo:rerun-if-changed=build.rs` 是防止其重新运行的简单方法(否则，如果没有发出 `rerun-if` 指令，则默认为扫描整个包目录的变化)。
Cargo会自动处理脚本本身是否需要重新编译，当然，脚本在重新编译后会被重新运行。
否则，指定 `build.rs` 是多余的，没有必要。

<a id="rerun-if-env-changed"></a>
#### `cargo:rerun-if-env-changed=NAME`

`rerun-if-env-changed` 指令告诉Cargo，如果给定名称的环境变量值发生变化，则重新运行构建脚本。

注意，这里的环境变量是针对全局环境变量如 `CC` 之类的，对于Cargo设置的 `TARGET` 之类的环境变量没有必要使用这个。


### `links` 配置清单Key

`package.links` 键可以在 `Cargo.toml` 清单中设置，以声明该包与给定的本地库相链接。
这个清单键的目的是让Cargo了解一个包的本地依赖，以及提供在包构建脚本之间传递元数据的有条理的系统。

```toml
[package]
# ...
links = "foo"
```

该清单表明，该包链接到 `libfoo` 本地库。
当使用 `links` 键时，包必须有一个构建脚本，而构建脚本应该使用 [`rustc-link-lib`指令](#rustc-link-lib) 来链接该库。

主要的是，Cargo要求每个 `links` 值最多只能有一个包。
换句话说，禁止让两个包链接到同一个本地库。
这有助于防止crates之间的重复符号。注意，有一些[已有的惯例](#-sys-packages)可以缓解这个问题。

如上文在输出格式中提到的，每个构建脚本可以以键值对的形式生成一组任意的元数据。
这些元数据被传递给 **依赖的** 包的构建脚本。
例如，如果包 `bar` 依赖于 `foo` ，那么如果 `foo` 生成 `key=value` 作为其构建脚本元数据的一部分，那么 `bar` 的构建脚本将有 `DEP_FOO_KEY=value` 的环境变量。
参见 ["使用另一个 `sys` crate"][using-another-sys]，以了解如何使用这个例子。

请注意，元数据只传递给直接依赖，而不传递给过渡依赖。

[using-another-sys]: build-script-examples.md#using-another-sys-crate

### `*-sys` 包

一些链接到系统库的Cargo包有后缀为 `-sys` 的命名惯例。
任何名为 `foo-sys` 的包都应该提供两个主要功能。

* 库crate应该链接到本地库 `libfoo` 。这通常会在从源代码构建之前探测当前系统中的 `libfoo` 。
* 这个库应该为 `libfoo` 中的类型和函数提供 **声明**，而**不是**更高级别的抽象。

`*-sys` 包的集合为连接本地库提供了通用的依赖。
有了这个本地库相关包的惯例，带来许多好处。

* 对 `foo-sys` 的共同依赖简便了对于每个 `links` 值一个包的规则。
* 其他 `sys` 包可以利用 `DEP_NAME_KEY=value` 环境变量的优势，更好地与其他包集成。参见 ["使用另一个 `sys` crate"][using-another-sys] 例子。
* 一个共同的依赖允许将逻辑集中在发现 `libfoo` 本身(或从源代码构建它)。
* 这些依赖很容易被 [覆盖](#overriding-build-scripts) 。

通常会有一个没有 `-sys` 后缀的配套包，在sys包的基础上提供安全的高级抽象。
例如，[`git2` crate] 为 [`libgit2-sys` crate] 提供了一个高级接口。

[`git2` crate]: https://crates.io/crates/git2
[`libgit2-sys` crate]: https://crates.io/crates/libgit2-sys

### 覆盖构建脚本

如果配置清单中包含 `links` 键，那么Cargo支持用自定义库覆盖指定的构建脚本。
这一功能的目的是为了防止完全运行相关的构建脚本，而是提前提供元数据。

要覆盖一个构建脚本，在任意允许的 [`config.toml`](config.md) 文件中放置以下配置。

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

在这种配置下，如果包声明它链接到 `foo` ，那么构建脚本将 **不** 被编译或运行，而将使用指定的元数据。

不应使用 `warning` 、 `rerun-if-changed` 和 `rerun-if-env-changed` 键，它们将被忽略。

### Jobserver

Cargo和 `rustc` 使用为GNU 制作开发的[jobserver 协议]来协调进程间的并发。
它本质上是信号，控制同时运行的作业数量。
并发性可以用 `--jobs` 标志来设置，默认为逻辑CPU的数量。

每个构建脚本都从Cargo那里继承一个作业槽，并试图运行时只使用一个CPU。
如果脚本想并行使用更多的CPU，应该使用[`jobserver` crate]来与Cargo协调。

As an example, the [`cc` crate] may enable the optional `parallel` feature
which will use the jobserver protocol to attempt to build multiple C files
at the same time.

[`cc` crate]: https://crates.io/crates/cc
[`jobserver` crate]: https://crates.io/crates/jobserver
[jobserver 协议]: http://make.mad-scientist.net/papers/jobserver-implementation/
[crates.io]: https://crates.io/
