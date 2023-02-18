{==+==}
## Overriding Dependencies
{==+==}
## 覆盖依赖
{==+==}

{==+==}
The desire to override a dependency can arise through a number of scenarios.
Most of them, however, boil down to the ability to work with a crate before
it's been published to [crates.io]. For example:
{==+==}
覆盖依赖的需求可能源于许多情况。然而，这些需求大多归结为在将一个包发布到 [crates.io] 之前使用一个包的能力。例如：
{==+==}

{==+==}
* A crate you're working on is also used in a much larger application you're
  working on, and you'd like to test a bug fix to the library inside of the
  larger application.
* An upstream crate you don't work on has a new feature or a bug fix on the
  master branch of its git repository which you'd like to test out.
* You're about to publish a new major version of your crate, but you'd like to
  do integration testing across an entire package to ensure the new major
  version works.
* You've submitted a fix to an upstream crate for a bug you found, but you'd
  like to immediately have your application start depending on the fixed
  version of the crate to avoid blocking on the bug fix getting merged.
{==+==}
* 你正在开发的 crate 也被用于一个更大的应用程序中，你想在这个更大的应用程序中测试 crate 的错误修复。
* 你不所属的上游包在其 git 仓库的主分支上有一个新特性或错误修复，你想尝试一下。
* 你即将发布一个新的重大版本，但你想跨整个包进行集成测试，以确保新版本能够正常工作。
* 你已经为发现的一个错误向一个上游包提交了修复，但是你想立即让你的应用程序开始依赖于修复后的包，以避免在等待修复合并的过程中被阻塞。
{==+==}


