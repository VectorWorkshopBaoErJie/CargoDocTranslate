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
在很多场景下可能会希望覆盖一个依赖。但大部分情况都可以归结为想在一个包发布到 [crates.io] 之前使用它。例如: 
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
* 你正在写的一个crate同时也被另一个更大的应用(app)使用着，而且你希望在这个app中测试对该crate的一个bug fix。
* 一个不属于你的上游crate在其git仓库的master分支增加了一些新特性，或修复了一些bug，你想要测试一下。
* 你准备给自己的crate发布一个新的主版本(major version)，但是你想先在整个包上做一下集成测试来确保正确。
* 你已经给一个上游crate提交了bug fix，但是现在想立刻让你的app使用这个修复后的crate，避免在等待这个bug fix 被 merge 期间浪费时间。
{==+==}

{==+==}
These scenarios can be solved with the [`[patch]` manifest
section](#the-patch-section).
{==+==}
这些问题都可以通过清单中的 [`[patch]` ](#the-patch-section) 部分来解决。
{==+==}

{==+==}
This chapter walks through a few different use cases, and includes details
on the different ways to override a dependency.
{==+==}
本章将从几种不同使用案例出发，详细介绍各种覆盖依赖的方法。
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
{==+==}

{==+==}
> **Note**: See also specifying a dependency with [multiple locations], which
> can be used to override the source for a single dependency declaration in a
> local package.
{==+==}
> **注意**: 也可以参考使用多依赖位置([multiple locations])来指定一个依赖，这个方法可以在本地覆盖一个依赖的源地址。
{==+==}

{==+==}
### Testing  bugfix
{==+==}
### 测试一个bugfix
{==+==}

{==+==}
Let's say you're working with the [`uuid` crate] but while you're working on it
you discover a bug. You are, however, quite enterprising so you decide to also
try to fix the bug! Originally your manifest will look like:
{==+==}
比方说你正在使用 [`uuid` crate] 但是用着用着却在里面发现了一个bug。然而，你是一个有雄心的人，因此打算自己修复这个bug！刚开始的时候，你的清单文件长这样:
{==+==}

{==+==}
[`uuid` crate]: https://crates.io/crates/uuid
{==+==}
[`uuid` crate]: https://crates.io/crates/uuid
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
```toml
[package]
name = "my-library"
version = "0.1.0"

[dependencies]
uuid = "1.0"
```
{==+==}

{==+==}
First thing we'll do is to clone the [`uuid` repository][uuid-repository]
locally via:
{==+==}
我们首先要做的是吧 [`uuid` 仓库][uuid-repository] clone下来:
{==+==}

{==+==}
```console
$ git clone https://github.com/uuid-rs/uuid.git
```
{==+==}
```console
$ git clone https://github.com/uuid-rs/uuid.git
```
{==+==}

{==+==}
Next we'll edit the manifest of `my-library` to contain:
{==+==}
然后我们修改自己的 `my-library` 包的清单文件来包含clone下来的uuid:
{==+==}

{==+==}
```toml
[patch.crates-io]
uuid = { path = "../path/to/uuid" }
```
{==+==}
```toml
[patch.crates-io]
uuid = { path = "../path/to/uuid" }
```
{==+==}

{==+==}
Here we declare that we're *patching* the source `crates-io` with a new
dependency. This will effectively add the local checked out version of `uuid` to
the crates.io registry for our local package.
{==+==}
这里我们声明我们在用一个新的依赖*覆盖*(*patching*) `crates-io` 源。这会将我们刚下载到本地的 `uuid` 添加到 crates.io 中(仅仅针对我们这个本地项目)。
{==+==}

{==+==}
Next up we need to ensure that our lock file is updated to use this new version
of `uuid` so our package uses the locally checked out copy instead of one from
crates.io. The way `[patch]` works is that it'll load the dependency at
`../path/to/uuid` and then whenever crates.io is queried for versions of `uuid`
it'll *also* return the local version.
{==+==}
接着我们我们需要保证 lock file 被更新，以保证我们使用的是下载下来的本地版 `uuid`，而不是 crates.io 上的。`[patch]` 的原理是加载位于 `../path/to/uuid` 的依赖，当需要从 crates.io 中获取 `uuid` 的某个版本时，本地的版本*也*会被返回。
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
这意味着本地版本的版本号是很重要的，这会影响到本地版本是否实际被选用。我们清单文件中声明 `uuid = "1.0"` ，表示我们请求 `>= 1.0.0, < 2.0.0` 的包，Cargo的贪婪策略意味着我们得到的会是这个范围内的最高版本(译者补充：也就是说，如果本地版本低于crates.io上的版本，那么会是crates.io上的版本被选中)。一般来说这一点不太需要关心，因为 git 仓库里的版本总是高于或者等于 crates.io 里的最高版本，但是原理要明白！
{==+==}

{==+==}
In any case, typically all you need to do now is:
{==+==}
你现在需要做的是:
{==+==}

{==+==}
```console
$ cargo build
   Compiling uuid v1.0.0 (.../uuid)
   Compiling my-library v0.1.0 (.../my-library)
    Finished dev [unoptimized + debuginfo] target(s) in 0.32 secs
```
{==+==}
```console
$ cargo build
   Compiling uuid v1.0.0 (.../uuid)
   Compiling my-library v0.1.0 (.../my-library)
    Finished dev [unoptimized + debuginfo] target(s) in 0.32 secs
```
{==+==}

{==+==}
And that's it! You're now building with the local version of `uuid` (note the
path in parentheses in the build output). If you don't see the local path version getting
built then you may need to run `cargo update -p uuid --precise $version` where
`$version` is the version of the locally checked out copy of `uuid`.
{==+==}
搞定了。现在构建使用的就是本地版本的 `uuid` (看括号内的文件路径)。如果你看见构建的不是本地版本，那你可能需要运行 `cargo update -p uuid --precise $version`，这里的 `$version` 是本地版本 `uuid` 的版本号。
{==+==}

{==+==}
Once you've fixed the bug you originally found the next thing you'll want to do
is to likely submit that as a pull request to the `uuid` crate itself. Once
you've done this then you can also update the `[patch]` section. The listing
inside of `[patch]` is just like the `[dependencies]` section, so once your pull
request is merged you could change your `path` dependency to:
{==+==}
当你解决了之前发现的bug，接下来要做的事可能是将其通过 pull request 提交给 `uuid` 仓库。当你做完这些后，可以更新 `[patch]` 部分。`[patch]` 中条目的功能和 `[dependencies]` 一样，当你的 pull request 被合并后，你可以把 `path` 依赖改为 `git` 依赖:
{==+==}

{==+==}
```toml
[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```
{==+==}
```toml
[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```
{==+==}

{==+==}
[uuid-repository]: https://github.com/uuid-rs/uuid
{==+==}
[uuid-repository]: https://github.com/uuid-rs/uuid
{==+==}

{==+==}
### Working with an unpublished minor version
{==+==}
### 使用未发布的次版本crate
{==+==}

{==+==}
Let's now shift gears a bit from bug fixes to adding features. While working on
`my-library` you discover that a whole new feature is needed in the `uuid`
crate. You've implemented this feature, tested it locally above with `[patch]`,
and submitted a pull request. Let's go over how you continue to use and test it
before it's actually published.
{==+==}
现在让我们从修复bug转到添加featrue。在写 `my-library` 时你发现需要在 `uuid` 里加一个新feature。你已经实现了这个feature并在本地通过 `[patch]` 进行了测试，然后提交了 pull request。现在我们看看怎么在这个crate实际发布前继续测试和使用它。
{==+==}

{==+==}
Let's also say that the current version of `uuid` on crates.io is `1.0.0`, but
since then the master branch of the git repository has updated to `1.0.1`. This
branch includes your new feature you submitted previously. To use this
repository we'll edit our `Cargo.toml` to look like
{==+==}
假设 `uuid` 目前在crates.io上的最新版为 `1.0.0`，但 git 仓库上的最新版是 `1.0.1`，也就是你之前提交的新 feature。为了使用这个版本，我们把 `Cargo.toml` 改成了这样:
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
我们的 `uuid` 本地版本是 `1.0.1`，这也是当这个crate被发布后我们所需的版本。目前这个版本还不存在于 crates.io，所以我们需要使用 `[patch]` 来声明。
{==+==}

{==+==}
Now when our library is built it'll fetch `uuid` from the git repository and
resolve to 1.0.1 inside the repository instead of trying to download a version
from crates.io. Once 1.0.1 is published on crates.io the `[patch]` section can
be deleted.
{==+==}
现在，当我们构建我们的库时，Cargo 会从git仓库fetch这个 `uuid` ，解析版本为 `1.0.1`，而不是尝试从 crates.io 下载。而当 `1.0.1` 在crates.io发布后，这个 `[patch]` 就可以删除了。
{==+==}

{==+==}
It's also worth noting that `[patch]` applies *transitively*. Let's say you use
`my-library` in a larger package, such as:
{==+==}
值得一提的是 `[patch]` 支持传递依赖。比如我们在另一个更大的包中使用了之前的 `my-library`:
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
注意，`[patch]` 是传递的，但是只能在*顶层*定义，所以作为 `my-library` 的用户我们必要时需要重复写一遍 `[patch]` 。在本例中，新的 `uuid` crate 同时作用于 `uuid` 和 `my-library -> uuid` 这两个依赖。整个依赖图中，`uuid` 只使用了我们从git仓库拉下来的 `1.0.1` 这个版本。
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
如果你想要覆盖的依赖不在crates.io上，那么就需要改变使用 `[patch]` 的方法。比如说一个位于git仓库的依赖，你需要这样覆盖为本地路径:
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
更新主版本一般来说会有破坏性的更新(breaking change)。拿之前的crate来举例，这意味着我们会创建 `uuid` 的2.0.0版。把所有改动提交给上游后，更新 `my-library` 的清单文件为:
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
很好。就像之前的例子一样，因为crates.io中实际上没有2.0.0版，我们实际上通过 `[patch]` 使用了git仓库中的版本。为了详尽地练习一下，我们再看看 `my-binary` 的清单文件:
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
注意，这里会解析出两个版本的 `uuid`。 `my-binary` 会继续使用 `1.x.y` 版的 `uuid`，而 `my-library` 会使用 `2.0.0` 版。这种解析逻辑允许你在依赖图中逐步应用某个crate的破坏性更新，而不是强制把这个破坏性更新一次性应用到整个依赖图。
{==+==}

{==+==}
### Using `[patch]` with multiple versions
{==+==}
### 多版本的情况下使用 `[patch]`
{==+==}

{==+==}
You can patch in multiple versions of the same crate with the `package` key
used to rename dependencies. For example let's say that the `serde` crate has
a bugfix that we'd like to use to its `1.*` series but we'd also like to
prototype using a `2.0.0` version of serde we have in our git repository. To
configure this we'd do:
{==+==}
你可以通过 `package` 重命名来对同一个crate有多个patch。比如说我们想使用 `serde` 一个 `1.*` 版的bugfix（还没发布到crates.io），同时也想使用git仓库中 `serde` 的 `2.0.0` 版来构建原型。这时可以设置:
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
第一个 `serde = ...` 命令指示从git仓库中下载 serde  `1.*` 版 (我们需要的bugfix)，第二个 `serde2 = ...` 指示从 `https://github.com/example/serde` 的 `v2` 分支中下载serde的 `2.0.0` 版 (我们假设git仓库中该分支中的 `Cargo.toml` 中声明这个crate的版本是 `2.0.0`)。
{==+==}

{==+==}
Note that when using the `package` key the `serde2` identifier here is actually
ignored. We simply need a unique name which doesn't conflict with other patched
crates.
{==+==}
注意，当我们在 `serde2` 里面用了 `package` 时，实际上 `serde2` 这个标识符会被忽略。我们只是需要一个和其他patch crate不冲突的名字而已。 (译者注：这里的意思是：`serde` 和 `serde2` 其实都是针对 `serde` 的补丁，一个覆盖 `1.*` 版，另一个覆盖 `2.*` 版，在这里 `serde2` 这个名字没有什么实际用途)
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
`Cargo.toml` 中的 `[patch]` 部分可以用其他版本覆盖某个依赖。语法与 [`[dependencies]`][dependencies] 相似。
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
**注意**: `[patch]` 也可以被设置为 [configuration option](config.md) ，比如 `.cargo/config.toml` 文件或者命令行选项，如 `--config 'patch.crates-io.rand.path="rand"'`。这对于你不打算 commit 的本地修改，或是临时测试某个patch 很方便。(译者注：因为这样就不用写到Cargo.toml里面了，所有patch设置都在本地，不会被上传到git)。
{==+==}

{==+==}
The `[patch]` table is made of dependency-like sub-tables. Each key after
`[patch]` is a URL of the source that is being patched, or the name of a
registry. The name `crates-io` may be used to override the default registry
[crates.io]. The first `[patch]` in the example above demonstrates overriding
[crates.io], and the second `[patch]` demonstrates overriding a git source.
{==+==}
`[patch]` 表和 `dependencies` 表很类似。`[patch]` 的key是一个源的URL，或者是注册机构的名字。 `crates-io`  用于覆盖默认的注册机构 [crates.io]。上面的例子里第一个 `[patch]` 用于展示对 [crates.io] 的覆盖，第二个 `[patch]` 展示对一个git源的覆盖。

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
`[patch]` 表中的条目就是普通的依赖项，与`[dependencies]` 里的一样。这些依赖项被用于覆盖 URL 指定的源中的相应crate。上面例子中覆盖了 `crates-io` 源中的 `foo` crate 和 `bar` brate。同时，其也用另一个git仓库中的 `my-branch` 分支覆盖了 `https://github.com/example/baz` 源。
{==+==}

{==+==}
Sources can be patched with versions of crates that do not exist, and they can
also be patched with versions of crates that already exist. If a source is
patched with a crate version that already exists in the source, then the
source's original crate is replaced.
{==+==}
可以对源中某个crate尚不存在的版本进行覆盖，也可以对存在的版本进行覆盖。如果覆盖的是源中crate的已存在版本，则实际上是把这个版本替换掉了。
{==+==}

{==+==}
Cargo only looks at the patch settings in the `Cargo.toml` manifest at the
root of the workspace. Patch settings defined in dependencies will be
ignored.
{==+==}
Cargo 只读取 workspace 中顶层 `Cargo.toml` 中的 `[patch]` 设置，依赖中的patch设置会被忽略。
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
Cargo.toml的这个部分被用来以其他拷贝来覆盖某个依赖。语法与 `[dependencies]` 相似。
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
`[replace]` 表中的每个key都是一个 [package ID specification](pkgid-spec.md)，其可以覆盖依赖图中的任意一个节点 (需要以三数字格式标明版本号)。每个key对应的value与 `[dependencies]` 中依赖格式相同 (除了不能使用 feature 字段以外)。用于覆盖的crate必须与被覆盖的crate版本相同，但是可以来自不同的源 (比如git或本地路径)。
{==+==}

{==+==}
Cargo only looks at the replace settings in the `Cargo.toml` manifest at the
root of the workspace. Replace settings defined in dependencies will be
ignored.
{==+==}
Cargo 仅读取 workspace 中顶层 `Cargo.toml` 中的 `[replace]` 设置，依赖中的设置会被忽略。
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
有时你仅仅想临时使用一个crate，而不想修改 `Cargo.toml` (比如`[patch]` 字段)，为此 Cargo 提供了一个更简单但功能有限的 **路径覆盖**(**path overrides**) 功能。
{==+==}

{==+==}
Path overrides are specified through [`.cargo/config.toml`](config.md) instead of
`Cargo.toml`. Inside of `.cargo/config.toml` you'll specify a key called `paths`:
{==+==}
路径覆盖可以通过 [`.cargo/config.toml`](config.md) 而不是 `Cargo.toml` 来指定。在 `.cargo/config.toml` 中，你可以指定一个名为 `paths` 的key:
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
这个数组中应该填写一系列包含一个 `Cargo.toml` 文件的路径。在这个例子中，我们只添加了 `uuid` ，所以只有这个ctate被覆盖。这个路径可以是绝对地址，也可以是相对于**包含.cargo文件夹**的那个文件夹的相对路径。

译者注：这里说法比较绕，举个例子

比如你的路径格式为:
```
rust
├── .cargo
│   └── config.toml
├── .rustup
└── overrides
    └── uuid
        └── Cargo.toml
```
那么相应的在 `config.toml` 中应该写:
```toml
paths = ["overrides/uuid"]
```
而且paths字段应写在文件的最上方，不在任何一个 `[xxx]` 的下面，才能生效。

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
路径覆盖比 `[patch]` 更严格，其无法改变依赖图的结构。替换路径后，之前所有的依赖必须满足新 `Cargo.toml` 的要求。这意味着路径覆盖无法在测试时给某个crate添加依赖，这种情况只能使用 `[patch]` 。因此，路径覆盖一般只用于孤立地修改某个crate，以快速修复其中的bug，而不应用于更大规模的修改。
{==+==}

{==+==}
Note: using a local configuration to override paths will only work for crates
that have been published to [crates.io]. You cannot use this feature to tell
Cargo how to find local unpublished crates.
{==+==}
注意：用本地设置来进行路径覆盖，仅能用于那些已经发布在 [crates.io] 上的包。你无法把这个功能用于让Cargo查找本地的未发布crate。
{==+==}


{==+==}
[crates.io]: https://crates.io/
[multiple locations]: specifying-dependencies.md#multiple-locations
[dependencies]: specifying-dependencies.md
{==+==}
{==+==}
