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
在 Rust 中，库或可执行程序被称为 [*crate*][def-crate] 。使用 Rust 编译器 `rustc` 编译 crate  。
当开始使用 Rust 时，大多数人遇到的第一份源代码是经典的 "hello world" 程序，可以通过直接调用 `rustc` 进行编译。
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
注意，上述命令需要我们明确指定文件名。如果我们直接使用 `rustc` 编译不同的程序，则需要不同的命令行调用。
如果我们需要指定任何特定的编译器标志或包含外部依赖项，则所需的命令将需要十分具体和详尽。
{==+==}


{==+==}
Furthermore, most non-trivial programs will likely have dependencies on
external libraries, and will therefore also depend transitively on *their*
dependencies. Obtaining the correct versions of all the necessary dependencies
and keeping them up to date would be laborious and error-prone if done by
hand.
{==+==}
此外，大多数复杂的程序可能会依赖外部库，这些外部依赖又会有其他依赖。
此时手动完成获取所有必要依赖的正确版本并使它们保持最新，将十分费力且容易出错。
{==+==}


{==+==}
Rather than work only with crates and `rustc`, we can avoid the manual tedium
involved with performing the above tasks by introducing a higher-level
["*package*"][def-package] abstraction and by using a
[*package manager*][def-package-manager].
{==+==}
Rust 中，我们可以引入更高级别的 ["*包(package)*"][def-package] 抽象和使用 [包管理器][def-package-manager] ，避免需要手动执行上述任务的繁琐过程。
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
*Cargo* 是 Rust 的包管理器。它是工具，允许 Rust [*packages*][def-package] 声明它们的各种依赖项，并确保您始终可以获得可重复的构建。
{==+==}

{==+==}
To accomplish this goal, Cargo does four things:
{==+==}
为了实现这一目标，Cargo 执行以下四个操作:
{==+==}

{==+==}
* Introduces two metadata files with various bits of package information.
* Fetches and builds your package’s dependencies.
* Invokes `rustc` or another build tool with the correct parameters to build
  your package.
* Introduces conventions to make working with Rust packages easier.
{==+==}
* 引入两个元数据文件，包含有关包的各种信息。
* 获取和构建包的依赖项。
* 调用 `rustc` 或其他构建工具及正确的参数来构建包。
* 通过规范使 Rust 包的操作更简洁
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
正如所述，Cargo 的目标之一是将构建 Rust 程序或库所需的命令规范化，这是上述惯例的一个方面。
如稍后所示，相同的命令可以用于构建不同的 [制品][def-artifact] ，而不管它们的名称如何。
与直接调用 `rustc` 不同，我们可以调用像 `cargo build` 这样的通用工具，让 Cargo 负责构建正确的 `rustc` 调用。
此外，Cargo 将自动从 [*registry*][def-registry] "注册中心" 中获取我们为制品定义的任何依赖，并安排将它们按需要合并到我们的构建中。
{==+==}

{==+==}
It is only a slight exaggeration to say that once you know how to build one
Cargo-based project, you know how to build *all* of them.
{==+==}
可以说，你一旦学会使用 Cargo 就可以构建 *所有* 项目。
{==+==}

{==+==}
[def-artifact]:         ../appendix/glossary.md#artifact         '"artifact" (glossary entry)'
[def-crate]:            ../appendix/glossary.md#crate            '"crate" (glossary entry)'
[def-package]:          ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-package-manager]:  ../appendix/glossary.md#package-manager  '"package manager" (glossary entry)'
[def-registry]:         ../appendix/glossary.md#registry         '"registry" (glossary entry)'
{==+==}

{==+==}
