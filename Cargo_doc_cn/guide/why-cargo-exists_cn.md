{==+==}
## Why Cargo Exists
{==+==}
## 为何有Cargo
{==+==}

{==+==}
### Preliminaries
{==+==}
### 初识
{==+==}

{==+==}
In Rust, as you may know, a library or executable program is called a
[*crate*][def-crate]. Crates are compiled using the Rust compiler,
`rustc`. When starting with Rust, the first source code most people encounter
is that of the venerable “hello world” program, which they compile by invoking
`rustc` directly:
{==+==}
在 Rust 中，库或可执行程序被称为 [*crate*][def-crate] 。可以使用 Rust 编译器 `rustc` 编译 Crate 。
刚开始学习 Rust 时，经典的 "hello world" 程序，可以通过 `rustc` 直接编译:
{==+==}


{==+==}
```console
$ rustc hello.rs
$ ./hello
Hello, world!
```
{==+==}

{==+==}


{==+==}
Note that the above command required that we specify the file name
explicitly. If we were to directly use `rustc` to compile a different program,
a different command line invocation would be required. If we needed to specify
any specific compiler flags or include external dependencies, then the
needed command would be even more specific (and elaborate).
{==+==}
请注意，上面的命令需要显式指定文件名。
如果直接使用 `rustc` 来编译不同的程序，那么不同的文件就需要执行不同的命令。
如果需要指定编译选项或包含的外部依赖，执行的命令就需要十分具体详尽。
{==+==}


{==+==}
Furthermore, most non-trivial programs will likely have dependencies on
external libraries, and will therefore also depend transitively on *their*
dependencies. Obtaining the correct versions of all the necessary dependencies
and keeping them up to date would be laborious and error-prone if done by
hand.
{==+==}
而且，大多数程序会有额外的外部依赖，这些外部依赖又会有其他依赖。
此时手动维护必要依赖的正确版本，并协调依赖版本的更新会很困难。
{==+==}


{==+==}
Rather than work only with crates and `rustc`, we can avoid the manual tedium
involved with performing the above tasks by introducing a higher-level
["*package*"][def-package] abstraction and by using a
[*package manager*][def-package-manager].
{==+==}
引入了 ["*包(package)*"][def-package] 这一更高层的抽象。
并使用 [*包管理器*][def-package-manager] ，避免了直接跟 crate 和 `rustc` 手动乏味的交互。
{==+==}


{==+==}
### Enter: Cargo
{==+==}
### 走进 Cargo
{==+==}


{==+==}
*Cargo* is the Rust package manager. It is a tool that allows Rust
[*packages*][def-package] to declare their various dependencies and ensure
that you’ll always get a repeatable build.
{==+==}
*Cargo* 是 Rust 的包管理器。它是工具，允许 Rust [*packages*][def-package] 声明其各种依赖关系，确保总是能得到一个可重复的构建。
{==+==}

{==+==}
To accomplish this goal, Cargo does four things:
{==+==}
Cargo 做了以下四件事来实现这个目标:
{==+==}

{==+==}
* Introduces two metadata files with various bits of package information.
* Fetches and builds your package’s dependencies.
* Invokes `rustc` or another build tool with the correct parameters to build
  your package.
* Introduces conventions to make working with Rust packages easier.
{==+==}
* 引进两个文件，包含包的各类元数据信息。
* 下载并构建包的依赖。
* 调用 `rustc` 或其他构建工具及正确的参数来构建包。
* 通过规范使 Rust 包的操作更简洁。
{==+==}

{==+==}
To a large extent, Cargo normalizes the commands needed to build a given
program or library; this is one aspect to the above mentioned conventions. As
we show later, the same command can be used to build different
[*artifacts*][def-artifact], regardless of their names. Rather than invoke
`rustc` directly, we can instead invoke something generic such as `cargo
build` and let cargo worry about constructing the correct `rustc`
invocation. Furthermore, Cargo will automatically fetch from a
[*registry*][def-registry] any dependencies we have defined for our artifact,
and arrange for them to be incorporated into our build as needed.
{==+==}
作为上述规范的一个方面， Cargo 有很标准的构建程序或包的命令。
从下文中可以看到，相同的命令可以构建名称不同的 [*artifacts*][def-artifact] "制品"。
相比直接调用 `rustc` ，可以调用 `cargo build` 等更加通用的命令，让 cargo 去调用 `rustc` 去正确构建。
并且，Cargo 可以自动从 [*registry*][def-registry] "注册中心" 下载依赖，并将依赖合并到构建中。
{==+==}

{==+==}
It is only a slight exaggeration to say that once you know how to build one
Cargo-based project, you know how to build *all* of them.
{==+==}
夸张一点说，一旦你学会使用 Cargo 就可以构建 *所有* 项目。
{==+==}

{==+==}
[def-artifact]:         ../appendix/glossary.md#artifact         '"artifact" (glossary entry)'
[def-crate]:            ../appendix/glossary.md#crate            '"crate" (glossary entry)'
[def-package]:          ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-package-manager]:  ../appendix/glossary.md#package-manager  '"package manager" (glossary entry)'
[def-registry]:         ../appendix/glossary.md#registry         '"registry" (glossary entry)'
{==+==}

{==+==}
