{==+==}
## Specifying Dependencies
{==+==}
## 指定依赖
{==+==}


{==+==}
Your crates can depend on other libraries from [crates.io] or other
registries, `git` repositories, or subdirectories on your local file system.
You can also temporarily override the location of a dependency — for example,
to be able to test out a bug fix in the dependency that you are working on
locally. You can have different dependencies for different platforms, and
dependencies that are only used during development. Let's take a look at how
to do each of these.
{==+==}
你的 crate 可以依赖于来自 [crates.io] 或其他注册中心、`git` 仓库或本地文件系统子目录中的其他库。
你还可以暂时覆盖依赖的位置 —— 例如，为了能够在本地测试正在处理的依赖中的错误修复。
你可以为不同的平台设置不同的依赖，并且可以在开发过程中仅使用某些依赖。让我们看看如何完成这些操作。
{==+==}


{==+==}
### Specifying dependencies from crates.io
{==+==}
### 指定 crate.io 中的依赖
{==+==}

{==+==}
Cargo is configured to look for dependencies on [crates.io] by default. Only
the name and a version string are required in this case. In [the cargo
guide](../guide/index.md), we specified a dependency on the `time` crate:
{==+==}
默认情况下，Cargo 配置为在 [crates.io] 上查找依赖。
此时仅需要指定依赖的名称和版本字符串。在 Cargo [cargo指南](../guide/index.md) 中，我们指定了对 `time` crate 的依赖关系：
{==+==}


{==+==}
```toml
[dependencies]
time = "0.1.12"
```
{==+==}

{==+==}


{==+==}
The string `"0.1.12"` is a version requirement. Although it looks like a
specific *version* of the `time` crate, it actually specifies a *range* of
versions and allows [SemVer] compatible updates. An update is allowed if the new
version number does not modify the left-most non-zero digit in the major, minor,
patch grouping. In this case, if we ran `cargo update -p time`, cargo should
update us to version `0.1.13` if it is the latest `0.1.z` release, but would not
update us to `0.2.0`. If instead we had specified the version string as `1.0`,
cargo should update to `1.1` if it is the latest `1.y` release, but not `2.0`.
The version `0.0.x` is not considered compatible with any other version.
{==+==}
字符串 `"0.1.12"` 是一个版本需求。虽然它看起来像是对 `time` crate 的具体版本，但实际上指定了一个版本范围，并允许 [SemVer] 语义化兼容的更新。
如果新版本号不修改 `主版本号.次版本号.修订号` 的最左侧非零数字，就允许更新。
在这种情况下，如果我们运行 `cargo update -p time`，Cargo 应该将更新到 `0.1.13` 版本 (如果它是最新的 `0.1.z` 发布)，但不会更新到 `0.2.0` 版本。
如果我们将版本字符串指定为 `1.0` ，则当最新的 `1.y` 发布为 `1.1` 时，Cargo 应该会更新到该版本，但不会更新到 `2.0` 版本。版本 `0.0.x` 认为与任何其他版本都不兼容。
{==+==}


{==+==}
[SemVer]: https://semver.org
{==+==}

{==+==}


{==+==}
Here are some more examples of version requirements and the versions that would
be allowed with them:
{==+==}
以下是一些版本需求的示例以及符合这些需求的版本：
{==+==}


{==+==}
```notrust
1.2.3  :=  >=1.2.3, <2.0.0
1.2    :=  >=1.2.0, <2.0.0
1      :=  >=1.0.0, <2.0.0
0.2.3  :=  >=0.2.3, <0.3.0
0.2    :=  >=0.2.0, <0.3.0
0.0.3  :=  >=0.0.3, <0.0.4
0.0    :=  >=0.0.0, <0.1.0
0      :=  >=0.0.0, <1.0.0
```
{==+==}

{==+==}


{==+==}
This compatibility convention is different from SemVer in the way it treats
versions before 1.0.0. While SemVer says there is no compatibility before
1.0.0, Cargo considers `0.x.y` to be compatible with `0.x.z`, where `y ≥ z`
and `x > 0`.
{==+==}
这种兼容性约定与 SemVer 在处理 1.0.0 之前的版本时不同。虽然 SemVer 规定 1.0.0 之前的版本不兼容，但是 Cargo 认为 `0.x.y` 与 `0.x.z` 兼容，只要 `y ≥ z`，且 `x > 0`。
{==+==}

