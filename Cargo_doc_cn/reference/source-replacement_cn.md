{==+==}
## Source Replacement
{==+==}
## 源替换
{==+==}


{==+==}
This document is about replacing the crate index. You can read about overriding
dependencies in the [overriding dependencies] section of this
documentation.
{==+==}
这篇文档是关于替换 crate 索引的。你可以在本文档的 [overriding dependencies] 部分阅读关于覆盖依赖的内容。
{==+==}


{==+==}
A *source* is a provider that contains crates that may be included as
dependencies for a package. Cargo supports the ability to **replace one source
with another** to express strategies such as:
{==+==}
*源* 是包含可以作为包的依赖项的crate的提供者。
Cargo支持 **用一个源替换另一个源的能力** ，从而有以下的策略:
{==+==}


{==+==}
* Vendoring - custom sources can be defined which represent crates on the local
  filesystem. These sources are subsets of the source that they're replacing and
  can be checked into packages if necessary.
{==+==}
* 拓展 - 可以自定义源，代表本地文件系统上的crate。这些源是它们所替换源的子集，如果有必要，可以被检查引到包中。
{==+==}


{==+==}
* Mirroring - sources can be replaced with an equivalent version which acts as a
  cache for crates.io itself.
{==+==}
* 镜像 - 源被替换成一个相等的版本，作为crates.io的缓存。
{==+==}


{==+==}
Cargo has a core assumption about source replacement that the source code is
exactly the same from both sources. Note that this also means that
a replacement source is not allowed to have crates which are not present in the
original source.
{==+==}
Cargo有一个关于源替换的核心假设，即两个源的源代码是完全一样的。
请注意，这也意味着替换源不允许有原始源中没有的crate。
{==+==}


{==+==}
As a consequence, source replacement is not appropriate for situations such as
patching a dependency or a private registry. Cargo supports patching
dependencies through the usage of [the `[patch]` key][overriding
dependencies], and private registry support is described in [the Registries
chapter][registries].
{==+==}
因此，源替换并不适合于修补依赖或私有注册中心的情况。
Cargo支持通过使用[ `[patch]` 键][overriding dependencies]来修补依赖，对私有注册中心的支持在[注册中心章节][registries]中描述。
{==+==}


{==+==}
When using source replacement, running commands like `cargo publish` that need to
contact the registry require passing the `--registry` option. This helps avoid
any ambiguity about which registry to contact, and will use the authentication
token for the specified registry.
{==+==}
当使用源替换时，运行像 `cargo publish`  这样需要联系注册中心的命令需要通过 `--registry` 选项。这有助于避免在联系哪个注册中心方面出现歧义，并将使用指定注册中心的认证令牌。
{==+==}


{==+==}
[overriding dependencies]: overriding-dependencies.md
[registries]: registries.md
{==+==}

{==+==}


{==+==}
### Configuration
{==+==}
### 配置
{==+==}


{==+==}
Configuration of replacement sources is done through [`.cargo/config.toml`][config]
and the full set of available keys are:
{==+==}
替换源的配置是通过 [`.cargo/config.toml`][config] 完成的，全部可用的键有：
{==+==}


{==+==}
```toml
# The `source` table is where all keys related to source-replacement
# are stored.
[source]
{==+==}
```toml
# `source` 表是存储所有与源替换有关的键的位置。
[source]
{==+==}


{==+==}
# Under the `source` table are a number of other tables whose keys are a
# name for the relevant source. For example this section defines a new
# source, called `my-vendor-source`, which comes from a directory
# located at `vendor` relative to the directory containing this `.cargo/config.toml`
# file
[source.my-vendor-source]
directory = "vendor"
{==+==}
# 在 `source` 表下有一些其他的表，它们的键是相关来源的名称。
# 例如，这一节定义了一个新的源文件，叫做 `my-vendor-source` ，它来自一个位于 `vendor` 的目录，相对于包含这个 `.cargo/config.toml` 文件的目录而言。
[source.my-vendor-source]
directory = "vendor"
{==+==}


{==+==}
# The crates.io default source for crates is available under the name
# "crates-io", and here we use the `replace-with` key to indicate that it's
# replaced with our source above.
#
{==+==}
# crates.io的默认源代码以 "crates-io" 的名称提供，这里我们使用 `replace-with` 键来表示它被我们上面的源替换。
#
{==+==}


{==+==}
# The `replace-with` key can also reference an alternative registry name defined in the `[registries]` table.
[source.crates-io]
replace-with = "my-vendor-source"
{==+==}
# `replace-with` 键也可以引用在 `[registries]` 表中定义的其他注册中心名称。
[source.crates-io]
replace-with = "my-vendor-source"
{==+==}


{==+==}
# Each source has its own table where the key is the name of the source
[source.the-source-name]
{==+==}
# 每个源都有自己的表，其中键是源的名称。
[source.the-source-name]
{==+==}


