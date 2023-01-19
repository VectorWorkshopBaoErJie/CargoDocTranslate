{==+==}
## Creating a New Package
{==+==}
## 创建新包
{==+==}

{==+==}
To start a new [package][def-package] with Cargo, use `cargo new`:
{==+==}
使用 `cargo new` 命令创建新 [package][def-package] :
{==+==}

{==+==}
```console
$ cargo new hello_world --bin
```
{==+==}

{==+==}


{==+==}
We’re passing `--bin` because we’re making a binary program: if we
were making a library, we’d pass `--lib`. This also initializes a new `git`
repository by default. If you don't want it to do that, pass `--vcs none`.
{==+==}
因为我们创建的是二进制程序，所以传递 `--bin` 参数:
如果创建的是类库，需要传递 `--lib` 。
这也会默认初始化 `git` 仓库，如果不需要创建代码仓库，可以传递 `--vcs none` 。
{==+==}


{==+==}
Let’s check out what Cargo has generated for us:
{==+==}
来看看 Cargo 生成的文件:
{==+==}


{==+==}
```console
$ cd hello_world
$ tree .
.
├── Cargo.toml
└── src
    └── main.rs

1 directory, 2 files
```
{==+==}

{==+==}


{==+==}
Let’s take a closer look at `Cargo.toml`:
{==+==}
来看看 `Cargo.toml` 文件:
{==+==}


{==+==}
```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]

```
{==+==}

{==+==}


{==+==}
This is called a [***manifest***][def-manifest], and it contains all of the
metadata that Cargo needs to compile your package. This file is written in the
[TOML] format (pronounced /tɑməl/).
{==+==}
这称为 [***manifest***][def-manifest] ，包含Cargo编译所需的所有元数据。
此文件采用 [TOML] (发音为 /tɑməl/) 格式书写。
{==+==}


{==+==}
Here’s what’s in `src/main.rs`:
{==+==}
这是 `src/main.rs` 的内容:
{==+==}


{==+==}
```rust
fn main() {
    println!("Hello, world!");
}
```
{==+==}

{==+==}

{==+==}
Cargo generated a “hello world” program for us, otherwise known as a
[*binary crate*][def-crate]. Let’s compile it:
{==+==}
Cargo 生成了一个 "hello world" 程序，也称 [*binary crate*][def-crate]。编译它：
{==+==}

{==+==}
```console
$ cargo build
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```
{==+==}

{==+==}


{==+==}
And then run it:
{==+==}
然后运行:
{==+==}


{==+==}
```console
$ ./target/debug/hello_world
Hello, world!
```
{==+==}

{==+==}


{==+==}
We can also use `cargo run` to compile and then run it, all in one step (You
won't see the `Compiling` line if you have not made any changes since you last
compiled):
{==+==}
也可以使用 `cargo run` 命令来编译并运行，将编译与运行合成一步(如果相较上次编译没有进行过改动，不会看到 `Compiling` 信息输出):
{==+==}


{==+==}
```console
$ cargo run
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
     Running `target/debug/hello_world`
Hello, world!
```
{==+==}

{==+==}


{==+==}
You’ll now notice a new file, `Cargo.lock`. It contains information about our
dependencies. Since we don’t have any yet, it’s not very interesting.
{==+==}
你会注意到一个名为 `Cargo.lock` 的新文件出现了。它包含依赖的相关信息。
目前我们并没有任何依赖，所以它之中并没有多少有用的信息。
{==+==}


{==+==}
Once you’re ready for release, you can use `cargo build --release` to compile
your files with optimizations turned on:
{==+==}
当你准备好要发布程序，可以使用 `cargo build --release` 命令来编译文件(此选项开启编译优化):
{==+==}


{==+==}
```console
$ cargo build --release
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```
{==+==}

{==+==}


{==+==}
`cargo build --release` puts the resulting binary in `target/release` instead of
`target/debug`.
{==+==}
`cargo build --release` 命令会将产生二进制文件放在 `target/release` 目录，而非 `target/debug` 。
{==+==}


{==+==}
Compiling in debug mode is the default for development. Compilation time is
shorter since the compiler doesn't do optimizations, but the code will run
slower. Release mode takes longer to compile, but the code will run faster.
{==+==}
开发过程中，编译会默认在调试模式(debug mode)下进行。
由于编译器未进行编译优化，能缩短编译耗时，但代码运行会更慢。
发布模式(release mode)下的编译耗时更长但代码运行更快。
{==+==}

{==+==}
[TOML]: https://toml.io/
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
{==+==}

{==+==}