{==+==}
It is possible to further tweak the logic for selecting compatible versions
using special operators, though it shouldn't be necessary most of the time.
{==+==}
可以使用特殊运算符进一步调整选择兼容版本的逻辑，但大多数情况下不需要这样做。
{==+==}

{==+==}
### Caret requirements
{==+==}
### 使用 `^` 符号
{==+==}


{==+==}
**Caret requirements** are an alternative syntax for the default strategy,
`^1.2.3` is exactly equivalent to `1.2.3`.
{==+==}
** `^` 符号需求** 是默认策略的另一种语法形式， `^1.2.3` 和 `1.2.3` 完全等价。
{==+==}


{==+==}
### Tilde requirements
{==+==}
### 使用 `~` 符号
{==+==}


{==+==}
**Tilde requirements** specify a minimal version with some ability to update.
If you specify a major, minor, and patch version or only a major and minor
version, only patch-level changes are allowed. If you only specify a major
version, then minor- and patch-level changes are allowed.
{==+==}
** `~` 符号需求** 指定了一个具有一定升级能力的最小版本。
如果你指定了 `主.次.修` ，或者只指定了 `主.次` ，则只允许进行修订级别的更改。
如果只指定了主版本号，则允许进行次级别和修订级别的更改。
{==+==}


{==+==}
`~1.2.3` is an example of a tilde requirement.
{==+==}
`~1.2.3` 的例子:
{==+==}


{==+==}
```notrust
~1.2.3  := >=1.2.3, <1.3.0
~1.2    := >=1.2.0, <1.3.0
~1      := >=1.0.0, <2.0.0
```
{==+==}

{==+==}


{==+==}
### Wildcard requirements
{==+==}
### 使用 `*` 通配符
{==+==}

{==+==}
**Wildcard requirements** allow for any version where the wildcard is
positioned.
{==+==}
** `*` 符号需求** 允许在通配符所在位置使用任何版本。
{==+==}

{==+==}
`*`, `1.*` and `1.2.*` are examples of wildcard requirements.
{==+==}
比如 `*` 、 `1.*` 、 `1.2.*`。
{==+==}


{==+==}
```notrust
*     := >=0.0.0
1.*   := >=1.0.0, <2.0.0
1.2.* := >=1.2.0, <1.3.0
```
{==+==}

{==+==}


{==+==}
> **Note**: [crates.io] does not allow bare `*` versions.
{==+==}
> **注意**: [crates.io] 不允许单独的 `*` 。
{==+==}

{==+==}
### Comparison requirements
{==+==}
### 使用比较符号
{==+==}

{==+==}
**Comparison requirements** allow manually specifying a version range or an
exact version to depend on.
{==+==}
**比较符号需求** 使用比较符号可以手动指定版本范围或一个具体的版本。
{==+==}

{==+==}
Here are some examples of comparison requirements:
{==+==}
下面是一些例子:
{==+==}


{==+==}
```notrust
>= 1.2.0
> 1
< 2
= 1.2.3
```
{==+==}

{==+==}


{==+==}
### Multiple requirements
{==+==}
### 多重约束
{==+==}

{==+==}
As shown in the examples above, multiple version requirements can be
separated with a comma, e.g., `>= 1.2, < 1.5`.
{==+==}
如上面的示例所示，多个版本需求可以用逗号分隔，例如 `>= 1.2, < 1.5` 。
{==+==}

{==+==}
### Specifying dependencies from other registries
{==+==}
### 指定来自其他注册中心的依赖
{==+==}


{==+==}
To specify a dependency from a registry other than [crates.io], first the
registry must be configured in a `.cargo/config.toml` file. See the [registries
documentation] for more information. In the dependency, set the `registry` key
to the name of the registry to use.
{==+==}
要指定来自 [crates.io] 以外的注册中心的依赖项，首先必须在 `.cargo/config.toml` 文件中配置该注册中心。
有关更多信息，请参阅 [registries documentation]。在依赖项中，将 `registry` 键设置为要使用的注册中心的名称。
{==+==}


{==+==}
```toml
[dependencies]
some-crate = { version = "1.0", registry = "my-registry" }
```
{==+==}

{==+==}


{==+==}
> **Note**: [crates.io] does not allow packages to be published with
> dependencies on other registries.
{==+==}
> **注意**: [crates.io] 不允许发布依赖其他注册中心的包。
{==+==}


