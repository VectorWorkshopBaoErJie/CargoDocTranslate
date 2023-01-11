## 源替换

这篇文档是关于替换 crate 索引的。你可以在本文档的 [overriding dependencies] 部分阅读关于覆盖依赖的内容。

*源* 是包含可以作为包的依赖项的crate的提供者。
Cargo支持 **用一个源替换另一个源的能力** ，从而有以下的策略:

* 拓展 - 可以自定义源，代表本地文件系统上的crate。这些源是它们所替换源的子集，如果有必要，可以被检查引到包中。

* 镜像 - 源被替换成一个相等的版本，作为crates.io的缓存。

Cargo有一个关于源替换的核心假设，即两个源的源代码是完全一样的。
请注意，这也意味着替换源不允许有原始源中没有的crate。

因此，源替换并不适合于修补依赖或私有注册中心的情况。
Cargo支持通过使用[ `[patch]` 键][overriding dependencies]来修补依赖，对私有注册中心的支持在[注册中心章节][registries]中描述。

当使用源替换时，运行像 `cargo publish`  这样需要联系注册中心的命令需要通过 `--registry` 选项。这有助于避免在联系哪个注册中心方面出现歧义，并将使用指定注册中心的认证令牌。

[overriding dependencies]: overriding-dependencies.md
[registries]: registries.md

### 配置

替换源的配置是通过 [`.cargo/config.toml`][config] 完成的，全部可用的键有：

```toml
# `source` 表是存储所有与源替换有关的键的位置。
[source]

# 在 `source` 表下有一些其他的表，它们的键是相关来源的名称。
# 例如，这一节定义了一个新的源文件，叫做 `my-vendor-source` ，它来自一个位于 `vendor` 的目录，相对于包含这个 `.cargo/config.toml` 文件的目录而言。
[source.my-vendor-source]
directory = "vendor"

# crates.io的默认源代码以 "crates-io" 的名称提供，这里我们使用 `replace-with` 键来表示它被我们上面的源替换。
#
# `replace-with` 键也可以引用在 `[registries]` 表中定义的其他注册中心名称。
[source.crates-io]
replace-with = "my-vendor-source"

# 每个源都有自己的表，其中键是源的名称。
[source.the-source-name]

# 表示 `the-source-name` 替换为 `another-source` ，定义在其他地方
replace-with = "another-source"

# 可以指定几种源(下文有更详细的描述):
registry = "https://example.com/path/to/index"
local-registry = "path/to/registry"
directory = "path/to/vendor"

# Git源也可以选择指定一个branch/tag/rev
git = "https://example.com/path/to/repo"
# branch = "master"
# tag = "v1.0.1"
# rev = "313f44e8"
```

[config]: config.md

### 注册中心源

"注册中心源" 是与crates.io 相同的。
也就是说，它有一个在git仓库中提供的索引，与 [crates.io index](https://github.com/rust-lang/crates.io-index) 的格式一致。
然后，该仓库表明从哪里下载crates的配置。

目前还没有一个已经可用的项目来建立crates.io的镜像。但请继续关注!

### 本地注册中心源

"本地注册中心源" 旨在成为另一个注册中心源的子集，但在本地文件系统上可用(又称拓展)。
本地注册中心是提前下载的，通常与 `Cargo.lock` 同步，并由一组 `*.crate` 文件和一个索引组成，就像普通注册中心一样。

管理和创建本地注册中心源的主要方式是通过 [`cargo-local-registry`][cargo-local-registry] 子命令，
[crates.io上有][cargo-local-registry]，可以用 `cargo install cargo-local-registry` 来安装。

[cargo-local-registry]: https://crates.io/crates/cargo-local-registry

本地注册中心包含在一个目录中，并包含一些从crates.io下载的 `*.crate` 文件，以及 `index` 目录，其格式与 crates.io-index 项目相同 (只填充存在的crates的条目)。

### 目录源

"目录源" 类似于本地注册中心源，它包含了一些在本地文件系统上可用的crate，适合于拓展依赖。目录源主要由 `cargo vendor` 子命令管理。

但目录源与本地注册中心不同，它们包含 `*.crate` 文件的解压版本，在某些情况下更适合将所有东西都检查引入源控制中。
目录源只是一个包含其他一些目录的目录，这些目录包含了crate的源代码(`*.crate` 文件的解压版本)。目前对每个目录的名称没有限制。

目录源中的每个crate也有一个相关的元数据文件，表明crate中每个文件的校验和，以防止意外的修改。
