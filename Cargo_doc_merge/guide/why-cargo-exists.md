## Cargo 为何存在

### 前言

在 Rust 中，一个类库或可执行程序称为一个 [*crate*][def-crate] 。
Crate 是使用 Rust 编译器 `rustc` 编译的。
刚开始学习 Rust 时，大多数人上手的代码便是经典的 "hello world" 程序，它可以通过 `rustc` 直接编译:

```console
$ rustc hello.rs
$ ./hello
Hello, world!
```

请注意，上面的命令需要我们显式指定文件名。
如果我们直接使用 `rustc` 编译一个不同的程序，因为文件不同了，那就需要执行不同的命令了。
如果我们指定任何编译选项或者包含外部依赖，那需要执行的命令便更加具体(和复杂)。

更进一步来说，大多数程序会有额外的外部依赖，这些外部依赖又会有其他依赖。
那么手动维护必要依赖的正确版本并保持依赖的版本更新便是一件费力不讨好的事。

相较于直接跟 crate 和 `rustc` 打交道，
我们可以通过引入更高层的 ["*包(package)*"][def-package] 抽象概念
并使用 [*包管理器*][def-package-manager] 来避免这些手动的乏味工作。

### 走进 Cargo

*Cargo* 是 Rust 的包管理器。它是让 Rust 的 [*packages*][def-package] 声明不同的依赖并保证可重复构建的工具

Cargo 做了以下四件事来实现这个目标:

* 引入两个包含多种包信息的元数据文件。
* 下载并构建包的依赖。
* 调用 `rustc` 或其他构建工具以及正确的参数来构建包。
* 引入规范令我们与 Rust 的包的工作更简单。

Cargo 在很大程度上标准化了构建程序或包的命令；这仅是上述规范的一个方面。
下文中我们可以看到，相同的命令可以用于构建不同的 [*artifacts*][def-artifact] 即使它们的名称不同。
相较于直接调用 `rustc` ，我们可以调用 `cargo build` 等更加通用的命令，让 cargo 解决构建正确的 `rustc` 调用。
更进一步，Cargo 可以自动从 [*registry*][def-registry] 下载我们为 artifact 定义的任何依赖，并将依赖合并在构建中。

夸张一点说，一旦你学会使用 Cargo 构建项目，你也学会了使用 *所有* 包管理器构建项目。

[def-artifact]:         ../appendix/glossary.md#artifact         '"artifact" (glossary entry)'
[def-crate]:            ../appendix/glossary.md#crate            '"crate" (glossary entry)'
[def-package]:          ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-package-manager]:  ../appendix/glossary.md#package-manager  '"package manager" (glossary entry)'
[def-registry]:         ../appendix/glossary.md#registry         '"registry" (glossary entry)'
