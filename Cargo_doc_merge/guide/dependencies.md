## 依赖

[crates.io] 是 Rust 社区主要的 [*包注册中心*][def-package-registry] 。
是搜索和下载 [packages][def-package] 的仓库。 `cargo` 默认使用这个地址来搜索所需的包。

要添加 [crates.io] 上托管的库，你需要将库添加到 `Cargo.toml` 。

[crates.io]: https://crates.io/

### 添加依赖

如果你的 `Cargo.toml` 还没有 `[dependencies]` 部分，添加上这个标记，
然后在标记下方列出你需要使用的 [crate][def-crate] 的名称和版本。
下面这个例子展示了如何添加 `time` 依赖:

```toml
[dependencies]
time = "0.1.12"
```

描述版本的字符串要求使用 [SemVer] "语义化版本"规范。对此 [specifying dependencies](../reference/specifying-dependencies.md) 部分有更多信息。

[SemVer]: https://semver.org

如果我们想添加一个 `regex` 依赖，则不需要为每个依赖都添加 `[dependencies]` 。
下面是 `Cargo.toml` 文件添加 `time` 和 `regex` 依赖的范例:

```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
time = "0.1.12"
regex = "0.1.41"
```

重新执行 `cargo build` 命令，Cargo 会下载新的依赖以及依赖本身所需的依赖，
全部编译，并更新 `Cargo.lock` 文件:

```console
$ cargo build
      Updating crates.io index
   Downloading memchr v0.1.5
   Downloading libc v0.1.10
   Downloading regex-syntax v0.2.1
   Downloading memchr v0.1.5
   Downloading aho-corasick v0.3.0
   Downloading regex v0.1.41
     Compiling memchr v0.1.5
     Compiling libc v0.1.10
     Compiling regex-syntax v0.2.1
     Compiling memchr v0.1.5
     Compiling aho-corasick v0.3.0
     Compiling regex v0.1.41
     Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
```

`Cargo.lock` 文件包含着所有依赖准确的版本信息。

如果 `regex` 依赖升级了，仍然会使用当前的版本进行构建，除非手动执行 `cargo update` 命令。

现在可以在 `main.rs` 中使用 `regex` 库了。

```rust,ignore
use regex::Regex;

fn main() {
    let re = Regex::new(r"^\d{4}-\d{2}-\d{2}$").unwrap();
    println!("Did our date match? {}", re.is_match("2014-01-01"));
}
```

运行它会输出:

```console
$ cargo run
   Running `target/hello_world`
Did our date match? true
```

[def-crate]:             ../appendix/glossary.md#crate             '"crate" (glossary entry)'
[def-package]:           ../appendix/glossary.md#package           '"package" (glossary entry)'
[def-package-registry]:  ../appendix/glossary.md#package-registry  '"package-registry" (glossary entry)'
