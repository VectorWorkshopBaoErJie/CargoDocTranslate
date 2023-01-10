{==+==}
## Dependencies
{==+==}
## 依赖
{==+==}

{==+==}
[crates.io] is the Rust community's central [*package registry*][def-package-registry]
that serves as a location to discover and download
[packages][def-package]. `cargo` is configured to use it by default to find
requested packages.
{==+==}
[crates.io] 是 Rust 社区的中央 [*package registry*][def-package-registry] 。
它用作搜索和下载 [packages][def-package] 的仓库。 `cargo` 默认使用这个地址来搜索所需的包。
{==+==}

{==+==}
To depend on a library hosted on [crates.io], add it to your `Cargo.toml`.
{==+==}
要添加 [crates.io] 上托管的依赖库，将它添加到你的 `Cargo.toml` 。
{==+==}

{==+==}
[crates.io]: https://crates.io/
{==+==}

{==+==}

{==+==}
### Adding a dependency
{==+==}
### 添加依赖
{==+==}

{==+==}
If your `Cargo.toml` doesn't already have a `[dependencies]` section, add
that, then list the [crate][def-crate] name and version that you would like to
use. This example adds a dependency of the `time` crate:
{==+==}
如果你的 `Cargo.toml` 还没有 `[dependencies]` 部分，添加上这个标记，
然后在标记下方列出你需要使用的 [crate][def-crate] 的名称和版本。
下面这个例子展示了如何添加 `time` 依赖:
{==+==}

{==+==}
```toml
[dependencies]
time = "0.1.12"
```
{==+==}

{==+==}


{==+==}
The version string is a [SemVer] version requirement. The [specifying
dependencies](../reference/specifying-dependencies.md) docs have more information about
the options you have here.
{==+==}
版本字符串要求使用 [SemVer]。[specifying dependencies](../reference/specifying-dependencies.md) 部分对此有更多信息。
{==+==}

{==+==}
[SemVer]: https://semver.org
{==+==}

{==+==}

{==+==}
If we also wanted to add a dependency on the `regex` crate, we would not need
to add `[dependencies]` for each crate listed. Here's what your whole
`Cargo.toml` file would look like with dependencies on the `time` and `regex`
crates:
{==+==}
如果我们想添加一个 `regex` 依赖，我们不需要为每个依赖都添加 `[dependencies]` 。
下面是添加了 `time` 和 `regex` 依赖的 `Cargo.toml` 文件应该有的样子:
{==+==}

{==+==}
```toml
[package]
name = "hello_world"
version = "0.1.0"
edition = "2021"

[dependencies]
time = "0.1.12"
regex = "0.1.41"
```
{==+==}

{==+==}

{==+==}
Re-run `cargo build`, and Cargo will fetch the new dependencies and all of
their dependencies, compile them all, and update the `Cargo.lock`:
{==+==}
重新执行 `cargo build` 命令，Cargo 会下载新的依赖以及它们本身所需的依赖，
将它们全部编译，并更新 `Cargo.lock` 文件:
{==+==}

{==+==}
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
{==+==}

{==+==}

{==+==}
Our `Cargo.lock` contains the exact information about which revision of all of
these dependencies we used.
{==+==}
`Cargo.lock` 文件包含着所有依赖的准确版本信息
{==+==}

{==+==}
Now, if `regex` gets updated, we will still build with the same revision until
we choose to `cargo update`.
{==+==}
如果 `regex` 依赖升级了，我们依然会使用当前的版本进行构建，除非我们手动执行 `cargo update` 命令。
{==+==}

{==+==}
You can now use the `regex` library in `main.rs`.
{==+==}
现在可以在 `main.rs` 中使用 `regex` 库了。
{==+==}

{==+==}
```rust,ignore
use regex::Regex;

fn main() {
    let re = Regex::new(r"^\d{4}-\d{2}-\d{2}$").unwrap();
    println!("Did our date match? {}", re.is_match("2014-01-01"));
}
```
{==+==}

{==+==}

{==+==}
Running it will show:
{==+==}
运行它会输出:
{==+==}

{==+==}
```console
$ cargo run
   Running `target/hello_world`
Did our date match? true
```
{==+==}

{==+==}

{==+==}
[def-crate]:             ../appendix/glossary.md#crate             '"crate" (glossary entry)'
[def-package]:           ../appendix/glossary.md#package           '"package" (glossary entry)'
[def-package-registry]:  ../appendix/glossary.md#package-registry  '"package-registry" (glossary entry)'
{==+==}

{==+==}
