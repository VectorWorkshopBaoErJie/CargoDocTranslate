## Cargo.toml 和 Cargo.lock

`Cargo.toml` 和 `Cargo.lock` 具有不同的用途。在谈论之前，这里先概况一下：

* `Cargo.toml` 用于宽泛地描述包的依赖，这个文件是由开发者来写。
* `Cargo.lock` 包含依赖条目的更多额外信息。这个文件是由 Cargo 维护，不应手动编辑。

如果你构建的是一个非末端产品，比如一个其他 rust [packages][def-package] 会依赖的库，那么把 `Cargo.lock` 放进 `.gitignore` 即忽略 Cargo.lock 文件。
如果你构建是一个末端产品，比如像命令行工具或桌面应用，这样的可执行程序，或者是一个系统库 ( crate-type 为 `staticlib` 或 `cdylib` ) ，
那么就应该将 `Cargo.lock` 加入 git。想了解为什么要这样做，
参考 [FAQ中的"为什么binary的版本控制中有 `Cargo.lock` ，library却没有？"](../faq.md#why-do-binaries-have-cargolock-in-version-control-but-not-libraries) 一节。

让我们更进一步。

`Cargo.toml` 是 [**manifest**][def-manifest] "配置清单"文件，其中包含了一系列该包的元数据。比如，可以声明包依赖于另一个包:

```toml
[package]
name = "hello_world"
version = "0.1.0"

[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git" }
```

包依赖简单的 `regex` 库。在这个例子中，我们声明包依赖于一个github上的仓库。
如果没有提供更多信息，Cargo 会假定使用该仓库 `master` 分支的最新 commit "提交"来构建包。

听起来不错？但是这里有一个问题：如果你今天构建了这个包，然后把代码复制一份发给了我，然后我第二天才去构建这个包，这时就可能有坏事发生。
在这期间，`regex` 库可能产生了更多的commit，而这些 commit 内容在你的构建中没有。
因此，构建会得到不同的结果。这一般很糟糕，因为构建总是希望一致可重复。

可以在 `Cargo.toml` 中定义一个 `rev` 字段，这样Cargo就会知道构建包时应该使用哪个具体的修订版本(revision)。

```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git", rev = "9f9f693" }
```

现在我们两个的构建结果又一致了。但是这种方式有个很大的缺点：现在每次想更新库的时候，都必须手动来调整SHA-1字符串。这件事既无聊又容易出错。

于是 `Cargo.lock` 应运而生。因为它的存在，无需手动跟踪具体的修订版本。当有这样一个配置清单文件，Cargo会帮我们做这件事:

```toml
[package]
name = "hello_world"
version = "0.1.0"

[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git" }
```

在进行第一次构建的时候，Cargo 会获取最新的commit并将信息写入 `Cargo.lock` 文件。 `Cargo.lock` 的内容如下:

```toml
[[package]]
name = "hello_world"
version = "0.1.0"
dependencies = [
 "regex 1.5.0 (git+https://github.com/rust-lang/regex.git#9f9f693768c584971a4d53bc3c586c33ed3a6831)",
]

[[package]]
name = "regex"
version = "1.5.0"
source = "git+https://github.com/rust-lang/regex.git#9f9f693768c584971a4d53bc3c586c33ed3a6831"
```

可以看到这个文件中有更多的信息，包括我们构建中使用的包的具体修订版本。现在当你把包发给其他人时，他们会使用完全相同的SHA，即使没有在 `Cargo.toml` 中标注版本号。

当我们准备切换到库的新版本时，Cargo可以重新计算依赖并帮我们更新。

```console
$ cargo update            # 更新全部依赖
$ cargo update -p regex   # 只更新 "regex"
```

这会将新的版本信息覆写进 `Cargo.lock` 。注意， `cargo update` 的参数实际上是一个 [Package ID Specification](../reference/pkgid-spec.md) "包ID规格"， `regex` 只是简写。

[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
