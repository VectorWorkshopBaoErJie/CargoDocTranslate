{==+==}
## Workspaces
{==+==}
## 工作空间
{==+==}

{==+==}
A *workspace* is a collection of one or more packages, called *workspace
members*, that are managed together.
{==+==}
*工作空间* 是一个或多个被称为 *工作空间成员* 的包的集合，它们被一起管理。
{==+==}

{==+==}
The key points of workspaces are:
{==+==}
工作空间的关键目标是:
{==+==}

{==+==}
* Common commands can run across all workspace members, like `cargo check --workspace`.
* All packages share a common [`Cargo.lock`] file which resides in the
  *workspace root*.
* All packages share a common [output directory], which defaults to a
  directory named `target` in the *workspace root*.
* Sharing package metadata, like with [`workspace.package`](#the-package-table).
* The [`[patch]`][patch], [`[replace]`][replace] and [`[profile.*]`][profiles]
  sections in `Cargo.toml` are only recognized in the *root* manifest, and
  ignored in member crates' manifests.
{==+==}
* 通用命令可以在所有工作空间成员上运行，例如 `cargo check --workspace` 。
* 所有包共享相同的 [`Cargo.lock`] 文件，位于 *工作空间根目录* 中。
* 所有包共享相同的 [输出目录][output directory] ，默认为 *工作空间根目录* 中的一个名为 `target` 的目录。
* 共享包元数据，例如使用 [`workspace.package`](#the-package-table) 。
* `Cargo.toml` 中的 [`[patch]`][patch] 、 [`[replace]`][replace] 和 [`[profile.*]`][profiles] 部分只在 *根* 清单中识别，在成员 crate 清单中忽略。
{==+==}

{==+==}
In the `Cargo.toml`, the `[workspace]` table supports the following sections:
{==+==}
在 `Cargo.toml` 中， `[workspace]` 表支持以下部分。
{==+==}

{==+==}
* [`[workspace]`](#the-workspace-section) — Defines a workspace.
  * [`resolver`](resolver.md#resolver-versions) — Sets the dependency resolver to use.
  * [`members`](#the-members-and-exclude-fields) — Packages to include in the workspace.
  * [`exclude`](#the-members-and-exclude-fields) — Packages to exclude from the workspace.
  * [`default-members`](#the-default-members-field) — Packages to operate on when a specific package wasn't selected.
  * [`package`](#the-package-table) — Keys for inheriting in packages.
  * [`dependencies`](#the-dependencies-table) — Keys for inheriting in package dependencies.
  * [`metadata`](#the-metadata-table) — Extra settings for external tools.
* [`[patch]`](overriding-dependencies.md#the-patch-section) — Override dependencies.
* [`[replace]`](overriding-dependencies.md#the-replace-section) — Override dependencies (deprecated).
* [`[profile]`](profiles.md) — Compiler settings and optimizations.
{==+==}
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
{==+==}

{==+==}
### The `[workspace]` section
{==+==}
###  `[workspace]` 部分
{==+==}

{==+==}
To create a workspace, you add the `[workspace]` table to a `Cargo.toml`:
{==+==}
要创建工作空间，你需要在 `Cargo.toml` 中添加 `[workspace]` 表:
{==+==}

```toml
[workspace]
# ...
```

{==+==}
At minimum, a workspace has to have a member, either with a root package or as
a virtual manifest.
{==+==}
至少，工作空间必须有一个成员，要么是根包，要么是虚拟配置清单。
{==+==}

{==+==}
#### Root package
{==+==}

{==+==}

{==+==}
If the [`[workspace]` section](#the-workspace-section) is added to a
`Cargo.toml` that already defines a `[package]`, the package is
the *root package* of the workspace. The *workspace root* is the directory
where the workspace's `Cargo.toml` is located.
{==+==}
如果向 `Cargo.toml` 添加了 [`[workspace]` 部分](#the-workspace-section) ，而该文件已经定义了一个 `[package]` ，那么该包就是工作空间的 *根包* 。
 *工作空间根目录* 是存放工作空间 `Cargo.toml` 文件的目录。
{==+==}

{==+==}
```toml
[workspace]

[package]
name = "hello_world" # the name of the package
version = "0.1.0"    # the current version, obeying semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

<a id="virtual-manifest"></a>
{==+==}
```toml
[workspace]

[package]
name = "hello_world" # 包的名称
version = "0.1.0"    # 当前语义化版本
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

<a id="virtual-manifest"></a>
{==+==}

{==+==}
#### Virtual workspace
{==+==}
#### 虚拟工作空间
{==+==}


{==+==}
Alternatively, a `Cargo.toml` file can be created with a `[workspace]` section
but without a [`[package]` section][package]. This is called a *virtual
manifest*. This is typically useful when there isn't a "primary" package, or
you want to keep all the packages organized in separate directories.
{==+==}
另外，可以使用 `[workspace]` 部分但没有 [`[package]` 部分][package] 创建一个 `Cargo.toml` 文件。
这被称为 *虚拟配置清单* 。当没有 "主" 包时，或者希望将所有包组织在不同的目录中时，通常很有用。
{==+==}


{==+==}
```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["hello_world"]
```
{==+==}

{==+==}


{==+==}
```toml
# [PROJECT_DIR]/hello_world/Cargo.toml
[package]
name = "hello_world" # the name of the package
version = "0.1.0"    # the current version, obeying semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```
{==+==}
```toml
# [PROJECT_DIR]/hello_world/Cargo.toml
[package]
name = "hello_world" # package名称
version = "0.1.0"    # 当前的语义化版本
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```
{==+==}


{==+==}
### The `members` and `exclude` fields 
{==+==}
### `members` 和 `exclude` 字段 
{==+==}

{==+==}
The `members` and `exclude` fields define which packages are members of
the workspace:
{==+==}
 `members` 和 `exclude` 字段定义了哪些包是工作空间的成员:
{==+==}

{==+==}
```toml
[workspace]
members = ["member1", "path/to/member2", "crates/*"]
exclude = ["crates/foo", "path/to/other"]
```
{==+==}

{==+==}


{==+==}
All [`path` dependencies] residing in the workspace directory automatically
become members. Additional members can be listed with the `members` key, which
should be an array of strings containing directories with `Cargo.toml` files.
{==+==}
所有位于工作空间目录中的 [`path` 依赖][`path` dependencies] 都会自动成为成员。
可以使用 `members` 键列出其他成员，该键应该是一个包含具有 `Cargo.toml` 文件的目录的字符串数组。
{==+==}


{==+==}
The `members` list also supports [globs] to match multiple paths, using
typical filename glob patterns like `*` and `?`.
{==+==}
 `members` 列表还支持 [通配符][globs] 来匹配多个路径，使用典型的文件名通配符模式，如 `*` 和 `?` 。
{==+==}


{==+==}
The `exclude` key can be used to prevent paths from being included in a
workspace. This can be useful if some path dependencies aren't desired to be
in the workspace at all, or using a glob pattern and you want to remove a
directory.
{==+==}
 `exclude` 键可以用来防止路径被包含在工作空间中。
如果某些路径依赖不希望完全包含在工作空间中，或者使用通配符模式并且想要排除目录，这可能会很有用。
{==+==}


{==+==}
When inside a subdirectory within the workspace, Cargo will automatically
search the parent directories for a `Cargo.toml` file with a `[workspace]`
definition to determine which workspace to use. The [`package.workspace`]
manifest key can be used in member crates to point at a workspace's root to
override this automatic search. The manual setting can be useful if the member
is not inside a subdirectory of the workspace root.
{==+==}
当在工作空间的子目录中时， Cargo 将自动搜索父目录以查找具有 `[workspace]` 定义的 `Cargo.toml` 文件，以确定要使用哪个工作空间。
可以使用 [`package.workspace`] 键在成员 crate 中指向工作空间根目录来覆盖此自动搜索。
如果成员不在工作区空间目录的子目录中，则手动设置可能很有用。
{==+==}


{==+==}
#### Package selection
{==+==}
#### Package 部分
{==+==}


{==+==}
In a workspace, package-related cargo commands like [`cargo build`] can use
the `-p` / `--package` or `--workspace` command-line flags to determine which
packages to operate on. If neither of those flags are specified, Cargo will
use the package in the current working directory. If the current directory is
a [virtual workspace](#virtual-workspace), it will apply to all members (as if
`--workspace` were specified on the command-line).  See also
[`default-members`](#the-default-members-field).
{==+==}
在工作空间中，可以使用 `-p` / `-package` 或 `-workspace` 命令行标志来确定要操作哪些包的 cargo 命令，如 [`cargo build`] 。
如果未指定这些标志， Cargo 将使用当前工作目录中的包。
如果当前目录是 [虚拟工作空间](#virtual-workspace) ，则它将应用于所有成员 (就像在命令行上指定了 `--workspace` 一样) 。
另请参阅 [`default-members`](#the-default-members-field) 。
{==+==}


{==+==}
### The `default-members` field
{==+==}
###  `default-members` 字段
{==+==}


{==+==}
The optional `default-members` key can be specified to set the members to
operate on when in the workspace root and the package selection flags are not
used:
{==+==}
可以指定可选的 `default-members` 键来设置在工作空间根目录中未使用包选择标志时要操作的成员:
{==+==}


{==+==}
```toml
[workspace]
members = ["path/to/member1", "path/to/member2", "path/to/member3/*"]
default-members = ["path/to/member2", "path/to/member3/foo"]
```
{==+==}

{==+==}


{==+==}
When specified, `default-members` must expand to a subset of `members`.
{==+==}
当指定 `default-members` 时，添加的必须是 `members` 的子集。
{==+==}


{==+==}
### The `package` table
{==+==}
### `package` 表
{==+==}


{==+==}
The `workspace.package` table is where you define keys that can be
inherited by members of a workspace. These keys can be inherited by
defining them in the member package with `{key}.workspace = true`.
{==+==}
 `workspace.package` 表是您定义可以由工作空间成员继承的键的地方。
 可以通过在成员包中使用 `{key}.workspace = true` 定义它们来继承这些键。
{==+==}

{==+==}
Keys that are supported:
{==+==}
支持的键:
{==+==}

{==+==}
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
{==+==}

{==+==}


{==+==}
- `license-file` and `readme` are relative to the workspace root
- `include` and `exclude` are relative to your package root
{==+==}
- `license-file` 和 `readme` 是相对于工作空间根。
- `include` 和 `exclude` 是相对于包的根。
{==+==}


{==+==}
Example:
{==+==}
示例:
{==+==}


{==+==}
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
{==+==}

{==+==}


{==+==}
### The `dependencies` table
{==+==}
### `dependencies` 表
{==+==}

{==+==}
The `workspace.dependencies` table is where you define dependencies to be
inherited by members of a workspace.
{==+==}
 `workspace.dependencies` 表是您定义要由工作空间成员继承的依赖的地方。
{==+==}

{==+==}
Specifying a workspace dependency is similar to [package dependencies][specifying-dependencies] except:
{==+==}
指定工作空间依赖与 [包依赖][specifying-dependencies] 类似，但是:

{==+==}


{==+==}
- Dependencies from this table cannot be declared as `optional`
- [`features`][features] declared in this table are additive with the `features` from `[dependencies]`
{==+==}
- 此表中的依赖不能声明为 `optional` 可选的。
- 在此表中声明的 [`features`][features] 特性将与来自 `[dependencies]` 的 `features` 叠加。
{==+==}


{==+==}
You can then [inherit the workspace dependency as a package dependency][inheriting-a-dependency-from-a-workspace]
{==+==}
从而，就可以 [把工作区的依赖作为包的依赖来继承][inheriting-a-dependency-from-a-workspace] 。
{==+==}


{==+==}
Example:
{==+==}
示例:
{==+==}


{==+==}
```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["bar"]

[workspace.dependencies]
cc = "1.0.73"
rand = "0.8.5"
regex = { version = "1.6.0", default-features = false, features = ["std"] }
```
{==+==}

{==+==}


{==+==}
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
{==+==}

{==+==}



{==+==}
### The `metadata` table
{==+==}
### `metadata` 表
{==+==}


{==+==}
The `workspace.metadata` table is ignored by Cargo and will not be warned
about. This section can be used for tools that would like to store workspace
configuration in `Cargo.toml`. For example:
{==+==}
 `workspace.metadata` 表被 Cargo 忽略，不会发出警告。此部分可用于希望在 `Cargo.toml` 中存储工作空间配置的工具。例如:
{==+==}


{==+==}
```toml
[workspace]
members = ["member1", "member2"]

[workspace.metadata.webcontents]
root = "path/to/webproject"
tool = ["npm", "run", "build"]
# ...
```
{==+==}

{==+==}


{==+==}
There is a similar set of tables at the package level at
[`package.metadata`][package-metadata]. While cargo does not specify a
format for the content of either of these tables, it is suggested that
external tools may wish to use them in a consistent fashion, such as referring
to the data in `workspace.metadata` if data is missing from `package.metadata`,
if that makes sense for the tool in question.
{==+==}
在 [`package.metadata`][package-metadata] 的包层级有一套类似的表。
虽然 Cargo 不为这些表中的内容指定格式，但建议外部工具能以一致的方式使用它们，例如，如果 `package.metadata` 中缺少数据，可以参考 `workspace.metadata` 中的数据，如果对相关工具来说有意义。
{==+==}


{==+==}
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
{==+==}

{==+==}