{==+==}
[registries documentation]: registries.md
{==+==}

{==+==}


{==+==}
### Specifying dependencies from `git` repositories
{==+==}
### 指定来自 `git` 的依赖
{==+==}


{==+==}
To depend on a library located in a `git` repository, the minimum information
you need to specify is the location of the repository with the `git` key:
{==+==}
要依赖位于 `git` 存储库中的库，你需要指定的最小信息是使用 `git` 键指定仓库的位置:
{==+==}


{==+==}
```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git" }
```
{==+==}

{==+==}


{==+==}
Cargo will fetch the `git` repository at this location then look for a
`Cargo.toml` for the requested crate anywhere inside the `git` repository
(not necessarily at the root - for example, specifying a member crate name
of a workspace and setting `git` to the repository containing the workspace).
{==+==}
Cargo 将在此位置获取 `git` 仓库，然后在仓库内查找所请求的 crate 的 `Cargo.toml` (不一定在根目录 - 例如，指定工作区的成员名称并将 `git` 设置为包含工作空间的仓库)。
{==+==}


{==+==}
Since we haven’t specified any other information, Cargo assumes that
we intend to use the latest commit on the main branch to build our package.
You can combine the `git` key with the `rev`, `tag`, or `branch` keys to
specify something else. Here's an example of specifying that you want to use
the latest commit on a branch named `next`:
{==+==}
由于我们没有指定其他信息，Cargo 假定我们打算使用最新的提交来构建我们的包。
你可以将 `git` 键与 `rev`、`tag` 或 `branch` 键组合，以指定其他内容。
下面是一个示例，指定你要使用名为 `next` 的分支上的最新提交：
{==+==}


{==+==}
```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git", branch = "next" }
```
{==+==}

{==+==}


{==+==}
Anything that is not a branch or tag falls under `rev`. This can be a commit
hash like `rev = "4c59b707"`, or a named reference exposed by the remote
repository such as `rev = "refs/pull/493/head"`. What references are available
varies by where the repo is hosted; GitHub in particular exposes a reference to
the most recent commit of every pull request as shown, but other git hosts often
provide something equivalent, possibly under a different naming scheme.
{==+==}
任何不是分支或标签的都属于 `rev` 。这可以是类似于 `rev="4c59b707"` 的提交哈希，或者是由远程仓库公开的命名引用，例如 `rev="refs/pull/493/head"` 。
可用的引用因仓库托管的位置而异；特别是 GitHub 会显示每个拉取请求的最新提交的引用，但其他 git 主机通常提供类似的东西，可能使用不同的命名方案。
{==+==}


{==+==}
Once a `git` dependency has been added, Cargo will lock that dependency to the
latest commit at the time. New commits will not be pulled down automatically
once the lock is in place. However, they can be pulled down manually with
`cargo update`.
{==+==}
一旦添加了一个 `git` 依赖，Cargo 将锁定该依赖到在该时间的最新提交。
一旦锁定，新的提交将不会自动拉取。但是，可以使用 `cargo update` 命令手动拉取。
{==+==}


{==+==}
See [Git Authentication] for help with git authentication for private repos.
{==+==}
参见 [Git 身份验证][Git Authentication] ，了解如何为私有仓库进行 Git 身份验证。
{==+==}


