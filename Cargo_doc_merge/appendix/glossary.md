# 词汇表

### 制品

*artifact* "制品"是指编译进程最终创建的文件或文件集，包括可链接库、可执行的二进制文件和生成的文档。

### Cargo

*Cargo* 是Rust的[*包管理器*](#package-manager)，也是本书涉及的主要内容。

### Cargo.lock

参阅 [*lock 文件*](#lock-file)。

### Cargo.toml

参阅 [*配置清单*](#manifest)。

### Crate

Rust *crate* 是指一个库或一个可执行程序，分别称为 *library crate* 或 *binary crate* 。

Cargo [package](#package)定义的每个[target](#target)都是*crate*。

广义来说，术语 *crate* 可以指目标源代码或目标产生的编译制品，也可以指从[注册中心](#registry)获取的压缩包。

指定crate源代码可以细分为[*modules*](#module) "模块"。

### 版本

*Rust版本* 是Rust语言的发展标志。[包的版本][edition-field]是在 `Cargo.toml` [配置清单](#manifest)中指定的，不同的目标可以指定对应版本来使用。更多信息请参阅[版本指南]。

### 特性

*feature* "特性" 的含义取决于上下文:

- [*feature*][feature]是一个命名的标志，允许有条件的编译。一个特性可以指一个可选的依赖，也可以指一个任意的名字，在 `Cargo.toml` [manifest](#manifest) 中定义，可在源代码中检查。

- Cargo有[*不稳定特性标记*][cargo-unstable]，可以用来启用Cargo本身的实验性特性。

- Rust编译器和Rustdoc有自己的不稳定特性标志 (参阅[不稳定篇][unstable-book]和[Rustdoc篇][rustdoc-unstable]）。

- CPU 目标有[*目标特性*][target-feature]，指定CPU的性能。

### 索引

*index* "索引" 是[*注册中心*](#registry)中 [*crates*](#crate) 的可搜索列表。

### Lock 文件

`Cargo.lock` *lock文件* 记录 [*workspace*](#workspace)或[*package*](#package)中使用的每个依赖的确切版本。它是由Cargo自动生成的。参阅 [Cargo.toml vs Cargo.lock] 。

### 配置清单

其名为 `Cargo.toml` 的文件中，[*配置清单*][manifest]是对[package](#package)或[workspace](#workspace)的描述。

[*虚拟配置清单*][virtual manifest] `Cargo.toml` 文件，仅描述一个工作空间，不包含包。

### 成员

*member* "成员"是属于[*workspace*](#workspace) 的 [*package*](#package)。

### 模块

Rust的模块系统将代码组织成称为 *modules* "模块"的逻辑单元，在代码中提供独立的命名空间。

指定的 [crate](#crate) 的源代码可以被细分为一个或多个独立的模块。这样做通常是为了将代码组织在相关的功能区域，或者来控制源代码中的标识符(结构体、函数等)的可见性(public/private) "公共/私有"。

[`Cargo.toml`](#manifest)文件主要关注它所定义的[package](#package)、crates、它们所依赖的crates的包。尽管如此，在使用Rust时，你会经常注意到 "模块" 这个术语，所以你应该了解模块与crate的关系。

### 包

*package* "包" 是对源文件集合和 `Cargo.toml` [*manifest*](#manifest) 文件的描述。包对应的名称和版本，用来指定包之间的依赖关系。

package "包" 包含多个[*target*](#target)，每个都是一个[*crate*](#crate)。 `Cargo.toml` 文件描述了包内的crate的二进制或库的类型，以及每个crate的一些元数据--如何构建每个crate，它们的直接依赖是什么，等等，这正是本书所描述的。

*package root* "包的根" 是指包的 `Cargo.toml` 配置清单所在的目录。(相对于[*工作区根*](#workspace))。

[*package ID specification*][pkgid-spec]，或 *SPEC* ，是一个字符串，用来唯一地引用一个特定来源包的特定版本。

尽管多个crates是很常见的，但往往中小型的Rust项目只需要一个包。

较大的项目可能涉及多个软件包，在这种情况下，Cargo [*workspaces*](#workspace) 可以用来管理软件包之间的共同依赖和其他相关元数据。

### 包管理

广义上讲，*包管理器* 是软件生态系统中的一个程序(或相关程序的集合)，它可以自动获取、安装和升级制品。在编程语言的生态系统中，软件包管理器是以开发者为中心的工具，其主要功能是从一些中心存储库中下载库的制品和它们的依赖；这种功能通常与执行软件构建的功能相结合(通过调用特定语言的编译器)。

[*Cargo*](#cargo)是Rust生态系统中的软件包管理器。Cargo下载 Rust [package](#package)的依赖项([*artifacts*](#artifact)被称为[*crates*](#crate))、编译包、制作可分享的包，并(可选择)将它们上传到Rust社区的 [*package 注册中心*](#registry)。

### 包注册中心

参阅 [*注册中心*](#registry)。

### 项目

[package](#package) 的另一个名称。

### 注册中心

*registry* "注册中心" 服务，拥有可下载的[*crates*](#crate)集合，可以作为[*package*](#package)的依赖而被安装使用。Rust生态系统中的默认注册中心是[crates.io](https://crates.io)。
该注册中心有一个[*index*](#index)，包含了所有crate的列表，并告知Cargo如何下载需要的crate。

### 源

一个*source* "源" 是拥有[*crates*](#crate)的提供者，它可以作为 [*package*](#package) 的依赖项。源有以下几种类型:

- **注册中心源** — 参阅 [注册中心](#registry)。
- **本地注册源** — 一组以压缩文件形式存储在文件系统中的crates。参阅 [本地注册源] 。
- **目录源** — 一组以压缩文件形式存储在文件系统中的crates。参阅 [目录源].
- **路径源** — 在文件系统是独立包(如[路径依赖])或多个软件包的集合(比如[路径覆盖])。
- **Git源** — 位于git仓库中的包(比如[git 依赖]或[git 源])。

详见 [源替换]。

### Spec

参阅 [package ID specification](#package) 。

### 目标

 *target* "目标"术语的含义取决于上下文:

- **Cargo 目标** — Cargo [*packages*](#package) *targets* ，对应于将要生成的 [*制品*](#artifact)。包可以有库、二进制、示例、测试和性能测试目标。在 `Cargo.toml` [*manifest*](#manifest)中配置[目标列表][targets]，通常由源文件的[目录层级]自动推断。
- **目标目录** — Cargo将所有构建的制品和中间文件放在 *目标* 目录中。默认情况下是一个名称为 `target` 的目录，位于 [*workspace*](#workspace) 根目录下，如果不使用工作区，则为包的根目录。该目录可以通过 `--target-dir` 命令行选项、`CARGO_TARGET_DIR`[环境变量]或 `build.target-dir` [配置选项] 来改变。
- **目标架构** — 操作系统以及机器架构中所构建的制品通常被称为 *目标* 。
- **目标三元组** — 三元组架构是指定目标体系结构的特定格式。三元组可以被称为 *目标三元组* ，它是生成制品的体系结构，而 *host triple* 是编译器运行的体系结构。目标三元组可以通过命令行选项 `--target` 或 `build.target` [配置选项] 指定。三元组的一般格式是 `<arch><sub>-<vendor>-<sys>-<abi>` :

  - `arch` = CPU基础架构, 例如 `x86_64`, `i686`, `arm`, `thumb`, `mips` 等。
  - `sub` = CPU子架构, 例如 `arm` has `v7`, `v7s`, `v5te` 等。
  - `vendor` = 供应商 , 例如 `unknown`, `apple`, `pc`, `nvidia` 等.
  - `sys` = 系统名称, 例如 `linux`, `windows`, `darwin` 等。 `none` 是没有操作系统的裸机.
  - `abi` = ABI, 例如 `gnu`, `android`, `eabi` 等。

  一些可省略参数。运行 `rustc --print target-list` 获取列表。

### 测试目标

Cargo *测试目标* 生成的二进制文件有助于验证代码的正确操作和准确性。有两种类型的测试制品:

* **单元测试** — *单元测试*是可执行的二进制文件，由库或二进制目标直接编译生成。它包含库或二进制代码的全部内容，并运行 `#[test]` 注解的函数，旨在验证各个单元的代码。
* **集成测试目标** — [*集成测试目标*][integration-tests] 是由 *测试目标* 编译的可执行二进制文件，该目标是一个独立的 [*crate*](#crate) ，其来源位于 `tests` 目录下或由 `Cargo.toml` [*manifest*](#manifest) 中的 [`[[test]]` table][targets] 指定。它的目的是只测试一个库的公共API，或执行一个二进制文件以验证操作。

### 工作空间

[*workspace*][workspace] 是一个或多个 [*packages*](#package) 的集合，它们共享共同的依赖(拥有共享的`Cargo.lock` [*lock file*](#lock-file))、输出目录，各项设置，如配置文件。

[*虚拟工作区*][virtual] 根 `Cargo.toml` [*manifest*](#manifest) 没有定义包，只列出工作区 [*成员*](#member) 。

*工作区根* 是工作区的 `Cargo.toml` 配置清单所在的目录。 (相对于[*package root*](#package))。


[Cargo.toml vs Cargo.lock]: ../guide/cargo-toml-vs-cargo-lock.md
[目录源]: ../reference/source-replacement.md#directory-sources
[本地注册源]: ../reference/source-replacement.md#local-registry-sources
[源替换]: ../reference/source-replacement.md
[cargo-unstable]: ../reference/unstable.md
[配置选项]: ../reference/config.md
[crates.io]: https://crates.io/
[目录层级]: ../guide/project-layout.md
[版本指南]: ../../edition-guide/index.html
[edition-field]: ../reference/manifest.md#the-edition-field
[环境变量]: ../reference/environment-variables.md
[feature]: ../reference/features.md
[git 依赖]: ../reference/specifying-dependencies.md#specifying-dependencies-from-git-repositories
[git 源]: ../reference/source-replacement.md
[integration-tests]: ../reference/cargo-targets.md#integration-tests
[manifest]: ../reference/manifest.md
[路径依赖]: ../reference/specifying-dependencies.md#specifying-path-dependencies
[path overrides]: ../reference/overriding-dependencies.md#paths-overrides
[pkgid-spec]: ../reference/pkgid-spec.md
[rustdoc-unstable]: https://doc.rust-lang.org/nightly/rustdoc/unstable-features.html
[target-feature]: ../../reference/attributes/codegen.html#the-target_feature-attribute
[targets]: ../reference/cargo-targets.md#configuring-a-target
[unstable-book]: https://doc.rust-lang.org/nightly/unstable-book/index.html
[virtual]: ../reference/workspaces.md
[workspace]: ../reference/workspaces.md
