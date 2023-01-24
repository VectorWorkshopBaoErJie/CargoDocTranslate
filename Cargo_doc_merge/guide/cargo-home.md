## Cargo home

"Cargo home"功能为下载和源代码提供缓存。
当构建crate时，Cargo会将下载的构建依赖保存在Cargo home中。你可以通过设置 `CARGO_HOME` [环境变量][env]来修改Cargo home的位置。
如果你需要在自己的crate中获取这个位置，[home](https://crates.io/crates/home) crate 提供了相关的API。

注意，Cargo home的内部结构规范还未稳定下来，可能会改变。

Cargo home由以下几个部分构成:

## 文件:

* `config.toml`
	Cargo 的全局配置文件，见[参考部分的config][config]。

* `credentials.toml`
 	[`cargo login`]的私有凭证，用于登陆某个[注册中心][def-registry]。

* `.crates.toml`, `.crates2.json`
	这些隐藏文件包含通过[`cargo install`]下载的[包][def-package]的信息。不要手动修改这些文件！

## 目录:

* `bin`
bin目录中保存通过[`cargo install`]或[`rustup`](https://rust-lang.github.io/rustup/)下载的可执行文件。
方便在终端中直接使用这些二进制文件，可以把该目录添加到你的 `$PATH` 环境变量。

* `git`
	Git源代码保存在这里:

	* `git/db`
		 当crate的依赖是git仓库，Cargo会将这个仓库clone到该目录下作为一个裸仓库(只有`.git`文件夹中的内容)，并在必要时更新该仓库。

	* `git/checkouts`
		如果某个git源的代码被用到，实际的代码会从 `git/db` 内的仓库中checkout检出，保存在该目录下。
		为编译器提供依赖指定的*commit*文件。从而可以检出同一个仓库的不同提交。

* `registry`
	crate注册中心(比如[crates.io](https://crates.io/))的元数据和下载的包保存在这个文件夹中。

  * `registry/index`
		index是一个裸仓库，其中包含着注册中心所有可用crate的元数据(版本、依赖等)。

  *  `registry/cache`
		下载的依赖项源代码保存在cache目录中。这些crate被压缩为gzip文件，以 `.crate` 为后缀。

  * `registry/src`
		如果某个包需要已下载的 `.crate` 压缩文件，该文件会解压到 `registry/src` 目录，从而让rustc能找到相应的 `.rs` 文件。


## 在CI中缓存Cargo home

为避免在持续集成时重复下载所有crate依赖，你可以对 `$CARGO_HOME` 目录进行缓存。
但是，缓存整个Cargo home目录往往低效，因为它会把相同的代码保存两遍。
如果我们依赖一个crate叫做 `serde 1.0.92` 而缓存了整个 `$CARGO_HOME`，会把源代码存两遍( `registry/cache` 中的 `serde-1.0.92.crate` 以及解压到 `registry/src` 的`.rs`文件)。
这会拖慢构建过程，下载、解压、压缩和重新上传cache到CI服务器都会消耗时间。

只需缓存以下的文件夹就足够了:

* `bin/`
* `registry/index/`
* `registry/cache/`
* `git/db/`



## 打包缓存项目的所有依赖

见 [`cargo vendor`] 子命令。

译者注："vendor"这个词本身是个名词，意为"小贩、销售商"，在软件领域往往表示"将源代码和其所依赖的第三方库统一管理"的意思。像npm的 `node_modules` 。
参考来源[wiktionary-vendor](https://en.wiktionary.org/wiki/vendor)



## 清除缓存

理论上，你可以删除cache的任何部分，当一个crate需要某些源码时，Cargo会帮你恢复，要么是解压已有的压缩文件或从裸仓库中检出，或从网上重新下载源文件。

另一种方法是，[cargo-cache](https://crates.io/crates/cargo-cache) crate 提供了一个CLI工具来只清除cache中选中的部分和显示cache组成部分所占用的空间大小。

[`cargo install`]: ../commands/cargo-install.md
[`cargo login`]: ../commands/cargo-login.md
[`cargo vendor`]: ../commands/cargo-vendor.md
[config]: ../reference/config.md
[def-crate]:     ../appendix/glossary.md#crate     '"crate" (glossary entry)'
[def-package]:   ../appendix/glossary.md#package   '"package" (glossary entry)'
[def-registry]:  ../appendix/glossary.md#registry  '"registry" (glossary entry)'
[env]: ../reference/environment-variables.md
