## 为何有Cargo

### 初识

在 Rust 中，一个类库或可执行程序称为一个 [*crate*][def-crate] 。
使用 Rust 编译器 `rustc` 编译 Crate 。
刚开始学习 Rust 时，经典的 "hello world" 程序，可以通过 `rustc` 直接编译:

```console
$ rustc hello.rs
$ ./hello
Hello, world!
```

请注意，上面的命令需要显式指定文件名。
如果直接使用 `rustc` 编译不同的程序，不同的文件就需要执行不同的命令。
如果需要指定编译选项或包含的外部依赖，就需要十分具体详尽的执行命令。

而且，大多数程序会有额外的外部依赖，这些外部依赖又会有其他依赖。
此时手动维护必要依赖的正确版本，并协调依赖版本更新会很困难。

相较于直接跟 crate 和 `rustc` 打交道，引入了更高层 ["*包(package)*"][def-package] 的抽象。
并使用 [*包管理器*][def-package-manager] 来避免这些手动的乏味工作。

### 走进 Cargo

*Cargo* 是 Rust 的包管理器。它是工具，允许 Rust [*packages*][def-package] 声明其各种依赖关系，确保总是能得到一个可重复的构建。

Cargo 做了以下四件事来实现这个目标:

* 引进两个文件，包含包的各类元数据信息。
* 下载并构建包的依赖。
* 调用 `rustc` 或其他构建工具及正确的参数来构建包。
* 引进规范使 Rust 包的操作更简单。

Cargo 在很大程度的标准化了构建程序或包的命令，这是上述规范的一个方面。
从下文中可以看到，相同的命令可以构建名称不同的 [*artifacts*][def-artifact] "制品"。
相比直接调用 `rustc` ，可以调用 `cargo build` 等更加通用的命令，而让 cargo 正确的调用 `rustc` 去构建。
并且，Cargo 可以自动从 [*registry*][def-registry] "注册中心"下载依赖，并将依赖合并到构建中。

夸张一点说，一旦你学会使用 Cargo 就可以构建 *所有* 项目。

[def-artifact]:         ../appendix/glossary.md#artifact         '"artifact" (glossary entry)'
[def-crate]:            ../appendix/glossary.md#crate            '"crate" (glossary entry)'
[def-package]:          ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-package-manager]:  ../appendix/glossary.md#package-manager  '"package manager" (glossary entry)'
[def-registry]:         ../appendix/glossary.md#registry         '"registry" (glossary entry)'
