## 创一个建新的包

使用 `cargo new` 命令创建一个新的 [package][def-package] :

```console
$ cargo new hello_world --bin
```

因为我们创建的是二进制程序，所以我们传递 `--bin` 参数:
如果我们创建的是类库，我们需要传递 `--lib` 。
这也会默认初始化一个 `git` 仓库。如果不需要创建代码仓库，你可以传递 `--vcs none` 。

让我们看看 Cargo 为我们生成的文件:

```console
$ cd hello_world
$ tree .
.
├── Cargo.toml
└── src
    └── main.rs

1个目录, 2个文件
```

让我们看看 `Cargo.toml` 文件:

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]

```

这是 [***manifest***][def-manifest] ，它包含所有Cargo编译所需的元数据。
此文件采用 [TOML] (发音为 /tɑməl/) 格式书写。

这是 `src/main.rs` 的内容:

```rust
fn main() {
    println!("Hello, world!");
}
```

Cargo 生成了一个 "hello world" 程序，也被称为一个 [*binary crate*][def-crate]

```console
$ cargo build
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

然后运行:

```console
$ ./target/debug/hello_world
Hello, world!
```

我们也可以使用 `cargo run` 命令来编译并运行，将编译与运行合成一步
(如果相较上次编译没有进行过改动，不会看到 `Compiling` 信息输出):

```console
$ cargo run
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
     Running `target/debug/hello_world`
Hello, world!
```

你会注意到一个名为 `Cargo.lock` 的新文件出现了。它包含依赖的相关信息。
当下我们并没有任何依赖，所以它现在并没有很多有用的信息。

当你准备好要发布程序，你可以使用 `cargo build --release` 命令来编译你的文件(使用此选项会启用编译优化):

```console
$ cargo build --release
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

`cargo build --release` 命令会将二进制生成物放在 `target/release` 目录，而非 `target/debug` 。

开发过程中，编译会默认在调试模式(debug mode)下进行。
由于编译器没有进行编译优化，编译耗时会缩短，但代码会运行地更慢。
发布模式(release mode)下的编译耗时更长但是代码会运行地更快。

[TOML]: https://toml.io/
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
