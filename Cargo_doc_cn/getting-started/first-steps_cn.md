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
这节提供对 `cargo` 命令行工具的快速一览。
演示如何使用 `cargo` 工具创建一个新的包 [***package***][def-package]，对包中的 [***crate***][def-crate] 进行编译，以及运行生成的程序。
{==+==}


{==+==}
To start a new package with Cargo, use `cargo new`:
{==+==}
可以使用 `cargo new` 创建新包:
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
Cargo 默认使用 `--bin` 选项生成一个二进制程序，要生成一个库，我们可以传递 `--lib` 选项。
{==+==}


{==+==}
Let’s check out what Cargo has generated for us:
{==+==}
让我们看一下 Cargo 为我们生成了什么:
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
这就是我们开始的全部内容。首先，让我们看一下 `Cargo.toml` :
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
这被称为 [***配置清单***][def-manifest] ，包含 Cargo 编译包所需的所有元数据。
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
Cargo 为我们生成了一个 "hello world" 程序，是 [***binary crate***][def-crate] "二进制crate"。
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
关于Cargo的更多细节，查阅 [Cargo 指南](../guide/index.md) 。
{==+==}


{==+==}
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
{==+==}

{==+==}
