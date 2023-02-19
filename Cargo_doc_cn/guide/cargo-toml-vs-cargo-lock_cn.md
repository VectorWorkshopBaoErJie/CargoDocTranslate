{==+==}
## Cargo.toml vs Cargo.lock
{==+==}
## Cargo.toml 和 Cargo.lock
{==+==}

{==+==}
`Cargo.toml` and `Cargo.lock` serve two different purposes. Before we talk
about them, here’s a summary:
{==+==}
`Cargo.toml` 和 `Cargo.lock` 具有不同的用途。在谈论它们之前，这里是一个简要总结:
{==+==}

{==+==}
* `Cargo.toml` is about describing your dependencies in a broad sense, and is
  written by you.
* `Cargo.lock` contains exact information about your dependencies. It is
  maintained by Cargo and should not be manually edited.
{==+==}
* `Cargo.toml` 是关于广义依赖的描述，由开发者编写。
* `Cargo.lock` 包含有关依赖项的确切信息。它由 Cargo 维护，不应手动编辑。
{==+==}


{==+==}
If you’re building a non-end product, such as a rust library that other rust
[packages][def-package] will depend on, put `Cargo.lock` in your
`.gitignore`. If you’re building an end product, which are executable like
command-line tool or an application, or a system library with crate-type of
`staticlib` or `cdylib`, check `Cargo.lock` into `git`. If you're curious
about why that is, see
["Why do binaries have `Cargo.lock` in version control, but not libraries?" in the
FAQ](../faq.md#why-do-binaries-have-cargolock-in-version-control-but-not-libraries).
{==+==}
如果您正在构建一个非终端产品 (例如，其他 Rust 包将依赖的 Rust 库) ，请将 `Cargo.lock` 放入 `.gitignore` 文件中。
如果您正在构建一个终端产品 (如命令行工具或应用程序)，或者一个 `staticlib` 或 `cdylib` crate 类型的系统库，则将 `Cargo.lock` 提交到 git 中。
如果您想知道原因，可以参考 [FAQ 中的 "为什么二进制文件在版本控制中有 `Cargo.lock` ，而库没有？"](../faq.md#why-do-binaries-have-cargolock-in-version-control-but-not-libraries)。
{==+==}


{==+==}
Let’s dig in a little bit more.
{==+==}
让我们深入了解一下。
{==+==}


{==+==}
`Cargo.toml` is a [**manifest**][def-manifest] file in which we can specify a
bunch of different metadata about our package. For example, we can say that we
depend on another package:
{==+==}
`Cargo.toml` 是一个 [配置清单][def-manifest] 文件，我们可以在其中指定包的许多不同元数据。例如，我们可以声明依赖于另一个包。
{==+==}


{==+==}
This package has a single dependency, on the `regex` library. We’ve stated in
this case that we’re relying on a particular Git repository that lives on
GitHub. Since we haven’t specified any other information, Cargo assumes that
we intend to use the latest commit on the `master` branch to build our package.
{==+==}
在本节例子中，包依赖单独的 `regex` 库，声明为一个 github 上的仓库。
由于我们没有指定其他信息，Cargo 假定我们打算使用 `master` 分支上的最新提交来构建。
{==+==}


{==+==}
Sound good? Well, there’s one problem: If you build this package today, and
then you send a copy to me, and I build this package tomorrow, something bad
could happen. There could be more commits to `regex` in the meantime, and my
build would include new commits while yours would not. Therefore, we would
get different builds. This would be bad because we want reproducible builds.
{==+==}
似乎不错！但是有一个问题：如果你今天构建这个包，然后你将它发送给我，我明天构建这个包，就会发生一些不好的事情。
在此期间可能会有更多的提交到 `regex` ，而我的构建将包含新提交，而你的构建则不会。
因此，我们会得到不同的构建结果。这很糟糕，因为我们想要可重复构建的结果。
{==+==}


{==+==}
We could fix this problem by defining a specific `rev` value in our `Cargo.toml`,
so Cargo could know exactly which revision to use when building the package:
{==+==}
我们可以通过在 `Cargo.toml` 中定义一个特定的 `rev` 值来解决这个问题，这样 Cargo 就可以知道在构建包时使用哪个精确的修订版本:
{==+==}


{==+==}
```toml
[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git", rev = "9f9f693" }
```
{==+==}

{==+==}


{==+==}
Now our builds will be the same. But there’s a big drawback: now we have to
manually think about SHA-1s every time we want to update our library. This is
both tedious and error prone.
{==+==}
现在我们的构建将是相同的。但是有一个很大的缺点：现在我们每次更新库时都必须手动考虑SHA-1值，这既繁琐又容易出错。
{==+==}


{==+==}
Enter the `Cargo.lock`. Because of its existence, we don’t need to manually
keep track of the exact revisions: Cargo will do it for us. When we have a
manifest like this:
{==+==}
有了 `Cargo.lock`，我们就不需要手动跟踪确切的提交版本，因为 Cargo 会替我们完成。当我们有这样一个清单时:
{==+==}


{==+==}
```toml
[package]
name = "hello_world"
version = "0.1.0"

[dependencies]
regex = { git = "https://github.com/rust-lang/regex.git" }
```
{==+==}

{==+==}


{==+==}
Cargo will take the latest commit and write that information out into our
`Cargo.lock` when we build for the first time. That file will look like this:
{==+==}
当我们第一次构建时， Cargo 会获取最新的提交记录并将其写入 `Cargo.lock` 文件中。该文件看起来会像这样:
{==+==}


{==+==}
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
{==+==}

{==+==}


{==+==}
You can see that there’s a lot more information here, including the exact
revision we used to build. Now when you give your package to someone else,
they’ll use the exact same SHA, even though we didn’t specify it in our
`Cargo.toml`.
{==+==}
你可以看到这里有更多的信息，包括我们用于构建的确切修订版本。现在当你把你的包交给别人时，他们将使用完全相同的SHA值，尽管我们没有在 `Cargo.toml` 中指定它。
{==+==}


{==+==}
When we’re ready to opt in to a new version of the library, Cargo can
re-calculate the dependencies and update things for us:
{==+==}
当我们准备使用新版本的库时， Cargo 可以重新计算依赖关系并为我们自动更新相关内容:
{==+==}


{==+==}
```console
$ cargo update            # updates all dependencies
$ cargo update -p regex   # updates just “regex”
```
{==+==}
```console
$ cargo update            # 更新全部依赖
$ cargo update -p regex   # 只更新 "regex"
```
{==+==}


{==+==}
This will write out a new `Cargo.lock` with the new version information. Note
that the argument to `cargo update` is actually a
[Package ID Specification](../reference/pkgid-spec.md) and `regex` is just a
short specification.
{==+==}
这将写出一个新的 `Cargo.lock` 文件，包含新版本信息。注意，`cargo update` 命令的参数实际上是一个包ID规格，`regex` 只是简写。
{==+==}


{==+==}
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
{==+==}

{==+==}
