## 工作空间

*工作空间* 是一个或多个包的集合，这些包称为 *工作空间成员* ，它们被统一管理。

工作空间的关键目标是:

* 常规命令可以对所有工作空间成员运行，比如 `cargo check --workspace` 。
* 所有包共享 [`Cargo.lock`] 文件，该文件在 *工作空间根* 下。
* 所有包共享 [输出目录][output directory] ，默认为 *工作空间根* 下的 `target` 。
* 共享包的metadata，比如 [`workspace.package`](#the-package-table) 。
* [`[patch]`][patch] , [`[replace]`][replace] 和 [`[profile.*]`][profiles] 仅识别 *根* 配置清单 `Cargo.toml` 中的，忽略其成员 crate 配置清单中的。

在 `Cargo.toml` 中， `[workspace]` 表支持以下部分:

* `[workspace]`](#the-workspace-section) — 工作空间的定义。
  * [`resolver`](resolver.md#resolver-versions) — 设置要使用的依赖解析器。
  * [`members`](#the-members-and-exclude-fields) — 包含在工作空间的包。
  * [`exclude`](#the-members-and-exclude-fields) — 从工作空间排除的包。
  * [`default-members`](#the-default-members-field) — 当没有选择特定的包时，操作默认项。
  * [`package`](#the-package-table) — 可被成员继承的键。
  * [`dependencies`](#the-dependencies-table)  — 可被成员继承的依赖。
  * [`metadata`](#the-metadata-table) — 外部插件的附加设置。
* [`[patch]`](overriding-dependencies.md#the-patch-section) — 覆盖依赖。
* [`[replace]`](overriding-dependencies.md#the-replace-section) — 覆盖依赖(已废弃)。
* [`[profile]`](profiles.md) — 编译器设置和优化。

###  `[workspace]` 部分

要创建工作空间，你需要在 `Cargo.toml` 中添加 `[workspace]` 表:
```toml
[workspace]
# ...
```

工作空间至少要有一个成员，要么是一个根package，或者是虚拟配置清单。

#### Root package

如果在已定义 `[package]` 的 `Cargo.toml` 中，添加 [`[workspace]` 部分](#the-workspace-section) ，该package就是工作空间的 *Root package* 。 *工作空间根* 指的是工作空间 `Cargo.toml` 所在的目录。

```toml
[workspace]

[package]
name = "hello_world" # 包的名称
version = "0.1.0"    # 当前语义化版本
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

<a id="virtual-manifest"></a>
#### 虚拟工作空间

或者，创建 `Cargo.toml` 的文件中，有 `[workspace]` 表，没有 [`[package]`][package] 表，则称为 *虚拟配置清单* 。
这通常在没有 "主" 包时很有用，可把拥有的各个包放在不同的目录里。

```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["hello_world"]
```

```toml
# [PROJECT_DIR]/hello_world/Cargo.toml
[package]
name = "hello_world" # package名称
version = "0.1.0"    # 当前的语义化版本
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

### `members` 和 `exclude` 字段 

`members` 和 `exclude` 字段定义哪些包是工作空间的成员:

```toml
[workspace]
members = ["member1", "path/to/member2", "crates/*"]
exclude = ["crates/foo", "path/to/other"]
```

工作空间目录中的所有 [`path` 依赖][`path` dependencies] 自动成为成员。
可以用 `Cargo.toml` 中 `members` 键，以字符串数组列出其他成员。

`members` 列表支持用 [globs] 通配符来匹配多个路径，使用典型的文件名通配符模式 `*` 和 `?` 。

`exclude` 键可以防止路径自动包含到工作空间，排除某些路径依赖，可用通配符模式。

当在工作空间子目录内操作时，Cargo会自动搜索父目录中的 `Cargo.toml` 文件，以其中的 `[workspace]` 定义，来确定使用的工作空间。
在工作空间成员可以使用 [`package.workspace`] 配置键来配置工作空间根，以覆盖向上自动搜索。当成员不在工作空间根的子目录内时，就需要手动设置。

#### Package 部分

在工作空间中，与包有关的cargo命令，如 [`cargo build`] ，可以使用 `-p` / `-package` 或 `-workspace` 命令行标志来选择成员进行操作。
如果这两个标志都没有指定，Cargo将使用当前工作目录的包。如果是无根包的 [虚拟工作空间](#virtual-workspace) ，
命令将应用于所有成员 (同指定 `--workspace` 一样) 。 另请参阅 [`default-members`](#the-default-members-field) 。

###  `default-members` 字段

`default-members` 键可选，在未使用工作空间根包和选择包的标志时，默认操作的成员:

```toml
[workspace]
members = ["path/to/member1", "path/to/member2", "path/to/member3/*"]
default-members = ["path/to/member2", "path/to/member3/foo"]
```

当指定 `default-members` 时，添加的必须是 `members` 的子集。

### `package` 表

`workspace.package` 表可以定义工作空间成员继承的键。这些键可以通过在成员包配置清单中定义 `{key}.workspace = true` 的方式继承。

支持的键:

|                |                 |
|----------------|-----------------|
| `authors`      | `categories`    |
| `description`  | `documentation` |
| `edition`      | `exclude`       |
| `homepage`     | `include`       |
| `keywords`     | `license`       |
| `license-file` | `publish`       |
| `readme`       | `repository`    |
| `rust-version` | `version`       |

- `license-file` 和 `readme` 是相对于工作空间根。
- `include` 和 `exclude` 是相对于包的根。

示例:
```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["bar"]

[workspace.package]
version = "1.2.3"
authors = ["Nice Folks"]
description = "A short description of my package"
documentation = "https://example.com/bar"
```

```toml
# [PROJECT_DIR]/bar/Cargo.toml
[package]
name = "bar"
version.workspace = true
authors.workspace = true
description.workspace = true
documentation.workspace = true
```

### `dependencies` 表

`workspace.dependencies` 是可以定义工作空间成员所能继承的依赖。

指定工作空间依赖与 [package依赖][specifying-dependencies] 类似，除了:
- 此表中的依赖不能声明为 `optional` 可选的。
- 在此表中声明的 [`features`][features] 特性将与来自 `[dependencies]` 的 `features` 相加。

从而，就可以[把工作区的依赖作为包的依赖来继承][inheriting-a-dependency-from-a-workspace]。

示例:
```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["bar"]

[workspace.dependencies]
cc = "1.0.73"
rand = "0.8.5"
regex = { version = "1.6.0", default-features = false, features = ["std"] }
```

```toml
# [PROJECT_DIR]/bar/Cargo.toml
[package]
name = "bar"
version = "0.2.0"

[dependencies]
regex = { workspace = true, features = ["unicode"] }

[build-dependencies]
cc.workspace = true

[dev-dependencies]
rand.workspace = true
```

### `metadata` 表

Cargo忽略对 `workspace.metadata` 表的检查，不会发出警告。一些工具插件可以在 `Cargo.toml` 的这一部分中存储配置。比如:

```toml
[workspace]
members = ["member1", "member2"]

[workspace.metadata.webcontents]
root = "path/to/webproject"
tool = ["npm", "run", "build"]
# ...
```

在包中也有类似的表 [`package.metadata`][package-metadata] 。虽然cargo没有为表的内容指定格式，
但建议外部工具以一致的方式使用，对工具来说有意义就好，在 `package.metadata` 中缺少数据时，会参考 `workspace.metadata` 中的数据。

[package]: manifest.md#the-package-section
[`Cargo.lock`]: ../guide/cargo-toml-vs-cargo-lock.md
[package-metadata]: manifest.md#the-metadata-table
[output directory]: ../guide/build-cache.md
[patch]: overriding-dependencies.md#the-patch-section
[replace]: overriding-dependencies.md#the-replace-section
[profiles]: profiles.md
[`path` dependencies]: specifying-dependencies.md#specifying-path-dependencies
[`package.workspace`]: manifest.md#the-workspace-field
[globs]: https://docs.rs/glob/0.3.0/glob/struct.Pattern.html
[`cargo build`]: ../commands/cargo-build.md
[specifying-dependencies]: specifying-dependencies.md
[features]: features.md
[inheriting-a-dependency-from-a-workspace]: specifying-dependencies.md#inheriting-a-dependency-from-a-workspace
