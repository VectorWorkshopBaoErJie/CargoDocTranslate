{==+==}
## Workspaces
{==+==}
## 工作空间
{==+==}

{==+==}
A *workspace* is a collection of one or more packages, called *workspace
members*, that are managed together.
{==+==}
*工作空间*是一个或多个包的集合，称为*工作空间成员*，它们被一起管理。
{==+==}

{==+==}
The key points of workspaces are:
{==+==}
工作空间的关键点是:
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
* 普通命令可以在所有工作空间成员中运行，如`cargo check --workspace`。
* 所有软件包共享一个共同的[`Cargo.lock`]文件，该文件驻留在 *工作空间根* 下。
* 所有软件包共享一个共同的[output directory]，该目录默认为 *工作空间根* 下的`target`。
* 共享包的元数据，比如[`workspace.package`](#`package`表)。
*   `Cargo.toml`中的[`[patch]`][patch], [`[replace]`][replace]和[`[profile.*]`][profiles]只在 *根* 清单中被识别，而在成员crates'清单中被忽略。
{==+==}

{==+==}
In the `Cargo.toml`, the `[workspace]` table supports the following sections:
{==+==}
在`Cargo.toml`中，`[workspace]`表格支持以下部分:
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
* [`[workspace]`](#`[workspace]`部分) — 定义了一个工作空间。
  * [`resolver`](resolver.md#resolver-versions) — 设置要使用的依赖关系解析器。
  * [`members`](#`members`和`exclude`字段) — 包括在工作空间的包。
  * [`exclude`](#`members`和`exclude`字段) — 要从工作空间排除的包。
  * [`default-members`](#`default-members`字段) — 当没有选择特定的包时，要对包进行操作。
  * [`package`](#`package`表) — 在包中继承的key。
  * [`dependencies`](#`dependencies`表) — 在包的依赖中继承的key。
  * [`metadata`](#`metadata`表) — 外部工具的额外设置。
* [`[patch]`](overriding-dependencies.md#the-patch-section) — 依赖覆盖。
* [`[replace]`](overriding-dependencies.md#the-replace-section) — 依赖覆盖(已废弃)。
* [`[profile]`](profiles.md) — 编译器设置和优化。
{==+==}

{==+==}
### The `[workspace]` section
{==+==}
###  `[workspace]`部分
{==+==}

{==+==}
To create a workspace, you add the `[workspace]` table to a `Cargo.toml`:
{==+==}
要创建一个工作空间，你需要在`Cargo.toml`中添加`[workspace]`:
{==+==}

```toml
[workspace]
# ...
```

{==+==}
At minimum, a workspace has to have a member, either with a root package or as
a virtual manifest.
{==+==}
一个工作空间至少有一个成员，要么是一个根package，要么作为虚拟清单。
{==+==}

{==+==}
#### Root package
{==+==}
#### 根package
{==+==}

{==+==}
If the [`[workspace]` section](#the-workspace-section) is added to a
`Cargo.toml` that already defines a `[package]`, the package is
the *root package* of the workspace. The *workspace root* is the directory
where the workspace's `Cargo.toml` is located.
{==+==}
如果 [`[workspace]` ](#`[workspace]`部分)被添加到了一个已定义`[package]`的 `Cargo.toml`中，该package就是工作空间的*根package*。 *工作空间根* 是指工作空间的 `Cargo.toml` 所在的目录。
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
name = "hello_world" # package的名字
version = "0.1.0"    # 当前版本, 遵循 semver
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
或者可以创建一个 `Cargo.toml`文件，其中有一个`[workspace]`但没有[`[package]`][package]。这被称为*虚拟清单*。当没有一个 "主要 "软件包时，这通常很有用，或者你想把所有的软件包放在不同的目录里。
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
version = "0.1.0"    # 当前版本, 遵循 semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```
{==+==}


{==+==}
### The `members` and `exclude` fields 
{==+==}
### `members`和`exclude`字段 
{==+==}

{==+==}
The `members` and `exclude` fields define which packages are members of
the workspace:
{==+==}
`members` 和 `exclude`字段定义哪些package是工作空间的成员:
{==+==}

```toml
[workspace]
members = ["member1", "path/to/member2", "crates/*"]
exclude = ["crates/foo", "path/to/other"]
```
{==+==}
All [`path` dependencies] residing in the workspace directory automatically
become members. Additional members can be listed with the `members` key, which
should be an array of strings containing directories with `Cargo.toml` files.
{==+==}
驻留在工作空间目录中的所有[`path` dependencies]自动成为成员。其他成员可以用 `members`key列出。
它应该是一个包含`Cargo.toml`文件的目录的字符串数组。
{==+==}

{==+==}
The `members` list also supports [globs] to match multiple paths, using
typical filename glob patterns like `*` and `?`.
{==+==}
`members`列表也支持[globs]来匹配多个路径，使用典型的文件名glob模式，如`*`和`?`。
{==+==}

{==+==}
The `exclude` key can be used to prevent paths from being included in a
workspace. This can be useful if some path dependencies aren't desired to be
in the workspace at all, or using a glob pattern and you want to remove a
directory.
{==+==}
`exclude`key可以用来防止路径被包含在一个工作空间。可以用于如果某些路径依赖不希望出现在工作空间中，使用glob模式和你想删除一个目录中。
{==+==}

{==+==}
When inside a subdirectory within the workspace, Cargo will automatically
search the parent directories for a `Cargo.toml` file with a `[workspace]`
definition to determine which workspace to use. The [`package.workspace`]
manifest key can be used in member crates to point at a workspace's root to
override this automatic search. The manual setting can be useful if the member
is not inside a subdirectory of the workspace root.
{==+==}
当在工作空间的一个子目录中，Cargo将自动搜索父目录中带`[workspace]`的 `Cargo.toml`文件，以确定使用哪个工作空间。定义的文件来决定使用哪个工作空间。
[`package.workspace`]文件可在成员crates中使用清单key来指向工作空间的根，以覆盖这种自动搜索。当成员不在工作空间根目录的子目录内，手动设置就很有用。
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
在工作空间中，与package有关的cargo命令，如[`cargo build`]可以使用
`-p`/`-package`或`-workspace`命令行标志来决定对哪些
package来操作。如果这两个标志都没有被指定，Cargo将使用当前工作目录下的package。
如果当前的目录是一个[虚拟工作空间](#virtual-workspace)，它将用于所有成员(就像`--workspace`是在命令行上指定的)。
也请参见[`default-members`](#the-default-members-field)。
{==+==}

{==+==}
### The `default-members` field
{==+==}
###  `default-members`字段
{==+==}

{==+==}
The optional `default-members` key can be specified to set the members to
operate on when in the workspace root and the package selection flags are not
used:
{==+==}
可选的`default-members`key可以被指定，以设置在工作空间根和package选择标志未被使用时操作的成员:
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
当指定时，`default-members`必须扩展到`members`的一个子集。
{==+==}

{==+==}
### The `package` table
{==+==}
### `package`表
{==+==}

{==+==}
The `workspace.package` table is where you define keys that can be
inherited by members of a workspace. These keys can be inherited by
defining them in the member package with `{key}.workspace = true`.
{==+==}
`workspace.package`表是你定义可以被工作空间成员继承的key的地方。这些key可以通过在成员包中定义`{key}.workspace = true`来继承。
{==+==}

{==+==}
Keys that are supported:
{==+==}
支持的key
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
- `license-file`和 `readme`是相对于工作空间根的。
- `include`和`exclude`是相对于你的package根的。
{==+==}

{==+==}
Example:
{==+==}
例子:
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
### `dependencies`表
{==+==}

{==+==}
The `workspace.dependencies` table is where you define dependencies to be
inherited by members of a workspace.
{==+==}
`workspace.dependencies`是你定义工作空间成员所继承的依赖性的地方。
{==+==}

{==+==}
Specifying a workspace dependency is similar to [package dependencies][specifying-dependencies] except:
{==+==}
指定工作空间依赖与[package依赖][specifying-dependencies]类似，除了:
{==+==}

{==+==}
- Dependencies from this table cannot be declared as `optional`
- [`features`][features] declared in this table are additive with the `features` from `[dependencies]`
{==+==}
- 此表中的依赖关系不能被声明为 `optional`。
- 在此表中声明的[`features`][features]与来自`[dependencies]`的 `features` 是相加的。
{==+==}

{==+==}
You can then [inherit the workspace dependency as a package dependency][inheriting-a-dependency-from-a-workspace]
{==+==}
然后你可以[把工作区的依赖性作为包的依赖性来继承][inheriting-a-dependency-from-a-workspace]
{==+==}

{==+==}
Example:
{==+==}
例子:
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
### `metadata`表
{==+==}

{==+==}
The `workspace.metadata` table is ignored by Cargo and will not be warned
about. This section can be used for tools that would like to store workspace
configuration in `Cargo.toml`. For example:
{==+==}
`workspace.metadata`表会被Cargo忽略，不会被警告。这一部分可以用于那些想在`Cargo.toml`中存储工作空间配置的工具。比如说:
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
There is a similar set of tables at the package level at
[`package.metadata`][package-metadata]. While cargo does not specify a
format for the content of either of these tables, it is suggested that
external tools may wish to use them in a consistent fashion, such as referring
to the data in `workspace.metadata` if data is missing from `package.metadata`,
if that makes sense for the tool in question.
{==+==}
在package一级也有一组类似的表格，地址是
[`package.metadata`][package-metadata]。虽然Cargo没有为这些表的内容指定格式，但建议外部工具以一致的方式使用它们，例如，如果`package.metadata`中缺少数据，可以参考`workspace.metadata`中的数据，如果这对相关工具来说是有意义的。
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