{==+==}
## Creating a New Package
{==+==}
## 创建新包
{==+==}

{==+==}
To start a new [package][def-package] with Cargo, use `cargo new`:
{==+==}
可以使用 `cargo new` 命令，创建新 [包][def-package]。
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
在运行 `cargo new` 命令时加入了 `--bin` 参数，将创建可执行二进制程序。
如果要创建库，需传入 `--lib` 参数。
默认情况下，该命令会初始化新的 `git` 仓库。如果不想这样做，可以传入 `--vcs none` 参数。
{==+==}


{==+==}
Let’s check out what Cargo has generated for us:
{==+==}
来看看 Cargo 所生成的内容:
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
来看看 `Cargo.toml` 文件的内容:
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
该文件称为 [***配置清单***][def-manifest] 文件，包含 Cargo 编译需要所有元数据。
这个文件采用 [TOML] (发音为 /tɑməl/) 格式书写。
{==+==}


{==+==}
Here’s what’s in `src/main.rs`:
{==+==}
这是 `src/main.rs` 文件的内容:
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
Cargo 生成了 "hello world" 程序，一个可执行二进制 [*binary crate*][def-crate] 。进行编译:
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
可以使用 `cargo run` 来一步来完成编译和运行 (如果没有更改，就不会有 `Compiling` 信息):：
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
`Cargo.lock` 文件存储了相关依赖的信息，当没有依赖时，就没什么有用的内容。
{==+==}


{==+==}
Once you’re ready for release, you can use `cargo build --release` to compile
your files with optimizations turned on:
{==+==}
使用 `cargo build --release` 命令，会开启优化选项来编译程序，以准备发布:
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
`cargo build --release` 命令会把编译后的二进制文件放在 `target/release` 目录下，而不是 `target/debug` 目录下。
{==+==}


{==+==}
Compiling in debug mode is the default for development. Compilation time is
shorter since the compiler doesn't do optimizations, but the code will run
slower. Release mode takes longer to compile, but the code will run faster.
{==+==}
在开发时，默认是以调试模式编译的。编译时间较短，因为编译器不进行优化，但代码运行速度较慢。
发布时的编译需要更长的时间，但代码运行速度会更快。
{==+==}

{==+==}
[TOML]: https://toml.io/
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
{==+==}

{==+==}
