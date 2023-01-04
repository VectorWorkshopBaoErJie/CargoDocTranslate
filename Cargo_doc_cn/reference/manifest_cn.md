{==+==}
## The Manifest Format
{==+==}
## 配置清单格式
{==+==}

{==+==}
The `Cargo.toml` file for each package is called its *manifest*. It is written
in the [TOML] format. It contains metadata that is needed to compile the package. Checkout
the `cargo locate-project` section for more detail on how cargo finds the manifest file.
{==+==}
每个包的 `Cargo.toml` 文件被称为其*manifest* "配置清单"。它是以[TOML]格式编写的。
它包含编译包所需的元数据。查看 `cargo locate-project` 部分，了解更多关于cargo如何查找配置清单文件的细节。
{==+==}

{==+==}
Every manifest file consists of the following sections:
{==+==}
每个配置清单文件由以下部分组成:
{==+==}

{==+==}
* [`cargo-features`](unstable.md) — Unstable, nightly-only features.
* [`[package]`](#the-package-section) — Defines a package.
  * [`name`](#the-name-field) — The name of the package.
  * [`version`](#the-version-field) — The version of the package.
  * [`authors`](#the-authors-field) — The authors of the package.
  * [`edition`](#the-edition-field) — The Rust edition.
  * [`rust-version`](#the-rust-version-field) — The minimal supported Rust version.
  * [`description`](#the-description-field) — A description of the package.
  * [`documentation`](#the-documentation-field) — URL of the package documentation.
  * [`readme`](#the-readme-field) — Path to the package's README file.
  * [`homepage`](#the-homepage-field) — URL of the package homepage.
  * [`repository`](#the-repository-field) — URL of the package source repository.
  * [`license`](#the-license-and-license-file-fields) — The package license.
  * [`license-file`](#the-license-and-license-file-fields) — Path to the text of the license.
  * [`keywords`](#the-keywords-field) — Keywords for the package.
  * [`categories`](#the-categories-field) — Categories of the package.
  * [`workspace`](#the-workspace-field) — Path to the workspace for the package.
  * [`build`](#the-build-field) — Path to the package build script.
  * [`links`](#the-links-field) — Name of the native library the package links with.
  * [`exclude`](#the-exclude-and-include-fields) — Files to exclude when publishing.
  * [`include`](#the-exclude-and-include-fields) — Files to include when publishing.
  * [`publish`](#the-publish-field) — Can be used to prevent publishing the package.
  * [`metadata`](#the-metadata-table) — Extra settings for external tools.
  * [`default-run`](#the-default-run-field) — The default binary to run by [`cargo run`].
  * [`autobins`](cargo-targets.md#target-auto-discovery) — Disables binary auto discovery.
  * [`autoexamples`](cargo-targets.md#target-auto-discovery) — Disables example auto discovery.
  * [`autotests`](cargo-targets.md#target-auto-discovery) — Disables test auto discovery.
  * [`autobenches`](cargo-targets.md#target-auto-discovery) — Disables bench auto discovery.
  * [`resolver`](resolver.md#resolver-versions) — Sets the dependency resolver to use.
{==+==}
* [`cargo-features`](unstable.md) — 不稳定, 每日构建特性。
* [`[package]`](#the-package-section) — 定义包。
  * [`name`](#the-name-field) — 包的名字。
  * [`version`](#the-version-field) — 包的版本。
  * [`authors`](#the-authors-field) — 包的作者。
  * [`edition`](#the-edition-field) — Rust版次。
  * [`rust-version`](#the-rust-version-field) — 最小支持的Rust版本。
  * [`description`](#the-description-field) — 包的描述。
  * [`documentation`](#the-documentation-field) — 包文档的URL。
  * [`readme`](#the-readme-field) — 包的README文件路径。
  * [`homepage`](#the-homepage-field) — 包主页的URL。
  * [`repository`](#the-repository-field) — 包源库的URL。
  * [`license`](#the-license-and-license-file-fields) — 包协议。
  * [`license-file`](#the-license-and-license-file-fields) — 许可证文本的路径。
  * [`keywords`](#the-keywords-field) — 包的Keywords。
  * [`categories`](#the-categories-field) — 包的分类。
  * [`workspace`](#the-workspace-field) — 包的工作空间路径。
  * [`build`](#the-build-field) — 包的构建脚本路径。
  * [`links`](#the-links-field) — 包与之链接的本地库的名称。
  * [`exclude`](#the-exclude-and-include-fields) — 发布时要排除的文件。
  * [`include`](#the-exclude-and-include-fields) — 发布时要包含的文件。
  * [`publish`](#the-publish-field) — 可用于防止发布包。
  * [`metadata`](#the-metadata-table) — 外部工具的附加设置。
  * [`default-run`](#the-default-run-field) — 由 [`cargo run`] 运行的默认二进制。
  * [`autobins`](cargo-targets.md#target-auto-discovery) — 禁用二进制自动搜索。
  * [`autoexamples`](cargo-targets.md#target-auto-discovery) — 禁用例子自动搜索。
  * [`autotests`](cargo-targets.md#target-auto-discovery) — 禁用测试自动搜索。
  * [`autobenches`](cargo-targets.md#target-auto-discovery) — 禁用基准自动搜索。
  * [`resolver`](resolver.md#resolver-versions) — 设置要使用的依赖解析器。
{==+==}

{==+==}
* Target tables: (see [configuration](cargo-targets.md#configuring-a-target) for settings)
  * [`[lib]`](cargo-targets.md#library) — Library target settings.
  * [`[[bin]]`](cargo-targets.md#binaries) — Binary target settings.
  * [`[[example]]`](cargo-targets.md#examples) — Example target settings.
  * [`[[test]]`](cargo-targets.md#tests) — Test target settings.
  * [`[[bench]]`](cargo-targets.md#benchmarks) — Benchmark target settings.
{==+==}
* 目标表: (设置参阅 [configuration](cargo-targets.md#configuring-a-target) )
  * [`[lib]`](cargo-targets.md#library) — 库目标设置。
  * [`[[bin]]`](cargo-targets.md#binaries) — 二进制目标设置。
  * [`[[example]]`](cargo-targets.md#examples) — 实例目标设置。
  * [`[[test]]`](cargo-targets.md#tests) — 测试目标设置。
  * [`[[bench]]`](cargo-targets.md#benchmarks) — 基准目标设置。
{==+==}

{==+==}
* Dependency tables:
  * [`[dependencies]`](specifying-dependencies.md) — Package library dependencies.
  * [`[dev-dependencies]`](specifying-dependencies.md#development-dependencies) — Dependencies for examples, tests, and benchmarks.
  * [`[build-dependencies]`](specifying-dependencies.md#build-dependencies) — Dependencies for build scripts.
  * [`[target]`](specifying-dependencies.md#platform-specific-dependencies) — Platform-specific dependencies.
* [`[badges]`](#the-badges-section) — Badges to display on a registry.
* [`[features]`](features.md) — Conditional compilation features.
* [`[patch]`](overriding-dependencies.md#the-patch-section) — Override dependencies.
* [`[replace]`](overriding-dependencies.md#the-replace-section) — Override dependencies (deprecated).
* [`[profile]`](profiles.md) — Compiler settings and optimizations.
* [`[workspace]`](workspaces.md) — The workspace definition.
{==+==}
* 依赖表:
  * [`[dependencies]`](specifying-dependencies.md) — 包库依赖。
  * [`[dev-dependencies]`](specifying-dependencies.md#development-dependencies) — 实例、测试、基准依赖。
  * [`[build-dependencies]`](specifying-dependencies.md#build-dependencies) — 构建脚本依赖。
  * [`[target]`](specifying-dependencies.md#platform-specific-dependencies) — 特定平台依赖。
* [`[badges]`](#the-badges-section) — 显示在注册中心的标志。
* [`[features]`](features.md) — 条件编译特性。
* [`[patch]`](overriding-dependencies.md#the-patch-section) — 覆盖依赖。
* [`[replace]`](overriding-dependencies.md#the-replace-section) — 覆盖依赖 (弃用)。
* [`[profile]`](profiles.md) — 编译器设置和优化。
* [`[workspace]`](workspaces.md) — 工作空间定义。
{==+==}

{==+==}
<a id="package-metadata"></a>
### The `[package]` section
{==+==}
<a id="package-metadata"></a>
### `[package]` 部分
{==+==}

{==+==}
The first section in a `Cargo.toml` is `[package]`.
{==+==}
在 `Cargo.toml` 中的第一个部分就是 `[package]` 。
{==+==}

{==+==}
```toml
[package]
name = "hello_world" # the name of the package
version = "0.1.0"    # the current version, obeying semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```
{==+==}
```toml
[package]
name = "hello_world" # 包的名称
version = "0.1.0"    # 当前版本, 语义化版本。
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```
{==+==}

{==+==}
The only fields required by Cargo are [`name`](#the-name-field) and
[`version`](#the-version-field). If publishing to a registry, the registry may
require additional fields. See the notes below and [the publishing
chapter][publishing] for requirements for publishing to [crates.io].
{==+==}
Cargo 仅需要的字段是 [`name`](#the-name-field) 和 [`version`](#the-version-field) 。
如果发布到注册中心，注册中心可能需要额外的字段。
关于发布到[crates.io]的要求，请参见下面的注释和[发布章节][publishing]。
{==+==}

{==+==}
#### The `name` field

The package name is an identifier used to refer to the package. It is used
when listed as a dependency in another package, and as the default name of
inferred lib and bin targets.
{==+==}
#### `name` 字段

包的名称是一个用来引用包的标识符。
可被列为另一个包的依赖，并作为lib和bin目标推导的默认名称。
{==+==}

{==+==}
The name must use only [alphanumeric] characters or `-` or `_`, and cannot be empty.
{==+==}
该名称只能使用 [字母数字] 字符或 `-` 或 `_` ，并且不能为空。
{==+==}

{==+==}
Note that [`cargo new`] and [`cargo init`] impose some additional restrictions on
the package name, such as enforcing that it is a valid Rust identifier and not
a keyword. [crates.io] imposes even more restrictions, such as:
{==+==}
请注意，[`cargo new`]和[`cargo init`]对包名有一些额外的限制，比如强制要求为有效的Rust标识符，而不能是关键词。
[crates.io]有更多的限制，比如说:
{==+==}

{==+==}
- Only ASCII characters are allowed.
- Do not use reserved names.
- Do not use special Windows name such as "nul".
- Use a maximum of 64 characters of length.
{==+==}
- 仅允许ASCII字符。
- 不能使用保留名称。
- 不要使用特殊的Windows名称，如 "nul" 。
- 最长使用64个字符。
{==+==}

{==+==}
[alphanumeric]: ../../std/primitive.char.html#method.is_alphanumeric
{==+==}
[alphanumeric]: ../../std/primitive.char.html#method.is_alphanumeric
{==+==}

{==+==}
#### The `version` field

Cargo bakes in the concept of [Semantic
Versioning](https://semver.org/), so make sure you follow some basic rules:
{==+==}
#### `version` 字段

Cargo 遵循 [语义化版本](https://semver.org/) 的概念，遵循一些基本规则:
{==+==}

{==+==}
* Before you reach 1.0.0, anything goes, but if you make breaking changes,
  increment the minor version. In Rust, breaking changes include adding fields to
  structs or variants to enums.
* After 1.0.0, only make breaking changes when you increment the major version.
  Don’t break the build.
* After 1.0.0, don’t add any new public API (no new `pub` anything) in patch-level
  versions. Always increment the minor version if you add any new `pub` structs,
  traits, fields, types, functions, methods or anything else.
* Use version numbers with three numeric parts such as 1.0.0 rather than 1.0.
{==+==}
* 在达到1.0.0之前，可以任意进行，但如果做了破坏性的改变，就要增加次要版本。在Rust中，破坏性修改包括向结构体添加字段或向枚举添加变体。
* 在1.0.0之后，只有在增加主版本的时候才可以进行破坏性的修改。不要破坏构建。
* 1.0.0之后，不要在补丁级版本中添加任何新的公共API(即没有新的 `pub` 接口)。如果添加任何新的 `pub` 结构、特征、字段、类型、函数、方法或其他东西，总是增加次要版本。
* 使用有三个数字部分的版本号，如1.0.0而不是1.0。
{==+==}

{==+==}
See the [Resolver] chapter for more information on how Cargo uses versions to
resolve dependencies, and for guidelines on setting your own version. See the
[SemVer compatibility] chapter for more details on exactly what constitutes a
breaking change.
{==+==}
请参阅 [Resolver] 章节，了解更多关于Cargo如何使用版本来解决依赖，以及设置自己版本的指南。
参见[语义化兼容]一章，以了解更多关于什么是破坏性变化的细节。
{==+==}

{==+==}
[Resolver]: resolver.md
[SemVer compatibility]: semver.md
{==+==}
[Resolver]: resolver.md
[语义化兼容]: semver.md
{==+==}

{==+==}
<a id="the-authors-field-optional"></a>
#### The `authors` field
{==+==}
<a id="the-authors-field-optional"></a>
####  `authors` 字段
{==+==}

{==+==}
The optional `authors` field lists in an array the people or organizations that are considered
the "authors" of the package. The exact meaning is open to interpretation — it
may list the original or primary authors, current maintainers, or owners of the
package. An optional email address may be included within angled brackets at
the end of each author entry.
{==+==}
可选的 `authors` 字段，以数组形式列出包 "作者" 的人或组织。
确切的意思有多种解释--可以列出原始或主要的作者、当前的维护者或者包的所有者。
可以在每个作者条目末尾的斜方括号内包含可选的电子邮件。
{==+==}

{==+==}
```toml
[package]
# ...
authors = ["Graydon Hoare", "Fnu Lnu <no-reply@rust-lang.org>"]
```
{==+==}
{==+==}

{==+==}
This field is only surfaced in package metadata and in the `CARGO_PKG_AUTHORS`
environment variable within `build.rs`. It is not displayed in the [crates.io]
user interface.
{==+==}
这个字段仅在包元数据和 `build.rs` 中的 `CARGO_PKG_AUTHORS` 环境变量中出现。
它不显示在 [crates.io] 用户界面中。
{==+==}

{==+==}
> **Warning**: Package manifests cannot be changed once published, so this
> field cannot be changed or removed in already-published versions of a
> package.
{==+==}
> **警告**: 包配置清单一旦发布就不能改变，所以这个字段不能在包已发布版本中改变或删除。
{==+==}

{==+==}
<a id="the-edition-field-optional"></a>
#### The `edition` field
{==+==}
<a id="the-edition-field-optional"></a>
####  `edition` 字段
{==+==}

{==+==}
The `edition` key is an optional key that affects which [Rust Edition] your package
is compiled with. Setting the `edition` key in `[package]` will affect all
targets/crates in the package, including test suites, benchmarks, binaries,
examples, etc.
{==+==}
`edition`键是可选的键，它影响你的包是用哪个[Rust 版次]编译的。
在 `[package]` 中设置 `edition` 键会影响到包中的所有targets/crates，包括测试套件、基准、二进制文件、实例等。
{==+==}

{==+==}
```toml
[package]
# ...
edition = '2021'
```
{==+==}
```toml
[package]
# ...
edition = '2021'
```
{==+==}

{==+==}
Most manifests have the `edition` field filled in automatically by [`cargo new`]
with the latest stable edition. By default `cargo new` creates a manifest with
the 2021 edition currently.
{==+==}
大多数配置清单的 `edition` 字段由 [`cargo new`] 自动填充，具有最新的稳定版本。
默认 `cargo new` 创建的是2021年版次的配置清单。
{==+==}

{==+==}
If the `edition` field is not present in `Cargo.toml`, then the 2015 edition is
assumed for backwards compatibility. Note that all manifests
created with [`cargo new`] will not use this historical fallback because they
will have `edition` explicitly specified to a newer value.
{==+==}
如果 `Cargo.toml` 中没有 `edition`  字段，那么为了向后兼容，将假定为2015版。
请注意，凡是用 [`cargo new`] 创建的配置清单不会使用这种历史版次，而会将 `edition` 指定为一个较新的值。
{==+==}

{==+==}
#### The `rust-version` field

The `rust-version` field is an optional key that tells cargo what version of the
Rust language and compiler your package can be compiled with. If the currently
selected version of the Rust compiler is older than the stated version, cargo
will exit with an error, telling the user what version is required.
{==+==}
#### `rust-version` 字段

`rust-version` 字段是可选的键，它告知cargo包可以用哪个版本的Rust语言和编译器来编译。
如果当前选择的Rust编译器的版本比声明的版本早，cargo会退出，并告诉用户需要什么版本。
{==+==}

{==+==}
The first version of Cargo that supports this field was released with Rust 1.56.0.
In older releases, the field will be ignored, and Cargo will display a warning.
{==+==}
第一个支持这个字段的Cargo版本是随着Rust 1.56.0发布的。
在旧版本中，这个字段会被忽略，Cargo会显示一个警告。
{==+==}

{==+==}
```toml
[package]
# ...
rust-version = "1.56"
```
{==+==}
```toml
[package]
# ...
rust-version = "1.56"
```
{==+==}

{==+==}
The Rust version must be a bare version number with two or three components; it
cannot include semver operators or pre-release identifiers. Compiler pre-release
identifiers such as -nightly will be ignored while checking the Rust version.
The `rust-version` must be equal to or newer than the version that first
introduced the configured `edition`.
{==+==}
Rust版本必须是由两或三个部分组成的基础版本号；它不能包括语义化操作符或预发布标识符。
编译器的预发布标识符，如-nightly，在检查Rust版本时将被忽略。
`rust-version` 必须等于或高于首次引入配置的 `edition` 的版本。
{==+==}

{==+==}
The `rust-version` may be ignored using the `--ignore-rust-version` option.
{==+==}
可以使用 `--ignore-rust-version` 选项忽略 `rust-version` 。
{==+==}

{==+==}
Setting the `rust-version` key in `[package]` will affect all targets/crates in
the package, including test suites, benchmarks, binaries, examples, etc.
{==+==}
在 `[package]` 中设置 `rust-version` 键将影响包中的所有 target/crates ，包括测试套件、基准、二进制文件、实例等。
{==+==}

{==+==}
#### The `description` field

The description is a short blurb about the package. [crates.io] will display
this with your package. This should be plain text (not Markdown).
{==+==}
#### `description` 字段

描述是关于该包的简介。[crates.io]会在你的包中显示这个。这应是纯文本(不是Markdown)。
{==+==}

{==+==}
```toml
[package]
# ...
description = "A short description of my package"
```
{==+==}
```toml
[package]
# ...
description = "A short description of my package"
```
{==+==}

{==+==}
> **Note**: [crates.io] requires the `description` to be set.
{==+==}
> **注意**: [crates.io] 需要 `description` 设置。
{==+==}

{==+==}
<a id="the-documentation-field-optional"></a>
#### The `documentation` field
{==+==}
<a id="the-documentation-field-optional"></a>
#### `documentation` 字段
{==+==}

{==+==}
The `documentation` field specifies a URL to a website hosting the crate's
documentation. If no URL is specified in the manifest file, [crates.io] will
automatically link your crate to the corresponding [docs.rs] page.
{==+==}
`documentation` 字段指定托管了crate文档网站的URL。
如果配置清单文件中没有指定URL，则 [crates.io] 会自动将你的crate链接到相应的 [docs.rs] 页面。
{==+==}

{==+==}
```toml
[package]
# ...
documentation = "https://docs.rs/bitflags"
```
{==+==}
```toml
[package]
# ...
documentation = "https://docs.rs/bitflags"
```
{==+==}

{==+==}
#### The `readme` field

The `readme` field should be the path to a file in the package root (relative
to this `Cargo.toml`) that contains general information about the package.
This file will be transferred to the registry when you publish. [crates.io]
will interpret it as Markdown and render it on the crate's page.
{==+==}
#### `readme` 字段

`readme` 字段应该是包根位置的文件的路径(相对于这个`Cargo.toml`)，其中包含关于包的常规信息。
当你发布时，这个文件将被转移到注册中心。
[crates.io] 将把它解释为Markdown并在crate的页面上呈现。
{==+==}

{==+==}
```toml
[package]
# ...
readme = "README.md"
```
{==+==}
```toml
[package]
# ...
readme = "README.md"
```
{==+==}

{==+==}
If no value is specified for this field, and a file named `README.md`,
`README.txt` or `README` exists in the package root, then the name of that
file will be used. You can suppress this behavior by setting this field to
`false`. If the field is set to `true`, a default value of `README.md` will
be assumed.
{==+==}
如果没有指定这个字段的值，并且在包的根位置存在名为 `README.md` 、 `README.txt` 或 `README` 的文件，那么将使用该文件名称。
你可以通过设置这个字段为 `false` 来阻止这种行为。如果该字段被设置为 `true` ，将假定默认值为 `README.md` 。
{==+==}

{==+==}
#### The `homepage` field

The `homepage` field should be a URL to a site that is the home page for your
package.
{==+==}
#### `homepage` 字段

`homepage` 字段应该是网站的URL，它是包的主页。
{==+==}

{==+==}
```toml
[package]
# ...
homepage = "https://serde.rs/"
```
{==+==}
```toml
[package]
# ...
homepage = "https://serde.rs/"
```
{==+==}

{==+==}
#### The `repository` field

The `repository` field should be a URL to the source repository for your
package.
{==+==}
#### `repository` 字段

`repository` 字段应该是包的源存储库的URL。
{==+==}

{==+==}
```toml
[package]
# ...
repository = "https://github.com/rust-lang/cargo/"
```
{==+==}
```toml
[package]
# ...
repository = "https://github.com/rust-lang/cargo/"
```
{==+==}

{==+==}
#### The `license` and `license-file` fields

The `license` field contains the name of the software license that the package
is released under. The `license-file` field contains the path to a file
containing the text of the license (relative to this `Cargo.toml`).
{==+==}
#### `license` 和 `license-file` 字段

`license` 字段包含软件许可证的名称，包根据该许可证发布的。
`license-file` 字段包含许可证文本的文件路径(相对于这个`Cargo.toml`)。
{==+==}

{==+==}
[crates.io] interprets the `license` field as an [SPDX 2.1 license
expression][spdx-2.1-license-expressions]. The name must be a known license
from the [SPDX license list 3.11][spdx-license-list-3.11]. Parentheses are not
currently supported. See the [SPDX site] for more information.
{==+==}
[crates.io]将 `license` 字段解释为 [SPDX 2.1 license expression][spdx-2.1-license-expressions] 。
该名称必须是 [SPDX license list 3.11][spdx-license-list-3.11] 中的一个已知许可证。
目前不支持括号。更多信息请参见 [SPDX网站] 。
{==+==}

{==+==}
SPDX license expressions support AND and OR operators to combine multiple
licenses.[^slash]
{==+==}
SPDX许可证表达式支持AND和OR运算符，以组合多个许可证。[^slash]
{==+==}

{==+==}
```toml
[package]
# ...
license = "MIT OR Apache-2.0"
```
{==+==}
```toml
[package]
# ...
license = "MIT OR Apache-2.0"
```
{==+==}

{==+==}
Using `OR` indicates the user may choose either license. Using `AND` indicates
the user must comply with both licenses simultaneously. The `WITH` operator
indicates a license with a special exception. Some examples:
{==+==}
使用 `OR` 表示用户可以选择任何一项许可证。使用 `AND` 表示用户必须同时遵守两个许可证。
使用 `WITH` 操作符表示有特殊例外的许可证。一些例子:
{==+==}

{==+==}
* `MIT OR Apache-2.0`
* `LGPL-2.1-only AND MIT AND BSD-2-Clause`
* `GPL-2.0-or-later WITH Bison-exception-2.2`
{==+==}
* `MIT OR Apache-2.0`
* `LGPL-2.1-only AND MIT AND BSD-2-Clause`
* `GPL-2.0-or-later WITH Bison-exception-2.2`
{==+==}

{==+==}
If a package is using a nonstandard license, then the `license-file` field may
be specified in lieu of the `license` field.
{==+==}
如果包使用非标准的许可证，那么可以指定 `license-file` 字段来代替 `license` 字段。
{==+==}

{==+==}
```toml
[package]
# ...
license-file = "LICENSE.txt"
```
{==+==}
```toml
[package]
# ...
license-file = "LICENSE.txt"
```
{==+==}

{==+==}
> **Note**: [crates.io] requires either `license` or `license-file` to be set.

[^slash]: Previously multiple licenses could be separated with a `/`, but that
usage is deprecated.
{==+==}
> **注意**: [crates.io] 要求设置 `license` 或 `license-file` 。

[^slash]: 以前，多个许可证可以用 `/` 来分隔，但这种用法已经过时了。
{==+==}

{==+==}
#### The `keywords` field

The `keywords` field is an array of strings that describe this package. This
can help when searching for the package on a registry, and you may choose any
words that would help someone find this crate.
{==+==}
#### `keywords` 字段

`keywords` 字段是描述这个包的字符串数组。
当在注册中心搜索该包时，提供帮助，你可以选择任意可以帮助别人找到这个crate的词。
{==+==}

{==+==}
```toml
[package]
# ...
keywords = ["gamedev", "graphics"]
```
{==+==}
```toml
[package]
# ...
keywords = ["gamedev", "graphics"]
```
{==+==}

{==+==}
> **Note**: [crates.io] has a maximum of 5 keywords. Each keyword must be
> ASCII text, start with a letter, and only contain letters, numbers, `_` or
> `-`, and have at most 20 characters.
{==+==}
> **注意**: [crates.io]最多可以有5个关键词。每个关键词必须是ASCII文本，以字母开头，只包含字母、数字、 `_` 或 `-` ，最多20个字符。
{==+==}

{==+==}
#### The `categories` field

The `categories` field is an array of strings of the categories this package
belongs to.
{==+==}
#### `categories` 字段

`categories` 字段是一个字符串数组，表示该包所属的类别。
{==+==}

{==+==}
```toml
categories = ["command-line-utilities", "development-tools::cargo-plugins"]
```
{==+==}
```toml
categories = ["command-line-utilities", "development-tools::cargo-plugins"]
```
{==+==}

{==+==}
> **Note**: [crates.io] has a maximum of 5 categories. Each category should
> match one of the strings available at <https://crates.io/category_slugs>, and
> must match exactly.
{==+==}
> **注意**: [crates.io]最多可以有5个类别。每个类别应与 <https://crates.io/category_slugs> 中的一个字符串完全匹配。
{==+==}

{==+==}
<a id="the-workspace--field-optional"></a>
#### The `workspace` field
{==+==}
<a id="the-workspace--field-optional"></a>
#### `workspace` 字段
{==+==}

{==+==}
The `workspace` field can be used to configure the workspace that this package
will be a member of. If not specified this will be inferred as the first
Cargo.toml with `[workspace]` upwards in the filesystem. Setting this is
useful if the member is not inside a subdirectory of the workspace root.
{==+==}
`workspace` 字段用来配置包的工作空间。
如果没有指定，这将被推断为文件系统中第一个带有 `[workspace]` 的Cargo.toml。
如果成员不在工作空间根目录下，设置这个很有用。
{==+==}

{==+==}
```toml
[package]
# ...
workspace = "path/to/workspace/root"
```
{==+==}
```toml
[package]
# ...
workspace = "path/to/workspace/root"
```
{==+==}

{==+==}
This field cannot be specified if the manifest already has a `[workspace]`
table defined. That is, a crate cannot both be a root crate in a workspace
(contain `[workspace]`) and also be a member crate of another workspace
(contain `package.workspace`).
{==+==}
如果配置清单中已经定义了 `[workspace]` 表，则不能指定此字段。
也就是说，crate 不能既是一个工作空间的根 crate (包含 `[workspace]`)，又是另一个工作空间的成员 crate (包含 `package.workspace` )。
{==+==}

{==+==}
For more information, see the [workspaces chapter](workspaces.md).
{==+==}
了解更多信息，请参见[工作空间章节](workspaces.md)。
{==+==}

{==+==}
<a id="package-build"></a>
<a id="the-build-field-optional"></a>
#### The `build` field
{==+==}
<a id="package-build"></a>
<a id="the-build-field-optional"></a>
#### `build` 字段
{==+==}

{==+==}
The `build` field specifies a file in the package root which is a [build
script] for building native code. More information can be found in the [build
script guide][build script].
{==+==}
`build` 字段指定包根位置的一个文件，该文件是用于构建本地代码的[构建脚本]。
更多信息可以在 [构建脚本指南][build script] 中找到。
{==+==}

{==+==}
[build script]: build-scripts.md

```toml
[package]
# ...
build = "build.rs"
```
{==+==}
[build script]: build-scripts.md

```toml
[package]
# ...
build = "build.rs"
```
{==+==}

{==+==}
The default is `"build.rs"`, which loads the script from a file named
`build.rs` in the root of the package. Use `build = "custom_build_name.rs"` to
specify a path to a different file or `build = false` to disable automatic
detection of the build script.
{==+==}
默认是 `"build.rs"` ，从包根目录下的 `build.rs` 文件中加载脚本。
使用 `build = "custom_build_name.rs"` 来指定不同文件的路径，或者使用 `build = false` 来禁止自动检测构建脚本。
{==+==}

{==+==}
<a id="the-links-field-optional"></a>
#### The `links` field
{==+==}
<a id="the-links-field-optional"></a>
#### `links` 字段
{==+==}

{==+==}
The `links` field specifies the name of a native library that is being linked
to. More information can be found in the [`links`][links] section of the build
script guide.
{==+==}
`links` 字段指定了被链接的本地库的名称。
更多信息可以在构建脚本指南的 [`links`][link] 部分找到。
{==+==}

{==+==}
[links]: build-scripts.md#the-links-manifest-key

For example, a crate that links a native library called "git2" (e.g. `libgit2.a`
on Linux) may specify:
{==+==}
[links]: build-scripts.md#the-links-manifest-key

例如，可以指定链接名为 "git2" 的本地库的crate(例如Linux上的 `libgit2.a` )。
{==+==}

{==+==}
```toml
[package]
# ...
links = "git2"
```
{==+==}
```toml
[package]
# ...
links = "git2"
```
{==+==}

{==+==}
<a id="the-exclude-and-include-fields-optional"></a>
#### The `exclude` and `include` fields
{==+==}
<a id="the-exclude-and-include-fields-optional"></a>
#### `exclude` 和 `include` 字段
{==+==}

{==+==}
The `exclude` and `include` fields can be used to explicitly specify which
files are included when packaging a project to be [published][publishing],
and certain kinds of change tracking (described below).
The patterns specified in the `exclude` field identify a set of files that are
not included, and the patterns in `include` specify files that are explicitly
included.
You may run [`cargo package --list`][`cargo package`] to verify which files will
be included in the package.
{==+==}
`exclude` 和 `include` 字段可以用来明确指定哪些文件在进行打包[发布][publishing]项目时被包含，以及某些特征的变更跟踪(如下所述)。
在 `exclude` 字段中指定的模式确定了一组不包括的文件，而 `include` 中的模式指定了明确包括的文件。
你可以运行 [`cargo package --list`][`cargo package`] 来验证哪些文件将被包含在包中。
{==+==}

{==+==}
```toml
[package]
# ...
exclude = ["/ci", "images/", ".*"]
```
{==+==}
```toml
[package]
# ...
exclude = ["/ci", "images/", ".*"]
```
{==+==}

{==+==}
```toml
[package]
# ...
include = ["/src", "COPYRIGHT", "/examples", "!/examples/big_example"]
```
{==+==}
```toml
[package]
# ...
include = ["/src", "COPYRIGHT", "/examples", "!/examples/big_example"]
```
{==+==}

{==+==}
The default if neither field is specified is to include all files from the
root of the package, except for the exclusions listed below.
{==+==}
如果这两个字段都没有被指定，默认情况是包括包根位置的所有文件，除了下面列出的例外情况。
{==+==}

{==+==}
If `include` is not specified, then the following files will be excluded:
{==+==}
如果未指定 `include` ，则以下文件将被排除:
{==+==}

{==+==}
* If the package is not in a git repository, all "hidden" files starting with
  a dot will be skipped.
* If the package is in a git repository, any files that are ignored by the
  [gitignore] rules of the repository and global git configuration will be
  skipped.
{==+==}
* 如果包不在git仓库中，所有以点开头的"隐藏"文件都会被跳过。
* 如果包在git仓库中，任何被仓库和全局git配置的[gitignore]规则所忽略的文件都将被跳过。
{==+==}

{==+==}
Regardless of whether `exclude` or `include` is specified, the following files
are always excluded:
{==+==}
不管是指定 `exclude` 或 `include` ，以下文件总是被排除在外:
{==+==}

{==+==}
* Any sub-packages will be skipped (any subdirectory that contains a
  `Cargo.toml` file).
* A directory named `target` in the root of the package will be skipped.
{==+==}
* 任何子包将被跳过(任何包含`Cargo.toml`文件的子目录)。
* 在包根位置的名为 `target` 的目录将被跳过。
{==+==}

{==+==}
The following files are always included:
{==+==}
以下文件总是被包含:
{==+==}

{==+==}
* The `Cargo.toml` file of the package itself is always included, it does not
  need to be listed in `include`.
* A minimized `Cargo.lock` is automatically included if the package contains a
  binary or example target, see [`cargo package`] for more information.
* If a [`license-file`](#the-license-and-license-file-fields) is specified, it
  is always included.
{==+==}
* 包本身的 `Cargo.toml` 文件总是被包括在内，它不需要被列在 `include` 中。
* 如果包包含二进制或示例目标，则会自动包含最小化的 `Cargo.lock` ，更多信息请参见 [`cargo package`] 。
* 如果指定了[`license-file`](#the-license-and-license-file-fields)，它总是被包括在内。
{==+==}

{==+==}
The options are mutually exclusive; setting `include` will override an
`exclude`. If you need to have exclusions to a set of `include` files, use the
`!` operator described below.
{==+==}
这些选项是相互排斥的；设置 `include` 将覆盖 `exclude` 。
如果你需要对一组 `include` 文件进行排除，使用下面描述的 `!` 操作符。
{==+==}

{==+==}
The patterns should be [gitignore]-style patterns. Briefly:
{==+==}
这些模式应该是[gitignore]格式的模式。简而言之:
{==+==}

{==+==}
- `foo` matches any file or directory with the name `foo` anywhere in the
  package. This is equivalent to the pattern `**/foo`.
- `/foo` matches any file or directory with the name `foo` only in the root of
  the package.
- `foo/` matches any *directory* with the name `foo` anywhere in the package.
- Common glob patterns like `*`, `?`, and `[]` are supported:
  - `*` matches zero or more characters except `/`.  For example, `*.html`
    matches any file or directory with the `.html` extension anywhere in the
    package.
  - `?` matches any character except `/`. For example, `foo?` matches `food`,
    but not `foo`.
  - `[]` allows for matching a range of characters. For example, `[ab]`
    matches either `a` or `b`. `[a-z]` matches letters a through z.
- `**/` prefix matches in any directory. For example, `**/foo/bar` matches the
  file or directory `bar` anywhere that is directly under directory `foo`.
- `/**` suffix matches everything inside. For example, `foo/**` matches all
  files inside directory `foo`, including all files in subdirectories below
  `foo`.
- `/**/` matches zero or more directories. For example, `a/**/b` matches
  `a/b`, `a/x/b`, `a/x/y/b`, and so on.
- `!` prefix negates a pattern. For example, a pattern of `src/*.rs` and
  `!foo.rs` would match all files with the `.rs` extension inside the `src`
  directory, except for any file named `foo.rs`.
{==+==}
- `foo` 匹配包中任何名字为 `foo` 的文件或目录。这等同于模式 `**/foo` 。
- `/foo` 匹配任何文件或目录，名称为`foo`，只在包的根位置。
- `foo/` 匹配包中任何名字为`foo`的 *目录* 。
- 支持常见的通配符模式，如`*`，`?`，和`[]`。
  - `*` 匹配除 `/` 以外的零个或多个字符。例如， `*.html` 匹配包中任何带有 `.html` 扩展名的文件或目录。
  - `?` 匹配除 `/` 以外的任何字符。例如，`foo?` 匹配 `food` ， 但不匹配 `foo` 。
  - `[]` 允许匹配一定范围的字符。例如， `[ab]` 匹配 `a` 或 `b`。 `[a-z]` 匹配字母 a 到 z。
- `**/` 前缀可以在任何目录下匹配。例如， `**/foo/bar` 匹配直接位于 `foo` 目录下的任何文件或目录 `bar` 。
- `/**` 后缀匹配里面的所有文件。例如，`foo/**` 匹配目录 `foo` 内的所有文件，包括 `foo` 下面子目录中的所有文件。
- `/**/`  匹配零个或多个目录。例如， `a/**/b` 匹配 `a/b` ， `a/x/b` ， `a/x/y/b` ，以此类推。
- `!` 前缀否定了一个模式。例如， `src/*.rs` 和 `!foo.rs` 的模式将匹配 `src` 目录下所有扩展名为 `.rs` 的文件，但不包括任何名为 `foo.rs` 的文件。
{==+==}

{==+==}
The include/exclude list is also used for change tracking in some situations.
For targets built with `rustdoc`, it is used to determine the list of files to
track to determine if the target should be rebuilt. If the package has a
[build script] that does not emit any `rerun-if-*` directives, then the
include/exclude list is used for tracking if the build script should be re-run
if any of those files change.
{==+==}
在某些情况下，include/exclude 列表被用于变化跟踪。
对于用 `rustdoc` 构建的目标，它被用来确定追踪的文件列表，以确定目标是否应该被重新构建。
如果包有一个没有发出任何 `rerun-if-*` 指令的 [build script] ，那么include/exclude列表就被用来跟踪如果这些文件有变化，build script是否应该被重新运行。
{==+==}

{==+==}
[gitignore]: https://git-scm.com/docs/gitignore
{==+==}
[gitignore]: https://git-scm.com/docs/gitignore
{==+==}

{==+==}
<a id="the-publish--field-optional"></a>
#### The `publish` field
{==+==}
<a id="the-publish--field-optional"></a>
#### `publish` 字段
{==+==}

{==+==}
The `publish` field can be used to prevent a package from being published to a
package registry (like *crates.io*) by mistake, for instance to keep a package
private in a company.
{==+==}
`publish` 字段可以用来防止一个包被错误地发布到包注册中心(如*crates.io*)，比如，在公司里保持包为私密的。
{==+==}

{==+==}
```toml
[package]
# ...
publish = false
```
{==+==}
```toml
[package]
# ...
publish = false
```
{==+==}

{==+==}
The value may also be an array of strings which are registry names that are
allowed to be published to.
{==+==}
该值也可以是一个字符串数组，这些字符串是允许发布的注册中心的名称。
{==+==}

{==+==}
```toml
[package]
# ...
publish = ["some-registry-name"]
```
{==+==}
```toml
[package]
# ...
publish = ["some-registry-name"]
```
{==+==}

{==+==}
If publish array contains a single registry, `cargo publish` command will use
it when `--registry` flag is not specified.
{==+==}
如果发布数组包含单个注册中心，当未指定 `--registry` 标志时， `cargo publish` 命令将使用它。
{==+==}

{==+==}
<a id="the-metadata-table-optional"></a>
#### The `metadata` table
{==+==}
<a id="the-metadata-table-optional"></a>
#### `metadata` 表
{==+==}

{==+==}
Cargo by default will warn about unused keys in `Cargo.toml` to assist in
detecting typos and such. The `package.metadata` table, however, is completely
ignored by Cargo and will not be warned about. This section can be used for
tools which would like to store package configuration in `Cargo.toml`. For
example:
{==+==}
默认情况下，Cargo会对 `Cargo.toml` 中未使用的键发出警告，以帮助检测错别字之类的。
然而， `package.metadata` 表是完全被Cargo忽略，不会被警告。
这一部分可以用于那些想在 `Cargo.toml` 中存储包配置的工具。比如说:
{==+==}

{==+==}
```toml
[package]
name = "..."
# ...
{==+==}
```toml
[package]
name = "..."
# ...
{==+==}

{==+==}
# Metadata used when generating an Android APK, for example.
[package.metadata.android]
package-name = "my-awesome-android-app"
assets = "path/to/static"
```
{==+==}
# 例如，生成Android APK时使用的元数据。
[package.metadata.android]
package-name = "my-awesome-android-app"
assets = "path/to/static"
```
{==+==}

{==+==}
There is a similar table at the workspace level at
[`workspace.metadata`][workspace-metadata]. While cargo does not specify a
format for the content of either of these tables, it is suggested that
external tools may wish to use them in a consistent fashion, such as referring
to the data in `workspace.metadata` if data is missing from `package.metadata`,
if that makes sense for the tool in question.
{==+==}
在工作空间层级也有类似的表，位于[`workspace.metadata`][workspace-metadata]。
虽然cargo没有指定这两个表的内容格式，但建议外部工具以一致的方式使用它们，例如，
如果`package.metadata`中缺少数据，就引用`workspace.metadata` 中的数据，如果这对相关工具来说合理。
{==+==}

{==+==}
[workspace-metadata]: workspaces.md#the-metadata-table
{==+==}
[workspace-metadata]: workspaces.md#the-metadata-table
{==+==}

{==+==}
#### The `default-run` field

The `default-run` field in the `[package]` section of the manifest can be used
to specify a default binary picked by [`cargo run`]. For example, when there is
both `src/bin/a.rs` and `src/bin/b.rs`:
{==+==}
#### `default-run` 字段

配置清单中 `[package]` 部分的 `default-run` 字段可用于指定由 [`cargo run`] 选择的默认二进制文件。
例如，当同时存在 `src/bin/a.rs` 和 `src/bin/b.rs` 时。
{==+==}

{==+==}
```toml
[package]
default-run = "a"
```
{==+==}
```toml
[package]
default-run = "a"
```
{==+==}

{==+==}
### The `[badges]` section

The `[badges]` section is for specifying status badges that can be displayed
on a registry website when the package is published.
{==+==}
### `[badges]` 部分

 `[badges]` 部分用于指定状态标志，当包发布时可以在注册中心网站上显示。
{==+==}

{==+==}
> Note: [crates.io] previously displayed badges next to a crate on its
> website, but that functionality has been removed. Packages should place
> badges in its README file which will be displayed on [crates.io] (see [the
> `readme` field](#the-readme-field)).
{==+==}
> 注意: [crates.io] 以前在其网站上的crate旁边显示标志，但该功能已被删除。
> 包应在其README文件中放置标志，该文件将在[crates.io]上显示(参阅[`readme`字段](#the-readme-field))。
{==+==}

{==+==}
```toml
[badges]
# The `maintenance` table indicates the status of the maintenance of
# the crate. This may be used by a registry, but is currently not
# used by crates.io. See https://github.com/rust-lang/crates.io/issues/2437
# and https://github.com/rust-lang/crates.io/issues/2438 for more details.
#
# The `status` field is required. Available options are:
# - `actively-developed`: New features are being added and bugs are being fixed.
# - `passively-maintained`: There are no plans for new features, but the maintainer intends to
#   respond to issues that get filed.
# - `as-is`: The crate is feature complete, the maintainer does not intend to continue working on
#   it or providing support, but it works for the purposes it was designed for.
# - `experimental`: The author wants to share it with the community but is not intending to meet
#   anyone's particular use case.
# - `looking-for-maintainer`: The current maintainer would like to transfer the crate to someone
#   else.
# - `deprecated`: The maintainer does not recommend using this crate (the description of the crate
#   can describe why, there could be a better solution available or there could be problems with
#   the crate that the author does not want to fix).
# - `none`: Displays no badge on crates.io, since the maintainer has not chosen to specify
#   their intentions, potential crate users will need to investigate on their own.
maintenance = { status = "..." }
```
{==+==}
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
{==+==}

{==+==}
### Dependency sections

See the [specifying dependencies page](specifying-dependencies.md) for
information on the `[dependencies]`, `[dev-dependencies]`,
`[build-dependencies]`, and target-specific `[target.*.dependencies]` sections.
{==+==}
### 依赖部分

参阅 [特定依赖页](specifying-dependencies.md) 在 `[dependencies]`, `[dev-dependencies]`, `[build-dependencies]`, 和 target-specific `[target.*.dependencies]` 部分.
{==+==}

{==+==}
### The `[profile.*]` sections

The `[profile]` tables provide a way to customize compiler settings such as
optimizations and debug settings. See [the Profiles chapter](profiles.md) for
more detail.
{==+==}
### `[profile.*]` 部分

`[profile]` 表提供了一种定制编译器设置的方法，如优化和调试设置。
更多细节请参见[配置文件章节](profiles.md)。
{==+==}

{==+==}
[`cargo init`]: ../commands/cargo-init.md
[`cargo new`]: ../commands/cargo-new.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo run`]: ../commands/cargo-run.md
[crates.io]: https://crates.io/
[docs.rs]: https://docs.rs/
[publishing]: publishing.md
[Rust Edition]: ../../edition-guide/index.html
[spdx-2.1-license-expressions]: https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60
[spdx-license-list-3.11]: https://github.com/spdx/license-list-data/tree/v3.11
[SPDX site]: https://spdx.org/license-list
[TOML]: https://toml.io/
{==+==}
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
{==+==}

{==+==}
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
{==+==}
{==+==}