{==+==}
# Indicate that `the-source-name` will be replaced with `another-source`,
# defined elsewhere
replace-with = "another-source"
{==+==}
# 表示 `the-source-name` 替换为 `another-source` ，定义在其他地方
replace-with = "another-source"
{==+==}


{==+==}
# Several kinds of sources can be specified (described in more detail below):
registry = "https://example.com/path/to/index"
local-registry = "path/to/registry"
directory = "path/to/vendor"
{==+==}
# 可以指定几种源(下文有更详细的描述):
registry = "https://example.com/path/to/index"
local-registry = "path/to/registry"
directory = "path/to/vendor"
{==+==}


{==+==}
# Git sources can optionally specify a branch/tag/rev as well
git = "https://example.com/path/to/repo"
# branch = "master"
# tag = "v1.0.1"
# rev = "313f44e8"
```
{==+==}
# Git源也可以选择指定一个branch/tag/rev
git = "https://example.com/path/to/repo"
# branch = "master"
# tag = "v1.0.1"
# rev = "313f44e8"
```
{==+==}


{==+==}
[config]: config.md
{==+==}

{==+==}


{==+==}
### Registry Sources
{==+==}
### 注册中心源
{==+==}


{==+==}
A "registry source" is one that is the same as crates.io itself. That is, it has
an index served in a git repository which matches the format of the
[crates.io index](https://github.com/rust-lang/crates.io-index). That repository
then has configuration indicating where to download crates from.
{==+==}
"注册中心源" 是与crates.io 相同的。
也就是说，它有一个在git仓库中提供的索引，与 [crates.io index](https://github.com/rust-lang/crates.io-index) 的格式一致。
然后，该仓库表明从哪里下载crates的配置。
{==+==}


{==+==}
Currently there is not an already-available project for setting up a mirror of
crates.io. Stay tuned though!
{==+==}
目前还没有一个已经可用的项目来建立crates.io的镜像。但请继续关注!
{==+==}


{==+==}
### Local Registry Sources
{==+==}
### 本地注册中心源
{==+==}


{==+==}
A "local registry source" is intended to be a subset of another registry
source, but available on the local filesystem (aka vendoring). Local registries
are downloaded ahead of time, typically sync'd with a `Cargo.lock`, and are
made up of a set of `*.crate` files and an index like the normal registry is.
{==+==}
"本地注册中心源" 旨在成为另一个注册中心源的子集，但在本地文件系统上可用(又称拓展)。
本地注册中心是提前下载的，通常与 `Cargo.lock` 同步，并由一组 `*.crate` 文件和一个索引组成，就像普通注册中心一样。
{==+==}


{==+==}
The primary way to manage and create local registry sources is through the
[`cargo-local-registry`][cargo-local-registry] subcommand,
[available on crates.io][cargo-local-registry] and can be installed with
`cargo install cargo-local-registry`.
{==+==}
管理和创建本地注册中心源的主要方式是通过 [`cargo-local-registry`][cargo-local-registry] 子命令，
[crates.io上有][cargo-local-registry]，可以用 `cargo install cargo-local-registry` 来安装。
{==+==}


{==+==}
[cargo-local-registry]: https://crates.io/crates/cargo-local-registry
{==+==}

{==+==}


{==+==}
Local registries are contained within one directory and contain a number of
`*.crate` files downloaded from crates.io as well as an `index` directory with
the same format as the crates.io-index project (populated with just entries for
the crates that are present).
{==+==}
本地注册中心包含在一个目录中，并包含一些从crates.io下载的 `*.crate` 文件，以及 `index` 目录，其格式与 crates.io-index 项目相同 (只填充存在的crates的条目)。
{==+==}


{==+==}
### Directory Sources
{==+==}
### 目录源
{==+==}


{==+==}
A "directory source" is similar to a local registry source where it contains a
number of crates available on the local filesystem, suitable for vendoring
dependencies. Directory sources are primarily managed by the `cargo vendor`
subcommand.
{==+==}
"目录源" 类似于本地注册中心源，它包含了一些在本地文件系统上可用的crate，适合于拓展依赖。目录源主要由 `cargo vendor` 子命令管理。
{==+==}


{==+==}
Directory sources are distinct from local registries though in that they contain
the unpacked version of `*.crate` files, making it more suitable in some
situations to check everything into source control. A directory source is just a
directory containing a number of other directories which contain the source code
for crates (the unpacked version of `*.crate` files). Currently no restriction
is placed on the name of each directory.
{==+==}
但目录源与本地注册中心不同，它们包含 `*.crate` 文件的解压版本，在某些情况下更适合将所有东西都检查引入源控制中。
目录源只是一个包含其他一些目录的目录，这些目录包含了crate的源代码(`*.crate` 文件的解压版本)。目前对每个目录的名称没有限制。
{==+==}


{==+==}
Each crate in a directory source also has an associated metadata file indicating
the checksum of each file in the crate to protect against accidental
modifications.
{==+==}
目录源中的每个crate也有一个相关的元数据文件，表明crate中每个文件的校验和，以防止意外的修改。
{==+==}
