{==+==}
## Installation
{==+==}
## 安装
{==+==}

{==+==}
### Install Rust and Cargo
{==+==}
### 安装 Rust 和 Cargo
{==+==}

{==+==}
The easiest way to get Cargo is to install the current stable release of [Rust]
by using [rustup]. Installing Rust using `rustup` will also install `cargo`.
{==+==}
获取 Cargo 的最简单方法是使用 [rustup] 安装当前稳定版本的 [Rust]。使用 `rustup` 安装 Rust 也将安装 `cargo` 。
{==+==}

{==+==}
On Linux and macOS systems, this is done as follows:
{==+==}
在 Linux 和 macOS 系统中，可以这样:
{==+==}


{==+==}
```console
curl https://sh.rustup.rs -sSf | sh
```
{==+==}

{==+==}


{==+==}
It will download a script, and start the installation. If everything goes well,
you’ll see this appear:
{==+==}
它将下载一个脚本，并开始安装。如果一切顺利，你将看到以下内容:
{==+==}


{==+==}
```console
Rust is installed now. Great!
```
{==+==}

{==+==}


{==+==}
On Windows, download and run [rustup-init.exe]. It will start the installation
in a console and present the above message on success.
{==+==}
在 Windows 操作系统上，可以下载并运行 [rustup-init.exe] ，它将在控制台中开始安装，并在成功时显示上述消息。
{==+==}

{==+==}
After this, you can use the `rustup` command to also install `beta` or `nightly`
channels for Rust and Cargo.
{==+==}
之后，你可以使用 `rustup` 命令来安装 Rust 和 Cargo 的 `beta` 或 `nightly` 版本。
{==+==}


{==+==}
For other installation options and information, visit the
[install][install-rust] page of the Rust website.
{==+==}
有关其他安装选项和信息，请访问 Rust 网站上的 [安装页面][install-rust] 。
{==+==}


{==+==}
### Build and Install Cargo from Source
{==+==}
### 从源代码构建和安装Cargo
{==+==}


{==+==}
Alternatively, you can [build Cargo from source][compiling-from-source].
{==+==}
做为备选，你可以 [从源代码构建Cargo][compiling-from-source] 。
{==+==}


{==+==}
[rust]: https://www.rust-lang.org/
[rustup]: https://rustup.rs/
[rustup-init.exe]: https://win.rustup.rs/
[install-rust]: https://www.rust-lang.org/tools/install
[compiling-from-source]: https://github.com/rust-lang/cargo#compiling-from-source
{==+==}

{==+==}
