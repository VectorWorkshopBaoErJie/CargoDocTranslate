{==+==}
## First Steps with Cargo
{==+==}
## Cargo起步
{==+==}

{==+==}
This section provides a quick sense for the `cargo` command line tool. We
demonstrate its ability to generate a new [***package***][def-package] for us,
its ability to compile the [***crate***][def-crate] within the package, and
its ability to run the resulting program.
{==+==}
本节提供对 `cargo` 命令行工具的快速一览。展示其生成新 [***package***][def-package] 的功能，
其在包内编译 [***crate***][def-crate] 的能力，以及运行所生成程序的功能。
{==+==}


{==+==}
To start a new package with Cargo, use `cargo new`:
{==+==}
使用 `cargo new` 可创建新包。
{==+==}

{==+==}
```console
$ cargo new hello_world
```
{==+==}

{==+==}


{==+==}
Cargo defaults to `--bin` to make a binary program. To make a library, we
would pass `--lib`, instead.
{==+==}
Cargo 默认为 `--bin` 来构建二进制程序，通过 `--lib` 来构建库。
{==+==}


{==+==}
Let’s check out what Cargo has generated for us:
{==+==}
让我们来查看 Cargo 所生成的:
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
This is all we need to get started. First, let’s check out `Cargo.toml`:
{==+==}
这就是创建的全部内容。先来查看一下 `Cargo.toml` :
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
metadata that Cargo needs to compile your package.
{==+==}
它被称为[***manifest***][def-manifest] "配置清单"，它包含Cargo编译包所需的所有元数据。
{==+==}


{==+==}
Here’s what’s in `src/main.rs`:
{==+==}
以下为 `src/main.rs` 的内容:
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
[***binary crate***][def-crate]. Let’s compile it:
{==+==}
Cargo 为我们生成了一个 "hello world" 程序，也就是[***binary crate***][def-crate] "二进制crate"。
编译这个程序:
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
然后运行程序:
{==+==}


{==+==}
```console
$ ./target/debug/hello_world
Hello, world!
```
{==+==}

{==+==}


{==+==}
We can also use `cargo run` to compile and then run it, all in one step:
{==+==}
可以使用 `cargo run` 来编译后运行，一步完成:
{==+==}


{==+==}
```console
$ cargo run
     Fresh hello_world v0.1.0 (file:///path/to/package/hello_world)
   Running `target/hello_world`
Hello, world!
```
{==+==}

{==+==}


{==+==}
### Going further
{==+==}
### 继续了解
{==+==}


{==+==}
For more details on using Cargo, check out the [Cargo Guide](../guide/index.md)
{==+==}
关于Cargo的更多细节，查阅 [Cargo 指南](../guide/index.md)
{==+==}


{==+==}
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
{==+==}

{==+==}
