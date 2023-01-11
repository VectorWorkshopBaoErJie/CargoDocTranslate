{==+==}
## Unstable Features
{==+==}
## 不稳定的特性
{==+==}


{==+==}
Experimental Cargo features are only available on the [nightly channel]. You
are encouraged to experiment with these features to see if they meet your
needs, and if there are any issues or problems. Check the linked tracking
issues listed below for more information on the feature, and click the GitHub
subscribe button if you want future updates.
{==+==}
实验性的Cargo 特性只在[nightly channel]"每日构建"中提供。我们鼓励你尝试使用这些特性，看看它们是否符合你的需求，以及是否有问题或难题。请查看下面列出的链接的问题跟踪，了解更多关于该特性的信息，如果你想获得未来的更新，请点击GitHub订阅按钮。
{==+==}


{==+==}
After some period of time, if the feature does not have any major concerns, it
can be [stabilized], which will make it available on stable once the current
nightly release reaches the stable channel (anywhere from 6 to 12 weeks).
{==+==}
经过一段时间后，如果该特性没有任何重大问题，它可以被[stabilized]，这将使它在当前每日构建发布的版本到达稳定通道后，就可以在稳定版上使用(6到12周不等)。
{==+==}


{==+==}
There are three different ways that unstable features can be enabled based on
how the feature works:
{==+==}
根据特性的工作方式，有三种不同的方式可以启用不稳定的特性。
{==+==}


{==+==}
* New syntax in `Cargo.toml` requires a `cargo-features` key at the top of
  `Cargo.toml`, before any tables. For example:
{==+==}
* 按照 `Cargo.toml` 新语法，在顶部任意表之前设置 `cargo-features` 键。例如:
{==+==}


{==+==}
  ```toml
  # This specifies which new Cargo.toml features are enabled.
  cargo-features = ["test-dummy-unstable"]

  [package]
  name = "my-package"
  version = "0.1.0"
  im-a-teapot = true  # This is a new option enabled by test-dummy-unstable.
  ```
{==+==}
  ```toml
  # 这里指定启用哪些新的 Cargo.toml 特性。
  cargo-features = ["test-dummy-unstable"]

  [package]
  name = "my-package"
  version = "0.1.0"
  im-a-teapot = true  # 这是由 test-dummy-unstable 启用的新选项。
  ```
{==+==}


{==+==}
* New command-line flags, options, and subcommands require the `-Z
  unstable-options` CLI option to also be included. For example, the new
  `--out-dir` option is only available on nightly:
{==+==}
* 新的命令行标志、选项和子命令需要同时包含 `-Z unstable-options` CLI选项。
  例如，新的 `--out-dir` 选项只在每日构建中可用。
{==+==}


{==+==}
  ```cargo +nightly build --out-dir=out -Z unstable-options```
{==+==}

{==+==}


