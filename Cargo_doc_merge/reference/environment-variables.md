## 环境变量

Cargo设置和读取一些环境变量，你的代码可以检测或覆盖这些变量。
下面是Cargo设置的变量列表，按照与之交互的时间次序排列:

### Cargo读取环境变量

你可以覆盖这些环境变量来改变Cargo所在系统中的行为:

* `CARGO_LOG` - Cargo 使用 [`env_logger`] crate 来显示调试日志信息。
  `CARGO_LOG` 环境变量可以设置为启用调试日志，其值为 `trace` 、 `debug` 或 `warn` 。
  通常，其只在调试时使用。更多细节请参考[Debug logging]。
* `CARGO_HOME` — Cargo 维护着注册中心索引和git签出crate的本地缓存。
  默认情况下，这些数据存储在 `$HOME/.cargo` 下(Windows下为 `%USERPROFILE%\.cargo`)，但这个变量可以覆盖这个目录位置。
  一旦crate被缓存，就不会被clean命令删除。
  更多细节请参考[指南](.../guide/cargo-home.md)。
* `CARGO_TARGET_DIR` — 放置所有生成制品的位置，相对于当前工作目录。见[`build.target-dir`]通过配置来设置。
* `CARGO` - 如果设置了这个变量，Cargo在构建crate以及执行构建脚本和外部子命令时，将转发这个值，而不是设置为自己的自动检测路径。
  这个值不会被Cargo直接执行，它应该总是指向一个行为与 `cargo` 完全相同的命令，因为这也是使用该变量的用户所期望的。
* `RUSTC` — Cargo将执行这个指定的编译器，而不是运行 `rustc` 。见[`build.rustc`]通过配置来设置。
* `RUSTC_WRAPPER` — Cargo将执行这个指定的包装器，而不是简单地运行 `rustc` ，将rustc的调用作为其命令行参数，第一个参数是实际rustc的路径。
  这对设置构建缓存工具(如 `sccache`)很有用。见 [`build.rustc-wrapper`] 通过配置来设置。
  将其设置为空字符串会覆盖配置，并将crate重置为不使用包装器。
* `RUSTC_WORKSPACE_WRAPPER` — 对于工作空间成员，Cargo将执行这个指定的包装器，而不是简单地运行 `rustc`，将rustc的调用作为其命令行参数，第一个参数是实际rustc的路径。
  它影响文件名hash，以便单独缓存包装器产生制品。参见 [`build.rustc-workspace-wrapper`] 通过配置来设置。
  将其设置为空字符串会覆盖配置，并将crate重置为不对工作空间成员使用包装器。
* `RUSTDOC` — Cargo将执行这个指定的 `rustdoc` 实例，而不是运行 `rustdoc `。见 [`build.rustdoc`] 通过配置来设置。
* `RUSTDOCFLAGS` — 以空格分隔的自定义标志列表，用于传递给Cargo执行的所有 `rustdoc` 调用。
  与 [`cargo rustdoc`] 不同的是，这对于向 *所有* `rustdoc` 实例传递标志很有用。
  参见 [`build.rustdocflags`] 以了解更多设置标志的方法。这个字符串用空格分割；如果要对多个参数进行更健壮的编码，请参见 `CARGO_ENCODED_RUSTDOCFLAGS` 。
* `CARGO_ENCODED_RUSTDOCFLAGS` - 用 `0x1f` (ASCII单位分隔符)分隔的自定义标志列表，用于传递给Cargo执行的所有 `rustdoc` 调用。
* `RUSTFLAGS` — 以空格分隔的自定义标志列表，用于传递给Cargo执行的所有编译器调用。
  与 [`cargo rustc`] 不同的是，这对于向 *所有* 编译器实例传递标志很有用。
  参见 [`build.rustflags`] 以了解更多设置标志的方法。这个字符串是由空格分割；如果要对多个参数进行更健壮的编码，见`CARGO_ENCODED_RUSTFLAGS` 。
