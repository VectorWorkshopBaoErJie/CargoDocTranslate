## 覆盖依赖

在很多场景下可能会希望覆盖一个依赖。但大部分情况都可以归结为想在一个包发布到 [crates.io] 之前使用它。例如: 

* 你正在写的一个crate同时也被另一个更大的应用(app)使用着，而且你希望在这个app中测试对该crate的一个bug fix。
* 一个不属于你的上游crate在其git仓库的master分支增加了一些新特性，或修复了一些bug，你想要测试一下。
* 你准备给自己的crate发布一个新的主版本(major version)，但是你想先在整个包上做一下集成测试来确保正确。
* 你已经给一个上游crate提交了bug fix，但是现在想立刻让你的app使用这个修复后的crate，避免在等待这个bug fix 被 merge 期间浪费时间。

这些问题都可以通过清单中的 [`[patch]` ](#the-patch-section) 部分来解决。

本章将从几种不同使用案例出发，详细介绍各种覆盖依赖的方法。

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

> **注意**: 也可以参考使用多依赖位置([multiple locations])来指定一个依赖，这个方法可以在本地覆盖一个依赖的源地址。

### 测试一个bugfix

比方说你正在使用 [`uuid` crate] 但是用着用着却在里面发现了一个bug。然而，你是一个有雄心的人，因此打算自己修复这个bug！刚开始的时候，你的清单文件长这样:

[`uuid` crate]: https://crates.io/crates/uuid

```toml
[package]
name = "my-library"
version = "0.1.0"

[dependencies]
uuid = "1.0"
```

我们首先要做的是吧 [`uuid` 仓库][uuid-repository] clone下来:

```console
$ git clone https://github.com/uuid-rs/uuid.git
```

然后我们修改自己的 `my-library` 包的清单文件来包含clone下来的uuid:

```toml
[patch.crates-io]
uuid = { path = "../path/to/uuid" }
```

这里我们声明我们在用一个新的依赖*覆盖*(*patching*) `crates-io` 源。这会将我们刚下载到本地的 `uuid` 添加到 crates.io 中(仅仅针对我们这个本地项目)。

接着我们我们需要保证 lock file 被更新，以保证我们使用的是下载下来的本地版 `uuid`，而不是 crates.io 上的。`[patch]` 的原理是加载位于 `../path/to/uuid` 的依赖，当需要从 crates.io 中获取 `uuid` 的某个版本时，本地的版本*也*会被返回。

这意味着本地版本的版本号是很重要的，这会影响到本地版本是否实际被选用。我们清单文件中声明 `uuid = "1.0"` ，表示我们请求 `>= 1.0.0, < 2.0.0` 的包，Cargo的贪婪策略意味着我们得到的会是这个范围内的最高版本(译者补充：也就是说，如果本地版本低于crates.io上的版本，那么会是crates.io上的版本被选中)。一般来说这一点不太需要关心，因为 git 仓库里的版本总是高于或者等于 crates.io 里的最高版本，但是原理要明白！

你现在需要做的是:

```console
$ cargo build
   Compiling uuid v1.0.0 (.../uuid)
   Compiling my-library v0.1.0 (.../my-library)
    Finished dev [unoptimized + debuginfo] target(s) in 0.32 secs
```

搞定了。现在构建使用的就是本地版本的 `uuid` (看括号内的文件路径)。如果你看见构建的不是本地版本，那你可能需要运行 `cargo update -p uuid --precise $version`，这里的 `$version` 是本地版本 `uuid` 的版本号。

当你解决了之前发现的bug，接下来要做的事可能是将其通过 pull request 提交给 `uuid` 仓库。当你做完这些后，可以更新 `[patch]` 部分。`[patch]` 中条目的功能和 `[dependencies]` 一样，当你的 pull request 被合并后，你可以把 `path` 依赖改为 `git` 依赖:

```toml
[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```

[uuid-repository]: https://github.com/uuid-rs/uuid

### 使用未发布的次版本crate

现在让我们从修复bug转到添加featrue。在写 `my-library` 时你发现需要在 `uuid` 里加一个新feature。你已经实现了这个feature并在本地通过 `[patch]` 进行了测试，然后提交了 pull request。现在我们看看怎么在这个crate实际发布前继续测试和使用它。

假设 `uuid` 目前在crates.io上的最新版为 `1.0.0`，但 git 仓库上的最新版是 `1.0.1`，也就是你之前提交的新 feature。为了使用这个版本，我们把 `Cargo.toml` 改成了这样:

```toml
[package]
name = "my-library"
version = "0.1.0"

[dependencies]
uuid = "1.0.1"

[patch.crates-io]
uuid = { git = 'https://github.com/uuid-rs/uuid.git' }
```

我们的 `uuid` 本地版本是 `1.0.1`，这也是当这个crate被发布后我们所需的版本。目前这个版本还不存在于 crates.io，所以我们需要使用 `[patch]` 来声明。

现在，当我们构建我们的库时，Cargo 会从git仓库fetch这个 `uuid` ，解析版本为 `1.0.1`，而不是尝试从 crates.io 下载。而当 `1.0.1` 在crates.io发布后，这个 `[patch]` 就可以删除了。

值得一提的是 `[patch]` 支持传递依赖。比如我们在另一个更大的包中使用了之前的 `my-library`:

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

注意，`[patch]` 是传递的，但是只能在*顶层*定义，所以作为 `my-library` 的用户我们必要时需要重复写一遍 `[patch]` 。在本例中，新的 `uuid` crate 同时作用于 `uuid` 和 `my-library -> uuid` 这两个依赖。整个依赖图中，`uuid` 只使用了我们从git仓库拉下来的 `1.0.1` 这个版本。

#### 覆盖git仓库的URL

如果你想要覆盖的依赖不在crates.io上，那么就需要改变使用 `[patch]` 的方法。比如说一个位于git仓库的依赖，你需要这样覆盖为本地路径:

```toml
[patch."https://github.com/your/repository"]
my-library = { path = "../my-library/path" }
```

OK了。

### 预发布一个破坏性更新

更新主版本一般来说会有破坏性的更新(breaking change)。拿之前的crate来举例，这意味着我们会创建 `uuid` 的2.0.0版。把所有改动提交给上游后，更新 `my-library` 的清单文件为:

```toml
[dependencies]
uuid = "2.0"

[patch.crates-io]
uuid = { git = "https://github.com/uuid-rs/uuid.git", branch = "2.0.0" }
```

很好。就像之前的例子一样，因为crates.io中实际上没有2.0.0版，我们实际上通过 `[patch]` 使用了git仓库中的版本。为了详尽地练习一下，我们再看看 `my-binary` 的清单文件:

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

注意，这里会解析出两个版本的 `uuid`。 `my-binary` 会继续使用 `1.x.y` 版的 `uuid`，而 `my-library` 会使用 `2.0.0` 版。这种解析逻辑允许你在依赖图中逐步应用某个crate的破坏性更新，而不是强制把这个破坏性更新一次性应用到整个依赖图。

### 多版本的情况下使用 `[patch]`

你可以通过 `package` 重命名来对同一个crate有多个patch。比如说我们想使用 `serde` 一个 `1.*` 版的bugfix（还没发布到crates.io），同时也想使用git仓库中 `serde` 的 `2.0.0` 版来构建原型。这时可以设置:

```toml
[patch.crates-io]
serde = { git = 'https://github.com/serde-rs/serde.git' }
serde2 = { git = 'https://github.com/example/serde.git', package = 'serde', branch = 'v2' }
```

第一个 `serde = ...` 命令指示从git仓库中下载 serde  `1.*` 版 (我们需要的bugfix)，第二个 `serde2 = ...` 指示从 `https://github.com/example/serde` 的 `v2` 分支中下载serde的 `2.0.0` 版 (我们假设git仓库中该分支中的 `Cargo.toml` 中声明这个crate的版本是 `2.0.0`)。

注意，当我们在 `serde2` 里面用了 `package` 时，实际上 `serde2` 这个标识符会被忽略。我们只是需要一个和其他patch crate不冲突的名字而已。 (译者注：这里的意思是：`serde` 和 `serde2` 其实都是针对 `serde` 的补丁，一个覆盖 `1.*` 版，另一个覆盖 `2.*` 版，在这里 `serde2` 这个名字没有什么实际用途)

### `[patch]` 部分

`Cargo.toml` 中的 `[patch]` 部分可以用其他版本覆盖某个依赖。语法与 [`[dependencies]`][dependencies] 相似。

```toml
[patch.crates-io]
foo = { git = 'https://github.com/example/foo.git' }
bar = { path = 'my/local/bar' }

[dependencies.baz]
git = 'https://github.com/example/baz.git'

[patch.'https://github.com/example/baz']
baz = { git = 'https://github.com/example/patched-baz.git', branch = 'my-branch' }
```

**注意**: `[patch]` 也可以被设置为 [configuration option](config.md) ，比如 `.cargo/config.toml` 文件或者命令行选项，如 `--config 'patch.crates-io.rand.path="rand"'`。这对于你不打算 commit 的本地修改，或是临时测试某个patch 很方便。(译者注：因为这样就不用写到Cargo.toml里面了，所有patch设置都在本地，不会被上传到git)。

`[patch]` 表和 `dependencies` 表很类似。`[patch]` 的key是一个源的URL，或者是注册机构的名字。 `crates-io`  用于覆盖默认的注册机构 [crates.io]。上面的例子里第一个 `[patch]` 用于展示对 [crates.io] 的覆盖，第二个 `[patch]` 展示对一个git源的覆盖。


`[patch]` 表中的条目就是普通的依赖项，与`[dependencies]` 里的一样。这些依赖项被用于覆盖 URL 指定的源中的相应crate。上面例子中覆盖了 `crates-io` 源中的 `foo` crate 和 `bar` brate。同时，其也用另一个git仓库中的 `my-branch` 分支覆盖了 `https://github.com/example/baz` 源。

可以对源中某个crate尚不存在的版本进行覆盖，也可以对存在的版本进行覆盖。如果覆盖的是源中crate的已存在版本，则实际上是把这个版本替换掉了。

Cargo 只读取 workspace 中顶层 `Cargo.toml` 中的 `[patch]` 设置，依赖中的patch设置会被忽略。

### `[replace]` 部分

> **注意**: `[replace]` 已经废弃，你应该使用 [`[patch]`](#the-patch-section)。

Cargo.toml的这个部分被用来以其他拷贝来覆盖某个依赖。语法与 `[dependencies]` 相似。

```toml
[replace]
"foo:0.1.0" = { git = 'https://github.com/example/foo.git' }
"bar:1.0.2" = { path = 'my/local/bar' }
```

`[replace]` 表中的每个key都是一个 [package ID specification](pkgid-spec.md)，其可以覆盖依赖图中的任意一个节点 (需要以三数字格式标明版本号)。每个key对应的value与 `[dependencies]` 中依赖格式相同 (除了不能使用 feature 字段以外)。用于覆盖的crate必须与被覆盖的crate版本相同，但是可以来自不同的源 (比如git或本地路径)。

Cargo 仅读取 workspace 中顶层 `Cargo.toml` 中的 `[replace]` 设置，依赖中的设置会被忽略。

### `paths` 覆盖

有时你仅仅想临时使用一个crate，而不想修改 `Cargo.toml` (比如`[patch]` 字段)，为此 Cargo 提供了一个更简单但功能有限的 **路径覆盖**(**path overrides**) 功能。

路径覆盖可以通过 [`.cargo/config.toml`](config.md) 而不是 `Cargo.toml` 来指定。在 `.cargo/config.toml` 中，你可以指定一个名为 `paths` 的key:

```toml
paths = ["/path/to/uuid"]
```

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


路径覆盖比 `[patch]` 更严格，其无法改变依赖图的结构。替换路径后，之前所有的依赖必须满足新 `Cargo.toml` 的要求。这意味着路径覆盖无法在测试时给某个crate添加依赖，这种情况只能使用 `[patch]` 。因此，路径覆盖一般只用于孤立地修改某个crate，以快速修复其中的bug，而不应用于更大规模的修改。

注意：用本地设置来进行路径覆盖，仅能用于那些已经发布在 [crates.io] 上的包。你无法把这个功能用于让Cargo查找本地的未发布crate。


[crates.io]: https://crates.io/
[multiple locations]: specifying-dependencies.md#multiple-locations
[dependencies]: specifying-dependencies.md
