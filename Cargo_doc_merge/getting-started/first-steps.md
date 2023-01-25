## Cargo起步

本节提供对 `cargo` 命令行工具的快速一览。展示其生成新 [***package***][def-package] 的功能，
其在包内编译 [***crate***][def-crate] 的能力，以及运行所生成程序的功能。

使用 `cargo new` 可创建新包。

```console
$ cargo new hello_world
```

Cargo 默认为 `--bin` 来构建二进制程序，通过 `--lib` 来构建库。

让我们来查看 Cargo 所生成的:

```console
$ cd hello_world
$ tree .
.
├── Cargo.toml
└── src
    └── main.rs

1 directory, 2 files
```

这就是创建的全部内容。先来查看一下 `Cargo.toml` :

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
```

它被称为[***manifest***][def-manifest] "配置清单"，它包含Cargo编译包所需的所有元数据。

以下为 `src/main.rs` 的内容:

```rust
fn main() {
    println!("Hello, world!");
}
```

Cargo 为我们生成了一个 "hello world" 程序，也就是[***binary crate***][def-crate] "二进制crate"。
编译这个程序:

```console
$ cargo build
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

然后运行程序:

```console
$ ./target/debug/hello_world
Hello, world!
```

可以使用 `cargo run` 来编译后运行，一步完成:

```console
$ cargo run
     Fresh hello_world v0.1.0 (file:///path/to/package/hello_world)
   Running `target/hello_world`
Hello, world!
```

### 继续了解

关于Cargo的更多细节，查阅 [Cargo 指南](../guide/index.md)

[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-manifest]:  ../appendix/glossary.md#manifest  '"manifest" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