{==+==}
> **Note**: [crates.io] does not allow packages to be published with `git`
> dependencies (`git` [dev-dependencies] are ignored). See the [Multiple
> locations](#multiple-locations) section for a fallback alternative.
{==+==}
> **注意**: [crates.io] 不允许在发布包时使用 `git` 依赖 ( `git` [dev-dependencies] 被忽略) 。请参见 [多个位置](#multiple-locations) 部分以获取回退的替代方案。
{==+==}


{==+==}
[Git Authentication]: ../appendix/git-authentication.md
{==+==}

{==+==}


{==+==}
### Specifying path dependencies
{==+==}
### 指定路径依赖
{==+==}


{==+==}
Over time, our `hello_world` package from [the guide](../guide/index.md) has
grown significantly in size! It’s gotten to the point that we probably want to
split out a separate crate for others to use. To do this Cargo supports **path
dependencies** which are typically sub-crates that live within one repository.
Let’s start off by making a new crate inside of our `hello_world` package:
{==+==}
随着时间的推移，我们的 [指南](../guide/index.md) 中的 `hello_world` 包变得越来越庞大！
现在，我们可能想要将其拆分为一个独立的包供其他人使用。
为此，Cargo 支持路径依赖，它们通常是位于同一个仓库中的子 crate 。
让我们首先在 `hello_world` 包中创建一个新的 crate ：
{==+==}


{==+==}
```console
# inside of hello_world/
$ cargo new hello_utils
```
{==+==}
```console
# hello_world/ 目录中
$ cargo new hello_utils
```
{==+==}


{==+==}
This will create a new folder `hello_utils` inside of which a `Cargo.toml` and
`src` folder are ready to be configured. In order to tell Cargo about this, open
up `hello_world/Cargo.toml` and add `hello_utils` to your dependencies:
{==+==}
这将在 `hello_world` 包内创建一个名为 `hello_utils` 的新文件夹，其中包含一个 `Cargo.toml` 文件和一个 `src` 文件夹，可以进行配置。
为了让 Cargo 知道这个新的 crate，打开 `hello_world/Cargo.toml` 并将 `hello_utils` 添加到依赖项中：
{==+==}


{==+==}
```toml
[dependencies]
hello_utils = { path = "hello_utils" }
```
{==+==}

{==+==}


{==+==}
This tells Cargo that we depend on a crate called `hello_utils` which is found
in the `hello_utils` folder (relative to the `Cargo.toml` it’s written in).
{==+==}
这告诉 Cargo 我们依赖一个名为 `hello_utils` 的 crate，该 crate 位于 `hello_utils` 文件夹中 (相对于包含它的 `Cargo.toml` 文件的路径)。
{==+==}


{==+==}
And that’s it! The next `cargo build` will automatically build `hello_utils` and
all of its own dependencies, and others can also start using the crate as well.
However, crates that use dependencies specified with only a path are not
permitted on [crates.io]. If we wanted to publish our `hello_world` crate, we
would need to publish a version of `hello_utils` to [crates.io]
and specify its version in the dependencies line as well:
{==+==}
这样就完成了！下一次运行 `cargo build` 命令时，Cargo 将自动构建 `hello_utils` 包及其所有依赖项，并且其他人也可以开始使用该包。
但是，仅使用路径指定的依赖项的 crate 不允许在 [crates.io] 上发布。
如果我们想要发布 `hello_world` crate，我们需要先将 `hello_utils` 包的一个版本发布到 [crates.io] 上，并在依赖项行中指定其版本号:
{==+==}


{==+==}
```toml
[dependencies]
hello_utils = { path = "hello_utils", version = "0.1.0" }
```
{==+==}

{==+==}


{==+==}
> **Note**: [crates.io] does not allow packages to be published with `path`
> dependencies (`path` [dev-dependencies] are ignored). See the [Multiple
> locations](#multiple-locations) section for a fallback alternative.
{==+==}
> **注意**: [crates.io] 不允许包含 `path` 依赖关系的包 ( `path` [dev-dependencies] 会被忽略) 。参见 [多个位置](#multiple-locations) 章节以获得替代方案。
{==+==}


{==+==}
### Multiple locations
{==+==}
### 多个位置
{==+==}


{==+==}
It is possible to specify both a registry version and a `git` or `path`
location. The `git` or `path` dependency will be used locally (in which case
the `version` is checked against the local copy), and when published to a
registry like [crates.io], it will use the registry version. Other
combinations are not allowed. Examples:
{==+==}
可以同时指定注册中心版本和 `git` 或 `path` 地址。
本地将使用 `git` 或 `path` 依赖项 ( 此时 `version` 会与本地副本进行比较)，当发布到像 [crates.io] 这样的注册中心时，它将使用注册中心版本。
不允许使用其他组合。例如：
{==+==}


{==+==}
```toml
[dependencies]
# Uses `my-bitflags` when used locally, and uses
# version 1.0 from crates.io when published.
bitflags = { path = "my-bitflags", version = "1.0" }

# Uses the given git repo when used locally, and uses
# version 1.0 from crates.io when published.
smallvec = { git = "https://github.com/servo/rust-smallvec.git", version = "1.0" }

# N.B. that if a version doesn't match, Cargo will fail to compile!
```
{==+==}
```toml
[dependencies]
# 在本地时使用 `my-bitflags`
# 而上传后使用 crates.io 中的 1.0 版本
bitflags = { path = "my-bitflags", version = "1.0" }

# 在本地时使用给定的 git 仓库
# 而上传后使用 crates.io 中的1.0 版本
smallvec = { git = "https://github.com/servo/rust-smallvec.git", version = "1.0" }

# 如果 version 不能匹配，Cargo 会编译失败！
```
{==+==}


{==+==}
One example where this can be useful is when you have split up a library into
multiple packages within the same workspace. You can then use `path`
dependencies to point to the local packages within the workspace to use the
local version during development, and then use the [crates.io] version once it
is published. This is similar to specifying an
[override](overriding-dependencies.md), but only applies to this one
dependency declaration.
{==+==}
这种情况的一个例子是将库拆分为同一工作空间中的多个包。
你可以使用 `path` 依赖项指向工作空间中的本地包，在开发期间使用本地版本，然后在发布后使用 [crates.io] 版本。
这类似于指定 [override](overriding-dependencies.md) ，但仅适用于这个依赖声明。
{==+==}


{==+==}
### Platform specific dependencies
{==+==}
### 平台特定依赖
{==+==}

{==+==}
Platform-specific dependencies take the same format, but are listed under a
`target` section. Normally Rust-like [`#[cfg]`
syntax](../../reference/conditional-compilation.html) will be used to define
these sections:
{==+==}
平台相关的依赖项采用相同的格式，但在 `target` 部分下进行列出。
通常，会使用类似 Rust [`#[cfg]` 语法](../../reference/conditional-compilation.html) 来定义这些部分：
{==+==}


{==+==}
```toml
[target.'cfg(windows)'.dependencies]
winhttp = "0.4.0"

[target.'cfg(unix)'.dependencies]
openssl = "1.0.1"

[target.'cfg(target_arch = "x86")'.dependencies]
native-i686 = { path = "native/i686" }

[target.'cfg(target_arch = "x86_64")'.dependencies]
native-x86_64 = { path = "native/x86_64" }
```
{==+==}

{==+==}


{==+==}
Like with Rust, the syntax here supports the `not`, `any`, and `all` operators
to combine various cfg name/value pairs.
{==+==}
和 Rust 一样，这里的语法支持 `not`、`any` 和 `all` 操作符来组合各种 cfg 名称/值对。
{==+==}


{==+==}
If you want to know which cfg targets are available on your platform, run
`rustc --print=cfg` from the command line. If you want to know which `cfg`
targets are available for another platform, such as 64-bit Windows,
run `rustc --print=cfg --target=x86_64-pc-windows-msvc`.
{==+==}
如果你想知道你的平台上有哪些 cfg target，可以在命令行中运行 `rustc --print=cfg` 。
如果你想知道另一个平台上有哪些 `cfg` target，比如 64 位 Windows ，请运行 `rustc --print=cfg --target=x86_64-pc-windows-msvc` 。
{==+==}


{==+==}
Unlike in your Rust source code, you cannot use
`[target.'cfg(feature = "fancy-feature")'.dependencies]` to add dependencies
based on optional features. Use [the `[features]` section](features.md)
instead:
{==+==}
与你的 Rust 源代码不同，你不能使用 `[target.'cfg(feature = "fancy-feature")'.dependencies]` 基于可选特性来添加依赖项。请改用 [features](features.md) 部分：
{==+==}


{==+==}
```toml
[dependencies]
foo = { version = "1.0", optional = true }
bar = { version = "1.0", optional = true }

[features]
fancy-feature = ["foo", "bar"]
```
{==+==}

{==+==}


{==+==}
The same applies to `cfg(debug_assertions)`, `cfg(test)` and `cfg(proc_macro)`.
These values will not work as expected and will always have the default value
returned by `rustc --print=cfg`.
There is currently no way to add dependencies based on these configuration values.
{==+==}
这同样适用于 `cfg(debug_assertions)`、`cfg(test)` 和 `cfg(proc_macro)`。
这些值不能按预期工作，它们始终返回 `rustc --print=cfg` 返回的默认值。目前还没有办法基于这些配置值添加依赖。
{==+==}


{==+==}
In addition to `#[cfg]` syntax, Cargo also supports listing out the full target
the dependencies would apply to:
{==+==}
除了 `#[cfg]` 语法之外，Cargo 还支持列出完整的目标，以适用于依赖项：
{==+==}


{==+==}
```toml
[target.x86_64-pc-windows-gnu.dependencies]
winhttp = "0.4.0"

[target.i686-unknown-linux-gnu.dependencies]
openssl = "1.0.1"
```
{==+==}

{==+==}


{==+==}
#### Custom target specifications
{==+==}

#### 为自定义目标指定依赖
{==+==}


{==+==}
If you’re using a custom target specification (such as `--target
foo/bar.json`), use the base filename without the `.json` extension:
{==+==}
如果你正在使用自定义目标规范 (例如 `--target foo/bar.json` )，请使用不带 `.json` 扩展名的基本文件名：
{==+==}


{==+==}
```toml
[target.bar.dependencies]
winhttp = "0.4.0"

[target.my-special-i686-platform.dependencies]
openssl = "1.0.1"
native = { path = "native/i686" }
```
{==+==}

{==+==}


{==+==}
> **Note**: Custom target specifications are not usable on the stable channel.
{==+==}
> **注意**: 自定义目标规范在稳定通道上不可用。
{==+==}

{==+==}
### Development dependencies
{==+==}
### 开发依赖
{==+==}

{==+==}
You can add a `[dev-dependencies]` section to your `Cargo.toml` whose format
is equivalent to `[dependencies]`:
{==+==}
你可以在 `Cargo.toml` 中添加一个 `[dev-dependencies]` 部分，其格式与 `[dependencies]` 相同：
{==+==}


{==+==}
```toml
[dev-dependencies]
tempdir = "0.3"
```
{==+==}

{==+==}


{==+==}
Dev-dependencies are not used when compiling
a package for building, but are used for compiling tests, examples, and
benchmarks.
{==+==}
dev-dependencies 是用于编译测试、实例和基准的，而不是编译构建包时使用的。
{==+==}


{==+==}
These dependencies are *not* propagated to other packages which depend on this
package.
{==+==}
这些依赖关系 *不会* 传递给依赖于该包的其他包。
{==+==}


{==+==}
You can also have target-specific development dependencies by using
`dev-dependencies` in the target section header instead of `dependencies`. For
example:
{==+==}
你也可以在目标特定的开发依赖项中使用 `dev-dependencies` 代替 `dependencies`。例如：
{==+==}


{==+==}
```toml
[target.'cfg(unix)'.dev-dependencies]
mio = "0.0.1"
```
{==+==}

{==+==}


{==+==}
> **Note**: When a package is published, only dev-dependencies that specify a
> `version` will be included in the published crate. For most use cases,
> dev-dependencies are not needed when published, though some users (like OS
> packagers) may want to run tests within a crate, so providing a `version` if
> possible can still be beneficial.
{==+==}
> **注意**: 当一个包被发布时，只有指定了 `version` 的开发依赖才会被包含在发布的 crate 中。
> 对于大多数用例，发布时不需要开发依赖，但某些用户 (如操作系统打包者) 可能希望在 crate 中运行测试，因此如果可能的话，提供一个 `version` 仍然是有益的。
{==+==}


{==+==}
### Build dependencies
{==+==}
### 构建依赖
{==+==}


{==+==}
You can depend on other Cargo-based crates for use in your build scripts.
Dependencies are declared through the `build-dependencies` section of the
manifest:
{==+==}
你可以依赖其他基于 Cargo 的 crate 用于在你的构建脚本中使用。
通过 `build-dependencies` 部分在 manifest 中声明依赖：
{==+==}


{==+==}
```toml
[build-dependencies]
cc = "1.0.3"
```
{==+==}

{==+==}


{==+==}
You can also have target-specific build dependencies by using
`build-dependencies` in the target section header instead of `dependencies`. For
example:
{==+==}
这些依赖项只在执行构建脚本时才会被使用，而不会在编译你的 Rust 代码时使用。
你可以使用与 `dev-dependencies` 相同的方式声明目标特定的构建依赖。例如：
{==+==}


{==+==}
```toml
[target.'cfg(unix)'.build-dependencies]
cc = "1.0.3"
```
{==+==}

{==+==}


{==+==}
In this case, the dependency will only be built when the host platform matches the
specified target.
{==+==}
在这种情况下，只有在主机平台与指定的目标匹配时才会构建依赖项。
{==+==}


{==+==}
The build script **does not** have access to the dependencies listed
in the `dependencies` or `dev-dependencies` section. Build
dependencies will likewise not be available to the package itself
unless listed under the `dependencies` section as well. A package
itself and its build script are built separately, so their
dependencies need not coincide. Cargo is kept simpler and cleaner by
using independent dependencies for independent purposes.
{==+==}
构建脚本没有访问 `dependencies` 或 `dev-dependencies` 中列出的依赖项。
同样，除非在 `dependencies` 部分中列出，否则构建依赖项也不会对包本身可用。
包本身和其构建脚本是分别构建的，因此它们的依赖项不必一致。
对于独立的目的使用独立的依赖，使用独立的依赖可以使 Cargo 更简单、更清洁。
{==+==}


{==+==}
### Choosing features
{==+==}
### 选择特性
{==+==}


{==+==}
If a package you depend on offers conditional features, you can
specify which to use:
{==+==}
如果你依赖的包提供了条件特性，你可以指定使用哪些特性：
{==+==}


{==+==}
```toml
[dependencies.awesome]
version = "1.3.5"
default-features = false # do not include the default features, and optionally
                         # cherry-pick individual features
features = ["secure-password", "civet"]
```
{==+==}
```toml
[dependencies.awesome]
version = "1.3.5"
default-features = false # 不使用默认特性
                         # 手动选择单独的特性
features = ["secure-password", "civet"]
```
{==+==}


{==+==}
More information about features can be found in the [features
chapter](features.md#dependency-features).
{==+==}
更多关于特性的信息可以在 [特性章节][features chapter](features.md#dependency-features) 中找到。
{==+==}


{==+==}
### Renaming dependencies in `Cargo.toml`
{==+==}
### 在 `Cargo.toml` 中重命名依赖
{==+==}


{==+==}
When writing a `[dependencies]` section in `Cargo.toml` the key you write for a
dependency typically matches up to the name of the crate you import from in the
code. For some projects, though, you may wish to reference the crate with a
different name in the code regardless of how it's published on crates.io. For
example you may wish to:
{==+==}
在 `Cargo.toml` 中编写 `[dependencies]` 部分时，你为一个依赖写的键通常与你在代码中导入的 crate 的名称相匹配。
但是对于某些项目，你可能希望不管 crate 在 crates.io 上如何发布，在代码中都用不同的名称引用它。例如，你可能希望：
{==+==}


{==+==}
* Avoid the need to  `use foo as bar` in Rust source.
* Depend on multiple versions of a crate.
* Depend on crates with the same name from different registries.
{==+==}
* 避免在 Rust 源代码中需要 `use foo as bar`。
* 依赖于多个版本的 crate。
* 从不同的注册中心中依赖于具有相同名称的 crate。
{==+==}


{==+==}
To support this Cargo supports a `package` key in the `[dependencies]` section
of which package should be depended on:
{==+==}
为了支持这一点， Cargo 在 `[dependencies]` 部分支持一个 `package` 键，指定应该依赖哪个包：
{==+==}


{==+==}
```toml
[package]
name = "mypackage"
version = "0.0.1"

[dependencies]
foo = "0.1"
bar = { git = "https://github.com/example/project.git", package = "foo" }
baz = { version = "0.1", registry = "custom", package = "foo" }
```
{==+==}

{==+==}


{==+==}
In this example, three crates are now available in your Rust code:
{==+==}
在这个例子中，你的 Rust 代码中现在有三个 crate 可用：
{==+==}


{==+==}
```rust,ignore
extern crate foo; // crates.io
extern crate bar; // git repository
extern crate baz; // registry `custom`
```
{==+==}

{==+==}


{==+==}
All three of these crates have the package name of `foo` in their own
`Cargo.toml`, so we're explicitly using the `package` key to inform Cargo that
we want the `foo` package even though we're calling it something else locally.
The `package` key, if not specified, defaults to the name of the dependency
being requested.
{==+==}
这三个 crate 在它们各自的 `Cargo.toml` 文件中都有 `foo` 作为包名，所以我们使用 `package` 键明确告诉 Cargo 我们希望使用 `foo` 包，即使我们在本地使用不同的名称。
如果没有指定 `package` 键，则默认使用请求的依赖项名称。
{==+==}


{==+==}
Note that if you have an optional dependency like:
{==+==}
请注意，如果你有一个可选依赖项，例如：
{==+==}


{==+==}
```toml
[dependencies]
bar = { version = "0.1", package = 'foo', optional = true }
```
{==+==}

{==+==}


{==+==}
you're depending on the crate `foo` from crates.io, but your crate has a `bar`
feature instead of a `foo` feature. That is, names of features take after the
name of the dependency, not the package name, when renamed.
{==+==}
如果你的 crate 有一个 `bar` 特性而不是 `foo` 特性，那么虽然你从 crates.io 依赖的是 `foo` crate，但仍可以在 Cargo.toml 文件中将其重命名为 `bar`。
也就是说，在重命名时，特性的名称采用依赖的名称，而不是包名称。
{==+==}


{==+==}
Enabling transitive dependencies works similarly, for example we could add the
following to the above manifest:
{==+==}
启用传递依赖的方法类似，例如我们可以将以下内容添加到上述清单中：
{==+==}


{==+==}
```toml
[features]
log-debug = ['bar/log-debug'] # using 'foo/log-debug' would be an error!
```
{==+==}
```toml
[features]
log-debug = ['bar/log-debug'] # 用 'foo/log-debug' 会报错!
```
{==+==}

{==+==}
### Inheriting a dependency from a workspace
{==+==}
### 从工作空间中继承依赖
{==+==}


{==+==}
Dependencies can be inherited from a workspace by specifying the
dependency in the workspace's [`[workspace.dependencies]`][workspace.dependencies] table.
After that, add it to the `[dependencies]` table with `workspace = true`.
{==+==}
可以通过在工作空间的 [`[workspace.dependencies]`][workspace.dependencies] 表中指定依赖继承自工作空间。
然后，在 `[dependencies]` 表中添加 `workspace = true`。
{==+==}


{==+==}
Along with the `workspace` key, dependencies can also include these keys:
- [`optional`][optional]: Note that the`[workspace.dependencies]` table is not allowed to specify `optional`.
- [`features`][features]: These are additive with the features declared in the `[workspace.dependencies]`
{==+==}
除了 `workspace` 字段，还可以加入:
- [`optional`][optional]: 注意 `[workspace.dependencies]` 不允许使用 `optional`。
- [`features`][features]: 这是对于 `[workspace.dependencies]` 中声明的依赖的补充。
{==+==}


{==+==}
Other than `optional` and `features`, inherited dependencies cannot use any other
dependency key (such as `version` or `default-features`).
{==+==}
除了 `optional` 和 `features` 之外，继承的依赖不能使用任何其他的依赖键 (例如 `version` 或 `default-features` )。
{==+==}


{==+==}
Dependencies in the `[dependencies]`, `[dev-dependencies]`, `[build-dependencies]`, and
`[target."...".dependencies]` sections support the ability to reference the
`[workspace.dependencies]` definition of dependencies.
{==+==}
`[dependencies]` 、 `[dev-dependencies]` 、 `[build-dependencies]` 、 `[target."...".dependencies]` 都可以引用 `[workspace.dependencies]` 中定义的依赖。
{==+==}


{==+==}
```toml
[package]
name = "bar"
version = "0.2.0"

[dependencies]
regex = { workspace = true, features = ["unicode"] }

[build-dependencies]
cc.workspace = true

[dev-dependencies]
rand = { workspace = true, optional = true }
```
{==+==}

{==+==}


{==+==}
[crates.io]: https://crates.io/
[dev-dependencies]: #development-dependencies
[workspace.dependencies]: workspaces.md#the-dependencies-table
[optional]: features.md#optional-dependencies
[features]: features.md
{==+==}

{==+==}


{==+==}
<script>
(function() {
    var fragments = {
        "#overriding-dependencies": "overriding-dependencies.html",
        "#testing-a-bugfix": "overriding-dependencies.html#testing-a-bugfix",
        "#working-with-an-unpublished-minor-version": "overriding-dependencies.html#working-with-an-unpublished-minor-version",
        "#overriding-repository-url": "overriding-dependencies.html#overriding-repository-url",
        "#prepublishing-a-breaking-change": "overriding-dependencies.html#prepublishing-a-breaking-change",
        "#overriding-with-local-dependencies": "overriding-dependencies.html#paths-overrides",
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
