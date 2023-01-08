## 工作空间

*工作空间*是一个或多个包的集合，称为*工作空间成员*，它们被一起管理。

工作空间的关键点是:

* 普通命令可以在所有工作空间成员中运行，如`cargo check --workspace`。
* 所有软件包共享一个共同的[`Cargo.lock`]文件，该文件驻留在 *工作空间根* 下。
* 所有软件包共享一个共同的[output directory]，该目录默认为 *工作空间根* 下的`target`。
* 共享包的元数据，比如[`workspace.package`](#`package`表)。
*   `Cargo.toml`中的[`[patch]`][patch], [`[replace]`][replace]和[`[profile.*]`][profiles]只在 *根* 清单中被识别，而在成员crates'清单中被忽略。

在`Cargo.toml`中，`[workspace]`表格支持以下部分:

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

###  `[workspace]`部分

要创建一个工作空间，你需要在`Cargo.toml`中添加`[workspace]`:
```toml
[workspace]
# ...
```

一个工作空间至少有一个成员，要么是一个根package，要么作为虚拟清单。

#### 根package

如果 [`[workspace]` ](#`[workspace]`部分)被添加到了一个已定义`[package]`的 `Cargo.toml`中，该package就是工作空间的*根package*。 *工作空间根* 是指工作空间的 `Cargo.toml` 所在的目录。

```toml
[workspace]

[package]
name = "hello_world" # package的名字
version = "0.1.0"    # 当前版本, 遵循 semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

<a id="virtual-manifest"></a>
#### 虚拟工作空间

或者可以创建一个 `Cargo.toml`文件，其中有一个`[workspace]`但没有[`[package]`][package]。这被称为*虚拟清单*。当没有一个 "主要 "软件包时，这通常很有用，或者你想把所有的软件包放在不同的目录里。

```toml
# [PROJECT_DIR]/Cargo.toml
[workspace]
members = ["hello_world"]
```

```toml
# [PROJECT_DIR]/hello_world/Cargo.toml
[package]
name = "hello_world" # package名称
version = "0.1.0"    # 当前版本, 遵循 semver
authors = ["Alice <a@example.com>", "Bob <b@example.com>"]
```

### `members`和`exclude`字段 

`members` 和 `exclude`字段定义哪些package是工作空间的成员:

```toml
[workspace]
members = ["member1", "path/to/member2", "crates/*"]
exclude = ["crates/foo", "path/to/other"]
```

驻留在工作空间目录中的所有[`path` dependencies]自动成为成员。其他成员可以用 `members`key列出。
它应该是一个包含`Cargo.toml`文件的目录的字符串数组。

`members`列表也支持[globs]来匹配多个路径，使用典型的文件名glob模式，如`*`和`?`。

`exclude`key可以用来防止路径被包含在一个工作空间。可以用于如果某些路径依赖不希望出现在工作空间中，使用glob模式和你想删除一个目录中。

当在工作空间的一个子目录中，Cargo将自动搜索父目录中带`[workspace]`的 `Cargo.toml`文件，以确定使用哪个工作空间。定义的文件来决定使用哪个工作空间。
[`package.workspace`]文件可在成员crates中使用清单key来指向工作空间的根，以覆盖这种自动搜索。当成员不在工作空间根目录的子目录内，手动设置就很有用。

#### Package 部分

在工作空间中，与package有关的cargo命令，如[`cargo build`]可以使用
`-p`/`-package`或`-workspace`命令行标志来决定对哪些
package来操作。如果这两个标志都没有被指定，Cargo将使用当前工作目录下的package。
如果当前的目录是一个[虚拟工作空间](#virtual-workspace)，它将用于所有成员(就像`--workspace`是在命令行上指定的)。
也请参见[`default-members`](#the-default-members-field)。

###  `default-members`字段

可选的`default-members`key可以被指定，以设置在工作空间根和package选择标志未被使用时操作的成员:

```toml
[workspace]
members = ["path/to/member1", "path/to/member2", "path/to/member3/*"]
default-members = ["path/to/member2", "path/to/member3/foo"]
```

当指定时，`default-members`必须扩展到`members`的一个子集。

### `package`表

`workspace.package`表是你定义可以被工作空间成员继承的key的地方。这些key可以通过在成员包中定义`{key}.workspace = true`来继承。

支持的key

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

- `license-file`和 `readme`是相对于工作空间根的。
- `include`和`exclude`是相对于你的package根的。

例子:
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

### `dependencies`表

`workspace.dependencies`是你定义工作空间成员所继承的依赖性的地方。

指定工作空间依赖与[package依赖][specifying-dependencies]类似，除了:
- 此表中的依赖关系不能被声明为 `optional`。
- 在此表中声明的[`features`][features]与来自`[dependencies]`的 `features` 是相加的。

然后你可以[把工作区的依赖性作为包的依赖性来继承][inheriting-a-dependency-from-a-workspace]

例子:
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

### `metadata`表

`workspace.metadata`表会被Cargo忽略，不会被警告。这一部分可以用于那些想在`Cargo.toml`中存储工作空间配置的工具。比如说:

```toml
[workspace]
members = ["member1", "member2"]

[workspace.metadata.webcontents]
root = "path/to/webproject"
tool = ["npm", "run", "build"]
# ...
```

在package一级也有一组类似的表格，地址是
[`package.metadata`][package-metadata]。虽然Cargo没有为这些表的内容指定格式，但建议外部工具以一致的方式使用它们，例如，如果`package.metadata`中缺少数据，可以参考`workspace.metadata`中的数据，如果这对相关工具来说是有意义的。

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
