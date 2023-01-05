{==+==}
## Cargo Home
{==+==}
## Cargo Home
{==+==}

{==+==}
The "Cargo home" functions as a download and source cache.
When building a [crate][def-crate], Cargo stores downloaded build dependencies in the Cargo home.
You can alter the location of the Cargo home by setting the `CARGO_HOME` [environmental variable][env].
The [home](https://crates.io/crates/home) crate provides an API for getting this location if you need this information inside your Rust crate.
By default, the Cargo home is located in `$HOME/.cargo/`.
{==+==}
”Cargo home“功能为下载和源代码提供缓存。
当构建一个crate时，Cargo会将下载的构建依赖保存在Cargo home中。你可以通过设置 `CARGO_HOME` [环境变量][env]来修改Cargo home的位置。
如果你需要在自己的crate中获取这个位置，[home](https://crates.io/crates/home) crate 提供了相关的API。
{==+==}

{==+==}
Please note that the internal structure of the Cargo home is not stabilized and may be subject to change at any time.
{==+==}
注意，Cargo home的内部结构规范还未稳定下来，可能会在任何时候改变。
{==+==}

{==+==}
The Cargo home consists of following components:
{==+==}
Cargo home由以下几个部分构成:
{==+==}

{==+==}
## Files:
{==+==}
## 文件:
{==+==}

{==+==}
* `config.toml`
	Cargo's global configuration file, see the [config entry in the reference][config].
{==+==}
* `config.toml`
	Cargo 的全局配置文件，见[config entry in the reference][config]。
{==+==}

{==+==}
* `credentials.toml`
 	Private login credentials from [`cargo login`] in order to log in to a [registry][def-registry].
{==+==}
* `credentials.toml`
 	[`cargo login`]的私人登陆凭证，用于登陆某个[registry][def-registry].
{==+==}

{==+==}
* `.crates.toml`, `.crates2.json`
	These hidden files contain [package][def-package] information of crates installed via [`cargo install`]. Do NOT edit by hand!
{==+==}
* `.crates.toml`, `.crates2.json`
	这些隐藏文件包含通过[`cargo install`]下载的[包][def-package]的信息。不要手动修改这些文件！
{==+==}

{==+==}
## Directories:
{==+==}
## 目录:
{==+==}

{==+==}
* `bin`
The bin directory contains executables of crates that were installed via [`cargo install`] or [`rustup`](https://rust-lang.github.io/rustup/).
To be able to make these binaries accessible, add the path of the directory to your `$PATH` environment variable.
{==+==}
* `bin`
bin目录中保存通过[`cargo install`]或[`rustup`](https://rust-lang.github.io/rustup/)下载的可执行文件。方便在终端中直接使用这些二进制文件，可以把该目录添加到你的 `$PATH` 环境变量。
{==+==}

{==+==}
 *  `git`
	Git sources are stored here:
{==+==}
* `git`
	Git源代码保存在这里:
{==+==}

{==+==}
    * `git/db`
		When a crate depends on a git repository, Cargo clones the repo as a bare repo into this directory and updates it if necessary.
{==+==}
	* `git/db`
		 当一个crate的依赖是一个git仓库，Cargo会将这个仓库clone到该目录下作为一个裸仓库(只有`.git`文件夹中的内容)，并在必要时更新该仓库。
{==+==}

{==+==}
    * `git/checkouts`
		If a git source is used, the required commit of the repo is checked out from the bare repo inside `git/db` into this directory.
		This provides the compiler with the actual files contained in the repo of the commit specified for that dependency.
		Multiple checkouts of different commits of the same repo are possible.
{==+==}
	* `git/checkouts`
		如果某个git源的代码被用到，实际的代码会从`git/db`内的裸仓库中checkout出来，保存在该目录下。
		这个功能可以为编译器提供依赖指定的*特定commit*的文件。
		只需一个仓库，就可以checkout出不同commit版本的代码。
{==+==}

{==+==}
* `registry`
	Packages and metadata of crate registries (such as [crates.io](https://crates.io/)) are located here.
{==+==}
* `registry`
	crate注册机构(比如[crates.io](https://crates.io/))的元数据和从这些机构下载的包保存在这个文件夹中。
{==+==}

{==+==}
  * `registry/index`
		The index is a bare git repository which contains the metadata (versions, dependencies etc) of all available crates of a registry.
{==+==}
  * `registry/index`
		index是一个裸仓库，其中包含着一个注册机构中所有可用crate的元数据(版本、依赖等)。
{==+==}

{==+==}
  *  `registry/cache`
		Downloaded dependencies are stored in the cache. The crates are compressed gzip archives named with a `.crate` extension.
{==+==}
  *  `registry/cache`
		下载下来的依赖项源代码被保存在cache目录中。这些crate被压缩为gzip文件，以`.crate`为后缀。
{==+==}

{==+==}
  * `registry/src`
		If a downloaded `.crate` archive is required by a package, it is unpacked into `registry/src` folder where rustc will find the `.rs` files.
{==+==}
  * `registry/src`
		如果一个已下载的 `.crate` 压缩文件被某个包所需要，该文件会被解压到 `registry/src` 目录，好让rustc能找到相应的`.rs`文件。
{==+==}


{==+==}
## Caching the Cargo home in CI
{==+==}
## 在CI中缓存Cargo home
{==+==}

{==+==}
To avoid redownloading all crate dependencies during continuous integration, you can cache the `$CARGO_HOME` directory.
However, caching the entire directory is often inefficient as it will contain downloaded sources twice.
If we depend on a crate such as `serde 1.0.92` and cache the entire `$CARGO_HOME` we would actually cache the sources twice, the `serde-1.0.92.crate` inside `registry/cache` and the extracted `.rs` files of serde inside `registry/src`.
That can unnecessarily slow down the build as downloading, extracting, recompressing and reuploading the cache to the CI servers can take some time.
{==+==}
为避免在持续集成时重复下载所有crate依赖，你可以对 `$CARGO_HOME` 目录进行缓存。
但是，缓存整个Cargo home目录往往很低效，因为它会把相同的代码保存两遍。如果我们依赖一个crate叫做 `serde 1.0.92` 而且缓存了整个 `$CARGO_HOME`，我们会把源代码存两遍( `registry/cache` 中的 `serde-1.0.92.crate` 以及解压到 `registry/src` 的`.rs`文件)。
这会没必要地拖慢构建过程，下载、解压、压缩和重新上传cache到CI服务器都会消耗时间。
{==+==}

{==+==}
It should be sufficient to only cache the following directories across builds:
{==+==}
只需缓存以下的文件夹就足够了:
{==+==}

{==+==}
* `bin/`
* `registry/index/`
* `registry/cache/`
* `git/db/`
{==+==}
* `bin/`
* `registry/index/`
* `registry/cache/`
* `git/db/`
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

译者注：“vendor”这个词本身是个名词，意为”小贩、销售商“，没有动词含义。但是有一些软件领域的文章将其作为一个动词使用，表示”将源代码和其所依赖的第三方库一起打包起来“这么一个意思。就像是npm的 `node_modules` 。 参考来源是[wiktionary-vendor](https://en.wiktionary.org/wiki/vendor)
{==+==}



{==+==}
## Clearing the cache
{==+==}
## 清除缓存
{==+==}

{==+==}
In theory, you can always remove any part of the cache and Cargo will do its best to restore sources if a crate needs them either by reextracting an archive or checking out a bare repo or by simply redownloading the sources from the web.
{==+==}
理论上，你可以删除cache的任何一部分，当一个crate需要某些源码时，Cargo会尽力帮你恢复，要么是解压已有的压缩文件或从一个裸仓库中checkout出来，要么是从网上重新下载源文件。
{==+==}

{==+==}
Alternatively, the [cargo-cache](https://crates.io/crates/cargo-cache) crate provides a simple CLI tool to only clear selected parts of the cache or show sizes of its components in your command-line.
{==+==}
另一种方法是，[cargo-cache](https://crates.io/crates/cargo-cache) crate 提供了一个CLI工具来只清除cache中选中的部分和显示cache组成各部分所占的空间大小。
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
[`cargo install`]: ../commands/cargo-install.md
[`cargo login`]: ../commands/cargo-login.md
[`cargo vendor`]: ../commands/cargo-vendor.md
[config]: ../reference/config.md
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
[def-registry]:  ../appendix/glossary.md#registry  '"registry" (glossary entry)'
[env]: ../reference/environment-variables.md
{==+==}