* `CARGO_ENCODED_RUSTFLAGS` - 用 `0x1f` (ASCII单元分隔符) 分隔的自定义标志列表，用于传递给Cargo执行的所有编译器调用。
* `CARGO_INCREMENTAL` — 如果设置为1，那么Cargo将强制在当前编译中启用[incremental compilation] ，设置为0时，
  将强制禁用增量编译。如果这个环境变量不存在，那么将使用cargo的默认值。另请参见 [`build.incremental`] 配置值。
* `CARGO_CACHE_RUSTC_INFO` — 如果这个设置为0，那么Cargo将不会尝试缓存编译器版本信息。
* `HTTPS_PROXY` or `https_proxy` or `http_proxy` — 要使用的HTTP代理，更多细节见 [`http.proxy`] 。
* `HTTP_TIMEOUT` — HTTP超时，以秒为单位，详见 [`http.timeout`] 。
* `TERM` — 如果这个设置为 `dumb` ，将禁用进度条。
* `BROWSER` — 用 [`cargo doc`]的 `--open` 标志打开文档时要执行的网络浏览器，更多细节见 [`doc.browser`] 。
* `RUSTFMT` — 代替 `rustfmt` ，[`cargo fmt`](https://github.com/rust-lang/rustfmt) 将执行这个指定的 `rustfmt` 实例。

#### 配置环境变量

Cargo会读取一些配置值的环境变量。详情见[配置章节][config-env]。概括起来，支持的环境变量有:

* `CARGO_ALIAS_<name>` — 命令别名, 见 [`alias`] 。
* `CARGO_BUILD_JOBS` — 并行执行数量, 见 [`build.jobs`] 。
* `CARGO_BUILD_RUSTC` — `rustc` 可执行文件, 见 [`build.rustc`] 。
* `CARGO_BUILD_RUSTC_WRAPPER` — `rustc` 包装器, 见 [`build.rustc-wrapper`] 。
* `CARGO_BUILD_RUSTC_WORKSPACE_WRAPPER` — 工作空间成员 `rustc` 包装器, 见 [`build.rustc-workspace-wrapper`] 。
* `CARGO_BUILD_RUSTDOC` — `rustdoc` 可执行文件, 见 [`build.rustdoc`] 。
* `CARGO_BUILD_TARGET` — 默认目标平台, 见 [`build.target`] 。
* `CARGO_BUILD_TARGET_DIR` — 默认输出目录, 见 [`build.target-dir`] 。
* `CARGO_BUILD_RUSTFLAGS` — 附加 `rustc` 标志, 见 [`build.rustflags`] 。
* `CARGO_BUILD_RUSTDOCFLAGS` — 附加 `rustdoc` 标志, 见 [`build.rustdocflags`] 。
* `CARGO_BUILD_INCREMENTAL` — 增量编译, 见 [`build.incremental`] 。
* `CARGO_BUILD_DEP_INFO_BASEDIR` — 仓库信息的相对目录, 见 [`build.dep-info-basedir`].
* `CARGO_CARGO_NEW_VCS` —  [`cargo new`] 默认的源码控制系统, 见 [`cargo-new.vcs`].
* `CARGO_FUTURE_INCOMPAT_REPORT_FREQUENCY` - 应该多长时间生成一次未来的不兼容报告通知, 见 [`future-incompat-report.frequency`].
* `CARGO_HTTP_DEBUG` — 启用 HTTP 调试, 见 [`http.debug`].
* `CARGO_HTTP_PROXY` — 启用HTTP代理, 见 [`http.proxy`].
* `CARGO_HTTP_TIMEOUT` — HTTP超时, 见 [`http.timeout`].
* `CARGO_HTTP_CAINFO` — TLS证书机构文件, 见 [`http.cainfo`].
* `CARGO_HTTP_CHECK_REVOKE` — 禁用TLS证书废止检查, 见 [`http.check-revoke`].
* `CARGO_HTTP_SSL_VERSION` — 要使用的TLS版本, 见 [`http.ssl-version`].
* `CARGO_HTTP_LOW_SPEED_LIMIT` — HTTP的低速限制, 见 [`http.low-speed-limit`].
* `CARGO_HTTP_MULTIPLEXING` — 是否使用HTTP/2多路复用, 见 [`http.multiplexing`].
* `CARGO_HTTP_USER_AGENT` — HTTP user-agent 头, 见 [`http.user-agent`].
* `CARGO_INSTALL_ROOT` — [`cargo install`] 的默认目录, 见 [`install.root`].
* `CARGO_NET_RETRY` — 网络错误重试的次数, 见 [`net.retry`].
* `CARGO_NET_GIT_FETCH_WITH_CLI` — 启用 `git` 可执行程序来获取, 见 [`net.git-fetch-with-cli`].
* `CARGO_NET_OFFLINE` — 脱机模式, 见 [`net.offline`].
* `CARGO_PROFILE_<name>_BUILD_OVERRIDE_<key>` — 覆盖构建脚本配置文件, 见 [`profile.<name>.build-override`].
* `CARGO_PROFILE_<name>_CODEGEN_UNITS` — 设定代码生成单元, 见 [`profile.<name>.codegen-units`].
* `CARGO_PROFILE_<name>_DEBUG` — 要包括什么样的调试信息, 见 [`profile.<name>.debug`].
* `CARGO_PROFILE_<name>_DEBUG_ASSERTIONS` — 启用/禁用调试断言, 见 [`profile.<name>.debug-assertions`].
* `CARGO_PROFILE_<name>_INCREMENTAL` — 启用/禁用增量编译, 见 [`profile.<name>.incremental`].
* `CARGO_PROFILE_<name>_LTO` — 链接时间优化, 见 [`profile.<name>.lto`].
* `CARGO_PROFILE_<name>_OVERFLOW_CHECKS` — 启用/禁用溢出检查, 见 [`profile.<name>.overflow-checks`].
* `CARGO_PROFILE_<name>_OPT_LEVEL` — 设置优化级别, 见 [`profile.<name>.opt-level`].
* `CARGO_PROFILE_<name>_PANIC` — 要使用的恐慌策略, 见 [`profile.<name>.panic`].
* `CARGO_PROFILE_<name>_RPATH` — rpath链接选项, 见 [`profile.<name>.rpath`].
* `CARGO_PROFILE_<name>_SPLIT_DEBUGINFO` — 控制调试文件的输出行为, 见 [`profile.<name>.split-debuginfo`].
* `CARGO_REGISTRIES_<name>_INDEX` — 注册中心索引的URL, 见 [`registries.<name>.index`].
* `CARGO_REGISTRIES_<name>_TOKEN` — 注册中心认证token, 见 [`registries.<name>.token`].
* `CARGO_REGISTRY_DEFAULT` — `--registry` 的默认注册中心。见 [`registry.default`] 。
* `CARGO_REGISTRY_TOKEN` — [crates.io]的认证token。 见 [`registry.token`] 。
* `CARGO_TARGET_<triple>_LINKER` — 使用的链接器, 见 [`target.<triple>.linker`] 。 三元组必须是 [转换为大写字母和下划线](config.md#environment-variables) 。
* `CARGO_TARGET_<triple>_RUNNER` — 可执行的运行器, 见 [`target.<triple>.runner`] 。
* `CARGO_TARGET_<triple>_RUSTFLAGS` — 目标的额外 `rustc` 标志, 见 [`target.<triple>.rustflags`] 。
* `CARGO_TERM_QUIET` — 静默模式, 见 [`term.quiet`] 。
* `CARGO_TERM_VERBOSE` — 默认的终端口令, 见 [`term.verbose`] 。
* `CARGO_TERM_COLOR` — 默认颜色模式, 见 [`term.color`] 。
* `CARGO_TERM_PROGRESS_WHEN` — 默认的进度条显示模式, 见 [`term.progress.when`] 。
* `CARGO_TERM_PROGRESS_WIDTH` — 默认的进度条宽度, 见 [`term.progress.width`] 。

[`cargo doc`]: ../commands/cargo-doc.md
[`cargo install`]: ../commands/cargo-install.md
[`cargo new`]: ../commands/cargo-new.md
[`cargo rustc`]: ../commands/cargo-rustc.md
[`cargo rustdoc`]: ../commands/cargo-rustdoc.md
[config-env]: config.md#environment-variables
[crates.io]: https://crates.io/
[incremental compilation]: profiles.md#incremental
[`alias`]: config.md#alias
[`build.jobs`]: config.md#buildjobs
[`build.rustc`]: config.md#buildrustc
[`build.rustc-wrapper`]: config.md#buildrustc-wrapper
[`build.rustc-workspace-wrapper`]: config.md#buildrustc-workspace-wrapper
[`build.rustdoc`]: config.md#buildrustdoc
[`build.target`]: config.md#buildtarget
[`build.target-dir`]: config.md#buildtarget-dir
[`build.rustflags`]: config.md#buildrustflags
[`build.rustdocflags`]: config.md#buildrustdocflags
[`build.incremental`]: config.md#buildincremental
[`build.dep-info-basedir`]: config.md#builddep-info-basedir
[`doc.browser`]: config.md#docbrowser
[`cargo-new.name`]: config.md#cargo-newname
[`cargo-new.email`]: config.md#cargo-newemail
[`cargo-new.vcs`]: config.md#cargo-newvcs
[`future-incompat-report.frequency`]: config.md#future-incompat-reportfrequency
[`http.debug`]: config.md#httpdebug
[`http.proxy`]: config.md#httpproxy
[`http.timeout`]: config.md#httptimeout
[`http.cainfo`]: config.md#httpcainfo
[`http.check-revoke`]: config.md#httpcheck-revoke
[`http.ssl-version`]: config.md#httpssl-version
[`http.low-speed-limit`]: config.md#httplow-speed-limit
[`http.multiplexing`]: config.md#httpmultiplexing
[`http.user-agent`]: config.md#httpuser-agent
[`install.root`]: config.md#installroot
[`net.retry`]: config.md#netretry
[`net.git-fetch-with-cli`]: config.md#netgit-fetch-with-cli
[`net.offline`]: config.md#netoffline
[`profile.<name>.build-override`]: config.md#profilenamebuild-override
[`profile.<name>.codegen-units`]: config.md#profilenamecodegen-units
[`profile.<name>.debug`]: config.md#profilenamedebug
[`profile.<name>.debug-assertions`]: config.md#profilenamedebug-assertions
[`profile.<name>.incremental`]: config.md#profilenameincremental
[`profile.<name>.lto`]: config.md#profilenamelto
[`profile.<name>.overflow-checks`]: config.md#profilenameoverflow-checks
[`profile.<name>.opt-level`]: config.md#profilenameopt-level
[`profile.<name>.panic`]: config.md#profilenamepanic
[`profile.<name>.rpath`]: config.md#profilenamerpath
[`profile.<name>.split-debuginfo`]: config.md#profilenamesplit-debuginfo
[`registries.<name>.index`]: config.md#registriesnameindex
[`registries.<name>.token`]: config.md#registriesnametoken
[`registry.default`]: config.md#registrydefault
[`registry.token`]: config.md#registrytoken
[`target.<triple>.linker`]: config.md#targettriplelinker
[`target.<triple>.runner`]: config.md#targettriplerunner
[`target.<triple>.rustflags`]: config.md#targettriplerustflags
[`term.quiet`]: config.md#termquiet
[`term.verbose`]: config.md#termverbose
[`term.color`]: config.md#termcolor
[`term.progress.when`]: config.md#termprogresswhen
[`term.progress.width`]: config.md#termprogresswidth

### 环境变量Cargo的crate集

Cargo在编译时将这些环境变量暴露给你的crate。
注意，这也适用于用 `cargo run` 和 `cargo test` 运行二进制文件。
要在Rust程序中获得这些变量的值，请这样做:

```rust,ignore
let version = env!("CARGO_PKG_VERSION");
```

`version` 现在将包含 `CARGO_PKG_VERSION` 的值。

请注意，如果配置清单中没有提供这些值之一，则相应的环境变量将被设置为空字符串 `""` 。

* `CARGO` — 执行构建的 `cargo` 二进制文件的路径。
* `CARGO_MANIFEST_DIR` — 包含你的包配置清单的目录。
* `CARGO_PKG_VERSION` — 你的包的完整版本。
* `CARGO_PKG_VERSION_MAJOR` — 你的包的主要版本。
* `CARGO_PKG_VERSION_MINOR` — 你的包的次要版本。
* `CARGO_PKG_VERSION_PATCH` — 你的包的补丁版本。
* `CARGO_PKG_VERSION_PRE` — 你的包的预发布版本。
* `CARGO_PKG_AUTHORS` — 冒号分隔的作者名单，来自你的包的配置清单。
* `CARGO_PKG_NAME` — 你的包的名称。
* `CARGO_PKG_DESCRIPTION` — 你的包配置清单的描述。
* `CARGO_PKG_HOMEPAGE` — 你的包的配置清单中的主页。
* `CARGO_PKG_REPOSITORY` — 你的包配置清单中的存储库。
* `CARGO_PKG_LICENSE` — 你的包的配置清单中的许可证。
* `CARGO_PKG_LICENSE_FILE` — 你的包的配置清单中的许可证文件。
* `CARGO_PKG_RUST_VERSION` — 你的包的配置清单中的Rust版本。 注意，这是包支持的最小Rust版本，而不是当前的Rust版本。
* `CARGO_CRATE_NAME` — 当前正在编译的crate的名称。
* `CARGO_BIN_NAME` — 当前正在编译的二进制文件的名称(如果它是一个二进制文件)。这个名字不包括任何文件扩展名，如 `.exe` 。
* `OUT_DIR` — 如果该包有构建脚本，这将被设置为构建脚本应该放置其输出的文件夹。更多信息见下文。(只在编译过程中设置)。
* `CARGO_BIN_EXE_<name>` — 二进制目标的可执行文件的绝对路径。这只在构建[集成测试]或性能测试时设置。这可以与[`env` macro]一起使用，以找到为测试目的运行的可执行文件。 `<name>` 是二进制目标的名称，完全按原样。例如， `CARGO_BIN_EXE_my-program` 代表一个名为 `my-program` 的二进制文件。当测试建立时，二进制文件会自动建立，除非二进制文件有未启用的必要特性。
* `CARGO_PRIMARY_PACKAGE` — 如果正在构建的包是主要的，这个环境变量将被设置。主要包是用户在命令行中选择的，可以是 `-p` 标志，也可以是基于当前目录和默认工作空间成员的默认值。这个环境变量在构建依赖时不会被设置。只有在编译包时才会设置（而不是在运行二进制文件或测试时）。
* `CARGO_TARGET_TMPDIR` — 只在构建[集成测试]或性能测试代码时设置。这是一个指向目标目录内的路径，集成测试或性能测试可以在这里自由放置测试/性能测试所需的任何数据。Cargo初始创建这个目录，但不以任何方式管理其内容，这是测试代码的责任。

[integration test]: cargo-targets.md#integration-tests
[`env` macro]: ../../std/macro.env.html

#### 动态库路径

在使用 `cargo run` 和 `cargo test` 等命令编译和运行二进制文件时，Cargo也会设置动态库路径。这有助于定位作为构建过程一部分的共享库。变量名称取决于平台:

* Windows: `PATH`
* macOS: `DYLD_FALLBACK_LIBRARY_PATH`
* Unix: `LD_LIBRARY_PATH`

macOS有特殊的考虑，如果 `DYLD_FALLBACK_LIBRARY_PATH` 还没有设置，它就会增加默认的 `$HOME/lib:/usr/local/lib:/usr/lib` 。

Cargo包括以下路径:

* 搜索任何带有[`rustc-link-search` instruction](build-scripts.md#rustc-link-search)的构建脚本中包含的路径。 `target` 目录之外的路径会被删除。如果在搜索路径中需要额外的系统库，运行Cargo的用户有责任正确设置环境。
* 基本输出目录，如 `target/debug` ，和 "deps" 目录。这主要是为了对 `rustc` 编译器插件的遗留支持。
* rustc sysroot库的路径。这对大多数用户来说通常并不重要。

### 环境变量 Cargo为构建脚本设置的环境变量

Cargo在运行构建脚本时设置了几个环境变量。因为这些变量在编译构建脚本时还没有设置，所以上面的例子中使用 `env!` 是行不通的，而是需要在运行构建脚本时检索这些值。

```rust,ignore
use std::env;
let out_dir = env::var("OUT_DIR").unwrap();
```

`out_dir` 现在将包含 `OUT_DIR` 的值。

* `CARGO` — 执行构建的 `cargo` 二进制文件的路径。
* `CARGO_MANIFEST_DIR` — 包含正在构建的包的配置清单的目录(包含构建脚本的包)。还要注意，这是构建脚本启动时的当前工作目录的值。
* `CARGO_MANIFEST_LINKS` — 配置清单 `links` 值。
* `CARGO_MAKEFLAGS` — 包含Cargo的[jobserver]实现所需的参数，以使子进程并行化。Rustc或build.rs中的cargo调用已经可以读取 `CARGO_MAKEFLAGS` ，但GNU Make要求这些标志直接作为参数指定，或通过 `MAKEFLAGS` 环境变量指定。目前Cargo并没有设置 `MAKEFLAGS`变量，但GNU Make的编译脚本可以将其设置为 `CARGO_MAKEFLAGS` 的内容。
* `CARGO_FEATURE_<name>` — 对于正在构建的包的每个激活的特性，这个环境变量将出现，其中 `<name>` 是特性的名称，为大写字母， `-` 转换成 `_` 。
* `CARGO_CFG_<cfg>` — 对于正在构建的包的每一个[配置选项][configuration]，这个环境变量将包含配置的值，其中 `<cfg>` 是配置的名称，为大写，并将 `-` 转换为 `_` 。
  布尔型配置如果被设置就会出现，否则就不会出现。具有多个值的配置连接到一个变量，其值以 `,` 分割。
  这包括编译器内置的值(可以用`rustc --print=cfg` 查看)，以及由编译脚本和传递给 `rustc` 的额外标志(比如在 `RUSTFLAGS` 中定义的)设置的值。这些变量的一些例子:
    * `CARGO_CFG_UNIX` — 在 [unix-like platforms] 设置。
    * `CARGO_CFG_WINDOWS` — 在 [windows-like platforms] 设置。
    * `CARGO_CFG_TARGET_FAMILY=unix` —  [target family] 。
    * `CARGO_CFG_TARGET_OS=macos` —  [target operating system] 。
    * `CARGO_CFG_TARGET_ARCH=x86_64` —  CPU [target architecture] 。
    * `CARGO_CFG_TARGET_VENDOR=apple` —  [target vendor] 。
    * `CARGO_CFG_TARGET_ENV=gnu` —  [target environment] ABI 。
    * `CARGO_CFG_TARGET_POINTER_WIDTH=64` —  CPU [pointer width] 。
    * `CARGO_CFG_TARGET_ENDIAN=little` —  CPU [target endianness] 。
    * `CARGO_CFG_TARGET_FEATURE=mmx,sse` — 启用的CPU[target features] 列表。
* `OUT_DIR` — 所有输出和中间制品应该放在哪个文件夹里。这个文件夹位于正在构建的包的构建目录内，而且对相关的包来说是唯一的。
* `TARGET` — 正在被编译的目标三元组。本地代码应该为这个三元组进行编译。更多信息请参见 [Target Triple] 的描述。
* `HOST` — 是Rust编译器的主机三元组。
* `NUM_JOBS` — 被指定为顶层的并行性。这对于向 `make` 这样的系统传递 `-j` 参数很有用。注意，在解释这个环境变量的时候要注意。
               出于历史原因，仍然提供了这个变量，但最近的Cargo版本，例如，不需要运行 `make -j` ，而是可以将 `MAKEFLAGS` 环境变量设置为 `CARGO_MAKEFLAGS` 的内容，以激活使用Cargo的GNU Make兼容 [jobserver] 进行子make调用。
* `OPT_LEVEL`, `DEBUG` — 目前正在建立的配置文件的相应变量的值。
* `PROFILE` — `release` 用于发布版本， `debug` 用于其他版本。这是根据 [profile] 是否继承自 [`dev`] 或 [`release`] 配置文件来决定的。不建议使用这个环境变量。使用其他环境变量，如 `OPT_LEVEL` ，可以更准确地了解正在使用的实际设置。
* `DEP_<name>_<key>` — 关于这组环境变量的更多信息，请参见关于 [`links`][links] 的构建脚本文档。
* `RUSTC`, `RUSTDOC` — 是Cargo决定使用的编译器和文档生成器，传递给构建脚本，以便它也能使用。
* `RUSTC_WRAPPER` — Cargo使用的 `rustc` 包装器，如果有的话。 见 [`build.rustc-wrapper`].
* `RUSTC_WORKSPACE_WRAPPER` — `rustc` 包装器，如果有的话，Cargo对工作空间成员使用。 见 [`build.rustc-workspace-wrapper`].
* `RUSTC_LINKER` — 如果指定了链接器，则是Cargo已经决定为当前目标使用的链接器二进制文件的路径。链接器可以通过编辑 `.cargo/config.toml` 来改变；更多信息请参见 [cargo configuration][cargo-config] 文档。
* `CARGO_ENCODED_RUSTFLAGS` — 附加的标志，Cargo调用 `rustc` 时，用 `0x1f` 字符(ASCII单位分隔符)分隔。见 [`build.rustflags`] 。注意，从Rust 1.55开始， `RUSTFLAGS` 已经从环境中移除；脚本应该使用 `CARGO_ENCODED_RUSTFLAGS` 代替。
* `CARGO_PKG_<var>` - 包的信息变量，其名称和数值与[在crate构建过程中提供的][variables set for crates]相同。

[`env_logger`]: https://docs.rs/env_logger
[debug logging]: https://doc.crates.io/contrib/architecture/console.html#debug-logging
[unix-like platforms]: ../../reference/conditional-compilation.html#unix-and-windows
[windows-like platforms]: ../../reference/conditional-compilation.html#unix-and-windows
[target family]: ../../reference/conditional-compilation.html#target_family
[target operating system]: ../../reference/conditional-compilation.html#target_os
[target architecture]: ../../reference/conditional-compilation.html#target_arch
[target vendor]: ../../reference/conditional-compilation.html#target_vendor
[target environment]: ../../reference/conditional-compilation.html#target_env
[pointer width]: ../../reference/conditional-compilation.html#target_pointer_width
[target endianness]: ../../reference/conditional-compilation.html#target_endian
[target features]: ../../reference/conditional-compilation.html#target_feature
[links]: build-scripts.md#the-links-manifest-key
[configuration]: ../../reference/conditional-compilation.html
[jobserver]: https://www.gnu.org/software/make/manual/html_node/Job-Slots.html
[cargo-config]: config.md
[Target Triple]: ../appendix/glossary.md#target
[variables set for crates]: #environment-variables-cargo-sets-for-crates
[profile]: profiles.md
[`dev`]: profiles.md#dev
[`release`]: profiles.md#release

### 环境变量 Cargo 为第三方子命令设置的环境变量

Cargo将这个环境变量暴露给第三方子命令(即放在 `$PATH` 中的名为 `cargo-foobar` 的程序):

* `CARGO` — 执行构建的 `cargo` 二进制文件的路径。

对于你的环境的扩展信息，可以运行 `cargo metadata` 。