{==+==}
* `-Z` command-line flags are used to enable new functionality that may not
  have an interface, or the interface has not yet been designed, or for more
  complex features that affect multiple parts of Cargo. For example, the
  [mtime-on-use](#mtime-on-use) feature can be enabled with:
{==+==}
* `-Z`命令行标志用于启用可能没有接口的新功能，或者接口还没有设计好，或者用于影响Cargo多个部分的更复杂功能。例如，[mime-on-use](#mime-on-use)功能可以用以下方式启用:
{==+==}


{==+==}
  ```cargo +nightly build -Z mtime-on-use```
{==+==}

{==+==}


{==+==}
  Run `cargo -Z help` to see a list of flags available.
{==+==}
  运行 `cargo -Z help` 可以查看可用的标志列表。
{==+==}


{==+==}
  Anything which can be configured with a `-Z` flag can also be set in the
  cargo [config file] (`.cargo/config.toml`) in the `unstable` table. For
  example:
{==+==}
  可以用 `-Z` 标志配置的内容也可以在cargo [config file] (`.cargo/config.toml`)的 `unstable` 表中设置。比如说:
{==+==}


{==+==}
  ```toml
  [unstable]
  mtime-on-use = true
  build-std = ["core", "alloc"]
  ```
{==+==}

{==+==}


{==+==}
Each new feature described below should explain how to use it.
{==+==}
下面描述的每个新特性都将解释如何使用它。
{==+==}


{==+==}
[config file]: config.md
[nightly channel]: ../../book/appendix-07-nightly-rust.html
[stabilized]: https://doc.crates.io/contrib/process/unstable.html#stabilization
{==+==}

{==+==}


{==+==}
### List of unstable features
{==+==}
### 不稳定特性列表 
{==+==}


{==+==}
* Unstable-specific features
    * [-Z allow-features](#allow-features) — Provides a way to restrict which unstable features are used.
* Build scripts and linking
    * [Metabuild](#metabuild) — Provides declarative build scripts.
{==+==}
* 不稳定特定特性
    * [-Z allow-features](#allow-features) — 提供了一种限制使用哪些不稳定特性的方法。
* 构建脚本和链接
    * [Metabuild](#metabuild) — 提供声明式的构建脚本。
{==+==}


{==+==}
* Resolver and features
    * [no-index-update](#no-index-update) — Prevents cargo from updating the index cache.
    * [avoid-dev-deps](#avoid-dev-deps) — Prevents the resolver from including dev-dependencies during resolution.
    * [minimal-versions](#minimal-versions) — Forces the resolver to use the lowest compatible version instead of the highest.
    * [public-dependency](#public-dependency) — Allows dependencies to be classified as either public or private.
{==+==}
* 解析器和特性
    * [no-index-update](#no-index-update) — 防止cargo更新索引缓存。
    * [avoid-dev-deps](#avoid-dev-deps) — 防止解析器在解析过程中包含 dev-依赖。
    * [minimal-versions](#minimal-versions) — 强制解析器使用最低的兼容版本，而不是最高的版本。
    * [public-dependency](#public-dependency) — 允许将依赖分类为公共或私有。
{==+==}


{==+==}
* Output behavior
    * [out-dir](#out-dir) — Adds a directory where artifacts are copied to.
    * [Different binary name](#different-binary-name) — Assign a name to the built binary that is separate from the crate name.
{==+==}
* 输出行为
    * [out-dir](#out-dir) — 添加一个目录，将制品复制到该目录。
    * [Different binary name](#different-binary-name) — 为构建的二进制文件指定一个与crate名称分开的名称。
{==+==}


{==+==}
* Compile behavior
    * [mtime-on-use](#mtime-on-use) — Updates the last-modified timestamp on every dependency every time it is used, to provide a mechanism to delete unused artifacts.
    * [doctest-xcompile](#doctest-xcompile) — Supports running doctests with the `--target` flag.
    * [build-std](#build-std) — Builds the standard library instead of using pre-built binaries.
    * [build-std-features](#build-std-features) — Sets features to use with the standard library.
    * [binary-dep-depinfo](#binary-dep-depinfo) — Causes the dep-info file to track binary dependencies.
    * [panic-abort-tests](#panic-abort-tests) — Allows running tests with the "abort" panic strategy.
    * [crate-type](#crate-type) — Supports passing crate types to the compiler.
    * [keep-going](#keep-going) — Build as much as possible rather than aborting on the first error.
{==+==}
* 编译行为
    * [mtime-on-use](#mtime-on-use) — 在每次使用依赖时，更新其最后修改的时间戳，以提供一种机制来删除未使用的制品。
    * [doctest-xcompile](#doctest-xcompile) — 支持运行带有 `--target` 标志的文档测试。
    * [build-std](#build-std) — 构建标准库而不是使用预先构建的二进制文件。
    * [build-std-features](#build-std-features) — 设置与标准库一起使用的特性。
    * [binary-dep-depinfo](#binary-dep-depinfo) — 致使dep-info文件跟踪二进制文件的依赖。
    * [panic-abort-tests](#panic-abort-tests) — 允许用 "中止" 恐慌策略运行测试。
    * [crate-type](#crate-type) — 支持向编译器传递crate类型。
    * [keep-going](#keep-going) — 尽可能多地构建，而不是在第一个错误时就中止。
{==+==}


{==+==}
* rustdoc
    * [`doctest-in-workspace`](#doctest-in-workspace) — Fixes workspace-relative paths when running doctests.
    * [rustdoc-map](#rustdoc-map) — Provides mappings for documentation to link to external sites like [docs.rs](https://docs.rs/).
{==+==}
* rustdoc
    * [`doctest-in-workspace`](#doctest-in-workspace) — 修复文档测试时与工作空间相对路径。
    * [rustdoc-map](#rustdoc-map) —提供文档的映射，以链接到外部网站，如 [docs.rs](https://docs.rs/) 。
{==+==}


{==+==}
* `Cargo.toml` extensions
    * [Profile `rustflags` option](#profile-rustflags-option) — Passed directly to rustc.
    * [per-package-target](#per-package-target) — Sets the `--target` to use for each individual package.
    * [artifact dependencies](#artifact-dependencies) - Allow build artifacts to be included into other build artifacts and build them for different targets.
{==+==}
* `Cargo.toml` 扩展
    * [Profile `rustflags` option](#profile-rustflags-option) — 直接传递给rustc。
    * [per-package-target](#per-package-target) — 设置每个独立包的 `--target` 。
    * [artifact dependencies](#artifact-dependencies) - 允许将构建制品包含到其他构建制品中，并为不同的目标构建。
{==+==}


{==+==}
* Information and metadata
    * [Build-plan](#build-plan) — Emits JSON information on which commands will be run.
    * [unit-graph](#unit-graph) — Emits JSON for Cargo's internal graph structure.
    * [`cargo rustc --print`](#rustc---print) — Calls rustc with `--print` to display information from rustc.
{==+==}
* 信息和元数据
    * [Build-plan](#build-plan) — 发送关于哪些命令将被运行的JSON信息。
    * [unit-graph](#unit-graph) — 为Cargo的内部图结构发送JSON。
    * [`cargo rustc --print`](#rustc---print) — 用 `--print` 调用rustc，以显示来自 rustc 的信息。
{==+==}


{==+==}
* Configuration
    * [config-include](#config-include) — Adds the ability for config files to include other files.
    * [`cargo config`](#cargo-config) — Adds a new subcommand for viewing config files.
{==+==}
* 配置
    * [config-include](#config-include) — 增加配置文件包含其他文件的能力。
    * [`cargo config`](#cargo-config) — 增加新的子命令用于查看配置文件。
{==+==}


{==+==}
* Registries
    * [credential-process](#credential-process) — Adds support for fetching registry tokens from an external authentication program.
    * [`cargo logout`](#cargo-logout) — Adds the `logout` command to remove the currently saved registry token.
    * [sparse-registry](#sparse-registry) — Adds support for fetching from static-file HTTP registries (`sparse+`)
    * [publish-timeout](#publish-timeout) — Controls the timeout between uploading the crate and being available in the index
    * [registry-auth](#registry-auth) — Adds support for authenticated registries, and generate registry authentication tokens using asymmetric cryptography.
{==+==}
* 注册中心
    * [credential-process](#credential-process) — 增加对从外部认证程序获取注册中心令牌的支持。
    * [`cargo logout`](#cargo-logout) — 添加 `logout` 命令，以删除当前保存的注册中心令牌。
    * [sparse-registry](#sparse-registry) — 增加从静态文件HTTP注册中心获取的支持(`sparse+`)。
    * [publish-timeout](#publish-timeout) — 控制上传crate和在索引中可用之间的超时。
    * [registry-auth](#registry-auth) — 增加对认证注册的支持，并使用非对称加密生成注册中心认证令牌。
{==+==}


{==+==}
### allow-features
{==+==}
### 接受特性
{==+==}


{==+==}
This permanently-unstable flag makes it so that only a listed set of
unstable features can be used. Specifically, if you pass
`-Zallow-features=foo,bar`, you'll continue to be able to pass `-Zfoo`
and `-Zbar` to `cargo`, but you will be unable to pass `-Zbaz`. You can
pass an empty string (`-Zallow-features=`) to disallow all unstable
features.
{==+==}
这个永久不稳定的标志使得可以使用只有列出的一组不稳定的特性。具体来说，如果你传递了 `-Zallow-features=foo,bar` ，你将继续能够向 `cargo` 传递 `-Zfoo` 和 `-Zbar` ，但将无法传递 `-Zbaz` 。你可以传递一个空字符串(`-Zallow-features=`)来禁止所有不稳定的特性。
{==+==}


{==+==}
`-Zallow-features` also restricts which unstable features can be passed
to the `cargo-features` entry in `Cargo.toml`. If, for example, you want
to allow
{==+==}
`-Zallow-features`也限制了哪些不稳定的特性可以被传递给 `Cargo.toml` 中的 `cargo-features` 条目。例如，如果你想接受
{==+==}


{==+==}
```toml
cargo-features = ["test-dummy-unstable"]
```
{==+==}

{==+==}


{==+==}
where `test-dummy-unstable` is unstable, that features would also be
disallowed by `-Zallow-features=`, and allowed with
`-Zallow-features=test-dummy-unstable`.
{==+==}
如果 `test-dummy-unstable` 是不稳定的，那么 `-Zallow-features=` 也不接受该特性，而 `-Zallow-features=test-dummy-unstable` 则接受。
{==+==}


{==+==}
The list of features passed to cargo's `-Zallow-features` is also passed
to any Rust tools that cargo ends up calling (like `rustc` or
`rustdoc`). Thus, if you run `cargo -Zallow-features=`, no unstable
Cargo _or_ Rust features can be used.
{==+==}
传递给cargo的 `-Zallow-features` 的特性列表也会传递给cargo最终调用的任何Rust工具(如 `rustc` 或 `rustdoc` )。因此，如果你运行 `cargo -Zallow-features=` ，就不能使用不稳定的Cargo_或Rust特性。
{==+==}


{==+==}
### no-index-update
* Original Issue: [#3479](https://github.com/rust-lang/cargo/issues/3479)
* Tracking Issue: [#7404](https://github.com/rust-lang/cargo/issues/7404)
{==+==}

{==+==}


{==+==}
The `-Z no-index-update` flag ensures that Cargo does not attempt to update
the registry index. This is intended for tools such as Crater that issue many
Cargo commands, and you want to avoid the network latency for updating the
index each time.
{==+==}
`-Z no-index-update` 标志确保Cargo不会尝试更新注册中心索引。这是为Crater等工具准备的，这些工具会发布很多Cargo命令，你想避免每次更新索引的网络潜在行为。
{==+==}


{==+==}
### mtime-on-use
* Original Issue: [#6477](https://github.com/rust-lang/cargo/pull/6477)
* Cache usage meta tracking issue: [#7150](https://github.com/rust-lang/cargo/issues/7150)
{==+==}

{==+==}


{==+==}
The `-Z mtime-on-use` flag is an experiment to have Cargo update the mtime of
used files to make it easier for tools like cargo-sweep to detect which files
are stale. For many workflows this needs to be set on *all* invocations of cargo.
To make this more practical setting the `unstable.mtime_on_use` flag in `.cargo/config.toml`
or the corresponding ENV variable will apply the `-Z mtime-on-use` to all
invocations of nightly cargo. (the config flag is ignored by stable)
{==+==}
`-Z mtime-on-use` 标志是一个实验性的，让Cargo更新使用过的文件的时间戳，以便像cargo-sweep这样的工具更容易发现哪些文件是过时的。对于许多工作流程来说，这需要在 *所有* cargo的调用中进行设置。为了更实用，在 `.cargo/config.toml` 中设置 `unstable.mtime_on_use` 标志或相应的环境变量，将对所有每日构建cargo的调用应用 `-Z mtime-on-use` 。(config标志在稳定版本中被忽略) 
{==+==}


{==+==}
### avoid-dev-deps
* Original Issue: [#4988](https://github.com/rust-lang/cargo/issues/4988)
* Tracking Issue: [#5133](https://github.com/rust-lang/cargo/issues/5133)
{==+==}

{==+==}


{==+==}
When running commands such as `cargo install` or `cargo build`, Cargo
currently requires dev-dependencies to be downloaded, even if they are not
used. The `-Z avoid-dev-deps` flag allows Cargo to avoid downloading
dev-dependencies if they are not needed. The `Cargo.lock` file will not be
generated if dev-dependencies are skipped.
{==+==}
当运行 `cargo install` 或 `cargo build` 等命令时，Cargo目前需要下载 dev-依赖，即使它们不被使用。
`-Z avoid-dev-deps`标志允许Cargo在不需要dev-依赖时避免下载它们。如果跳过了dev-依赖，将不会生成 `Cargo.lock` 文件。
{==+==}


{==+==}
### minimal-versions
* Original Issue: [#4100](https://github.com/rust-lang/cargo/issues/4100)
* Tracking Issue: [#5657](https://github.com/rust-lang/cargo/issues/5657)
{==+==}

{==+==}


{==+==}
> Note: It is not recommended to use this feature. Because it enforces minimal
> versions for all transitive dependencies, its usefulness is limited since
> not all external dependencies declare proper lower version bounds. It is
> intended that it will be changed in the future to only enforce minimal
> versions for direct dependencies.
{==+==}
> 注意: 不建议使用这个功能。因为它为所有的横向依赖强制执行最小版本，它的作用是有限的，因为不是所有的外部依赖都声明适当的版本下限。
> 我们打算在未来对其进行修改，只对直接依赖执行最小版本。
{==+==}


{==+==}
When a `Cargo.lock` file is generated, the `-Z minimal-versions` flag will
resolve the dependencies to the minimum SemVer version that will satisfy the
requirements (instead of the greatest version).
{==+==}
当生成 `Cargo.lock` 文件时， `-Z minimal-versions` 标志将把依赖解析为能满足要求的最小语义化版本(而不是最高版本)。
{==+==}


{==+==}
The intended use-case of this flag is to check, during continuous integration,
that the versions specified in Cargo.toml are a correct reflection of the
minimum versions that you are actually using. That is, if Cargo.toml says
`foo = "1.0.0"` that you don't accidentally depend on features added only in
`foo 1.5.0`.
{==+==}
这个标志的用途是在持续集成过程中检查 Cargo.toml 中指定的版本是否正确反映了你实际使用的最小版本。
也就是说，如果 Cargo.toml 说明 `foo = "1.0.0"`，就不会意外地依赖 `foo 1.5.0` 中增加的特性。
{==+==}


{==+==}
### out-dir
* Original Issue: [#4875](https://github.com/rust-lang/cargo/issues/4875)
* Tracking Issue: [#6790](https://github.com/rust-lang/cargo/issues/6790)
{==+==}

{==+==}


{==+==}
This feature allows you to specify the directory where artifacts will be
copied to after they are built. Typically artifacts are only written to the
`target/release` or `target/debug` directories. However, determining the
exact filename can be tricky since you need to parse JSON output. The
`--out-dir` flag makes it easier to predictably access the artifacts. Note
that the artifacts are copied, so the originals are still in the `target`
directory. Example:
{==+==}
这个特性允许你指定制品在构建后将被复制到的目录。通常，制品只被写入 `target/release` 或 `target/debug` 目录。然而，确定确切的文件名可能很棘手，因为你需要解析JSON输出。`--out-dir` 标志使其更容易预计访问制品。注意，制品是复制的，所以原件仍然在 `target` 目录中。例子:
{==+==}


{==+==}
```sh
cargo +nightly build --out-dir=out -Z unstable-options
```
{==+==}

{==+==}


{==+==}
This can also be specified in `.cargo/config.toml` files.
{==+==}
这也可以在 `.cargo/config.toml` 文件中指定。
{==+==}


{==+==}
```toml
[build]
out-dir = "out"
```
{==+==}

{==+==}


{==+==}
### doctest-xcompile
* Tracking Issue: [#7040](https://github.com/rust-lang/cargo/issues/7040)
* Tracking Rustc Issue: [#64245](https://github.com/rust-lang/rust/issues/64245)
{==+==}

{==+==}


{==+==}
This flag changes `cargo test`'s behavior when handling doctests when
a target is passed. Currently, if a target is passed that is different
from the host cargo will simply skip testing doctests. If this flag is
present, cargo will continue as normal, passing the tests to doctest,
while also passing it a `--target` option, as well as enabling
`-Zunstable-features --enable-per-target-ignores` and passing along
information from `.cargo/config.toml`. See the rustc issue for more information.
{==+==}
这个标志改变了 `cargo test` 在传递目标时处理文档测试的行为。目前，如果传递的目标与主机不同，cargo将直接跳过文档测试。如果有这个标志，cargo将继续正常工作，将测试传给文档测试，同时也将 `--target` 选项传给它，以及启用 `-Zunstable-features --enable-per-target-ignores`，并将 `.cargo/config.toml` 的信息传给它。更多信息请参见 rustc issue。
{==+==}


{==+==}
```sh
cargo test --target foo -Zdoctest-xcompile
```
{==+==}

{==+==}


{==+==}
#### New `dir-name` attribute
{==+==}
#### 新的 `dir-name` 属性
{==+==}


{==+==}
Some of the paths generated under `target/` have resulted in a de-facto "build
protocol", where `cargo` is invoked as a part of a larger project build. So, to
preserve the existing behavior, there is also a new attribute `dir-name`, which
when left unspecified, defaults to the name of the profile. For example:
{==+==}
在 `target/` 下生成的一些路径是约定俗成的 "构建协议" ， 被 `cargo` 作为更大的项目构建的一部分来调用。
因此，为了保留现有的行为，还有一个新的属性 `dir-name` ，当没有指定时，默认为配置文件的名称。比如说:
{==+==}


{==+==}
```toml
[profile.release-lto]
inherits = "release"
dir-name = "lto"  # Emits to target/lto instead of target/release-lto
lto = true
```
{==+==}
```toml
[profile.release-lto]
inherits = "release"
dir-name = "lto"  # 发送到target/lto，而不是target/release-lto
lto = true
```
{==+==}


{==+==}
### Build-plan
* Tracking Issue: [#5579](https://github.com/rust-lang/cargo/issues/5579)
{==+==}

{==+==}


{==+==}
The `--build-plan` argument for the `build` command will output JSON with
information about which commands would be run without actually executing
anything. This can be useful when integrating with another build tool.
Example:
{==+==}
`build` 命令的 `--build-plan` 参数将输出JSON信息，说明哪些命令将被运行，而不需要实际执行。这在与其他构建工具集成时很有用。
例子:
{==+==}


{==+==}
```sh
cargo +nightly build --build-plan -Z unstable-options
```
{==+==}

{==+==}


{==+==}
### Metabuild
* Tracking Issue: [rust-lang/rust#49803](https://github.com/rust-lang/rust/issues/49803)
* RFC: [#2196](https://github.com/rust-lang/rfcs/blob/master/text/2196-metabuild.md)
{==+==}

{==+==}


{==+==}
Metabuild is a feature to have declarative build scripts. Instead of writing
a `build.rs` script, you specify a list of build dependencies in the
`metabuild` key in `Cargo.toml`. A build script is automatically generated
that runs each build dependency in order. Metabuild packages can then read
metadata from `Cargo.toml` to specify their behavior.
{==+==}
Metabuild是声明式构建脚本的特性。你不用写 `build.rs` 脚本，而是在 `Cargo.toml` 中的 `metabuild` 键中指定一个构建依赖项列表。
构建脚本会自动生成，按顺序运行每个构建依赖项。Metabuild包可以从 `Cargo.toml` 中读取元数据以指定其行为。
{==+==}


{==+==}
Include `cargo-features` at the top of `Cargo.toml`, a `metabuild` key in the
`package`, list the dependencies in `build-dependencies`, and add any metadata
that the metabuild packages require under `package.metadata`. Example:
{==+==}
在 `Cargo.toml` 的顶部包含 `cargo-features` ，在 `package` 中包含 `metabuild` 键，
在 `build-dependencies` 中列出依赖项，并在 `package.metadata` 中添加metabuild包需要的元数据。
例子:
{==+==}


{==+==}
```toml
cargo-features = ["metabuild"]

[package]
name = "mypackage"
version = "0.0.1"
metabuild = ["foo", "bar"]

[build-dependencies]
foo = "1.0"
bar = "1.0"

[package.metadata.foo]
extra-info = "qwerty"
```
{==+==}

{==+==}


{==+==}
Metabuild packages should have a public function called `metabuild` that
performs the same actions as a regular `build.rs` script would perform.
{==+==}
Metabuild包应该有一个名为 `metabuild` 的公共函数，执行与普通 `build.rs` 脚本相同的动作。
{==+==}


{==+==}
### public-dependency
* Tracking Issue: [#44663](https://github.com/rust-lang/rust/issues/44663)
{==+==}

{==+==}


{==+==}
The 'public-dependency' feature allows marking dependencies as 'public'
or 'private'. When this feature is enabled, additional information is passed to rustc to allow
the 'exported_private_dependencies' lint to function properly.
{==+==}
'public-dependency' 特性允许将依赖标记为 'public' 或 'private' 。当这个特性被启用时，附加的信息会传递给 rustc，以使 'exported_private_dependencies' 链接项能够正常工作。
{==+==}


{==+==}
This requires the appropriate key to be set in `cargo-features`:
{==+==}
这需要在 `cargo-features` 中设置适当的键。
{==+==}


{==+==}
```toml
cargo-features = ["public-dependency"]

[dependencies]
my_dep = { version = "1.2.3", public = true }
private_dep = "2.0.0" # Will be 'private' by default
```
{==+==}
```toml
cargo-features = ["public-dependency"]

[dependencies]
my_dep = { version = "1.2.3", public = true }
private_dep = "2.0.0" # 默认情况下，将是 'private' 。
```
{==+==}


{==+==}
### build-std
* Tracking Repository: <https://github.com/rust-lang/wg-cargo-std-aware>
{==+==}

{==+==}


{==+==}
The `build-std` feature enables Cargo to compile the standard library itself as
part of a crate graph compilation. This feature has also historically been known
as "std-aware Cargo". This feature is still in very early stages of development,
and is also a possible massive feature addition to Cargo. This is a very large
feature to document, even in the minimal form that it exists in today, so if
you're curious to stay up to date you'll want to follow the [tracking
repository](https://github.com/rust-lang/wg-cargo-std-aware) and its set of
issues.
{==+==}
`build-std` 特性使Cargo能够自己编译标准库，作为crate图编译的一部分。这个功能曾称为 "std-aware Cargo"。
这个功能仍处于开发的早期阶段，也是Cargo可能增加的重要特性。这是大的特性文档，即使现在以最小形式存在，
如果想保持最新，请关注[跟踪仓库](https://github.com/rust-lang/wg-cargo-std-aware)和issues。
{==+==}


{==+==}
The functionality implemented today is behind a flag called `-Z build-std`. This
flag indicates that Cargo should compile the standard library from source code
using the same profile as the main build itself. Note that for this to work you
need to have the source code for the standard library available, and at this
time the only supported method of doing so is to add the `rust-src` rust rustup
component:
{==+==}
目前实现的功能是在名为 `-Z build-std` 的标志后。这个标志表明，Cargo应该使用与主构建本身相同的配置文件从源代码中编译标准库。
请注意，要实现这个功能，你需要有标准库的源代码，目前唯一支持的方法是添加 `rust-src` rust rustup组件。
{==+==}


{==+==}
```console
$ rustup component add rust-src --toolchain nightly
```
{==+==}

{==+==}


{==+==}
It is also required today that the `-Z build-std` flag is combined with the
`--target` flag. Note that you're not forced to do a cross compilation, you're
just forced to pass `--target` in one form or another.
{==+==}
现在还要求 `-Z build-std` 标志与 `--target` 标志组合。请注意，并不是强制进行交叉编译，只是要求以某种形式传递 `--target` 。
{==+==}


{==+==}
Usage looks like:
{==+==}
使用方法如下:
{==+==}


{==+==}
```console
$ cargo new foo
$ cd foo
$ cargo +nightly run -Z build-std --target x86_64-unknown-linux-gnu
   Compiling core v0.0.0 (...)
   ...
   Compiling foo v0.1.0 (...)
    Finished dev [unoptimized + debuginfo] target(s) in 21.00s
     Running `target/x86_64-unknown-linux-gnu/debug/foo`
Hello, world!
```
{==+==}

{==+==}


{==+==}
Here we recompiled the standard library in debug mode with debug assertions
(like `src/main.rs` is compiled) and everything was linked together at the end.
{==+==}
这里，在调试模式下重新编译了标准库，并带有调试断言(就像 `src/main.rs` 被编译一样) ，最后所有内容都被连接在一起。
{==+==}


{==+==}
Using `-Z build-std` will implicitly compile the stable crates `core`, `std`,
`alloc`, and `proc_macro`. If you're using `cargo test` it will also compile the
`test` crate. If you're working with an environment which does not support some
of these crates, then you can pass an argument to `-Zbuild-std` as well:
{==+==}
使用 `-Z build-std` 将隐式地编译稳定版本 crate `core` 、 `std` 、 `alloc` 和 `proc_macro` 。
如果你使用 `cargo test` ，它也将编译 `test` crate。如果你的工作环境不支持其中的一些crate，那么可以向 `-Zbuild-std` 传递参数。
{==+==}


{==+==}
```console
$ cargo +nightly build -Z build-std=core,alloc
```
{==+==}

{==+==}


{==+==}
The value here is a comma-separated list of standard library crates to build.
{==+==}
这里的值是以逗号分隔的要构建的标准库crate的列表。
{==+==}


{==+==}
#### Requirements
{==+==}
#### 要求
{==+==}


{==+==}
As a summary, a list of requirements today to use `-Z build-std` are:
{==+==}
总结起来，使用 `-Z build-std` 的需求清单是:
{==+==}


{==+==}
* You must install libstd's source code through `rustup component add rust-src`
* You must pass `--target`
* You must use both a nightly Cargo and a nightly rustc
* The `-Z build-std` flag must be passed to all `cargo` invocations.
{==+==}
* 你必须通过 `rustup component add rust-src` 安装libstd的源代码。
* 你必须传递 `--target` 。
* 你必须同时使用每日构建 Cargo 和 Rustc
* `-Z build-std` 标志必须传递给所有 `cargo` 调用。
{==+==}


{==+==}
#### Reporting bugs and helping out
{==+==}
#### 报告错误并提供帮助
{==+==}


{==+==}
The `-Z build-std` feature is in the very early stages of development! This
feature for Cargo has an extremely long history and is very large in scope, and
this is just the beginning. If you'd like to report bugs please either report
them to:
{==+==}
`-Z build-std` 特性正处于开发的早期阶段! Cargo的这项功能有非常长的历史，范围也非常大，而这只是一个开始。如果你想报告bug，请把它们报告给:
{==+==}


{==+==}
* Cargo - <https://github.com/rust-lang/cargo/issues/new> - for implementation bugs
* The tracking repository -
  <https://github.com/rust-lang/wg-cargo-std-aware/issues/new> - for larger design
  questions.
{==+==}

{==+==}


{==+==}
Also if you'd like to see a feature that's not yet implemented and/or if
something doesn't quite work the way you'd like it to, feel free to check out
the [issue tracker](https://github.com/rust-lang/wg-cargo-std-aware/issues) of
the tracking repository, and if it's not there please file a new issue!
{==+==}
此外，如果你想查看尚未实现的特性，或者如果某些内容没有完全按照你希望的方式工作，
请随时查看库的[问题跟踪](https://github.com/rust-lang/wg-cargo-std-aware/issues)，如果那里没有，请提交新问题！
{==+==}


{==+==}
### build-std-features
* Tracking Repository: <https://github.com/rust-lang/wg-cargo-std-aware>
{==+==}

{==+==}


{==+==}
This flag is a sibling to the `-Zbuild-std` feature flag. This will configure
the features enabled for the standard library itself when building the standard
library. The default enabled features, at this time, are `backtrace` and
`panic_unwind`. This flag expects a comma-separated list and, if provided, will
override the default list of features enabled.
{==+==}
这个标志是 `-Zbuild-std` 特性标志的成员。这将配置在构建标准库时为标准库本身启用的特性。
目前默认启用的特性是 `backtrace` 和 `panic_unwind` 。这个标志期望逗号分隔的列表，如果提供的话，将覆盖默认启用的特性列表。
{==+==}


{==+==}
### binary-dep-depinfo
* Tracking rustc issue: [#63012](https://github.com/rust-lang/rust/issues/63012)
{==+==}

{==+==}


{==+==}
The `-Z binary-dep-depinfo` flag causes Cargo to forward the same flag to
`rustc` which will then cause `rustc` to include the paths of all binary
dependencies in the "dep info" file (with the `.d` extension). Cargo then uses
that information for change-detection (if any binary dependency changes, then
the crate will be rebuilt). The primary use case is for building the compiler
itself, which has implicit dependencies on the standard library that would
otherwise be untracked for change-detection.
{==+==}
`-Z binary-dep-depinfo` 标志使 Cargo 将同样的标志转发给 `rustc` ，这将使 `rustc` 在 "dep info" 文件(扩展名为 `.d` )中包含所有二进制依赖的路径。
Cargo会使用这些信息进行变化检测(如果有任何二进制的依赖发生变化，那么crate就会被重新构建)。
主要的用例是编译器本身，它对标准库有隐含的依赖，否则就不会追踪到变化检测。
{==+==}


{==+==}
### panic-abort-tests
* Tracking Issue: [#67650](https://github.com/rust-lang/rust/issues/67650)
* Original Pull Request: [#7460](https://github.com/rust-lang/cargo/pull/7460)
{==+==}

{==+==}


{==+==}
The `-Z panic-abort-tests` flag will enable nightly support to compile test
harness crates with `-Cpanic=abort`. Without this flag Cargo will compile tests,
and everything they depend on, with `-Cpanic=unwind` because it's the only way
`test`-the-crate knows how to operate. As of [rust-lang/rust#64158], however,
the `test` crate supports `-C panic=abort` with a test-per-process, and can help
avoid compiling crate graphs multiple times.
{==+==}
`-Z panic-abort-tests` 标志将启用每日构建支持，以 `-Cpanic=abort` 编译测试连接crate。如果没有这个标志，Cargo会用 `-Cpanic=unwind` 来编译测试，
以及所有依赖，因为这是 `test`-the-rate 知道如何操作的唯一方式。然而，从[rust-lang/rust#64158]开始，`test`-crate 支持 `-C panic=abort` ，并支持每个进程的测试，可以帮助避免多次编译crate图。
{==+==}


{==+==}
It's currently unclear how this feature will be stabilized in Cargo, but we'd
like to stabilize it somehow!
{==+==}
目前还不清楚如何在Cargo中稳定这一特性，但我们希望能以某种方式稳定下来。
{==+==}


{==+==}
[rust-lang/rust#64158]: https://github.com/rust-lang/rust/pull/64158
{==+==}

{==+==}


{==+==}
### keep-going
* Tracking Issue: [#10496](https://github.com/rust-lang/cargo/issues/10496)
{==+==}

{==+==}


{==+==}
`cargo build --keep-going` (and similarly for `check`, `test` etc) will build as
many crates in the dependency graph as possible, rather than aborting the build
at the first one that fails to build.
{==+==}
`cargo build --keep-going` (以及类似的 `check` 、 `test` 等)将尽可能多地构建依赖图中的crate，而不是在第一个失败的crate中止构建。
{==+==}


{==+==}
For example if the current package depends on dependencies `fails` and `works`,
one of which fails to build, `cargo check -j1` may or may not build the one that
succeeds (depending on which one of the two builds Cargo picked to run first),
whereas `cargo check -j1 --keep-going` would definitely run both builds, even if
the one run first fails.
{==+==}
例如，如果当前包依赖于 `fails` 和 `works` 两个依赖项，其中一个构建失败，`cargo check -j1` 可能也可能不会构建成功(取决于Cargo选择先运行哪一个构建)，而 `cargo check -j1 --keep-going` 肯定会同时运行两个构建，即使先运行的那个构建失败。
{==+==}


{==+==}
The `-Z unstable-options` command-line option must be used in order to use
`--keep-going` while it is not yet stable:
{==+==}
必须使用 `-Z unstable-options` 命令行选项，以便在尚未稳定时使用 `--keep-going` 。
{==+==}


{==+==}
```console
cargo check --keep-going -Z unstable-options
```
{==+==}

{==+==}


{==+==}
### config-include
* Tracking Issue: [#7723](https://github.com/rust-lang/cargo/issues/7723)
{==+==}

{==+==}


{==+==}
The `include` key in a config file can be used to load another config file. It
takes a string for a path to another file relative to the config file, or a
list of strings. It requires the `-Zconfig-include` command-line option.
{==+==}
配置文件中的 `include` 键可以用来加载另一个配置文件。它需要相对于配置文件的另一个文件路径的字符串，或者字符串列表。需要 `-Zconfig-include` 命令行选项。
{==+==}


{==+==}
```toml
# .cargo/config
include = '../../some-common-config.toml'
```
{==+==}

{==+==}


{==+==}
The config values are first loaded from the include path, and then the config
file's own values are merged on top of it.
{==+==}
配置文件的值首先从包含路径中加载，然后在其上合并配置文件本身的值。
{==+==}


{==+==}
This can be paired with [config-cli](#config-cli) to specify a file to load
from the command-line. Pass a path to a config file as the argument to
`--config`:
{==+==}
这可以与[config-cli](#config-cli)搭配使用，以指定从命令行加载的文件。传递一个配置文件的路径作为 `--config` 的参数:
{==+==}


{==+==}
```console
cargo +nightly -Zunstable-options -Zconfig-include --config somefile.toml build
```
{==+==}

{==+==}


{==+==}
CLI paths are relative to the current working directory.
{==+==}
CLI路径是相对于当前工作目录的。
{==+==}


{==+==}
### target-applies-to-host
* Original Pull Request: [#9322](https://github.com/rust-lang/cargo/pull/9322)
* Tracking Issue: [#9453](https://github.com/rust-lang/cargo/issues/9453)
{==+==}

{==+==}


{==+==}
Historically, Cargo's behavior for whether the `linker` and `rustflags`
configuration options from environment variables and `[target]` are
respected for build scripts, plugins, and other artifacts that are
_always_ built for the host platform has been somewhat inconsistent.
When `--target` is _not_ passed, Cargo respects the same `linker` and
`rustflags` for build scripts as for all other compile artifacts. When
`--target` _is_ passed, however, Cargo respects `linker` from
`[target.<host triple>]`, and does not pick up any `rustflags`
configuration. This dual behavior is confusing, but also makes it
difficult to correctly configure builds where the host triple and the
target triple happen to be the same, but artifacts intended to run on
the build host should still be configured differently.
{==+==}
曾经，Cargo对环境变量中的 `linker` 和 `rustflags` 配置选项以及 `[target]` 是否遵从构建脚本、插件和其他始终为主机平台构建的制品的行为有些不一致。当 `--target` 没有通过时，Cargo会遵从构建脚本的 `linker` 和 `rustflags` ，与所有其他编译制品相同。然而，当 `--target` 通过时，Cargo遵从 `[target.<host triple>]` 的 `linker` ，而不接受任何 `rustflags` 配置。这种双重行为让人困惑，也让人难以正确地配置构建，在这种情况下，主机三元组和目标三元组恰好是相同的，但打算在构建主机上运行的制品仍应以不同方式配置。
{==+==}


{==+==}
`-Ztarget-applies-to-host` enables the top-level
`target-applies-to-host` setting in Cargo configuration files which
allows users to opt into different (and more consistent) behavior for
these properties. When `target-applies-to-host` is unset, or set to
`true`, in the configuration file, the existing Cargo behavior is
preserved (though see `-Zhost-config`, which changes that default). When
it is set to `false`, no options from `[target.<host triple>]`,
`RUSTFLAGS`, or `[build]` are respected for host artifacts regardless of
whether `--target` is passed to Cargo. To customize artifacts intended
to be run on the host, use `[host]` ([`host-config`](#host-config)).
{==+==}
`-Ztarget-applies-to-host` 在Cargo配置文件中启用顶层的 `target-applies-to-host` 设置，允许用户为这些属性选择不同(和更一致)的行为。当 `target-applies-to-host`  在配置文件中未设置或设置为 `true` 时，现有的Cargo行为将被保留(不过请查看 `-Zhost-config` ，它改变了这个默认值)。当它被设置为 `false` 时，无论 `--target` 是否被传递给Cargo， `[target.<host triple>]` 、 `RUSTFLAGS` 或 `[build]` 的选项都不会被主机制品所尊从。要定制打算在主机上运行的制品，请使用 `[host]` ([`host-config`](#host-config))。
{==+==}


{==+==}
In the future, `target-applies-to-host` may end up defaulting to `false`
to provide more sane and consistent default behavior.
{==+==}
将来， `target- appliesto -host` 可能最终会默认为 `false` ，以提供更健全和一致的默认行为。
{==+==}


{==+==}
```toml
# config.toml
target-applies-to-host = false
```
{==+==}

{==+==}


{==+==}
```console
cargo +nightly -Ztarget-applies-to-host build --target x86_64-unknown-linux-gnu
```
{==+==}

{==+==}


{==+==}
### host-config
* Original Pull Request: [#9322](https://github.com/rust-lang/cargo/pull/9322)
* Tracking Issue: [#9452](https://github.com/rust-lang/cargo/issues/9452)
{==+==}

{==+==}


{==+==}
The `host` key in a config file can be used pass flags to host build targets
such as build scripts that must run on the host system instead of the target
system when cross compiling. It supports both generic and host arch specific
tables. Matching host arch tables take precedence over generic host tables.
{==+==}
配置文件中的 `host` 键可以用来向主机构建目标传递标志，比如交叉编译时必须在主机系统而不是目标系统上运行的构建脚本。
它同时支持通用的和特定于主机架构的表。匹配的host arch表优先于通用的host表。
{==+==}


{==+==}
It requires the `-Zhost-config` and `-Ztarget-applies-to-host`
command-line options to be set, and that `target-applies-to-host =
false` is set in the Cargo configuration file.
{==+==}
它需要设置 `-Zhost-config` 和 `-Ztarget-applies-to-host` 命令行选项，并且在Cargo配置文件中设置 `target-applies-to-host = false` 。
{==+==}


{==+==}
```toml
# config.toml
[host]
linker = "/path/to/host/linker"
[host.x86_64-unknown-linux-gnu]
linker = "/path/to/host/arch/linker"
rustflags = ["-Clink-arg=--verbose"]
[target.x86_64-unknown-linux-gnu]
linker = "/path/to/target/linker"
```
{==+==}

{==+==}


{==+==}
The generic `host` table above will be entirely ignored when building on a
`x86_64-unknown-linux-gnu` host as the `host.x86_64-unknown-linux-gnu` table
takes precedence.
{==+==}
在 `x86_64-unknown-linux-gnu` 主机上构建时，上面的通用 `host` 表将被完全忽略，因为 `host.x86_64-unknown-linux-gnu` 表具有优先权。
{==+==}


{==+==}
Setting `-Zhost-config` changes the default for `target-applies-to-host` to
`false` from `true`.
{==+==}
设置 `-Zhost-config` 将 `target-applies-to-host` 的默认值从 `true` 改为 `false` 。
{==+==}


{==+==}
```console
cargo +nightly -Ztarget-applies-to-host -Zhost-config build --target x86_64-unknown-linux-gnu
```
{==+==}

{==+==}


{==+==}
### unit-graph
* Tracking Issue: [#8002](https://github.com/rust-lang/cargo/issues/8002)
{==+==}

{==+==}


{==+==}
The `--unit-graph` flag can be passed to any build command (`build`, `check`,
`run`, `test`, `bench`, `doc`, etc.) to emit a JSON object to stdout which
represents Cargo's internal unit graph. Nothing is actually built, and the
command returns immediately after printing. Each "unit" corresponds to an
execution of the compiler. These objects also include which unit each unit
depends on.
{==+==}
`--unit-graph` 标志可以传递给任何构建命令(`build`、`check`、`run`、`test`、`bench`、`doc`等)，
以向标准输出发送JSON对象，表示Cargo的内部单元图。实际上没有任何内容被构建，
命令在打印后立即返回。每个 "单元" 对应于编译器的一次执行。这些对象还包含每个单元所依赖的单元。
{==+==}


{==+==}
```
cargo +nightly build --unit-graph -Z unstable-options
```
{==+==}

{==+==}


{==+==}
This structure provides a more complete view of the dependency relationship as
Cargo sees it. In particular, the "features" field supports the new feature
resolver where a dependency can be built multiple times with different
features. `cargo metadata` fundamentally cannot represent the relationship of
features between different dependency kinds, and features now depend on which
command is run and which packages and targets are selected. Additionally it
can provide details about intra-package dependencies like build scripts or
tests.
{==+==}
这种结构提供了Cargo所看到的更完整的依赖的视图。特别是，"features" 字段支持新的特性解析器，
依赖可以用不同的特性构建多次。 `cargo metadata` 从根本上不能表示不同依赖种类之间的特性关系，
当前特性取决于运行哪个命令，选择哪个包和目标。此外，它还可以提供包内依赖的细节，如构建脚本或测试。
{==+==}


{==+==}
The following is a description of the JSON structure:
{==+==}
下面是对JSON结构的描述:
{==+==}


{==+==}
```javascript
{
  /* Version of the JSON output structure. If any backwards incompatible
     changes are made, this value will be increased.
  */
  "version": 1,
  /* Array of all build units. */
  "units": [
    {
      /* An opaque string which indicates the package.
         Information about the package can be obtained from `cargo metadata`.
      */
      "pkg_id": "my-package 0.1.0 (path+file:///path/to/my-package)",
      /* The Cargo target. See the `cargo metadata` documentation for more
         information about these fields.
         https://doc.rust-lang.org/cargo/commands/cargo-metadata.html
      */
      "target": {
        "kind": ["lib"],
        "crate_types": ["lib"],
        "name": "my-package",
        "src_path": "/path/to/my-package/src/lib.rs",
        "edition": "2018",
        "test": true,
        "doctest": true
      },
{==+==}
```javascript
{
  /* 是JSON输出结构的版本。如果有向后不兼容的变化，这个值将增加。 */
  "version": 1,
  /* 所有构建单位的数组。 */
  "units": [
    {
      /* 一个不透明的字符串，表示该包。关于包的信息可以从 `cargo metadata` 中获得。 */
      "pkg_id": "my-package 0.1.0 (path+file:///path/to/my-package)",
      /* Cargo目标。关于这些字段的更多信息，请参见 `cargo metadata` 文档。 https://doc.rust-lang.org/cargo/commands/cargo-metadata.html */
      "target": {
        "kind": ["lib"],
        "crate_types": ["lib"],
        "name": "my-package",
        "src_path": "/path/to/my-package/src/lib.rs",
        "edition": "2018",
        "test": true,
        "doctest": true
      },
{==+==}


{==+==}
      /* The profile settings for this unit.
         These values may not match the profile defined in the manifest.
         Units can use modified profile settings. For example, the "panic"
         setting can be overridden for tests to force it to "unwind".
      */
      "profile": {
        /* The profile name these settings are derived from. */
        "name": "dev",
        /* The optimization level as a string. */
        "opt_level": "0",
        /* The LTO setting as a string. */
        "lto": "false",
        /* The codegen units as an integer.
           `null` if it should use the compiler's default.
        */
        "codegen_units": null,
        /* The debug information level as an integer.
           `null` if it should use the compiler's default (0).
        */
        "debuginfo": 2,
        /* Whether or not debug-assertions are enabled. */
        "debug_assertions": true,
        /* Whether or not overflow-checks are enabled. */
        "overflow_checks": true,
        /* Whether or not rpath is enabled. */
        "rpath": false,
        /* Whether or not incremental is enabled. */
        "incremental": true,
        /* The panic strategy, "unwind" or "abort". */
        "panic": "unwind"
      },
{==+==}
      /* 本单元的配置文件设置。这些值可能与配置清单中定义的配置文件不一致。
         单位可以使用修改的配置文件设置。例如，"panic" 设置可以被覆盖，用于测试，以迫使它 "unwind" 。 */
      "profile": {
        /* 这些设置是由配置文件名称衍生而来。 */
        "name": "dev",
        /* 字符串表示的优化级别。 */
        "opt_level": "0",
        /* 字符串表示的LTO设置。 */
        "lto": "false",
        /* 编码单位是一个整数。 `null` 表示它应该使用编译器的默认值。 */
        "codegen_units": null,
        /* 整数表示的调试信息等级。 `null` 表示它应该使用编译器的默认值 (0) 。 */
        "debuginfo": 2,
        /* 是否启用了调试断言。 */
        "debug_assertions": true,
        /* 是否启用了溢出检查。 */
        "overflow_checks": true,
        /* 是否启用了rpath。 */
        "rpath": false,
        /* 是否启用了增量编译。 */
        "incremental": true,
        /* 恐慌的策略，"unwind" 或 "abort" 。 */
        "panic": "unwind"
      },
{==+==}


{==+==}
      /* Which platform this target is being built for.
         A value of `null` indicates it is for the host.
         Otherwise it is a string of the target triple (such as
         "x86_64-unknown-linux-gnu").
      */
      "platform": null,
      /* The "mode" for this unit. Valid values:

         * "test" — Build using `rustc` as a test.
         * "build" — Build using `rustc`.
         * "check" — Build using `rustc` in "check" mode.
         * "doc" — Build using `rustdoc`.
         * "doctest" — Test using `rustdoc`.
         * "run-custom-build" — Represents the execution of a build script.
      */
      "mode": "build",
      /* Array of features enabled on this unit as strings. */
      "features": ["somefeat"],
      /* Whether or not this is a standard-library unit,
         part of the unstable build-std feature.
         If not set, treat as `false`.
      */
      "is_std": false,
{==+==}
      /* 为哪个平台建立的目标。如果值为 `null` ，则表明它是为主机建立的。
         否则，它是目标三元组的字符串(如 "x86_64-unknown-linux-gnu" )。 */
      "platform": null,
      /* 该单元的 "mode" 。有效值:

         * "test" — 使用 `rustc` 作为测试来构建。
         * "build" — 使用 `rustc` 构建。
         * "check" — 在 "check" 模式下使用 `rustc` 构建。
         * "doc" — 使用 `rustdoc` 构建。
         * "doctest" — 使用 `rustdoc` 进行测试。
         * "run-custom-build" — 表示构建脚本的执行。
      */
      "mode": "build",
      /* 在这个单元上启用的特性数组字符串。 */
      "features": ["somefeat"],
      /* 这是否是一个标准库单元，是不稳定的 build-std 功能的一部分。如果没有设置，视为 `false` 。 */
      "is_std": false,
{==+==}


{==+==}
      /* Array of dependencies of this unit. */
      "dependencies": [
        {
          /* Index in the "units" array for the dependency. */
          "index": 1,
          /* The name that this dependency will be referred as. */
          "extern_crate_name": "unicode_xid",
          /* Whether or not this dependency is "public",
             part of the unstable public-dependency feature.
             If not set, the public-dependency feature is not enabled.
          */
          "public": false,
          /* Whether or not this dependency is injected into the prelude,
             currently used by the build-std feature.
             If not set, treat as `false`.
          */
          "noprelude": false
        }
      ]
    },
    // ...
  ],
  /* Array of indices in the "units" array that are the "roots" of the
     dependency graph.
  */
  "roots": [0],
}
```
{==+==}
      /* 该单元的依赖数组。 */
      "dependencies": [
        {
          /* 依赖的 "单位" 数组中的索引。 */
          "index": 1,
          /* 此依赖项将被称为的名称。 */
          "extern_crate_name": "unicode_xid",
          /* 这个依赖是否是 "public" 的，是不稳定的公共依赖特性的一部分。如果没有设置，则不启用公共依赖特性。*/
          "public": false,
          /* 该依赖是否被注入到 prelude 中，目前由 build-std 功能使用。如果没有设置，视为 `false` 。 */
          "noprelude": false
        }
      ]
    },
    // ...
  ],
  /* "单位" 数组中作为依赖图 "根" 的索引数组。 */
  "roots": [0],
}
```
{==+==}


{==+==}
### Profile `rustflags` option
* Original Issue: [rust-lang/cargo#7878](https://github.com/rust-lang/cargo/issues/7878)
* Tracking Issue: [rust-lang/cargo#10271](https://github.com/rust-lang/cargo/issues/10271)
{==+==}

{==+==}


{==+==}
This feature provides a new option in the `[profile]` section to specify flags
that are passed directly to rustc.
This can be enabled like so:
{==+==}
这个特性在 "[profile]" 部分提供了新的选项，用来指定直接传递给rustc的标志。可以像这样启用:
{==+==}


{==+==}
```toml
cargo-features = ["profile-rustflags"]

[package]
# ...

[profile.release]
rustflags = [ "-C", "..." ]
```
{==+==}

{==+==}


{==+==}
### rustdoc-map
* Tracking Issue: [#8296](https://github.com/rust-lang/cargo/issues/8296)
{==+==}

{==+==}


{==+==}
This feature adds configuration settings that are passed to `rustdoc` so that
it can generate links to dependencies whose documentation is hosted elsewhere
when the dependency is not documented. First, add this to `.cargo/config`:
{==+==}
这个特性增加了传递给 `rustdoc` 的配置，这样它就可以在依赖没有文档的情况下，
生成指向文档托管在其他地方的依赖的链接。首先，将其添加到 `.cargo/config` 中。
{==+==}


{==+==}
```toml
[doc.extern-map.registries]
crates-io = "https://docs.rs/"
```
{==+==}

{==+==}


{==+==}
Then, when building documentation, use the following flags to cause links
to dependencies to link to [docs.rs](https://docs.rs/):
{==+==}
然后，在构建文档时，使用以下标志，使链接的依赖链接到 [docs.rs](https://docs.rs/) 。
{==+==}


{==+==}
```
cargo +nightly doc --no-deps -Zrustdoc-map
```
{==+==}

{==+==}


{==+==}
The `registries` table contains a mapping of registry name to the URL to link
to. The URL may have the markers `{pkg_name}` and `{version}` which will get
replaced with the corresponding values. If neither are specified, then Cargo
defaults to appending `{pkg_name}/{version}/` to the end of the URL.
{==+==}
`registries` 表包含了注册中心名称与要链接的URL的映射。URL可以有 `{pkg_name}` 和 `{version}` 的标记，
这些标记会被替换成相应的值。如果两者都没有指定，那么Cargo默认会在URL的末尾添加 `{pkg_name}/{version}/` 。
{==+==}


{==+==}
Another config setting is available to redirect standard library links. By
default, rustdoc creates links to <https://doc.rust-lang.org/nightly/>. To
change this behavior, use the `doc.extern-map.std` setting:
{==+==}
另一个配置设置可用于重定向标准库链接。默认情况下，rustdoc 创建链接到 <https://doc.rust-lang.org/nightly/> 。
要改变这种行为，请使用 `doc.extern-map.std` 设置。
{==+==}


{==+==}
```toml
[doc.extern-map]
std = "local"
```
{==+==}

{==+==}


{==+==}
A value of `"local"` means to link to the documentation found in the `rustc`
sysroot. If you are using rustup, this documentation can be installed with
`rustup component add rust-docs`.
{==+==}
值为 `"local"` 意味着链接到在 `rustc` 系统根中找到的文档。如果你使用的是rustup，这个文档可以用 `rustup component add rust-docs` 来安装。  
{==+==}


{==+==}
The default value is `"remote"`.

The value may also take a URL for a custom location.
{==+==}
默认值是 `"remote"` 。

该值也可以接受一个自定义位置的URL。
{==+==}


{==+==}
### per-package-target
* Tracking Issue: [#9406](https://github.com/rust-lang/cargo/pull/9406)
* Original Pull Request: [#9030](https://github.com/rust-lang/cargo/pull/9030)
* Original Issue: [#7004](https://github.com/rust-lang/cargo/pull/7004)
{==+==}

{==+==}


{==+==}
The `per-package-target` feature adds two keys to the manifest:
`package.default-target` and `package.forced-target`. The first makes
the package be compiled by default (ie. when no `--target` argument is
passed) for some target. The second one makes the package always be
compiled for the target.
{==+==}
`per-package-target` 特性在配置清单中增加了两个键：`package.default-target` 和  `package.forced-target` 。
第一个键使包在默认情况下 (即没有传递 `--target` 参数时)为某个目标进行编译。第二种是使包总是为该目标编译。
{==+==}


{==+==}
Example:

```toml
[package]
forced-target = "wasm32-unknown-unknown"
```
{==+==}

{==+==}


{==+==}
In this example, the crate is always built for
`wasm32-unknown-unknown`, for instance because it is going to be used
as a plugin for a main program that runs on the host (or provided on
the command line) target.
{==+==}
在这个例子中，crate总是为 `wasm32-unknown-unknown` 构建的，例如，因为它将被用作运行在主机(或在命令行上提供)目标上的主程序的插件。
{==+==}


{==+==}
### artifact-dependencies
{==+==}

{==+==}


{==+==}
* Tracking Issue: [#9096](https://github.com/rust-lang/cargo/pull/9096)
* Original Pull Request: [#9992](https://github.com/rust-lang/cargo/pull/9992)
{==+==}

{==+==}


{==+==}
Allow Cargo packages to depend on `bin`, `cdylib`, and `staticlib` crates,
and use the artifacts built by those crates at compile time.
{==+==}
允许 Cargo 包依赖 `bin` 、 `cdylib` 和 `staticlib` crate，并在编译时使用这些crate构建的制品。
{==+==}


{==+==}
Run `cargo` with `-Z bindeps` to enable this functionality.
{==+==}
使用 `-Z bindeps` 运行 `cargo` 来启用这一功能。
{==+==}


{==+==}
**Example:** use _cdylib_ artifact in build script
{==+==}
**示例:** 在构建脚本中使用 _cdylib_ 制品
{==+==}


{==+==}
The `Cargo.toml` in the consuming package, building the `bar` library as `cdylib`
for a specific build target…
{==+==}
消耗包中的 `Cargo.toml` ，为特定的构建目标将 `bar` 库构建为 `cdylib` 
{==+==}


{==+==}
```toml
[build-dependencies]
bar = { artifact = "cdylib", version = "1.0", target = "wasm32-unknown-unknown" }
```
{==+==}

{==+==}


{==+==}
…along with the build script in `build.rs`.
{==+==}
和 `build.rs` 中的构建脚本一起。
{==+==}


{==+==}
```rust
fn main() {
  wasm::run_file(std::env::var("CARGO_CDYLIB_FILE_BAR").unwrap());
}
```
{==+==}

{==+==}


{==+==}
**Example:** use _binary_ artifact and its library in a binary
{==+==}
**示例:** 在二进制文件中使用 _binary_ 制品和它的库。
{==+==}


{==+==}
The `Cargo.toml` in the consuming package, building the `bar` binary for inclusion
as artifact while making it available as library as well…
{==+==}
消耗包中的 `Cargo.toml` ，构建 `bar` 二进制文件作为制品，同时将其作为库提供…
{==+==}


{==+==}
```toml
[dependencies]
bar = { artifact = "bin", version = "1.0", lib = true }
```
{==+==}

{==+==}


{==+==}
…along with the executable using `main.rs`.
{==+==}
与可执行文件一起使用 `main.rs` 。
{==+==}


{==+==}
```rust
fn main() {
  bar::init();
  command::run(env!("CARGO_BIN_FILE_BAR"));
}
```
{==+==}

{==+==}


{==+==}
### sparse-registry
* Tracking Issue: [9069](https://github.com/rust-lang/cargo/issues/9069)
* RFC: [#2789](https://github.com/rust-lang/rfcs/pull/2789)
{==+==}

{==+==}


{==+==}
The `sparse-registry` feature allows cargo to interact with remote registries served
over plain HTTP rather than git. These registries can be identified by urls starting with
`sparse+http://` or `sparse+https://`.
{==+==}
`sparse-registry` 特性允许cargo与通过普通HTTP而不是git提供的远程注册中心进行交互。这些注册中心可以通过以 `sparse+http://` 或 `sparse+https://` 开头的URL识别。
{==+==}


{==+==}
When fetching index metadata over HTTP, Cargo only downloads the metadata for relevant
crates, which can save significant time and bandwidth.
{==+==}
当通过HTTP获取索引元数据时，Cargo 只下载相关crate的元数据，这可以节省大量时间和带宽。
{==+==}


{==+==}
The format of the sparse index is identical to a checkout of a git-based index.
{==+==}
sparse索引格式与基于git的索引的签出是一样的。
{==+==}


{==+==}
The `registries.crates-io.protocol` config option can be used to set the default protocol
for crates.io. This option requires `-Z sparse-registry` to be enabled.
{==+==}
`registries.crates-io.protocol` 配置选项可以用来设置 crates.io 的默认协议。这个选项需要启用 `-Z sparse-registry` 。
{==+==}


{==+==}
* `sparse` — Use sparse index.
* `git` — Use git index.
* If the option is unset, it will be sparse index if `-Z sparse-registry` is enabled,
  otherwise it will be git index.
{==+==}
* `sparse` — 使用 sparse 索引。
* `git` — 使用 git 索引。
* 如果选项没有设置，若启用 `-Z sparse-registry` ，它将是sparse索引，否则它将是git索引。
{==+==}


{==+==}
Cargo locally caches the crate metadata files, and captures an `ETag` or `Last-Modified` 
HTTP header from the server for each entry. When refreshing crate metadata, Cargo will
send the `If-None-Match` or `If-Modified-Since` header to allow the server to respond
with HTTP 304 if the local cache is valid, saving time and bandwidth.
{==+==}
Cargo在本地缓存crate元数据文件，并从服务器上捕获每个条目的 `ETag` 或 `Last-Modified` HTTP头。
当刷新crate元数据时，Cargo会发送 `If-None-Match` 或 `If-Modified-Since` 头，如果本地缓存有效，则允许服务器以HTTP 304响应，以节省时间和带宽。
{==+==}


{==+==}
### publish-timeout
* Tracking Issue: [11222](https://github.com/rust-lang/cargo/issues/11222)
{==+==}

{==+==}


{==+==}
The `publish.timeout` key in a config file can be used to control how long
`cargo publish` waits between posting a package to the registry and it being
available in the local index.
{==+==}
配置文件中的 `publish.timeout` 键可以用来控制 `cargo publish` 在将包发布到注册中心和它在本地索引中可用之间的等待时间。
{==+==}


{==+==}
A timeout of `0` prevents any checks from occurring.
{==+==}
如果超时为 `0` 就不会发生任何检查。
{==+==}


{==+==}
It requires the `-Zpublish-timeout` command-line options to be set.
{==+==}
它需要设置 `-Zpublish-timeout` 命令行选项。
{==+==}


{==+==}
```toml
# config.toml
[publish]
timeout = 300  # in seconds
```
{==+==}
```toml
# config.toml
[publish]
timeout = 300  # 按秒
```
{==+==}


{==+==}
### registry-auth
* Tracking Issue: [10474](https://github.com/rust-lang/cargo/issues/10474)
* RFC: [#3139](https://github.com/rust-lang/rfcs/pull/3139)
{==+==}

{==+==}


{==+==}
Enables Cargo to include the authorization token for API requests, crate downloads
and sparse index updates by adding a configuration option to config.json
in the registry index.
{==+==}
通过在注册中心索引的config.json中添加配置选项，使Cargo在API请求、crate下载和sparse索引更新中包含授权令牌。
{==+==}


{==+==}
To use this feature, the registry server must include `"auth-required": true` in
`config.json`, and you must pass the `-Z registry-auth` flag on the Cargo command line.
{==+==}
要使用这个特性，注册中心服务器必须在 `config.json` 中包含 `"auth-required": true` ，并且必须在Cargo命令行中传递 `-Z registry-auth` 标志。
{==+==}


{==+==}
When using the sparse protocol, Cargo will attempt to fetch the `config.json` file before
fetching any other files. If the server responds with an HTTP 401, then Cargo will assume
that the registry requires authentication and re-attempt the request for `config.json`
with the authentication token included.
{==+==}
当使用sparse协议时，Cargo会在获取任何其他文件之前尝试获取 `config.json` 文件。
如果服务器的回应是HTTP 401，那么Cargo将认为注册中心需要认证，并重新尝试请求 `config.json` ，其中包含认证令牌。
{==+==}


{==+==}
On authentication failure (or missing authentication token) the server MAY include a
`WWW-Authenticate` header with a `Cargo login_url` challenge to indicate where the user
can go to get a token.
{==+==}
在认证失败 (或缺少认证令牌) 时，服务器可能包括 `WWW-Authenticate` 头和 `Cargo login_url` 信息，以表明用户可以去哪里获得令牌。
{==+==}


{==+==}
```
WWW-Authenticate: Cargo login_url="https://test-registry-login/me
```
{==+==}

{==+==}


{==+==}
This same flag is also used to enable asymmetric authentication tokens.
* Tracking Issue: [10519](https://github.com/rust-lang/cargo/issues/10519)
* RFC: [#3231](https://github.com/rust-lang/rfcs/pull/3231)
{==+==}

{==+==}


{==+==}
Add support for Cargo to authenticate the user to registries without sending secrets over the network.
{==+==}
增加对Cargo的支持，以便在不通过网络发送私密信息的情况下对用户进行认证。
{==+==}


{==+==}
In [`config.toml`](config.md) and `credentials.toml` files there is a field called `private-key`, which is a private key formatted in the secret [subset of `PASERK`](https://github.com/paseto-standard/paserk/blob/master/types/secret.md) and is used to sign asymmetric tokens
{==+==}
在 [`config.toml`](config.md) 和 `credentials.toml` 文件中，有名为 `private-key` 的字段，它是以秘密的 [subset of `PASERK`](https://github.com/paseto-standard/paserk/blob/master/types/secret.md)格式的私钥，用于签署非对称令牌。
{==+==}


{==+==}
A keypair can be generated with `cargo login --generate-keypair` which will:
- generate a public/private keypair in the currently recommended fashion.
- save the private key in `credentials.toml`.
- print the public key in [PASERK public](https://github.com/paseto-standard/paserk/blob/master/types/public.md) format.
{==+==}
可以用 `cargo login --generate-keypair` 生成密钥对，这将:
- 以目前推荐的方式生成公钥/私钥对。
- 保存私钥在 `credentials.toml` 。
- 格式打印公钥 [PASERK public](https://github.com/paseto-standard/paserk/blob/master/types/public.md) 。
{==+==}


{==+==}
It is recommended that the `private-key` be saved in `credentials.toml`. It is also supported in `config.toml`, primarily so that it can be set using the associated environment variable, which is the recommended way to provide it in CI contexts. This setup is what we have for the `token` field for setting a secret token.
{==+==}
建议将 `private-key` 保存在 `credentials.toml` 中。在 `config.toml` 中也支持，主要是为了使用相关的环境变量来设置，这也是在CI背景下提供的推荐方式。这种设置就是为 `token` 字段设置秘密令牌的方式。
{==+==}


{==+==}
There is also an optional field called `private-key-subject` which is a string chosen by the registry.
This string will be included as part of an asymmetric token and should not be secret.
It is intended for the rare use cases like "cryptographic proof that the central CA server authorized this action". Cargo requires it to be non-whitespace printable ASCII. Registries that need non-ASCII data should base64 encode it.
{==+==}
还有可选字段 `private-key-subject` ，是由注册中心选择的字符串。
这个字符串将作为非对称令牌的一部分，不应该是秘密的。
是为 "中央CA服务器授权此行为的加密证明" 这样的极少用例准备的。
Cargo要求它为非空格可打印的ASCII。需要非ASCII数据的注册中心应该对其进行base64编码。 
{==+==}


{==+==}
Both fields can be set with `cargo login --registry=name --private-key --private-key-subject="subject"` which will prompt you to put in the key value.
{==+==}
这两个字段都可以用 `cargo login --registry=name --private-key --private-key-subject="subject"` 来设置，它将提示你输入密钥值。
{==+==}


{==+==}
A registry can have at most one of `private-key`, `token`, or `credential-process` set.
{==+==}
注册中心最多可以设置  `private-key` 、`token` 、 `credential-process` 之一。
{==+==}


{==+==}
All PASETOs will include `iat`, the current time in ISO 8601 format. Cargo will include the following where appropriate:
{==+==}
所有PASETO将包含  `iat` ，即ISO 8601格式的当前时间。Cargo将酌情包含以下内容:
{==+==}


{==+==}
- `sub` an optional, non-secret string chosen by the registry that is expected to be claimed with every request. The value will be the `private-key-subject` from the `config.toml` file.
{==+==}
- `sub`一个可选的、非秘密的字符串，由注册中心选择，预期在每次请求时都会被取得。该值将是 `config.toml` 文件中的 `private-key-subject` 。
{==+==}


{==+==}
- `mutation` if present, indicates that this request is a mutating operation (or a read-only operation if not present), must be one of the strings `publish`, `yank`, or `unyank`.
  - `name` name of the crate related to this request.
  - `vers` version string of the crate related to this request.
  - `cksum` the SHA256 hash of the crate contents, as a string of 64 lowercase hexadecimal digits, must be present only when `mutation` is equal to `publish`
{==+==}
- `mutation` 如果存在, 表示该请求是一个改变操作(如果不存在，则是一个只读操作)，必须是字符串 `publish` 、 `yank` 、 `unyank` 之一。
  - `name` 与此请求有关的crate的名称。
  - `vers` 与此请求相关的包的版本字符串。
  - `cksum` 箱子内容的SHA256哈希值，是由64个小写的十六进制数字组成的字符串，只有当 `mutation` 等于 `publish` 时才必须出现。 
{==+==}


{==+==}
- `challenge` the challenge string received from a 401/403 from this server this session. Registries that issue challenges must track which challenges have been issued/used and never accept a given challenge more than once within the same validity period (avoiding the need to track every challenge ever issued).
{==+==}
- `challenge` 从该服务器的session 401/403中收到的质询字符串。发出质询的注册中心必须跟踪哪些质询已经 issued/used ，并且在同一有效期内不接受特定的质询超过一次(避免跟踪每一个曾经发出的质询)。
{==+==}


{==+==}
The "footer" (which is part of the signature) will be a JSON string in UTF-8 and include:
- `url` the RFC 3986 compliant URL where cargo got the config.json file,
  - If this is a registry with an HTTP index, then this is the base URL that all index queries are relative to.
  - If this is a registry with a GIT index, it is the URL Cargo used to clone the index.
- `kid` the identifier of the private key used to sign the request, using the [PASERK IDs](https://github.com/paseto-standard/paserk/blob/master/operations/ID.md) standard.
{==+==}
"footer" (这是签名的一部分)将是一个UTF-8格式的JSON字符串，包括:
- `url` 符合RFC 3986标准的URL，cargo从那里得到config.json文件。
  - 如果这是有HTTP索引的注册中心，那么这就是所有索引查询相对的基本URL。
  - 如果这是有GIT索引的注册中心，它是Cargo用来克隆索引的URL。
- `kid` 用于签署请求的私钥的标识，使用[PASERK IDs](https://github.com/paseto-standard/paserk/blob/master/operations/ID.md) 标准。
{==+==}


{==+==}
PASETO includes the message that was signed, so the server does not have to reconstruct the exact string from the request in order to check the signature. The server does need to check that the signature is valid for the string in the PASETO and that the contents of that string matches the request.
If a claim should be expected for the request but is missing in the PASETO then the request must be rejected.
{==+==}
PASETO包括被签名的信息，因而服务器不必为了检查签名而从请求中重构确切字符串。
服务器需要检查签名比对PASETO中的字符串是否有效，以及该字符串的内容是否与请求相符。
如果该请求应该有一个声明，但在PASETO中没有，那么该请求必须被拒绝。
{==+==}


{==+==}
### credential-process
* Tracking Issue: [#8933](https://github.com/rust-lang/cargo/issues/8933)
* RFC: [#2730](https://github.com/rust-lang/rfcs/pull/2730)
{==+==}

{==+==}


{==+==}
The `credential-process` feature adds a config setting to fetch registry
authentication tokens by calling an external process.
{==+==}
`credential-process` 特性增加了一个配置设置，通过调用一个外部进程来获取注册中心认证令牌。
{==+==}


{==+==}
Token authentication is used by the [`cargo login`], [`cargo publish`],
[`cargo owner`], and [`cargo yank`] commands. Additionally, this feature adds
a new `cargo logout` command.
{==+==}
Token认证被 [`cargo login`] 、 [`cargo publish`] 、 [`cargo owner`] 和 [`cargo yank`] 命令所使用。此外，该特性增加新的 `cargo logout` 命令。
{==+==}


{==+==}
To use this feature, you must pass the `-Z credential-process` flag on the
command-line. Additionally, you must remove any current tokens currently saved
in the [`credentials` file] (which can be done with the new `logout` command).
{==+==}
要使用这个特性，你必须在命令行中传递 `-Z credential-process` 标志。
此外，你必须删除当前保存在 [`credentials` file] 中的任何当前令牌(这可以通过新的 `logout` 命令来完成)。
{==+==}


{==+==}
#### `credential-process` Configuration
{==+==}
#### `credential-process` 配置
{==+==}


{==+==}
To configure which process to run to fetch the token, specify the process in
the `registry` table in a [config file]:
{==+==}
要配置运行哪个进程来获取令牌，在 [config file] 的 `registry` 表中指定进程:
{==+==}


{==+==}
```toml
[registry]
credential-process = "/usr/bin/cargo-creds"
```
{==+==}

{==+==}


{==+==}
If you want to use a different process for a specific registry, it can be
specified in the `registries` table:
{==+==}
如果你想对一个特定的注册中心使用不同的进程，可以在 `registries` 表中指定。
{==+==}


{==+==}
```toml
[registries.my-registry]
credential-process = "/usr/bin/cargo-creds"
```
{==+==}

{==+==}


{==+==}
The value can be a string with spaces separating arguments or it can be a TOML
array of strings.
{==+==}
该值可以是用空格分隔参数的字符串，也可以是TOML字符串数组。
{==+==}


{==+==}
Command-line arguments allow special placeholders which will be replaced with
the corresponding value:
{==+==}
命令行参数允许特殊的占位符，这些占位符将被替换成相应的值:
{==+==}


{==+==}
* `{name}` — The name of the registry.
* `{api_url}` — The base URL of the registry API endpoints.
* `{action}` — The authentication action (described below).
{==+==}
* `{name}` — 注册中心的名称。
* `{api_url}` —  注册中心 API 端点的基本URL。
* `{action}` — 认证动作(如下所述)。
{==+==}


{==+==}
Process names with the prefix `cargo:` are loaded from the `libexec` directory
next to cargo. Several experimental credential wrappers are included with
Cargo, and this provides convenient access to them:
{==+==}
带有 `cargo:` 前缀的进程名称会从cargo下的 `libexec` 目录中加载。Cargo中包含了几个实验性的证书包装器，以提供对它们的便利访问:
{==+==}


{==+==}
```toml
[registry]
credential-process = "cargo:macos-keychain"
```
{==+==}

{==+==}


{==+==}
The current wrappers are:
{==+==}
目前的包装器是:
{==+==}


{==+==}
* `cargo:macos-keychain`: Uses the macOS Keychain to store the token.
* `cargo:wincred`: Uses the Windows Credential Manager to store the token.
{==+==}
* `cargo:macos-keychain`: 使用macOS Keychain来存储令牌。
* `cargo:wincred`: 使用Windows证书管理器来存储令牌。
{==+==}


{==+==}
* `cargo:1password`: Uses the 1password `op` CLI to store the token. You must
  install the `op` CLI from the [1password
  website](https://1password.com/downloads/command-line/). You must run `op
  signin` at least once with the appropriate arguments (such as `op signin
  my.1password.com user@example.com`), unless you provide the sign-in-address
  and email arguments. The master password will be required on each request
  unless the appropriate `OP_SESSION` environment variable is set. It supports
  the following command-line arguments:
  * `--account`: The account shorthand name to use.
  * `--vault`: The vault name to use.
  * `--sign-in-address`: The sign-in-address, which is a web address such as `my.1password.com`.
  * `--email`: The email address to sign in with.
{==+==}
* `cargo:1password`: 使用1password `op` CLI来存储令牌。你必须从 [1password 网站](https://1password.com/downloads/command-line/)安装 `op` CLI。你必须至少运行一次`op signin`，并加上适当的参数(如 `op signin my.1password.com user@example.com` )，除非你提供地址和电子邮件参数。除非设置了适当的 `OP_SESSION` 环境变量，否则每次请求时都需要主密码。它支持以下命令行参数。
  * `--account`: 使用的账户简写名称。
  * `--vault`:  使用的保险名称。
  * `--sign-in-address`: 登录地址，是一个网址，如 `my.1password.com` 。
  * `--email`: 用来登录的电子邮件地址。
{==+==}


{==+==}
A wrapper is available for GNOME
[libsecret](https://wiki.gnome.org/Projects/Libsecret) to store tokens on
Linux systems. Due to build limitations, this wrapper is not available as a
pre-compiled binary. This can be built and installed manually. First, install
libsecret using your system package manager (for example, `sudo apt install
libsecret-1-dev`). Then build and install the wrapper with `cargo install
cargo-credential-gnome-secret`.
In the config, use a path to the binary like this:
{==+==}
GNOME [libsecret](https://wiki.gnome.org/Projects/Libsecret) 有包装器，可以在Linux系统上存储令牌。由于构建的限制，这个包装器不能作为预编译的二进制文件使用。
这可以手动构建和安装。首先，使用你的系统包管理器安装 libsecret (例如，`sudo apt install libsecret-1-dev`)。
然后用`cargo install cargo-credential-gnome-secret` 构建并安装包装器。在配置中，使用二进制文件的路径，如下所示:
{==+==}


{==+==}
```toml
[registry]
credential-process = "cargo-credential-gnome-secret {action}"
```
{==+==}

{==+==}


{==+==}
#### `credential-process` Interface
{==+==}
#### `credential-process` 接口
{==+==}


{==+==}
There are two different kinds of token processes that Cargo supports. The
simple "basic" kind will only be called by Cargo when it needs a token. This
is intended for simple and easy integration with password managers, that can
often use pre-existing tooling. The more advanced "Cargo" kind supports
different actions passed as a command-line argument. This is intended for more
pleasant integration experience, at the expense of requiring a Cargo-specific
process to glue to the password manager. Cargo will determine which kind is
supported by the `credential-process` definition. If it contains the
`{action}` argument, then it uses the advanced style, otherwise it assumes it
only supports the "basic" kind.
{==+==}
Cargo支持两种不同的token进程。简单的 "basic" 类型只在Cargo需要令牌时才会被调用。
这是为了与密码管理器进行简单而方便的集成，通常可以使用已有的工具。
更高级的 "Cargo" 类型支持作为命令行参数传递的不同动作。
这样做的目的是为了获得更好的集成体验，代价是需要一个Cargo特定的进程来粘合到密码管理器上。
Cargo会根据 "credential-process" 的定义来决定支持哪种类型。
如果它包含 `{action}` 参数，那么它就会使用高级样式，否则它就假定它只支持 "basic" 样式。
{==+==}


{==+==}
##### Basic authenticator
{==+==}
##### 基础认证器
{==+==}


{==+==}
A basic authenticator is a process that returns a token on stdout. Newlines
will be trimmed. The process inherits the user's stdin and stderr. It should
exit 0 on success, and nonzero on error.
{==+==}
基础认证器是在stdout上返回一个令牌的进程。新行将被修整。该进程继承了用户的 stdin 和 stderr 。它应在成功时退出0，在错误时退出非零。
{==+==}


{==+==}
With this form, [`cargo login`] and `cargo logout` are not supported and
return an error if used.
{==+==}
在这种形式下，不支持 [`cargo login`] 和 `cargo logout` ，如果使用，会返回一个错误。
{==+==}


{==+==}
##### Cargo authenticator
{==+==}
##### Cargo认证器
{==+==}


{==+==}
The protocol between the Cargo and the process is very basic, intended to
ensure the credential process is kept as simple as possible. Cargo will
execute the process with the `{action}` argument indicating which action to
perform:
{==+==}
Cargo和进程之间的协议是非常基本的，目的是确保认证过程尽可能简单。
Cargo将执行进程，其 `{action}` 参数表明要执行的动作。
{==+==}


{==+==}
* `store` — Store the given token in secure storage.
* `get` — Get a token from storage.
* `erase` — Remove a token from storage.
{==+==}
* `store` — 将给定令牌可靠存储。
* `get` —从存储中获取令牌。
* `erase` — 从存储中移除令牌。
{==+==}


{==+==}
The `cargo login` command uses `store` to save a token. Commands that require
authentication, like `cargo publish`, uses `get` to retrieve a token. `cargo
logout` uses the `erase` command to remove a token.
{==+==}
`cargo login` 命令使用 `store` 来保存令牌。需要认证的命令，如 `cargo publish` ，使用 `get` 检索令牌。 `cargo logout` 使用 `erase` 命令来删除令牌。
{==+==}


{==+==}
The process inherits the user's stderr, so the process can display messages.
Some values are passed in via environment variables (see below). The expected
interactions are:
{==+==}
进程继承了用户的stderr，所以进程可以显示信息。
有些值是通过环境变量传递进来(见下文)。预期的交互作用是:
{==+==}


{==+==}
* `store` — The token is sent to the process's stdin, terminated by a newline.
  The process should store the token keyed off the registry name. If the
  process fails, it should exit with a nonzero exit status.
{==+==}
* `store` — 令牌被发送到进程的stdin中，以换行结束。进程应该根据注册中心的名称来存储令牌。如果进程失败，它应该以非零的退出状态退出。
{==+==}


{==+==}
* `get` — The process should send the token to its stdout (trailing newline
  will be trimmed). The process inherits the user's stdin, should it need to
  receive input.
{==+==}
* `get` — 进程应将令牌发送到其stdout(尾部的换行将被修整)。进程继承用户的stdin，如果它需要接收输入的话。
{==+==}


{==+==}
  If the process is unable to fulfill the request, it should exit with a
  nonzero exit code.
{==+==}
  如果进程无法完成请求，它应该以非零退出代码退出。
{==+==}


{==+==}
* `erase` — The process should remove the token associated with the registry
  name. If the token is not found, the process should exit with a 0 exit
  status.
{==+==}
* `erase` — 该进程应该删除与注册中心名称相关联的令牌。如果没有找到令牌，进程应该以0状态退出。
{==+==}


{==+==}
##### Environment

The following environment variables will be provided to the executed command:
{==+==}
##### 环境

以下环境变量提供给被执行的命令:
{==+==}


{==+==}
* `CARGO` — Path to the `cargo` binary executing the command.
* `CARGO_REGISTRY_INDEX_URL` — The URL of the registry index.
* `CARGO_REGISTRY_NAME_OPT` — Optional name of the registry. Should not be used as a storage key. Not always available.
{==+==}
* `CARGO` — 执行命令的 `cargo` 二进制文件的路径。
* `CARGO_REGISTRY_INDEX_URL` — 注册中心索引的URL。
* `CARGO_REGISTRY_NAME_OPT` — 注册中心的可选名称。不应作为存储键使用。并不总是可用的。
{==+==}


{==+==}
#### `cargo logout`

A new `cargo logout` command has been added to make it easier to remove a
token from storage. This supports both [`credentials` file] tokens and
`credential-process` tokens.
{==+==}
#### `cargo logout`

增加新的 `cargo logout` 命令，使其更容易从存储中删除令牌。这同时支持 [`credentials` file] 令牌和 `credential-process` 令牌。
{==+==}


{==+==}
When used with `credentials` file tokens, it needs the `-Z unstable-options`
command-line option:
{==+==}
当与 `credentials` 文件令牌一起使用时，它需要 `-Z unstable-options` 命令行选项:
{==+==}


{==+==}
```console
cargo logout -Z unstable-options
```
{==+==}

{==+==}


{==+==}
When used with the `credential-process` config, use the `-Z
credential-process` command-line option:
{==+==}
当与 `credential-process` 配置一起使用时，使用 `-Z credential-process` 命令行选项:
{==+==}


{==+==}
```console
cargo logout -Z credential-process
```
{==+==}

{==+==}


{==+==}
[`cargo login`]: ../commands/cargo-login.md
[`cargo publish`]: ../commands/cargo-publish.md
[`cargo owner`]: ../commands/cargo-owner.md
[`cargo yank`]: ../commands/cargo-yank.md
[`credentials` file]: config.md#credentials
[crates.io]: https://crates.io/
[config file]: config.md
{==+==}

{==+==}


{==+==}
### `cargo config`

* Original Issue: [#2362](https://github.com/rust-lang/cargo/issues/2362)
* Tracking Issue: [#9301](https://github.com/rust-lang/cargo/issues/9301)
{==+==}

{==+==}


{==+==}
The `cargo config` subcommand provides a way to display the configuration
files that cargo loads. It currently includes the `get` subcommand which
can take an optional config value to display.
{==+==}
`cargo config` 子命令提供了一种显示cargo加载的配置文件的方法。
它目前包括 `get` 子命令，可以接受可选的配置文件来显示。
{==+==}


{==+==}
```console
cargo +nightly -Zunstable-options config get build.rustflags
```
{==+==}

{==+==}


{==+==}
If no config value is included, it will display all config values. See the
`--help` output for more options available.
{==+==}
如果不包含配置值，它将显示所有的配置值。参见 `--help` 输出，了解更多可用的选项。
{==+==}


{==+==}
### `doctest-in-workspace`

* Tracking Issue: [#9427](https://github.com/rust-lang/cargo/issues/9427)
{==+==}

{==+==}


{==+==}
The `-Z doctest-in-workspace` flag changes the behavior of the current working
directory used when running doctests. Historically, Cargo has run `rustdoc
--test` relative to the root of the package, with paths relative from that
root. However, this is inconsistent with how `rustc` and `rustdoc` are
normally run in a workspace, where they are run relative to the workspace
root. This inconsistency causes problems in various ways, such as when passing
RUSTDOCFLAGS with relative paths, or dealing with diagnostic output.
{==+==}
`-Z doctest-in-workspace` 标志改变了运行文档测试时使用的当前工作目录的行为。
曾经，Cargo运行 `rustdoc --test` 时是相对于包的根目录，路径相对于根目录。
然而，这与 `rustc` 和 `rustdoc` 在工作空间的正常运行方式不一致，它们是相对于工作空间根目录运行。
这种不一致会导致各种问题，比如在传递 RUSTDOCFLAGS 时，使用相对路径，或者处理诊断输出。
{==+==}


{==+==}
The `-Z doctest-in-workspace` flag causes cargo to switch to running `rustdoc`
from the root of the workspace. It also passes the `--test-run-directory` to
`rustdoc` so that when *running* the tests, they are run from the root of the
package. This preserves backwards compatibility and is consistent with how
normal unittests are run.
{==+==}
`-Z doctest-in-workspace` 标志使cargo切换到从工作空间的根运行 `rustdoc` 。
它还将 `--test-run-directory` 传递给 `rustdoc` ，以便在*运行*测试时，从包的根目录运行。
这保留了向后的兼容性，并且与正常的单元测试的运行方式一致。
{==+==}


{==+==}
### rustc `--print`

* Tracking Issue: [#9357](https://github.com/rust-lang/cargo/issues/9357)
{==+==}

{==+==}


{==+==}
`cargo rustc --print=VAL` forwards the `--print` flag to `rustc` in order to
extract information from `rustc`. This runs `rustc` with the corresponding
[`--print`](https://doc.rust-lang.org/rustc/command-line-arguments.html#--print-print-compiler-information)
flag, and then immediately exits without compiling. Exposing this as a cargo
flag allows cargo to inject the correct target and RUSTFLAGS based on the
current configuration.
{==+==}
`cargo rustc --print=VAL` 将 `--print` 标志转发给 `rustc` ，以便从 `rustc` 中提取信息。
在运行 `rustc` 时，会有相应的 [`--print`](https://doc.rust-lang.org/rustc/command-line-arguments.html#--print-print-compiler-information) 标志，
然后立即退出，不进行编译。将其作为cargo标志暴露，允许cargo根据当前配置注入正确的目标和RUSTFLAGS。
{==+==}


{==+==}
The primary use case is to run `cargo rustc --print=cfg` to get config values
for the appropriate target and influenced by any other RUSTFLAGS.
{==+==}
主要的使用情况是运行 `cargo rustc --print=cfg` 来获得相应目标的配置值，并受到任何其他RUSTFLAGS的影响。 
{==+==}


{==+==}
### Different binary name
{==+==}
### 不同的二进制名称
{==+==}


{==+==}
* Tracking Issue: [#9778](https://github.com/rust-lang/cargo/issues/9778)
* PR: [#9627](https://github.com/rust-lang/cargo/pull/9627)
{==+==}

{==+==}


{==+==}
The `different-binary-name` feature allows setting the filename of the binary without having to obey the
restrictions placed on crate names. For example, the crate name must use only `alphanumeric` characters
or `-` or `_`, and cannot be empty.
{==+==}
`different-binary-name` 特性允许设置二进制文件的文件名，而不必遵守对crate名称的限制。比如，crate名称只能使用 `alphanumeric` 字符或 `-` 或 `_` ，并且不能为空。
{==+==}


{==+==}
The `filename` parameter should **not** include the binary extension, `cargo` will figure out the appropriate
extension and use that for the binary on its own.
{==+==}
`filename` 参数 **不** 包含二进制扩展名，`cargo` 将计算出适当的扩展名并将其用于二进制文件。
{==+==}


{==+==}
The `filename` parameter is only available in the `[[bin]]` section of the manifest.
{==+==}
参数 `filename` 只在配置清单的 `[[bin]]` 部分可用。
{==+==}


{==+==}
```toml
cargo-features = ["different-binary-name"]

[package]
name =  "foo"
version = "0.0.1"

[[bin]]
name = "foo"
filename = "007bar"
path = "src/main.rs"
```
{==+==}

{==+==}


{==+==}
### scrape-examples
{==+==}

{==+==}


{==+==}
* RFC: [#3123](https://github.com/rust-lang/rfcs/pull/3123)
* Tracking Issue: [#9910](https://github.com/rust-lang/cargo/issues/9910)
{==+==}

{==+==}


{==+==}
The `-Z rustdoc-scrape-examples` flag tells Rustdoc to search crates in the current workspace
for calls to functions. Those call-sites are then included as documentation. You can use the flag
like this:
{==+==}
`-Z rustdoc-scrape-examples` 标志告诉 Rustdoc 在当前工作空间中搜索crate的函数调用。
然后，这些调用点会被包含在文档中。你可以像这样使用该标志:
{==+==}


{==+==}
```
cargo doc -Z unstable-options -Z rustdoc-scrape-examples
```
{==+==}

{==+==}


{==+==}
By default, Cargo will scrape examples from the example targets of packages being documented. 
You can individually enable or disable targets from being scraped with the `doc-scrape-examples` flag, such as:
{==+==}
默认情况下，Cargo会从记录的包的例子目标中抓取实例。
你可以用 `doc-scrape-examples` 标志单独启用或禁用目标，例如:
{==+==}


{==+==}
```toml
# Enable scraping examples from a library
[lib]
doc-scrape-examples = true

# Disable scraping examples from an example target
[[example]]
name = "my-example"
doc-scrape-examples = false
```
{==+==}
```toml
# 启用从库中抓取实例
[lib]
doc-scrape-examples = true

# 禁用从实例目标中抓取实例
[[example]]
name = "my-example"
doc-scrape-examples = false
```
{==+==}


{==+==}
**Note on tests:** enabling `doc-scrape-examples` on test targets will not currently have any effect. Scraping
examples from tests is a work-in-progress.
{==+==}
**关于测试的说明:** 在测试目标上启用 `doc-scrape-examples` 目前没有任何效果。从测试中抓取例子是一项正在进行的工作。
{==+==}


{==+==}
**Note on dev-dependencies:** documenting a library does not normally require the crate's dev-dependencies. However,
example targets require dev-deps. For backwards compatibility, `-Z rustdoc-scrape-examples` will *not* introduce a 
dev-deps requirement for `cargo doc`. Therefore examples will *not* be scraped from example targets under the 
following conditions:
{==+==}
**关于dev-依赖的说明:** 记录库通常不需要crate的dev-依赖。然而，示例目标需要dev-依赖。
为了向后兼容， `-Z rustdoc-scrape-examples` 将*不*为 `cargo doc` 引入dev-依赖要求。
因此，在以下情况下，将 *不会* 从示例目标中抓取示例:
{==+==}


{==+==}
1. No target being documented requires dev-deps, AND
2. At least one crate with targets being documented has dev-deps, AND
3. The `doc-scrape-examples` parameter is unset or false for all `[[example]]` targets.
{==+==}
1. 没有被记录的目标需要dev-依赖, AND
2. 至少有一个目标被记录的crate有dev-依赖, AND
3. 对于所有 `[[example]]` 目标，`doc-scrape-examples` 参数未设置或为假。
{==+==}


{==+==}
If you want examples to be scraped from example targets, then you must not satisfy one of the above conditions.
For example, you can set `doc-scrape-examples` to true for one example target, and that signals to Cargo that
you are ok with dev-deps being build for `cargo doc`.
{==+==}
如果你想让实例从实例目标中被抓取，那么你必须不满足上述条件之一。
例如，你可以为一个例子目标设置 `doc-scrape-examples` 为 true，这就向Cargo发出信号，你可以为 `cargo doc` 建立dev-依赖。
{==+==}


{==+==}
### check-cfg

* RFC: [#3013](https://github.com/rust-lang/rfcs/pull/3013)
* Tracking Issue: [#10554](https://github.com/rust-lang/cargo/issues/10554)
{==+==}

{==+==}


{==+==}
`-Z check-cfg` command line enables compile time checking of name and values in `#[cfg]`, `cfg!`,
`#[link]` and `#[cfg_attr]` with the `rustc` and `rustdoc` unstable `--check-cfg` command line.
{==+==}
`-Z check-cfg` 命令行可以在编译时检查 `#[cfg]` 、 `cfg!` 中的名称和值。
`#[link]` 和 `#[cfg_attr]` 中的名称和值，使用 `rustc` 和 `rustdoc` 不稳定的 `--check-cfg` 命令行。
{==+==}


{==+==}
It's values are:
 - `features`: enables features checking via `--check-cfg=values(feature, ...)`.
    Note than this command line options will probably become the default when stabilizing.
 - `names`: enables well known names checking via `--check-cfg=names()`.
 - `values`: enables well known values checking via `--check-cfg=values()`.
 - `output`: enable the use of `rustc-check-cfg` in build script.
{==+==}
它的值是:
 - `features`: 通过 `--check-cfg=values(feature, ...)` 启用特性检查。
    注意这个命令行选项可能会成为稳定时的默认选项。
 - `names`: 通过 `--check-cfg=names()` 实现众所周知的名称检查。
 - `values`: 通过 `--check-cfg=values()` 实现众所周知的值检查。
 - `output`: 启用构建脚本中的 `rustc-check-cfg` 。
{==+==}


{==+==}
For instance:
{==+==}
例如:
{==+==}


{==+==}
```
cargo check -Z unstable-options -Z check-cfg=features
cargo check -Z unstable-options -Z check-cfg=names
cargo check -Z unstable-options -Z check-cfg=values
cargo check -Z unstable-options -Z check-cfg=features,names,values
```
{==+==}

{==+==}


{==+==}
Or for `output`:
{==+==}

{==+==}


{==+==}
```rust,no_run
// build.rs
println!("cargo:rustc-check-cfg=names(foo, bar)");
```
{==+==}

{==+==}


{==+==}
```
cargo check -Z unstable-options -Z check-cfg=output
```
{==+==}

{==+==}


{==+==}
### `cargo:rustc-check-cfg=CHECK_CFG`
{==+==}

{==+==}


{==+==}
The `rustc-check-cfg` instruction tells Cargo to pass the given value to the
`--check-cfg` flag to the compiler. This may be used for compile-time
detection of unexpected conditional compilation name and/or values.
{==+==}
`rustc-check-cfg` 指令告诉Cargo将给定的值传递给编译器 `--check-cfg` 标志。
这可用于编译时检测意外的条件编译名称或值。
{==+==}


{==+==}
This can only be used in combination with `-Zcheck-cfg=output` otherwise it is ignored
with a warning.
{==+==}
这只能与 `-Zcheck-cfg=output` 结合使用，否则会被忽略并发出警告。
{==+==}


{==+==}
If you want to integrate with Cargo features, use `-Zcheck-cfg=features` instead of
trying to do it manually with this option.
{==+==}
如果你想集成Cargo的特性，请使用 `-Zcheck-cfg=features` ，而不是试图用这个选项手动完成。
{==+==}


{==+==}
## Stabilized and removed features
{==+==}
## 稳定和删除特性
{==+==}


{==+==}
### Compile progress
{==+==}
### 编译进度
{==+==}


{==+==}
The compile-progress feature has been stabilized in the 1.30 release.
Progress bars are now enabled by default.
See [`term.progress`](config.md#termprogresswhen) for more information about
controlling this feature.
{==+==}
编译进度功能在1.30版本中得到了稳定。进度条现在是默认启用的。
参见 [`term.progress`](config.md#termprogresswhen) 了解更多关于控制该特性的信息。
{==+==}


{==+==}
### Edition
{==+==}
### 版次
{==+==}


{==+==}
Specifying the `edition` in `Cargo.toml` has been stabilized in the 1.31 release.
See [the edition field](manifest.md#the-edition-field) for more information
about specifying this field.
{==+==}
在 `Cargo.toml` 中指定 `edition` 已在1.31版本中得到稳定。
请参阅 [the edition field](manifest.md#the-edition-field) 以了解有关指定该字段的更多信息。
{==+==}


{==+==}
### rename-dependency
{==+==}
### 重命名依赖
{==+==}


{==+==}
Specifying renamed dependencies in `Cargo.toml` has been stabilized in the 1.31 release.
See [renaming dependencies](specifying-dependencies.md#renaming-dependencies-in-cargotoml)
for more information about renaming dependencies.
{==+==}
在 `Cargo.toml` 中指定重命名依赖，在1.31版本中已经稳定。
参见 [renaming dependencies](specifying-dependencies.md#renaming-dependencies-in-cargotoml) 了解更多关于重命名依赖的信息。
{==+==}


{==+==}
### Alternate Registries
{==+==}
### 备用注册中心
{==+==}


{==+==}
在1.34版本中，对备用注册中心的支持已经稳定下来了。
请参阅 [Registries chapter](registries.md) 了解更多关于备用注册中心的信息。
{==+==}

{==+==}


{==+==}
### Offline Mode
{==+==}
### 脱机模式
{==+==}


{==+==}
The offline feature has been stabilized in the 1.36 release.
See the [`--offline` flag](../commands/cargo.md#option-cargo---offline) for
more information on using the offline mode.
{==+==}
脱机功能在1.36版本中已经稳定下来了。
参见 [`--offline` flag](../commands/cargo.md#option-cargo---offline)，了解更多关于使用脱机模式的信息。
{==+==}


{==+==}
### publish-lockfile
{==+==}
### 发表锁定文件
{==+==}


{==+==}
The `publish-lockfile` feature has been removed in the 1.37 release.
The `Cargo.lock` file is always included when a package is published if the
package contains a binary target. `cargo install` requires the `--locked` flag
to use the `Cargo.lock` file.
See [`cargo package`](../commands/cargo-package.md) and
[`cargo install`](../commands/cargo-install.md) for more information.
{==+==}
1.37版本中删除了 `publish-lockfile` 功能。如果包包含二进制目标，则在发布包时总是包括 `Cargo.lock` 文件。 `cargo install` 需要 `--locked` 标志来使用 `Cargo.lock` 文件。
更多信息见 [`cargo package`](../commands/cargo-package.md) 和 [`cargo install`](../commands/cargo-install.md) 。
{==+==}


{==+==}
### default-run
{==+==}
### 默认运行
{==+==}


{==+==}
The `default-run` feature has been stabilized in the 1.37 release.
See [the `default-run` field](manifest.md#the-default-run-field) for more
information about specifying the default target to run.
{==+==}
`default-run` 功能在1.37版本中已经稳定下来。参见 [the `default-run'field](manifest.md#the-default-run-field) 以了解更多关于指定默认运行目标的信息。
{==+==}


{==+==}
### cache-messages
{==+==}
### 缓存信息
{==+==}


{==+==}
Compiler message caching has been stabilized in the 1.40 release.
Compiler warnings are now cached by default and will be replayed automatically
when re-running Cargo.
{==+==}
编译器信息缓存在1.40版本中得到了稳定。编译器警告现在被默认缓存，并在重新运行Cargo时自动回放。
{==+==}


{==+==}
### install-upgrade
{==+==}
### 安装升级
{==+==}


{==+==}
The `install-upgrade` feature has been stabilized in the 1.41 release.
[`cargo install`] will now automatically upgrade packages if they appear to be
out-of-date. See the [`cargo install`] documentation for more information.
{==+==}
 `install-upgrade` 特性在1.41版本中得到了稳定。[`cargo install`]现在会在包出现过期时自动升级。更多信息请参见 [`cargo install`] 文档。
{==+==}


{==+==}
[`cargo install`]: ../commands/cargo-install.md
{==+==}

{==+==}


{==+==}
### Profile Overrides
{==+==}
### Profile覆盖
{==+==}


{==+==}
Profile overrides have been stabilized in the 1.41 release.
See [Profile Overrides](profiles.md#overrides) for more information on using
overrides.
{==+==}
Profile 覆盖已经在1.41版本中得到稳定。请参阅[Profile Overrides](profiles.md#overrides)以了解更多关于使用覆盖的信息。
{==+==}


{==+==}
### Config Profiles
{==+==}
### Config Profiles
{==+==}


{==+==}
Specifying profiles in Cargo config files and environment variables has been
stabilized in the 1.43 release.
See the [config `[profile]` table](config.md#profile) for more information
about specifying [profiles](profiles.md) in config files.
{==+==}
在Cargo 配置文件和环境变量中指定配置文件的做法在1.43版本中已经稳定下来。
参见 [config `[profile]` table](config.md#profile) 以了解更多关于在配置文件中指定 [profile](profiles.md) 的信息。
{==+==}


{==+==}
### crate-versions
{==+==}
### crate版本
{==+==}


{==+==}
The `-Z crate-versions` flag has been stabilized in the 1.47 release.
The crate version is now automatically included in the
[`cargo doc`](../commands/cargo-doc.md) documentation sidebar.
{==+==}
`-Z crate-versions` 标志在1.47版本中已经稳定。
crate版本现在自动包含在 [`cargo doc`](../commands/cargo-doc.md) 文档中。
{==+==}


{==+==}
### Features
{==+==}
### 特性
{==+==}


{==+==}
The `-Z features` flag has been stabilized in the 1.51 release.
See [feature resolver version 2](features.md#feature-resolver-version-2)
for more information on using the new feature resolver.
{==+==}
在1.51版本中，`-Z features` 标志已经稳定下来。参见 [feature resolver version 2](feature.md#feature-resolver-version-2) 以了解更多关于使用新特性解析器的信息。
{==+==}


{==+==}
### package-features
{==+==}
### 包特性
{==+==}


{==+==}
The `-Z package-features` flag has been stabilized in the 1.51 release.
See the [resolver version 2 command-line flags](features.md#resolver-version-2-command-line-flags)
for more information on using the features CLI options.
{==+==}
`-Z package-features` 标志在1.51版本中已经稳定了。
参见 [resolver version 2 command-line flags](features.md#resolver-version-2command-line-flags) 以了解更多关于使用特性 CLI 选项的信息。
{==+==}


{==+==}
### Resolver
{==+==}
### 解析器
{==+==}


{==+==}
The `resolver` feature in `Cargo.toml` has been stabilized in the 1.51 release.
See the [resolver versions](resolver.md#resolver-versions) for more
information about specifying resolvers.
{==+==}
`Cargo.toml` 中的 `Cargo.toml` 特性在1.51版本中已经稳定。
请参阅 [resolver versions](resolver.md#resolver-versions) 以了解有关指定解析器的更多信息。
{==+==}


{==+==}
### extra-link-arg
{==+==}

{==+==}


{==+==}
The `extra-link-arg` feature to specify additional linker arguments in build
scripts has been stabilized in the 1.56 release. See the [build script
documentation](build-scripts.md#outputs-of-the-build-script) for more
information on specifying extra linker arguments.
{==+==}
在1.56版本中，用于在构建脚本中指定额外链接器参数的 `extra-link-arg` 功能已经稳定了。
请参阅 [build script documentation](build-scripts.md#outputs-the-build-script) 以了解更多关于指定额外链接器参数的信息。
{==+==}


{==+==}
### configurable-env
{==+==}

{==+==}


{==+==}
The `configurable-env` feature to specify environment variables in Cargo
configuration has been stabilized in the 1.56 release. See the [config
documentation](config.html#env) for more information about configuring
environment variables.
{==+==}
在Cargo配置中指定环境变量的 `configurable-env` 功能在1.56版本中已经稳定下来。
关于配置环境变量的更多信息，请参见 [config documentation](config.html#env) 。
{==+==}


{==+==}
### rust-version
{==+==}

{==+==}


{==+==}
The `rust-version` field in `Cargo.toml` has been stabilized in the 1.56 release.
See the [rust-version field](manifest.html#the-rust-version-field) for more
information on using the `rust-version` field and the `--ignore-rust-version` option.
{==+==}
`Cargo.toml` 中的 `rust-version` 字段在1.56版本中已经稳定。
请参阅 [rust-version field](manifest.html#the-rust-version-field) 以了解更多关于使用 `rust-version` 字段和 `-ignore-rust-version` 选项的信息。
{==+==}


{==+==}
### codegen-backend
{==+==}

{==+==}


{==+==}
The `codegen-backend` feature makes it possible to select the codegen backend used by rustc using a
profile.
{==+==}
`codegen-backend` 特性使我们有可能使用配置文件来选择rustc使用的codegen后端。
{==+==}


{==+==}
Example:

```toml
[package]
name = "foo"

[dependencies]
serde = "1.0.117"

[profile.dev.package.foo]
codegen-backend = "cranelift"
```
{==+==}

{==+==}


{==+==}
### patch-in-config
{==+==}

{==+==}


{==+==}
The `-Z patch-in-config` flag, and the corresponding support for
`[patch]` section in Cargo configuration files has been stabilized in
the 1.56 release. See the [patch field](config.html#patch) for more
information.
{==+==}
`-Z patch-in-config` 标志，以及对Cargo配置文件中 `[patch]` 部分的相应支持，在1.56版本中已经稳定下来。更多信息请参见 [patch field](config.html#patch) 。
{==+==}


{==+==}
### edition 2021
{==+==}

{==+==}


{==+==}
The 2021 edition has been stabilized in the 1.56 release.
See the [`edition` field](manifest.md#the-edition-field) for more information on setting the edition.
See [`cargo fix --edition`](../commands/cargo-fix.md) and [The Edition Guide](../../edition-guide/index.html) for more information on migrating existing projects.
{==+==}
2021 版次在1.56版本中已经稳定下来了。
参见[`edition` field](manifest.md#the-edition-field)，了解更多关于设置版次的信息。
参见[`cargo fix --edition`](.../commands/cargo-fix.md)和[The Edition Guide](.../.../edition-guide/index.html)了解更多关于迁移现有项目的信息。
{==+==}


{==+==}
### Custom named profiles
{==+==}
### 自定义命名的配置文件
{==+==}


{==+==}
Custom named profiles have been stabilized in the 1.57 release. See the
[profiles chapter](profiles.md#custom-profiles) for more information.
{==+==}
自定义命名的配置文件已经在1.57版本中得到稳定。请参阅 [profiles chapter](profiles.md#custom-profiles) 了解更多信息。
{==+==}


{==+==}
### Profile `strip` option
{==+==}

{==+==}


{==+==}
The profile `strip` option has been stabilized in the 1.59 release. See the
[profiles chapter](profiles.md#strip) for more information.
{==+==}
配置文件 `strip` 选项在1.59版本中已经稳定了。更多信息请参见 [profiles chapter](profiles.md#strip) 。
{==+==}


{==+==}
### Future incompat report
{==+==}
### 未来不兼容报告
{==+==}


{==+==}
Support for generating a future-incompat report has been stabilized
in the 1.59 release. See the [future incompat report chapter](future-incompat-report.md)
for more information.
{==+==}
在1.59版本中，对生成未来不兼容报告的支持已经稳定下来了。
更多信息请参见 [future incompat report chapter](future-incompat-report.md)。
{==+==}


{==+==}
### Namespaced features
{==+==}
### 名称空间特性
{==+==}


{==+==}
Namespaced features has been stabilized in the 1.60 release.
See the [Features chapter](features.md#optional-dependencies) for more information.
{==+==}
在1.60版本中，名称空间特性已经稳定下来了。
更多信息请参见[Features chapter](features.md#optional-dependencies)。
{==+==}


{==+==}
### Weak dependency features
{==+==}
### 弱依赖性特性
{==+==}


{==+==}
Weak dependency features has been stabilized in the 1.60 release.
See the [Features chapter](features.md#dependency-features) for more information.
{==+==}
弱依赖性特性在1.60版本中已经稳定下来。
更多信息请参见[Features chapter](features.md#dependency-features)。
{==+==}


{==+==}
### timings
{==+==}

{==+==}


{==+==}
The `-Ztimings` option has been stabilized as `--timings` in the 1.60 release.
(`--timings=html` and the machine-readable `--timings=json` output remain
unstable and require `-Zunstable-options`.)
{==+==}
`-Ztimings` 选项在1.60版本中已经稳定为 `--timings` 。
( `--timings=html` 和机器可读的 `--timings=json` 输出仍然不稳定，需要 `--Zunstable-options` 。)
{==+==}


{==+==}
### config-cli
{==+==}

{==+==}


{==+==}
The `--config` CLI option has been stabilized in the 1.63 release. See
the [config documentation](config.html#command-line-overrides) for more
information.
{==+==}
`--config` CLI选项在1.63版本中已经稳定。更多信息请参见 [config documentation](config.html#command-line-overrides)。
{==+==}


{==+==}
### multitarget
{==+==}

{==+==}


{==+==}
The `-Z multitarget` option has been stabilized in the 1.64 release.
See [`build.target`](config.md#buildtarget) for more information about
setting the default target platform triples.
{==+==}
`-Z multitarget` 选项在1.64版本中已经稳定了。参见 [`build.target`](config.md#buildtarget) 以了解更多关于设置默认目标平台三元组的信息。
{==+==}


{==+==}
### crate-type
{==+==}

{==+==}


{==+==}
The `--crate-type` flag for `cargo rustc` has been stabilized in the 1.64
release. See the [`cargo rustc` documentation](../commands/cargo-rustc.md)
for more information.
{==+==}
在1.64版本中，`cargo rustc` 的 `--crate-type` 标志已经稳定。更多信息请参见 [`cargo rustc` documentation](../commands/cargo-rustc.md) 。
{==+==}


{==+==}
### Workspace Inheritance
{==+==}
### 工作空间继承
{==+==}


{==+==}
Workspace Inheritance has been stabilized in the 1.64 release.
See [workspace.package](workspaces.md#the-package-table),
[workspace.dependencies](workspaces.md#the-dependencies-table),
and [inheriting-a-dependency-from-a-workspace](specifying-dependencies.md#inheriting-a-dependency-from-a-workspace)
for more information.
{==+==}
工作空间继承在1.64版本中得到了稳定。
参见 [workspace.package](workspaces.md#the-package-table),[workspace.dependencies](workspaces.md#the-dependencies-table),和 [inheriting-a-dependency-from-a-workspace](specifying-dependencies.md#inheriting-a-dependency-from-a-workspace) 获得更多信息。
{==+==}


{==+==}
### terminal-width
{==+==}

{==+==}


{==+==}
The `-Z terminal-width` option has been stabilized in the 1.68 release.
The terminal width is always passed to the compiler when running from a
terminal where Cargo can automatically detect the width.
{==+==}
在1.68版本中， `-Z terminal-width` 选项已经稳定了。当从Cargo可以自动检测宽度的终端运行时，终端宽度总是被传递给编译器。
{==+==}