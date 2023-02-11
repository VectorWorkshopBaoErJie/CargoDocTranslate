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
获得 Cargo 最简单的方法是通过 [rustup] 来安装 [Rust] 当前的稳定版本，同时也会安装 `cargo` 。
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
它将下载一个脚本，并开始安装。如果安装顺利会有这样的提示:
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
在 Windows 操作系统中，下载并运行 [rustup-init.exe] ，在控制台进行安装，成功时会显示上述消息。
{==+==}

{==+==}
After this, you can use the `rustup` command to also install `beta` or `nightly`
channels for Rust and Cargo.
{==+==}
然后，就可以使用 `rustup` 命令来安装 Rust 和 Cargo ，也可以安装 `beta` "测试" 或 `nightly` "每日" 版本。
{==+==}


{==+==}
For other installation options and information, visit the
[install][install-rust] page of the Rust website.
{==+==}
关于其他安装选项和信息，请访问 Rust 网站的 [install][install-rust] 页面了解。
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