{==+==}
These scenarios can be solved with the [`[patch]` manifest
section](#the-patch-section).
{==+==}
这些情况可以通过使用 [`[patch]`](#the-patch-section) 配置部分来解决。
{==+==}


{==+==}
This chapter walks through a few different use cases, and includes details
on the different ways to override a dependency.
{==+==}
本章介绍了几种不同的用例，并包括有关覆盖依赖的不同方法的详细信息。
{==+==}


{==+==}
* Example use cases
    * [Testing a bugfix](#testing-a-bugfix)
    * [Working with an unpublished minor version](#working-with-an-unpublished-minor-version)
        * [Overriding repository URL](#overriding-repository-url)
    * [Prepublishing a breaking change](#prepublishing-a-breaking-change)
    * [Using `[patch]` with multiple versions](#using-patch-with-multiple-versions)
* Reference
    * [The `[patch]` section](#the-patch-section)
    * [The `[replace]` section](#the-replace-section)
    * [`paths` overrides](#paths-overrides)
{==+==}
* 用例
    * [测试bug修复](#testing-a-bugfix)
    * [使用未发布的次要版本](#working-with-an-unpublished-minor-version)
        * [覆盖仓库URL](#overriding-repository-url)
    * [预发布破坏性改变](#prepublishing-a-breaking-change)
    * [在多个版本中使用 `[patch]` ](#using-patch-with-multiple-versions)
* 参考
    * [ `[patch]` 部分](#the-patch-section)
    * [ `[replace]` 部分](#the-replace-section)
    * [`paths` 覆盖](#paths-overrides)
{==+==}


{==+==}
> **Note**: See also specifying a dependency with [multiple locations], which
> can be used to override the source for a single dependency declaration in a
> local package.
{==+==}
> **注意**: 另请参见 [指定具有多个位置依赖][multiple locations] ，该功能可用于覆盖本地包中单个依赖项声明的源。
{==+==}


{==+==}
### Testing a bugfix
{==+==}
### 测试bugfix
{==+==}


{==+==}
Let's say you're working with the [`uuid` crate] but while you're working on it
you discover a bug. You are, however, quite enterprising so you decide to also
try to fix the bug! Originally your manifest will look like:
{==+==}
假设你正在使用 [`uuid` crate] ，但是在使用过程中发现了一个 bug 。然后，你想要尝试自己修复这个 bug！原来你的清单文件如下所示：
{==+==}


{==+==}
[`uuid` crate]: https://crates.io/crates/uuid
{==+==}

{==+==}


{==+==}
```toml
[package]
name = "my-library"
version = "0.1.0"

[dependencies]
uuid = "1.0"
```
{==+==}

{==+==}


{==+==}
First thing we'll do is to clone the [`uuid` repository][uuid-repository]
locally via:
{==+==}
首先，我们将通过以下命令在本地克隆 [`uuid` 仓库][uuid-repository]:
{==+==}


{==+==}
```console
$ git clone https://github.com/uuid-rs/uuid.git
```
{==+==}

{==+==}


{==+==}
Next we'll edit the manifest of `my-library` to contain:
{==+==}
接下来我们将编辑 `my-library` 的清单文件，使其包含如下内容：
{==+==}


{==+==}
```toml
[patch.crates-io]
uuid = { path = "../path/to/uuid" }
```
{==+==}

{==+==}


{==+==}
Here we declare that we're *patching* the source `crates-io` with a new
dependency. This will effectively add the local checked out version of `uuid` to
the crates.io registry for our local package.
{==+==}
这里声明我们正在使用新的依赖 *补丁* (*patching*) 源修正 `crates-io` 。
这将在我们的本地包的 crates.io 注册中心中添加生效 uuid 的本地检出版本。
{==+==}


{==+==}
Next up we need to ensure that our lock file is updated to use this new version
of `uuid` so our package uses the locally checked out copy instead of one from
crates.io. The way `[patch]` works is that it'll load the dependency at
`../path/to/uuid` and then whenever crates.io is queried for versions of `uuid`
it'll *also* return the local version.
{==+==}
接下来，我们需要确保更新 lock 文件以使用 `uuid` 的新版本，这样我们的包就会使用本地检出的副本，而不是来自 crates.io 的副本。
 `[patch]` 的工作方式是它将加载 `../path/to/uuid` 处的依赖项，然后每当查询 crates.io `uuid` 的版本时，它将返回本地版本。
{==+==}


{==+==}
This means that the version number of the local checkout is significant and will
affect whether the patch is used. Our manifest declared `uuid = "1.0"` which
means we'll only resolve to `>= 1.0.0, < 2.0.0`, and Cargo's greedy resolution
algorithm also means that we'll resolve to the maximum version within that
range. Typically this doesn't matter as the version of the git repository will
already be greater or match the maximum version published on crates.io, but it's
important to keep this in mind!
{==+==}
这意味着本地副本的版本号很重要，并且将影响是否使用补丁。
我们配置清单声明了 `uuid = "1.0"` ，这意味着我们只解析到 `>= 1.0.0，< 2.0.0` ，并且 Cargo 的贪婪解析算法意味着将解析到该范围内的最大版本。
通常这并不重要，因为 Git 存储库的版本号已经大于或等于 crates.io 上发布的最大版本，但是请记住这一点！
{==+==}

{==+==}
In any case, typically all you need to do now is:
{==+==}
在通常情况下，你现在只需要做的就是：
{==+==}


{==+==}
```console
$ cargo build
   Compiling uuid v1.0.0 (.../uuid)
   Compiling my-library v0.1.0 (.../my-library)
    Finished dev [unoptimized + debuginfo] target(s) in 0.32 secs
```
{==+==}

{==+==}


{==+==}
And that's it! You're now building with the local version of `uuid` (note the
path in parentheses in the build output). If you don't see the local path version getting
built then you may need to run `cargo update -p uuid --precise $version` where
`$version` is the version of the locally checked out copy of `uuid`.
{==+==}
接下来就完成了！现在你正在使用本地版本的 `uuid` 进行构建 (请注意构建输出中的括号中的路径) 。
如果没有看到构建本地路径版本，则可能需要运行 `cargo update -p uuid --precise $version` ，其中 `$version` 是本地已检出的 `uuid` 的版本。
{==+==}


{==+==}
Once you've fixed the bug you originally found the next thing you'll want to do
is to likely submit that as a pull request to the `uuid` crate itself. Once
you've done this then you can also update the `[patch]` section. The listing
inside of `[patch]` is just like the `[dependencies]` section, so once your pull
request is merged you could change your `path` dependency to:
{==+==}
一旦您修复了最初发现的错误，下一步可能是将其作为拉取请求提交给 `uuid` crate。完成后，您还可以更新 `[patch]` 部分。
`[patch]` 部分内的列表就像 `[dependencies]` 部分一样，因此一旦您的拉取请求被合并，您可以将 `path` 依赖项更改为：
{==+==}


{==+==}
```toml
[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```
{==+==}

{==+==}


{==+==}
[uuid-repository]: https://github.com/uuid-rs/uuid
{==+==}

{==+==}


{==+==}
### Working with an unpublished minor version
{==+==}
### 使用未发布的crate次要版本
{==+==}


{==+==}
Let's now shift gears a bit from bug fixes to adding features. While working on
`my-library` you discover that a whole new feature is needed in the `uuid`
crate. You've implemented this feature, tested it locally above with `[patch]`,
and submitted a pull request. Let's go over how you continue to use and test it
before it's actually published.
{==+==}
让我们现在换个角度，从添加特性开始。当您在处理 `my-library` 时，发现需要 `uuid` 中的一个全新的特性。
您已经实现了此特性，并在上面使用 `[patch]` 进行了本地测试，并提交了一个拉取请求。
在实际发布之前，让我们讨论如何继续使用和测试它。
{==+==}


{==+==}
Let's also say that the current version of `uuid` on crates.io is `1.0.0`, but
since then the master branch of the git repository has updated to `1.0.1`. This
branch includes your new feature you submitted previously. To use this
repository we'll edit our `Cargo.toml` to look like
{==+==}
假设当前 `uuid` 在 crates.io 上的版本是 `1.0.0` ，但是自那时以来，git 仓库的主分支已更新到 `1.0.1`。
这个分支包括了你之前提交的新特性。为了使用这个仓库，我们将编辑 `Cargo.toml` ，让其变成这个样子：
{==+==}


{==+==}
```toml
[package]
name = "my-library"
version = "0.1.0"

[dependencies]
uuid = "1.0.1"

[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```
{==+==}

{==+==}


{==+==}
Note that our local dependency on `uuid` has been updated to `1.0.1` as it's
what we'll actually require once the crate is published. This version doesn't
exist on crates.io, though, so we provide it with the `[patch]` section of the
manifest.
{==+==}
请注意，我们本地的 `uuid` 依赖已经更新为 `1.0.1` ，因为这是我们在 crate 发布时实际需要的版本。
但是，该版本并不存在于 crates.io 上，所以我们需要在清单的 `[patch]` 部分提供它。
{==+==}


{==+==}
Now when our library is built it'll fetch `uuid` from the git repository and
resolve to 1.0.1 inside the repository instead of trying to download a version
from crates.io. Once 1.0.1 is published on crates.io the `[patch]` section can
be deleted.
{==+==}
现在当我们的库被构建时，它会从 git 存储库获取 `uuid` 并在存储库内部解析为 `1.0.1` ，而不是尝试从 crates.io 下载版本。
一旦 1.0.1 在 crates.io 上发布，就可以删除 `[patch]` 部分。
{==+==}


{==+==}
It's also worth noting that `[patch]` applies *transitively*. Let's say you use
`my-library` in a larger package, such as:
{==+==}
值得注意的是， `[patch]` 是递归应用的。比如，假设您在一个较大的包中使用了 `my-library`，如下所示：
{==+==}


{==+==}
```toml
[package]
name = "my-binary"
version = "0.1.0"

[dependencies]
my-library = { git = 'https://example.com/git/my-library' }
uuid = "1.0"

[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```
{==+==}

{==+==}


{==+==}
Remember that `[patch]` is applicable *transitively* but can only be defined at
the *top level* so we consumers of `my-library` have to repeat the `[patch]` section
if necessary. Here, though, the new `uuid` crate applies to *both* our dependency on
`uuid` and the `my-library -> uuid` dependency. The `uuid` crate will be resolved to
one version for this entire crate graph, 1.0.1, and it'll be pulled from the git
repository.
{==+==}
请记住， `[patch]` 是递归应用的，但只能在 *顶层* 进行定义，因此作为 `my-library` 的用户我们必须重复写一遍 `[patch]` 部分 (如果需要的话) 。
在这里，新的 `uuid` crate 对于我们对 `uuid` 和 `my-library -> uuid` 依赖都适用。
`uuid` crate 将在整个 crate 图中解析为一个版本，即 1.0.1，并且将从 git 仓库中获取。
{==+==}


{==+==}
#### Overriding repository URL
{==+==}
#### 覆盖git仓库的URL
{==+==}


{==+==}
In case the dependency you want to override isn't loaded from `crates.io`,
you'll have to change a bit how you use `[patch]`. For example, if the
dependency is a git dependency, you can override it to a local path with:
{==+==}
如果你想覆盖的依赖不是从 `crates.io` 载入，那么你需要稍微改变使用 `[patch]` 的方式。
例如，如果依赖是一个 git 依赖，你可以通过以下方式将其覆盖为一个本地路径：
{==+==}


{==+==}
```toml
[patch."https://github.com/your/repository"]
my-library = { path = "../my-library/path" }
```
{==+==}

{==+==}


{==+==}
And that's it!
{==+==}
OK了。
{==+==}


{==+==}
### Prepublishing a breaking change
{==+==}
### 预发布一个破坏性更新
{==+==}


{==+==}
Let's take a look at working with a new major version of a crate, typically
accompanied with breaking changes. Sticking with our previous crates, this
means that we're going to be creating version 2.0.0 of the `uuid` crate. After
we've submitted all changes upstream we can update our manifest for
`my-library` to look like:
{==+==}
让我们看一下如何处理一个 crate 的新的 major 版本，这通常伴随着破坏性更改。
继续使用我们之前的 crates ，这意味着我们将创建 `uuid` crate 的 2.0.0 版本。
在我们将所有更改上游提交之后，我们可以更新 `my-library` 的配置清单，如下所示：
{==+==}


{==+==}
```toml
[dependencies]
uuid = "2.0"

[patch.crates-io]
uuid = { git = "https://github.com/uuid-rs/uuid.git", branch = "2.0.0" }
```
{==+==}

{==+==}


{==+==}
And that's it! Like with the previous example the 2.0.0 version doesn't actually
exist on crates.io but we can still put it in through a git dependency through
the usage of the `[patch]` section. As a thought exercise let's take another
look at the `my-binary` manifest from above again as well:
{==+==}
这就是全部内容了！与之前的示例类似，版本 `2.0.0` 实际上并不存在于 crates.io 上，但我们仍然可以通过 git 依赖项将其放入 `[patch]` 部分。
作为一个思考练习，让我们再次查看上面的 `my-binary` 的配置清单：
{==+==}


{==+==}
```toml
[package]
name = "my-binary"
version = "0.1.0"

[dependencies]
my-library = { git = 'https://example.com/git/my-library' }
uuid = "1.0"

[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git', branch = '2.0.0' }
```
{==+==}

{==+==}


{==+==}
Note that this will actually resolve to two versions of the `uuid` crate. The
`my-binary` crate will continue to use the 1.x.y series of the `uuid` crate but
the `my-library` crate will use the `2.0.0` version of `uuid`. This will allow you
to gradually roll out breaking changes to a crate through a dependency graph
without being forced to update everything all at once.
{==+==}
请注意，这将实际上解析出 `uuid` crate 的两个版本。`my-binary` crate 将继续使用 `uuid` crate 的 `1.x.y` 系列，但是 `my-library` crate 将使用 `uuid` 的 `2.0.0` 版本。
这将允许您逐步通过依赖图向 crate 中引入破坏性更改，而不必被迫立即更新所有内容。
{==+==}


{==+==}
### Using `[patch]` with multiple versions
{==+==}
### 多版本情况下使用 `[patch]`
{==+==}


{==+==}
You can patch in multiple versions of the same crate with the `package` key
used to rename dependencies. For example let's say that the `serde` crate has
a bugfix that we'd like to use to its `1.*` series but we'd also like to
prototype using a `2.0.0` version of serde we have in our git repository. To
configure this we'd do:
{==+==}
你可以使用 `package` 键重命名依赖项，以在同一 crate 中打补丁多个版本。
例如，假设 `serde` crate 有一个我们想要在其 `1.*` 系列中使用的 bugfix，但我们也想尝试使用我们在 git 存储库中拥有的 `2.0.0` 版本的 `serde` 进行原型设计。
要配置这个，我们会这样做：
{==+==}


{==+==}
```toml
[patch.crates-io]
serde = { git = 'https://github.com/serde-rs/serde.git' }
serde2 = { git = 'https://github.com/example/serde.git', package = 'serde', branch = 'v2' }
```
{==+==}

{==+==}


{==+==}
The first `serde = ...` directive indicates that serde `1.*` should be used
from the git repository (pulling in the bugfix we need) and the second `serde2
= ...` directive indicates that the `serde` package should also be pulled from
the `v2` branch of `https://github.com/example/serde`. We're assuming here
that `Cargo.toml` on that branch mentions version `2.0.0`.
{==+==}
第一个 `serde = ...` 指令表示应该从 git 仓库中使用 serde `1.*` (包含我们需要的 bugfix)，而第二个 `serde2 = ...` 指令表示 `serde` 包也应该从 `https://github.com/example/serde` 的 `v2` 分支中拉取。
我们在此假设该分支的 `Cargo.toml` 文件中声明了版本 `2.0.0`。
{==+==}


{==+==}
Note that when using the `package` key the `serde2` identifier here is actually
ignored. We simply need a unique name which doesn't conflict with other patched
crates.
{==+==}
注意，使用 `package` 键时这里的 `serde2` 标识符实际上是被忽略的。我们只需要一个唯一的名称，不与其他打补丁的 crate 冲突即可。
{==+==}

{==+==}
### The `[patch]` section
{==+==}
### `[patch]` 部分
{==+==}

{==+==}
The `[patch]` section of `Cargo.toml` can be used to override dependencies
with other copies. The syntax is similar to the
[`[dependencies]`][dependencies] section:
{==+==}
`Cargo.toml` 的 `[patch]` 部分可以用于使用其他版本覆盖依赖。语法类似于 [`[dependencies]`][dependencies] 部分：
{==+==}

{==+==}
```toml
[patch.crates-io]
foo = { git = 'https://github.com/example/foo.git' }
bar = { path = 'my/local/bar' }

[dependencies.baz]
git = 'https://github.com/example/baz.git'

[patch.'https://github.com/example/baz']
baz = { git = 'https://github.com/example/patched-baz.git', branch = 'my-branch' }
```
{==+==}

{==+==}


{==+==}
> **Note**: The `[patch]` table can also be specified as a [configuration
> option](config.md), such as in a `.cargo/config.toml` file or a CLI option
> like `--config 'patch.crates-io.rand.path="rand"'`. This can be useful for
> local-only changes that you don't want to commit, or temporarily testing a
> patch.
{==+==}
**注意**: `[patch]` 表还可以指定为配置选项，比如在 `.cargo/config.toml` 文件中或使用 CLI 选项例如 `--config 'patch.crates-io.rand.path="rand"'` 。
这对于仅在本地更改而不想提交，或者临时测试补丁非常有用。
{==+==}


{==+==}
The `[patch]` table is made of dependency-like sub-tables. Each key after
`[patch]` is a URL of the source that is being patched, or the name of a
registry. The name `crates-io` may be used to override the default registry
[crates.io]. The first `[patch]` in the example above demonstrates overriding
[crates.io], and the second `[patch]` demonstrates overriding a git source.
{==+==}
`[patch]` 表是由类似于依赖的子表构成的。在 `[patch]` 之后的每个键都是正在被修补的源的 URL 或注册中心的名称。
名称 `crates-io` 可用于覆盖默认的注册中心 [crates.io]。
上面的例子中第一个 `[patch]` 展示了如何覆盖 [crates.io]，第二个 `[patch]` 展示了如何覆盖 git 源。
{==+==}


{==+==}
Each entry in these tables is a normal dependency specification, the same as
found in the `[dependencies]` section of the manifest. The dependencies listed
in the `[patch]` section are resolved and used to patch the source at the
URL specified. The above manifest snippet patches the `crates-io` source (e.g.
crates.io itself) with the `foo` crate and `bar` crate. It also
patches the `https://github.com/example/baz` source with a `my-branch` that
comes from elsewhere.
{==+==}
`[patch]` 中的每个条目都是一个标准的依赖规格，与清单的 `[dependencies]` 部分中的规格相同。
在 `[patch]` 部分列出的依赖将被解析并用于修补指定 URL 的源代码。
上面的清单片段使用 `foo` crate 和 `bar` crate 修补 `crates-io` 源 (例如 crates.io 本身) 。
它还使用来自其他 git 仓库的 `my-branch` 来修补 `https://github.com/example/baz` 源。
{==+==}


{==+==}
Sources can be patched with versions of crates that do not exist, and they can
also be patched with versions of crates that already exist. If a source is
patched with a crate version that already exists in the source, then the
source's original crate is replaced.
{==+==}
可以使用不存在的 crate 版本来对源进行打补丁，也可以使用已存在的 crate 版本来对源进行打补丁。
如果使用已经存在于源中的 crate 版本对源进行打补丁，则源的原始 crate 将被替换。
{==+==}


{==+==}
Cargo only looks at the patch settings in the `Cargo.toml` manifest at the
root of the workspace. Patch settings defined in dependencies will be
ignored.
{==+==}
Cargo 只会查看工作空间根目录下 `Cargo.toml` 中的补丁设置。在依赖项中定义的补丁设置会被忽略。
{==+==}


{==+==}
### The `[replace]` section
{==+==}
### `[replace]` 部分
{==+==}

{==+==}
> **Note**: `[replace]` is deprecated. You should use the
> [`[patch]`](#the-patch-section) table instead.
{==+==}
> **注意**: `[replace]` 已经废弃，你应该使用 [`[patch]`](#the-patch-section)。
{==+==}

{==+==}
This section of Cargo.toml can be used to override dependencies with other
copies. The syntax is similar to the `[dependencies]` section:
{==+==}
这个 `Cargo.toml` 部分可以被用来使用其他副本覆盖依赖。语法与 `[dependencies]` 部分类似：
{==+==}


{==+==}
```toml
[replace]
"foo:0.1.0" = { git = 'https://github.com/example/foo.git' }
"bar:1.0.2" = { path = 'my/local/bar' }
```
{==+==}

{==+==}


{==+==}
Each key in the `[replace]` table is a [package ID
specification](pkgid-spec.md), which allows arbitrarily choosing a node in the
dependency graph to override (the 3-part version number is required). The
value of each key is the same as the `[dependencies]` syntax for specifying
dependencies, except that you can't specify features. Note that when a crate
is overridden the copy it's overridden with must have both the same name and
version, but it can come from a different source (e.g., git or a local path).
{==+==}
`[replace]` 部分的每个键都是 [包 ID 规格](pkgid-spec.md)，这允许任意选择要覆盖的依赖图中的节点 (需要以三数字格式标明版本号)。
每个键的值与 `[dependencies]` 语法相同，用于指定依赖，但不能指定特性。
请注意，当一个 crate 被覆盖时，它被覆盖的副本必须具有相同的名称和版本，但可以来自不同的源 (例如，git 或本地路径)。
{==+==}


{==+==}
Cargo only looks at the replace settings in the `Cargo.toml` manifest at the
root of the workspace. Replace settings defined in dependencies will be
ignored.
{==+==}
Cargo 仅读取工作空间中顶层 `Cargo.toml` 中的 `[replace]` 设置，会忽略依赖中的设置。
{==+==}


{==+==}
### `paths` overrides
{==+==}
### `paths` 覆盖
{==+==}


{==+==}
Sometimes you're only temporarily working on a crate and you don't want to have
to modify `Cargo.toml` like with the `[patch]` section above. For this use
case Cargo offers a much more limited version of overrides called **path
overrides**.
{==+==}
有时候你只是暂时地在一个 crate 上工作，而不想像上面的 `[patch]` 那样修改 `Cargo.toml` 。
为了解决这个问题，Cargo 提供了一种更加有限的覆盖方式，称为  **路径覆盖** (**path overrides**) 。
{==+==}


{==+==}
Path overrides are specified through [`.cargo/config.toml`](config.md) instead of
`Cargo.toml`. Inside of `.cargo/config.toml` you'll specify a key called `paths`:
{==+==}
路径覆盖是通过 `.cargo/config.toml` 而不是 `Cargo.toml` 指定。在 `.cargo/config.toml` 中，您需要指定一个名为 `paths` 的键。
{==+==}

{==+==}
```toml
paths = ["/path/to/uuid"]
```
{==+==}

{==+==}


{==+==}
This array should be filled with directories that contain a `Cargo.toml`. In
this instance, we’re just adding `uuid`, so it will be the only one that’s
overridden. This path can be either absolute or relative to the directory that
contains the `.cargo` folder.
{==+==}
这个数组需要填写包含 `Cargo.toml` 的目录。在这个例子中，我们只添加 `uuid` ，因此它将是唯一被覆盖的 crate。
这个路径可以是绝对路径，也可以是相对于包含 `.cargo` 文件夹的目录的相对路径。
{==+==}


{==+==}
Path overrides are more restricted than the `[patch]` section, however, in
that they cannot change the structure of the dependency graph. When a
path replacement is used then the previous set of dependencies
must all match exactly to the new `Cargo.toml` specification. For example this
means that path overrides cannot be used to test out adding a dependency to a
crate, instead `[patch]` must be used in that situation. As a result usage of a
path override is typically isolated to quick bug fixes rather than larger
changes.
{==+==}
路径覆盖相较于 `[patch]` 部分的使用范围更加有限，因为它不能改变依赖图的结构。
当使用路径替换时，先前的依赖集合必须完全匹配新的 `Cargo.toml` 配置清单。
例如，这意味着路径覆盖不能用于测试向 crate 添加一个依赖，而必须使用 `[patch]` 。
因此，路径覆盖的使用通常仅限于快速修复错误，而不是进行较大的更改。
{==+==}

{==+==}
Note: using a local configuration to override paths will only work for crates
that have been published to [crates.io]. You cannot use this feature to tell
Cargo how to find local unpublished crates.
{==+==}
注意：使用本地配置覆盖路径仅适用于已发布到 [crates.io] 的 crate。
您不能使用此功能来告诉 Cargo 如何查找本地未发布的 crate。
{==+==}


{==+==}
[crates.io]: https://crates.io/
[multiple locations]: specifying-dependencies.md#multiple-locations
[dependencies]: specifying-dependencies.md
{==+==}

{==+==}
