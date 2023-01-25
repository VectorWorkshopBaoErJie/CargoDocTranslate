## 创建新包

使用 `cargo new` 命令创建新 [package][def-package] :

```console
$ cargo new hello_world --bin
```

因为我们创建的是二进制程序，所以传递 `--bin` 参数:
如果创建的是类库，需要传递 `--lib` 。
这也会默认初始化 `git` 仓库，如果不需要创建代码仓库，可以传递 `--vcs none` 。

来看看 Cargo 生成的文件:

```console
$ cd hello_world
$ tree .
.
├── Cargo.toml
└── src
    └── main.rs

1 directory, 2 files
```

来看看 `Cargo.toml` 文件:

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]

```

这称为 [***manifest***][def-manifest] ，包含Cargo编译所需的所有元数据。
此文件采用 [TOML] (发音为 /tɑməl/) 格式书写。

这是 `src/main.rs` 的内容:

```rust
fn main() {
    println!("Hello, world!");
}
```

Cargo 生成了一个 "hello world" 程序，也称 [*binary crate*][def-crate]。编译它：

```console
$ cargo build
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

然后运行:

```console
$ ./target/debug/hello_world
Hello, world!
```

也可以使用 `cargo run` 命令来编译并运行，将编译与运行合成一步(如果相较上次编译没有进行过改动，不会看到 `Compiling` 信息输出):

```console
$ cargo run
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
     Running `target/debug/hello_world`
Hello, world!
```

你会注意到一个名为 `Cargo.lock` 的新文件出现了。它包含依赖的相关信息。
目前我们并没有任何依赖，所以它之中并没有多少有用的信息。

当你准备好要发布程序，可以使用 `cargo build --release` 命令来编译文件(此选项开启编译优化):

```console
$ cargo build --release
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

`cargo build --release` 命令会将产生二进制文件放在 `target/release` 目录，而非 `target/debug` 。

开发过程中，编译会默认在调试模式(debug mode)下进行。
由于编译器未进行编译优化，能缩短编译耗时，但代码运行会更慢。
发布模式(release mode)下的编译耗时更长但代码运行更快。

[TOML]: https://toml.io/
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
