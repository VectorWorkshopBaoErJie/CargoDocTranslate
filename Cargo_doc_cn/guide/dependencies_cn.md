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
[crates.io] 是 Rust 社区的中央 [*包注册中心*][def-package-registry] ，用于查找和下载 [包][def-package] 。
`cargo` 默认使用从该位置查找所需要的包。
{==+==}

{==+==}
To depend on a library hosted on [crates.io], add it to your `Cargo.toml`.
{==+==}
要依赖托管在 [crates.io] 上的库，需将其添加到 `Cargo.toml` 文件中。
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
如果你的 `Cargo.toml` 文件中没有 `[dependencies]` 部分，可以添加该部分，然后列出你想要使用的 [crate][def-crate] 的名称和版本。
以下示例添加了 `time` crate 作为依赖项：
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
版本字符串是 [SemVer] 形式的要求。参阅 [指定依赖](../reference/specifying-dependencies.md) 文档，有更多可选项的信息。
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
如果要增加对 `regex` crate 的依赖，不需要为每个 crate 列出 `[dependencies]` 。
下面是 `Cargo.toml` 文件添加 `time` 和 `regex` 依赖的范例:
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
重新运行 `cargo build` ， Cargo 将会获取新的依赖及其所有的依赖，然后编译，并更新 `Cargo.lock` :
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
 `Cargo.lock` 文件包含所使用的所有依赖项的准确信息。
这有助于确保用户都使用相同的依赖项版本，从而避免由于不同版本之间的不兼容性而导致问题。
{==+==}


{==+==}
Now, if `regex` gets updated, we will still build with the same revision until
we choose to `cargo update`.
{==+==}
现在，如果 `regex` 更新了，我们仍将使用相同的版本，直到运行 `cargo update` 命令。
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
运行程序会输出:
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
