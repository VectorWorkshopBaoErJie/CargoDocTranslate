## 配置清单格式

每个包的 `Cargo.toml` 文件称为 *manifest* "配置清单" ，以[TOML]格式编写。
其包含编译包时所需的元数据。要了解更多关于cargo如何查找配置清单文件的细节，请查看 `cargo locate-project` 部分。

每个配置清单文件由以下部分组成:

* [`cargo-features`](unstable.md) — 不稳定的、每日构建的特性。
* [`[package]`](#the-package-section) — 包的定义。
  * [`name`](#the-name-field) — 包的名称。
  * [`version`](#the-version-field) — 包的版本。
  * [`authors`](#the-authors-field) — 包的作者。
  * [`edition`](#the-edition-field) — Rust版次。
  * [`rust-version`](#the-rust-version-field) — 最小支持的Rust版本。
  * [`description`](#the-description-field) — 包的描述。
  * [`documentation`](#the-documentation-field) — 包的文档URL。
  * [`readme`](#the-readme-field) — 包的README文件路径。
  * [`homepage`](#the-homepage-field) — 包的主页URL。
  * [`repository`](#the-repository-field) — 包的源库URL。
  * [`license`](#the-license-and-license-file-fields) — 包的协议。
  * [`license-file`](#the-license-and-license-file-fields) — 许可证文本的路径。
  * [`keywords`](#the-keywords-field) — 包的关键词。
  * [`categories`](#the-categories-field) — 包的类别。
  * [`workspace`](#the-workspace-field) — 包的工作空间路径。
  * [`build`](#the-build-field) — 包的构建脚本路径。
  * [`links`](#the-links-field) — 包与之链接的本地库的名称。
  * [`exclude`](#the-exclude-and-include-fields) — 发布时要排除的文件。
  * [`include`](#the-exclude-and-include-fields) — 发布时要包含的文件。
  * [`publish`](#the-publish-field) — 可用于防止发布包。
  * [`metadata`](#the-metadata-table) — 插件的附加设置。
  * [`default-run`](#the-default-run-field) — 由 [`cargo run`] 运行的默认二进制。
  * [`autobins`](cargo-targets.md#target-auto-discovery) — 禁用二进制自动搜索。
  * [`autoexamples`](cargo-targets.md#target-auto-discovery) — 禁用实例自动搜索。
  * [`autotests`](cargo-targets.md#target-auto-discovery) — 禁用测试自动搜索。
  * [`autobenches`](cargo-targets.md#target-auto-discovery) — 禁用性能测试自动搜索。
  * [`resolver`](resolver.md#resolver-versions) — 设置要使用的依赖解析器。
* 目标表: (参阅 [configuration](cargo-targets.md#configuring-a-target) )
  * [`[lib]`](cargo-targets.md#library) — 库目标设置。
  * [`[[bin]]`](cargo-targets.md#binaries) — 二进制目标设置。
  * [`[[example]]`](cargo-targets.md#examples) — 实例目标设置。
  * [`[[test]]`](cargo-targets.md#tests) — 测试目标设置。
  * [`[[bench]]`](cargo-targets.md#benchmarks) — 性能测试目标设置。
* 依赖表:
  * [`[dependencies]`](specifying-dependencies.md) — 包的库依赖。
  * [`[dev-dependencies]`](specifying-dependencies.md#development-dependencies) — 实例、测试、性能测试的依赖。
  * [`[build-dependencies]`](specifying-dependencies.md#build-dependencies) — 构建脚本依赖。
  * [`[target]`](specifying-dependencies.md#platform-specific-dependencies) — 特定平台依赖。
* [`[badges]`](#the-badges-section) — 显示在注册中心的标志。
* [`[features]`](features.md) — 条件编译特性。
* [`[patch]`](overriding-dependencies.md#the-patch-section) — 覆盖依赖。
* [`[replace]`](overriding-dependencies.md#the-replace-section) — 覆盖依赖 (弃用) 。
* [`[profile]`](profiles.md) — 编译器设置和优化。
* [`[workspace]`](workspaces.md) — 工作空间的定义。

<a id="package-metadata"></a>
### `[package]` 部分

在 `Cargo.toml` 中最先的部分就是 `[package]` 。

```toml
[package]
name = "hello_world" # 包的名称
version = "0.1.0"    # 当前的语义化版本。
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

Cargo 仅需要的字段是 [`name`](#the-name-field) 和 [`version`](#the-version-field) 。
如果发布到注册中心，那么可能需要额外的字段。
关于发布到[crates.io]的要求，请参见下面的注释和[发布章节][publishing]。

#### `name` 字段

包的名称是用来引用包的标识符。
可被列为另一个包的依赖，并作为lib和bin目标所推断的默认名称。

该名称只能使用 [字母数字] 、 `-` 、 `_` ，并且不能为空。

需注意，[`cargo new`]和[`cargo init`]对包名有一些额外的限制，如强制要求为有效的Rust标识符，而不能是关键字。
[crates.io]有更多的限制，比如说:

- 仅允许ASCII字符。
- 不能使用保留名称。
- 不要使用特殊的Windows名称，如 "nul" 。
- 最长使用64个字符。

[alphanumeric]: ../../std/primitive.char.html#method.is_alphanumeric

#### `version` 字段

Cargo 遵循 [语义化版本](https://semver.org/) 的概念，遵循一些基本规则:

* 在达到1.0.0之前，可以任意演进，但如果做了破坏性的改变，就要增加次要版本。在Rust中，破坏性修改包括向结构体添加字段或向枚举添加变体。
* 在1.0.0之后，只有在递增主版本的时候才可以进行破坏性的修改。不要破坏构建。
* 1.0.0之后，不要在补丁版本中添加任何新的公共API(即没有新的 `pub` 接口)。如果添加任何新的 `pub` 结构体、trait、字段、类型、函数、方法或其他内容，总是递增次要版本。
* 使用有三个数字部分的版本号，如1.0.0而不是1.0。

请参阅 [Resolver] 章节，了解更多关于Cargo如何使用版本号来解决依赖，以及自己设置版本号的指南。
参见 [语义化兼容] 一章，以了解更多关于什么是破坏性变化的细节。

[Resolver]: resolver.md
[语义化兼容]: semver.md

<a id="the-authors-field-optional"></a>
####  `authors` 字段

可选的 `authors` 字段，以数组形式列出包的 "作者" 人或组织。
确切的意思有多种解释--可以列出原始或主要的作者、当前的维护者或者包的所有者。
可以在每个作者条目末尾的斜方括号内包含可选的电子邮件。

```toml
[package]
# ...
authors = ["Graydon Hoare", "Fnu Lnu <no-reply@rust-lang.org>"]
```

这个字段仅在包的metadata 和 `build.rs` 中的 `CARGO_PKG_AUTHORS` 环境变量中出现。不显示在 [crates.io] 用户界面中。

> **警告**: 包的配置一旦发布就不能改变，所以不能在包已发布版本中改变或删除这个字段。

<a id="the-edition-field-optional"></a>
####  `edition` 字段

`edition` 是可选的键，影响包编译的 [Rust Edition] "版次"。
在 `[package]` 中设置 `edition` 键会影响到包中的所有targets/crates，包括测试套件、性能测试、二进制文件、实例等。

```toml
[package]
# ...
edition = '2021'
```

大多数配置清单的 `edition` 字段由 [`cargo new`] 自动填充，为最新的稳定版本。
`cargo new` 默认创建的是2021版。

如果 `Cargo.toml` 中没有 `edition` 字段，那么为了向后兼容，将假定为2015版。
请注意，凡是用 [`cargo new`] 创建的配置清单不会使用这种历史版次，而会将 `edition` 指定为一个较新的值。

#### `rust-version` 字段

`rust-version` 字段是可选的键，它告知cargo包可以用哪个版本的Rust语言和编译器来编译。
如果当前选择的Rust编译器的版本比声明的版本早，cargo会退出，并告诉用户需要什么版本。

第一个支持这个字段的Cargo版本是随着Rust 1.56.0发布的。
在旧版本中，这个字段会被忽略，Cargo会显示一个警告。

```toml
[package]
# ...
rust-version = "1.56"
```

Rust版本必须是由两或三个部分组成的基础版本号，不能包括语义化操作符或预发布标识符。
在检查Rust版本时，将忽略编译器的预发布标识符，如-nightly。
`rust-version` 必须等于或高于首次引入配置的 `edition` 的版本。

可以使用 `--ignore-rust-version` 选项忽略 `rust-version` 。

在 `[package]` 中设置 `rust-version` 键将影响包中的所有 target/crates ，包括测试套件、性能测试、二进制文件、实例等。

#### `description` 字段

是包的简介。[crates.io]会在包中显示这个内容，需是纯文本(不是Markdown)。

```toml
[package]
# ...
description = "A short description of my package"
```

> **注意**: [crates.io] 需要 `description` 设置。

<a id="the-documentation-field-optional"></a>
#### `documentation` 字段

`documentation` 字段指定托管了crate文档网站的URL。
如果配置清单文件中没有指定URL，则 [crates.io] 会自动将你的crate链接到相应的 [docs.rs] 页面。

```toml
[package]
# ...
documentation = "https://docs.rs/bitflags"
```

#### `readme` 字段

`readme` 字段应该是包根位置的文件的路径(相对于这个 `Cargo.toml` )，其中包含关于包的常规信息。
当你发布时，这个文件将迁移到注册中心。
[crates.io] 将以Markdown解释它，并在crate的页面上呈现。

```toml
[package]
# ...
readme = "README.md"
```

如果没有指定这个字段的值，并且在包的根位置存在名为 `README.md` 、 `README.txt` 或 `README` 的文件，那么将使用该名称文件。
你可以通过设置这个字段为 `false` 来阻止这种行为。如果该字段被设置为 `true` ，将假定默认值为 `README.md` 。

#### `homepage` 字段

`homepage` 字段应是包主页网站的URL。

```toml
[package]
# ...
homepage = "https://serde.rs/"
```

#### `repository` 字段

`repository` 字段应是包的源存储库的URL。

```toml
[package]
# ...
repository = "https://github.com/rust-lang/cargo/"
```

#### `license` 和 `license-file` 字段

`license` 字段包含软件许可证的名称，包根据该许可证发布。
`license-file` 字段包含许可证文本的文件路径(相对于当前 `Cargo.toml` )。

[crates.io]将 `license` 字段解释为 [SPDX 2.1 license expression][spdx-2.1-license-expressions] 。
该名称必须是 [SPDX license list 3.11][spdx-license-list-3.11] 中的一个已知许可证。
目前不支持括号。更多信息请参见 [SPDX网站] 。

SPDX许可证表达式支持AND和OR运算符，以组合多个许可证。[^slash]

```toml
[package]
# ...
license = "MIT OR Apache-2.0"
```

使用 `OR` 表示用户可以选择任何一项许可证。使用 `AND` 表示用户必须同时遵守两个许可证。
使用 `WITH` 操作符表示有特殊例外的许可证。一些例子:

* `MIT OR Apache-2.0`
* `LGPL-2.1-only AND MIT AND BSD-2-Clause`
* `GPL-2.0-or-later WITH Bison-exception-2.2`

如果包使用非标准的许可证，那么可以指定 `license-file` 字段来代替 `license` 字段。

```toml
[package]
# ...
license-file = "LICENSE.txt"
```

> **注意**: [crates.io] 要求设置 `license` 或 `license-file` 。

[^slash]: 以前，多个许可证可以用 `/` 来分隔，但这种用法已经过时了。

#### `keywords` 字段

`keywords` 字段是描述这个包的字符串数组。
当在注册中心搜索该包时，提供帮助，你可以选择任意可以帮助别人找到这个crate的词。

```toml
[package]
# ...
keywords = ["gamedev", "graphics"]
```

> **注意**: [crates.io]最多可以有5个关键词。每个关键词必须是ASCII文本，以字母开头，只包含字母、数字、 `_` 或 `-` ，最多20个字符。

#### `categories` 字段

`categories` 字段是一个字符串数组，表示该包所属的类别。

```toml
categories = ["command-line-utilities", "development-tools::cargo-plugins"]
```

> **注意**: [crates.io] 最多可以有5个类别。每个类别应与 <https://crates.io/category_slugs> 中的一个字符串完全匹配。

<a id="the-workspace--field-optional"></a>
#### `workspace` 字段

`workspace` 字段可用于配置包作为其成员的工作空间。
如果没有指定，将被推断为文件系统向上第一个带有 `[workspace]` 的 Cargo.toml。
如果成员不在工作空间根目录的子目录中，则设置这个是有用的。

```toml
[package]
# ...
workspace = "path/to/workspace/root"
```

如果配置清单中已经定义了 `[workspace]` 表，则不能指定此字段。
也就是说，crate 不能既是一个工作空间的根 crate (包含 `[workspace]`)，又是另一个工作空间的成员 crate (包含 `package.workspace` )。

了解更多信息，请参见[工作空间章节](workspaces.md)。

<a id="package-build"></a>
<a id="the-build-field-optional"></a>
#### `build` 字段

`build` 字段指定包根位置的文件，该文件是用于构建本地代码的[构建脚本]。
更多信息可以在 [构建脚本指南][build script] 中找到。

[build script]: build-scripts.md

```toml
[package]
# ...
build = "build.rs"
```

默认是 `"build.rs"` ，从包根目录下的 `build.rs` 文件中加载脚本。
使用 `build = "custom_build_name.rs"` 来指定不同文件的路径，或者使用 `build = false` 来禁止自动检测构建脚本。

<a id="the-links-field-optional"></a>
#### `links` 字段

`links` 字段指定了被链接的本地库的名称。
更多信息可以在构建脚本指南的 [`links`][link] 部分找到。

[links]: build-scripts.md#the-links-manifest-key

例如，可以指定链接名为 "git2" 的本地库crate (如Linux上的 `libgit2.a` )。

```toml
[package]
# ...
links = "git2"
```

<a id="the-exclude-and-include-fields-optional"></a>
#### `exclude` 和 `include` 字段

`exclude` 和 `include` 字段可以用来明确指定哪些文件在进行打包[发布][publishing]项目时被包含，以及某些种类的变更跟踪(如下所述)。
在 `exclude` 字段中指定的模式确定了一组不包括的文件，而 `include` 中的模式指定了明确包括的文件。
可以运行 [`cargo package --list`][`cargo package`] 来验证哪些文件被包含在包中。

```toml
[package]
# ...
exclude = ["/ci", "images/", ".*"]
```

```toml
[package]
# ...
include = ["/src", "COPYRIGHT", "/examples", "!/examples/big_example"]
```

如果这两个字段都没有被指定，默认情况是包括包根位置的所有文件，除了下面列出的例外情况。

如果未指定 `include` ，则以下文件将被排除:

* 如果包不在git仓库中，所有以点开头的"隐藏"文件都会被跳过。
* 如果包在git仓库中，任何被仓库和全局git配置的[gitignore]规则所忽略的文件都将被跳过。

不管是指定 `exclude` 或 `include` ，以下文件总是被排除在外:

* 任何子包将被跳过(任何包含 `Cargo.toml` 文件的子目录)。
* 在包根位置的名为 `target` 的目录将被跳过。

以下文件总是被包含:

* 包本身的 `Cargo.toml` 文件总是包括在内，不需要列在 `include` 中。
* 如果包包含二进制或示例目标，则会自动包含最小化的 `Cargo.lock` ，更多信息请参见 [`cargo package`] 。
* 如果指定了 [`license-file`](#the-license-and-license-file-fields)，其总是包括在内。

这些选项是相互排斥的；设置 `include` 将覆盖 `exclude` 。
如果你需要对一组 `include` 文件进行排除，使用下面描述的 `!` 操作符。

其模式是[gitignore]格式。简而言之:

- `foo` 匹配包中任何名字为 `foo` 的文件或目录。这等同于模式 `**/foo` 。
- `/foo` 匹配任何文件或目录，名称为 `foo` ，仅在包根位置。
- `foo/` 匹配包中任何名字为 `foo` 的 *目录* 。
- 支持常见的通配符模式，如 `*` ， `?` ，和 `[]` 。
  - `*` 匹配除 `/` 以外的零个或多个字符。例如， `*.html` 匹配包中任何带有 `.html` 扩展名的文件或目录。
  - `?` 匹配除 `/` 以外的任何字符。例如，`foo?` 匹配 `food` ， 但不匹配 `foo` 。
  - `[]` 允许匹配一定范围的字符。例如， `[ab]` 匹配 `a` 或 `b`。 `[a-z]` 匹配字母 a 到 z。
- `**/` 前缀可以在任何目录下匹配。例如， `**/foo/bar` 匹配直接位于 `foo` 目录下的任何文件或目录 `bar` 。
- `/**` 后缀匹配里面的所有文件。例如，`foo/**` 匹配目录 `foo` 内的所有文件，包括 `foo` 下面子目录中的所有文件。
- `/**/`  匹配零个或多个目录。例如， `a/**/b` 匹配 `a/b` ， `a/x/b` ， `a/x/y/b` ，以此类推。
- `!` 前缀否定了一个模式。例如， `src/*.rs` 和 `!foo.rs` 的模式将匹配 `src` 目录下所有扩展名为 `.rs` 的文件，但不包括任何名为 `foo.rs` 的文件。

在某些情况下，include/exclude 列表用于变化跟踪。
对于用 `rustdoc` 构建的目标，其用来确定追踪的文件列表，以确定目标是否应该被重新构建。
如果包有一个未发送任何 `rerun-if-*` 指令的 [build script] ，那么 include/exclude 列表就用来跟踪这些文件变化，推断构建脚本是否应该重新运行。

[gitignore]: https://git-scm.com/docs/gitignore

<a id="the-publish--field-optional"></a>
#### `publish` 字段

`publish` 字段可以用来防止一个包被错误地发布到包注册中心(如*crates.io*)，比如，在公司里需要保持包为私密的。

```toml
[package]
# ...
publish = false
```

该值也可以是一个字符串数组，这些字符串是允许发布的注册中心的名称。

```toml
[package]
# ...
publish = ["some-registry-name"]
```

如果发布数组包含单个注册中心，当未指定 `--registry` 标志时， `cargo publish` 命令将使用它。

<a id="the-metadata-table-optional"></a>
#### `metadata` 表

默认情况下，Cargo会对 `Cargo.toml` 中未使用的键发出警告，以帮助检测错别字之类的。
然而，Cargo 完全忽略 `package.metadata` 表，不会警告。
这一部分可以用于一些包工具在 `Cargo.toml` 中存储配置。比如说:

```toml
[package]
name = "..."
# ...

# 例如，生成Android APK时使用的元数据。
[package.metadata.android]
package-name = "my-awesome-android-app"
assets = "path/to/static"
```

在工作空间层级也有类似的表，位于[`workspace.metadata`][workspace-metadata]。
虽然cargo没有指定这两个表的内容格式，但建议插件以一致的方式使用它们，例如，
如果 `package.metadata` 中缺少数据，就引用 `workspace.metadata` 中的数据，只要对相关工具来说合理。

[workspace-metadata]: workspaces.md#the-metadata-table

#### `default-run` 字段

配置清单中 `[package]` 部分的 `default-run` 字段可用于指定由 [`cargo run`] 选择的默认二进制文件。
例如，当同时存在 `src/bin/a.rs` 和 `src/bin/b.rs` 时:

```toml
[package]
default-run = "a"
```

### `[badges]` 部分

 `[badges]` 部分用于指定状态标志，当包发布时可以在注册中心网站上显示。

> 注意: [crates.io] 以前在其网站中crate旁边显示标志，但该功能已被删除。
> 包应在其README文件中放置标志，该文件将在[crates.io]上显示(参阅[`readme` 字段](#the-readme-field))。

```toml
[badges]
# `maintenance` 表表示crate的维护状态。
# 这可能被一个注册中心使用，但目前crates.io没有使用。
# 参阅 https://github.com/rust-lang/crates.io/issues/2437 和 https://github.com/rust-lang/crates.io/issues/2438。
#
# `status` 字段是必填字段。可用的选项有:
# - `actively-developed`: 新功能正在添加，bug正在修复。
# - `passively-maintained`: 目前还没有新功能的计划，但维护者打算对提交的问题作出回应。
# - `as-is`:  这个板块的功能是完整的，维护者不打算继续工作或提供支持，但它可以满足它所设计的目的。
# - `experimental`: 作者希望与社区分享，但并不打算满足任何人的特定使用情况。
# - `looking-for-maintainer`: 目前的维护者想把这个crate转让给其他人。
# - `deprecated`: 维护者不建议使用这个crate (crate的描述可以说明原因，可能有更好的解决方案，或者crate可能存在作者不想修复的问题)。
# - `none`: 在crates.io上未显示标志，因为维护者没有选择说明他们的意图，潜在的crate用户需要自己去查寻。
maintenance = { status = "..." }
```

### 依赖部分

参阅 [特定依赖页](specifying-dependencies.md) 在 `[dependencies]` , `[dev-dependencies]` , `[build-dependencies]` , 和 target-specific `[target.*.dependencies]` 部分.

### `[profile.*]` 部分

`[profile]` 表提供了一种定制编译器设置的方法，如优化和调试设置。
更多细节请参见[编译设置章节](profiles.md)。



[`cargo init`]: ../commands/cargo-init.md
[`cargo new`]: ../commands/cargo-new.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo run`]: ../commands/cargo-run.md
[crates.io]: https://crates.io/
[docs.rs]: https://docs.rs/
[publishing]: publishing.md
[Rust 版次]: ../../edition-guide/index.html
[spdx-2.1-license-expressions]: https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60
[spdx-license-list-3.11]: https://github.com/spdx/license-list-data/tree/v3.11
[SPDX网站]: https://spdx.org/license-list
[TOML]: https://toml.io/

<script>
(function() {
    var fragments = {
        "#the-project-layout": "../guide/project-layout.html",
        "#examples": "cargo-targets.html#examples",
        "#tests": "cargo-targets.html#tests",
        "#integration-tests": "cargo-targets.html#integration-tests",
        "#configuring-a-target": "cargo-targets.html#configuring-a-target",
        "#target-auto-discovery": "cargo-targets.html#target-auto-discovery",
        "#the-required-features-field-optional": "cargo-targets.html#the-required-features-field",
        "#building-dynamic-or-static-libraries": "cargo-targets.html#the-crate-type-field",
        "#the-workspace-section": "workspaces.html#the-workspace-section",
        "#virtual-workspace": "workspaces.html",
        "#package-selection": "workspaces.html#package-selection",
        "#the-features-section": "features.html#the-features-section",
        "#rules": "features.html",
        "#usage-in-end-products": "features.html",
        "#usage-in-packages": "features.html",
        "#the-patch-section": "overriding-dependencies.html#the-patch-section",
        "#using-patch-with-multiple-versions": "overriding-dependencies.html#using-patch-with-multiple-versions",
        "#the-replace-section": "overriding-dependencies.html#the-replace-section",
    };
    var target = fragments[window.location.hash];
    if (target) {
        var url = window.location.toString();
        var base = url.substring(0, url.lastIndexOf('/'));
        window.location.replace(base + "/" + target);
    }
})();
</script>
