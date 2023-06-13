{==+==}
## Cargo Home
{==+==}
## Cargo home
{==+==}

{==+==}
The "Cargo home" functions as a download and source cache.
When building a [crate][def-crate], Cargo stores downloaded build dependencies in the Cargo home.
You can alter the location of the Cargo home by setting the `CARGO_HOME` [environmental variable][env].
The [home](https://crates.io/crates/home) crate provides an API for getting this location if you need this information inside your Rust crate.
By default, the Cargo home is located in `$HOME/.cargo/`.
{==+==}
"Cargo home" 目录的功能是为下载项和源代码提供缓存。
 Cargo 在构建 [crate][def-crate] 时，将下载的依赖存储在该目录中。
可以设置 `CARGO_HOME` [环境变量][env] 来更改目录位置。
如果需要在 Rust crate 中获取此信息，可以使用 [home](https://crates.io/crates/home) crate 提供的 API 。默认情况该目录位于 `$HOME/.cargo/` 。
{==+==}


{==+==}
Please note that the internal structure of the Cargo home is not stabilized and may be subject to change at any time.
{==+==}
请注意，该目录的内部结构还未稳定，可能会有所更改。
{==+==}


{==+==}
The Cargo home consists of following components:
{==+==}
由以下几个部分构成:
{==+==}


{==+==}
## Files:
{==+==}
## 文件项:
{==+==}


{==+==}
* `config.toml`
	Cargo's global configuration file, see the [config entry in the reference][config].
{==+==}
* `config.toml`
	Cargo 的全局配置文件，参阅 [参考部分的 config][config] 内容。
{==+==}


{==+==}
* `credentials.toml`
 	Private login credentials from [`cargo login`] in order to log in to a [registry][def-registry].
{==+==}
* `credentials.toml`
 	文件包含使用 [`cargo login`] 登录到 [registry][def-registry] 时使用的私人登录凭据。
{==+==}


{==+==}
* `.crates.toml`, `.crates2.json`
	These hidden files contain [package][def-package] information of crates installed via [`cargo install`]. Do NOT edit by hand!
{==+==}
* `.crates.toml`, `.crates2.json`
	这两个隐藏文件包含了使用 [`cargo install`] 安装的 crate 的信息。请注意，不要手动编辑这些文件！
{==+==}


{==+==}
## Directories:
{==+==}
## 目录项:
{==+==}


{==+==}
* `bin`
The bin directory contains executables of crates that were installed via [`cargo install`] or [`rustup`](https://rust-lang.github.io/rustup/).
To be able to make these binaries accessible, add the path of the directory to your `$PATH` environment variable.
{==+==}
* `bin`
 `bin` 目录包含通过 [`cargo install`] 或 [`rustup`](https://rust-lang.github.io/rustup/) 安装的 crate 的可执行文件。
 要使这些二进制文件可访问，需要将该目录的路径添加到 `$PATH` 环境变量中。
{==+==}


{==+==}
 *  `git`
	Git sources are stored here:
{==+==}
* `git`
	Git 源代码保存在这里:
{==+==}

{==+==}
    * `git/db`
		When a crate depends on a git repository, Cargo clones the repo as a bare repo into this directory and updates it if necessary.
{==+==}
	* `git/db`
		 当 crate 依赖于 Git 仓库时，Cargo 会将该仓库作为裸仓库 (只有 `.git` 文件夹中的内容) 克隆到 `git/db` 目录中，必要时还会更新该仓库。
{==+==}


{==+==}
    * `git/checkouts`
		If a git source is used, the required commit of the repo is checked out from the bare repo inside `git/db` into this directory.
		This provides the compiler with the actual files contained in the repo of the commit specified for that dependency.
		Multiple checkouts of different commits of the same repo are possible.
{==+==}
	* `git/checkouts`
		如果某个 git 源的代码被用到，实际的代码会从 `git/db` 内的仓库检出到 `git/checkouts` 目录中，提供编译器使用该依赖的指定提交所包含的实际文件。同一个仓库的不同提交可以有多个检出。
{==+==}


{==+==}
* `registry`
	Packages and metadata of crate registries (such as [crates.io](https://crates.io/)) are located here.
{==+==}
* `registry`
	此目录存储了 crate 注册中心 (如 [crates.io](https://crates.io/) ) 的包和元数据。
{==+==}


{==+==}
  * `registry/index`
		The index is a bare git repository which contains the metadata (versions, dependencies etc) of all available crates of a registry.
{==+==}
  * `registry/index`
		是裸的 git 仓库，包含了某个仓库中所有可用 crate 的元数据信息，如版本、依赖等。
{==+==}


{==+==}
  *  `registry/cache`
		Downloaded dependencies are stored in the cache. The crates are compressed gzip archives named with a `.crate` extension.
{==+==}
  *  `registry/cache`
		下载的依赖项存储在此缓存目录中。这些 crate 是以 `.crate` 扩展名命名压缩的 gzip 存档
{==+==}


{==+==}
  * `registry/src`
		If a downloaded `.crate` archive is required by a package, it is unpacked into `registry/src` folder where rustc will find the `.rs` files.
{==+==}
  * `registry/src`
		用于存放从 crate 源 (如 crates.io) 下载的源代码的目录。如果依赖的 crate 不存在于本地的 Cargo cache 中，Cargo 就会从注册中心下载它的压缩包，然后将其解压到 `registry/src` 文件夹下。当 Rust 编译器需要引用这些 crate 时，会在该目录下查找相关的 `.rs` 文件。
{==+==}


{==+==}
## Caching the Cargo home in CI
{==+==}
## 在 CI 中缓存 Cargo home
{==+==}


{==+==}
To avoid redownloading all crate dependencies during continuous integration, you can cache the `$CARGO_HOME` directory.
However, caching the entire directory is often inefficient as it will contain downloaded sources twice.
If we depend on a crate such as `serde 1.0.92` and cache the entire `$CARGO_HOME` we would actually cache the sources twice, the `serde-1.0.92.crate` inside `registry/cache` and the extracted `.rs` files of serde inside `registry/src`.
That can unnecessarily slow down the build as downloading, extracting, recompressing and reuploading the cache to the CI servers can take some time.
{==+==}
为避免在持续集成过程中重复下载所有 crate 依赖项，你可以缓存 `$CARGO_HOME` 目录。
但是，缓存整个目录通常效率较低，因为它将包含两个已下载的源文件。
如果我们依赖 `serde 1.0.92` 等包并缓存整个 `$CARGO_HOME` ，实际上会在 `registry/cache` 中缓存 `serde-1.0.92.crate` 和 `registry/src` 中的 serde 提取的 `.rs` 文件两次。
这可能会导致构建速度变慢，因为下载、提取、重新压缩并重新上传缓存到 CI 服务器可能需要一些时间。
{==+==}


{==+==}
It should be sufficient to only cache the following directories across builds:
{==+==}
交叉构建时，缓存以下目录就足够了：
{==+==}


{==+==}
* `bin/`
* `registry/index/`
* `registry/cache/`
* `git/db/`
{==+==}

{==+==}



{==+==}
## Vendoring all dependencies of a project
{==+==}
## 打包缓存项目的所有依赖
{==+==}


{==+==}
See the [`cargo vendor`] subcommand.
{==+==}
见 [`cargo vendor`] 子命令。

译者注："vendor" 这个词在软件领域往往表示 "将源代码和其所依赖的第三方库统一管理" 的意思。
参考来源 [wiktionary-vendor](https://en.wiktionary.org/wiki/vendor) 。
{==+==}



{==+==}
## Clearing the cache
{==+==}
## 清除缓存
{==+==}

{==+==}
In theory, you can always remove any part of the cache and Cargo will do its best to restore sources if a crate needs them either by reextracting an archive or checking out a bare repo or by simply redownloading the sources from the web.
{==+==}
理论上，你可以随时删除缓存中的任何部分，Cargo 会尽其所能恢复源代码，在 crate 需要时，Cargo 可以重新解压缩存档、检出裸仓库，或者直接从网络重新下载源代码。
{==+==}

{==+==}
Alternatively, the [cargo-cache](https://crates.io/crates/cargo-cache) crate provides a simple CLI tool to only clear selected parts of the cache or show sizes of its components in your command-line.
{==+==}
[cargo-cache](https://crates.io/crates/cargo-cache) 提供了简单的命令行界面的工具，可以用来清理选定的缓存部分或者显示其组成部分的大小。
{==+==}


{==+==}
[`cargo install`]: ../commands/cargo-install.md
[`cargo login`]: ../commands/cargo-login.md
[`cargo vendor`]: ../commands/cargo-vendor.md
[config]: ../reference/config.md
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
[def-registry]:  ../appendix/glossary.md#registry  '"registry" (glossary entry)'
[env]: ../reference/environment-variables.md
{==+==}

{==+==}
