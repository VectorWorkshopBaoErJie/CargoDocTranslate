## 配置

本文档解释了Cargo的配置系统如何工作，以及可用的键或配置。关于通过包的配置清单进行的配置，参阅[配置清单格式](manifest.md)。

### 层次结构

Cargo允许对某一特定包进行本地配置，也允许进行全局配置。它在当前目录和所有父目录下寻找配置文件。例如，如果在`/projects/foo/bar/baz`中调用Cargo，那么以下的配置文件会被探测到，并按照这个顺序统一起来。

* `/projects/foo/bar/baz/.cargo/config.toml`
* `/projects/foo/bar/.cargo/config.toml`
* `/projects/foo/.cargo/config.toml`
* `/projects/.cargo/config.toml`
* `/.cargo/config.toml`
* `$CARGO_HOME/config.toml` 默认为:
    * Windows: `%USERPROFILE%\.cargo\config.toml`
    * Unix: `$HOME/.cargo/config.toml`

有了这种结构，你可以指定每个包的配置，甚至可以将其检查到版本控制中。你也可以在你的主目录下用一个配置文件指定个人默认值。

如果一个键在多个配置文件中被指定，这些值将被合并在一起。数字、字符串和布尔值将使用更深层级配置目录中的值，其优先于祖先目录的，其主目录的优先级最低。数组将被连接在一起。

目前，当从工作区调用时，Cargo不会从工作区的crates中读取配置文件，即如果一个工作区有两个crates，分别名为 `/projects/foo/bar/baz/mylib` 和 `/projects/foo/bar/baz/mybin` ，并且存在 `/projects/foo/bar/baz/mylib/.cargo/config.toml` 和 `/projects/foo/bar/baz/mybin/.cargo/config.toml` ，如果从工作区根(`/projects/foo/bar/baz/`)调用，Cargo就不会读取这些配置文件。

> **注意:** Cargo 也可以读取没有 `.toml` 扩展名的配置文件，如`.cargo/config`。
> 对`.toml`扩展的支持是在1.39版本中加入的，是首选的形式。
> 如果两个文件都存在，Cargo 将使用没有扩展名的文件。

### 配置格式

配置文件是以 [TOML格式][toml] 编写的，在表内有简洁的键值对。以下是对所有设置的快速概述，详细说明见下文。

paths = ["/path/to/override"] # 路径依赖覆盖

[alias]     # 命令别名
b = "build"
c = "check"
t = "test"
r = "run"
rr = "run --release"
recursive_example = "rr --example recursions"
space_example = ["run", "--release", "--", "\"command list\""]

[build]
jobs = 1                      # 并行任务数, 默认为 CPU 数
rustc = "rustc"               # rust  编译器工具
rustc-wrapper = "…"           # 运行这个包装器，而不是 `rustc`
rustc-workspace-wrapper = "…" # 运行这个包装器，而不是 `rustc` ，对于工作区成员
rustdoc = "rustdoc"           # 文档生成工具
target = "triple"             # 构建 target triple (被 `cargo install` 忽略)
target-dir = "target"         # 放置所有生成制品的路径
rustflags = ["…", "…"]        # 要传递给所有编译器调用的自定义标志
rustdocflags = ["…", "…"]     # 传递给rustdoc的自定义标志
incremental = true            # 是否启用增量编译
dep-info-basedir = "…"        # 开发文件中目标的基础目录路径

[doc]
browser = "chromium"          # 与 `cargo doc --open` 一起使用的浏览器，覆盖 `BROWSER` 环境变量。

[env]
# 为Cargo运行的任何进程设置ENV_VAR_NAME=value
ENV_VAR_NAME = "value"
# 即使环境中已经存在，也将设置
ENV_VAR_NAME_2 = { value = "value", force = true }
# 该值是相对于包含 `config.toml` 的.cargo目录而言的，设置为绝对的。
ENV_VAR_NAME_3 = { value = "relative/path", relative = true }

[future-incompat-report]
frequency = 'always' # 何时显示关于未来不兼容报告的通知

[cargo-new]
vcs = "none"              # VCS 便用 ('git', 'hg', 'pijul', 'fossil', 'none')

[http]
debug = false               # HTTP 调试
proxy = "host:port"         # libcurl格式的HTTP代理
ssl-version = "tlsv1.3"     # 要使用的TLS版本
ssl-version.max = "tlsv1.3" # TLS 最大版本
ssl-version.min = "tlsv1.1" # TLS 最小版本
timeout = 30                # 每个HTTP请求的超时，单位为秒
low-speed-limit = 10        # 网络超时阈值(字节/秒)。
cainfo = "cert.pem"         # CA证书绑定的路径
check-revoke = true         # 检查SSL证书是否被撤销
multiplexing = true         # HTTP/2 多路复用
user-agent = "…"            # user-agent 头

[install]
root = "/some/path"         # `cargo install` 目标目录

[net]
retry = 2                   # 网络重试
git-fetch-with-cli = true   # 使用 `git` 可执行文件进行git操作
offline = true              # 不接入网络

[patch.<registry>]
# 与Cargo.toml中 [patch] 的键相同。

[profile.<name>]         # 通过配置来修改配置文件设置。
opt-level = 0            # 优化级别。
debug = true             # 包括调试信息。
split-debuginfo = '...'  # 调试信息拆分行为。
debug-assertions = true  # 启用调试断言。
overflow-checks = true   # 启用运行时的整数溢出检查。
lto = false              # 设置链接时优化。
panic = 'unwind'         # 恐慌策略。
incremental = true       # 增量编译。
codegen-units = 16       # 代码生成单元的数目。
rpath = false            # 设置rpath链接选项。
[profile.<name>.build-override]  # 覆盖build-script的设置。
# profile下的键是一样的。
[profile.<name>.package.<name>]  # 覆盖包的配置文件。
# profile下的键是一样的 (减去 `panic`, `lto`, 和 `rpath`)。

[registries.<name>]  # crates.io外的其他注册中心
index = "…"          # 注册中心的URL索引
token = "…"          # 注册中心的认证令牌

[registry]
default = "…"        # 默认注册中心的名称
token = "…"          # crates.io的认证令牌

[source.<name>]      # 源的定义和替换
replace-with = "…"   # 用给定命名的源替换这个源
directory = "…"      # 目录源的路径
registry = "…"       # 注册中心源的 URL
local-registry = "…" # 本地注册源的路径
git = "…"            # git 源的 URL
branch = "…"         # git仓库的分支名称
tag = "…"            # git仓库的tag名称
rev = "…"            # git仓库的修订

[target.<triple>]
linker = "…"            # 要使用的链接器
runner = "…"            # 运行可执行文件的包装器
rustflags = ["…", "…"]  # `rustc` 的自定义标记

[target.<cfg>]
runner = "…"            # 运行可执行文件的包装器
rustflags = ["…", "…"]  # `rustc` 的自定义标记

[target.<triple>.<links>] # `links` 构建脚本覆盖
rustc-link-lib = ["foo"]
rustc-link-search = ["/path/to/foo"]
rustc-flags = ["-L", "/some/path"]
rustc-cfg = ['key="value"']
rustc-env = {key = "value"}
rustc-cdylib-link-arg = ["…"]
metadata_key1 = "value"
metadata_key2 = "value"

[term]
quiet = false          # cargo是否输出静默
verbose = false        # cargo是否提供详细输出
color = 'auto'         # cargo是否着色输出
progress.when = 'auto' # cargo是否显示进度条
progress.width = 80    # 进度条的宽度
```

### 环境变量

除了TOML配置文件，Cargo还可以通过环境变量进行配置。对于每个形如 `foo.bar` 的配置键，也可以用环境变量 `CARGO_FOO_BAR` 定义值。
键被转换为大写字母，点和破折号被转换为下划线。例如，`target.x86_64-unknown-linux-gnu.runner` 键也可以由 `CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER` 环境变量定义。

环境变量将优先于TOML配置文件。目前只有整数、布尔值、字符串和一些数组值支持由环境变量定义。
[下面描述](#configuration-keys)表明哪些键支持环境变量，否则由于[技术问题](https://github.com/rust-lang/cargo/issues/5416)而不受支持。

除了上述系统外，Cargo还能识别一些其他特定的[环境变量][env]。

### 命令行覆盖

Cargo也可以通过 `--config` 命令行选项接受任意的配置覆盖。参数应是TOML语法中的 "KEY=VALUE" 。

```console
cargo --config net.git-fetch-with-cli=true fetch
```

`--config` 选项可以被多次指定，在这种情况下，这些值将按照从左到右的顺序合并，使用与适用多个配置文件时相同的合并逻辑。
以这种方式指定的配置值优先于环境变量，环境变量优先于配置文件。

一些看起像什么Bourne shell语法使用的例子:

```console
# 多数 shells 请求将转义。
cargo --config http.proxy=\"http://example.com\" …

# 可以使用空格。
cargo --config "net.git-fetch-with-cli = true" …

# TOML数组例子。单引号使其更容易读写。
cargo --config 'build.rustdocflags = ["--html-in-header", "header.html"]' …

# 一个复杂的TOML键的例子。
cargo --config "target.'cfg(all(target_arch = \"arm\", target_os = \"none\"))'.runner = 'my-runner'" …

# 覆盖一个配置文件设置的例子。
cargo --config profile.dev.package.image.opt-level=3 …
```

 `--config` 选项也可以用来传递额外的配置文件的路径，Cargo应该在特定的调用中使用这些文件。
通过这种方式加载的配置文件中的选项与直接用 `--config` 指定的其他选项遵循同样的优先级规则。

### Config相对路径

配置文件中的路径可以是绝对的、相对的，或者是没有任何路径分隔符的无修饰名称。
没有路径分隔符的可执行文件的路径将使用 `PATH` 环境变量来搜索可执行文件。
非可执行文件的路径将相对于配置值定义位置。

具体来说，规则是:

* 对于环境变量，路径是相对于当前工作目录的。
* 对于直接从 [`--config KEY=VALUE`](#command-line-overrides) 选项加载的配置值，路径是相对于当前工作目录的。
* 对于配置文件，路径是相对于定义配置文件的目录的父目录而言的，无论这些文件是来自 [层级检索](#hierarchical-structure) 还是 [`--config <path>`](#command-line-overrides) 选项。

> **注意:** 为了与现有的 `.cargo/config.toml` 检索行为保持一致，在设计上，通过 `--config <path>` 传递的配置文件中的路径也是相对于配置文件本身两级。
> 为了避免意外的结果，经验方法是把你的额外配置文件放在项目中发现的 `.cargo/config.toml` 的同一级别。
> 例如，给定项目 `/my/project` ，建议把配置文件放在 `/my/project/.cargo` 下，或者在同一级别上新建一个目录，如 `/my/project/.config` 。

```toml
# 相对路径例子。

[target.x86_64-unknown-linux-gnu]
runner = "foo"  # 在 `PATH` 中搜索 `foo` .

[source.vendored-sources]
# 目录是相对于 `.cargo/config.toml` 所在的父目录而言的。
# 比如, `/my/project/.cargo/config.toml` 会在 `/my/project/vendor` 。
directory = "vendor"
```

### 带参数的可执行路径

一些Cargo命令调用外部程序，可以将其配置为路径和一些参数。

该值可以是一个字符串数组，如 `['/path/to/program', 'somearg']` 或一个空格分隔的字符串，如 `'/path/to/program somearg'` 。如果可执行文件的路径包含一个空格，则必须使用列表形式。

如果Cargo向程序传递其他参数，比如打开或运行的路径，它们将在这种格式的选项值中最后指定的参数之后传递。如果指定的程序没有路径分隔符，Cargo会在 `PATH` 中搜索其可执行文件。

### 证书

带有敏感信息的配置值存储在 `$CARGO_HOME/credentials.toml` 文件中。这个文件由 [`cargo login`] 自动创建和更新。它遵循与Cargo配置文件相同的格式。

```toml
[registry]
token = "…"   # crates.io 访问 token

[registries.<name>]
token = "…"   # 具名注册中心访问 token
```

一些Cargo命令使用令牌，例如[`cargo publish`]，用于与远程注册中心进行认证。应该注意保护令牌，使其私密。

与其他大多数配置值一样，令牌可以用环境变量来指定。
[crates.io]的令牌可以用 `CARGO_REGISTRY_TOKEN` 环境变量来指定。
其他注册中心的令牌可以用 `CARGO_REGISTRIES_<name>_TOKEN` 形式的环境变量来指定，其中 `<name>` 是大写的注册中心的名称。

### 配置键

本节记录了所有的配置键。带有可变部分的键的描述用角括号标注，如 `target.<triple>` ，其中 `<triple>` 部分可以是任何目标三元组，如 `target.x86_64-pc-windows-msvc` 。

#### `paths`
* Type: 字符串数组 (paths)
* Default: none
* Environment: 不受支持

一个本地包的路径数组，这些包将被用作依赖覆盖。
更多信息请参阅 [覆盖依赖指南](overriding-dependencies.md#paths-overrides) 。

#### `[alias]`
* Type: 字符串或字符串数组
* Default: 参阅下面
* Environment: `CARGO_ALIAS_<name>`

`[alias]` 表定义了CLI命令的别名。例如，运行 `cargo b` 是运行 `cargo build` 的别名。表中的每个键是子命令，而值是实际要运行的命令。
值可以是一个字符串数组，其中第一个元素是命令，后面的元素是参数。它也可以是一个字符串，它将在空格处被分割成子命令和参数。以下是Cargo内置的别名。

```toml
[alias]
b = "build"
c = "check"
d = "doc"
t = "test"
r = "run"
rm = "remove"
```

别名不允许重新定义现有的内置命令。

别名可递归:

```toml
[alias]
rr = "run --release"
recursive_example = "rr --example recursions"
```

#### `[build]`

`[build]` 表控制构建时的操作和编译器设置。

##### `build.jobs`
* Type: 整数
* Default: 逻辑CPU的数量
* Environment: `CARGO_BUILD_JOBS`

设定并行运行的最大编译器进程数。如果是负数，它将编译器进程的最大数量设置为逻辑CPU的数量加上所提供的值。不应该是0。

可以用 `--jobs` CLI选项覆盖。

##### `build.rustc`
* Type: 字符串 (程序路径)
* Default: "rustc"
* Environment: `CARGO_BUILD_RUSTC` 或 `RUSTC`

设置用于 `rustc` 的可执行文件。

##### `build.rustc-wrapper`
* Type: 字符串 (程序路径)
* Default: none
* Environment: `CARGO_BUILD_RUSTC_WRAPPER` 或 `RUSTC_WRAPPER`

设置包装器来代替 `rustc` 执行。传递给包装器的第一个参数是要使用的实际可执行文件的路径(即 `build.rustc` ，如果它被设置了，或者 `"rustc"` 以其它方式)。

##### `build.rustc-workspace-wrapper`
* Type: 字符串 (程序路径)
* Default: none
* Environment: `CARGO_BUILD_RUSTC_WORKSPACE_WRAPPER` 或 `RUSTC_WORKSPACE_WRAPPER`

设置包装器来代替 `rustc` 执行，仅适用于工作区成员。
传递给包装器的第一个参数是要使用的实际可执行文件的路径(即`build.rustc`，如果它被设置了，或 `"rustc"` 以其它方式)。
它影响文件名hash，以便包装器产生的制品被单独缓存。

##### `build.rustdoc`
* Type: 字符串 (程序路径)
* Default: "rustdoc"
* Environment: `CARGO_BUILD_RUSTDOC` 或 `RUSTDOC`

设置用于 `rustdoc` 的可执行文件。

##### `build.target`
* Type: 字符串或字符串数组
* Default: 主机平台
* Environment: `CARGO_BUILD_TARGET`

默认的目标平台三元组编译。

这允许传递字符串或字符串数组。每个字符串值是目标平台三元组。将为每个选定的架构构建目标。

该字符串值也可以是 `.json` 目标规格文件的相对路径。

可以用 `--target` CLI选项覆盖。

```toml
[build]
target = ["x86_64-unknown-linux-gnu", "i686-unknown-linux-gnu"]
```

##### `build.target-dir`
* Type: 字符路 (path)
* Default: "target"
* Environment: `CARGO_BUILD_TARGET_DIR` 或 `CARGO_TARGET_DIR`

放置所有编译器输出的路径。如果没有指定，默认是位于工作区根的名为 `target` 的目录。

可以用 `--target-dir` CLI选项覆盖。

##### `build.rustflags`
* Type: 字符串或字符串数组
* Default: none
* Environment: `CARGO_BUILD_RUSTFLAGS` 或 `CARGO_ENCODED_RUSTFLAGS` 或 `RUSTFLAGS`

额外的命令行标志，传递给 `rustc` 。该值可以是字符串数组或以空格分隔的字符串。

有四个互相排斥的额外标志源，依次检查，首先使用第一个:

1. `CARGO_ENCODED_RUSTFLAGS` 环境变量。
2. `RUSTFLAGS`  环境变量。
3. 所有匹配的 `target.<triple>.rustflags` 和 `target.<cfg>.rustflags` 配置项连接在一起。
4. `build.rustflags` 配置值。

额外的标志也可以通过 [`cargo rustc`] 命令传递。

如果使用 `--target` 标志(或[`build.target`](#buildtarget))，那么这些标志将只传递给目标的编译器。为主机构建的东西，如构建脚本或proc macros，将不会收到这些args。
如果不使用 `--target` ，标志将被传递给所有编译器调用(包括构建脚本和proc macros)，因为依赖是共享的。
如果你有不想传递给构建脚本或proc macros的args，并且是为主机构建的，请将 `--target` 与主机三元组一起传递。

我们不建议传入Cargo本身通常管理的标志。
例如，由[profiles](profiles.md)决定的标志，最好通过设置适当的配置文件来处理。

> **警告**: 由于直接向编译器传递标志的低阶特性，这可能会与未来版本的Cargo产生冲突，后者可能会自行发布相同或类似的标志，这可能会干扰你指定的标志。
> 这是Cargo可能总是不会向后兼容的领域。

##### `build.rustdocflags`
* Type: 字符串或字符串数组
* Default: none
* Environment: `CARGO_BUILD_RUSTDOCFLAGS` 或 `CARGO_ENCODED_RUSTDOCFLAGS` 或 `RUSTDOCFLAGS`

额外的命令行标志，传递给 `rustdoc` 。该值可以是字符串数组或以空格分隔的字符串。

有三个相互排斥的额外标志源。依次检查它们，首先使用第一个。

1. `CARGO_ENCODED_RUSTDOCFLAGS` 环境变量。
2. `RUSTDOCFLAGS` 环境变量。
3. `build.rustdocflags` 配置值。

附加标志也可以通过 [`cargo rustdoc`] 命令传递。

##### `build.incremental`
* Type: bool
* Default: 来自配置文件
* Environment: `CARGO_BUILD_INCREMENTAL` 或 `CARGO_INCREMENTAL`

是否执行[增量编译]。如果没有设置，默认是使用 [profile](profiles.md#incremental) 中的值。否则这将覆盖所有配置文件的设置。

 `CARGO_INCREMENTAL` 环境变量可以设置为 `1` 以强制启用所有配置文件的增量编译，或 `0` 以禁用它。这个环境变量覆盖配置设置。

##### `build.dep-info-basedir`
* Type: 字符串 (path)
* Default: none
* Environment: `CARGO_BUILD_DEP_INFO_BASEDIR`

从[dep info](../guide/build-cache.md#dep-info-files)文件路径中分割指定的路径前缀。
这个配置的目的是为需要相对路径的工具，将绝对路径转换成相对路径。

这个设置自身是与配置相对的路径。举例来说，`"."` 的值将分割所有以 `.cargo` 目录的父目录为起点的路径。

##### `build.pipelining`

这个选项已被废弃，未使用。Cargo总是启用流水线。

#### `[doc]`

`[doc]` 表定义了 [`cargo doc`] 命令的选项。

##### `doc.browser`

* Type: 字符串或字符串数组 ([带参数的程序路径])
* Default: `BROWSER` 环境变量，如果缺少该变量，则以系统特定的方式打开链接

这个选项设置 [`cargo doc`] 使用的浏览器，在用 `--open` 选项打开文档时，覆盖 `BROWSER` 环境变量。

#### `[cargo-new]`

`[cargo-new]` 表定义了 [`cargo new`] 命令的默认值。

##### `cargo-new.name`

该选项已被废弃，未被使用。

##### `cargo-new.email`

该选项已被废弃，未被使用。

##### `cargo-new.vcs`
* Type: 字符串
* Default: "git" 或 "none"
* Environment: `CARGO_CARGO_NEW_VCS`

指定初始化新版本库时使用的源码控制系统。
有效值是 `git` 、 `hg` (用于Mercurial) 、 `pijul`  、 `fossil` ，或 `none` 以禁用此行为。默认为 `git` ，如果已经在一个VCS仓库内，则默认为 `none` 。可以用 `--vcs` CLI选项来覆盖。

### `[env]`

`[env]` 部分允许你为构建脚本、rustc调用、 `cargo run` 和 `cargo build` 设置附加的环境变量。

```toml
[env]
OPENSSL_DIR = "/opt/openssl"
```

默认情况下，指定的变量将不会覆盖环境中已经存在的值。可以通过设置 `force` 标志来改变这种行为。

设置 `relative` 标志会将该值评估为相对配置路径，它是相对于包含`config.toml` 文件的 `.cargo` 目录的父目录而言的。环境变量的值将是完整的绝对路径。

```toml
[env]
TMPDIR = { value = "/home/tmp", force = true }
OPENSSL_DIR = { value = "vendor/openssl", relative = true }
```

### `[future-incompat-report]`

`[future-incompat-report]` 表控制 [未来不匹配的报告](future-incompat-report.md) 的设置。

#### `future-incompat-report.frequency`
* Type: 字符串
* Default: "always"
* Environment: `CARGO_FUTURE_INCOMPAT_REPORT_FREQUENCY`

控制当未来不兼容报告可用时，多长时间向终端显示一次通知。可能的值为:

* `always` (默认): 当命令(例如 `cargo build`)产生未来不兼容报告时，总是显示通知。
* `never`: 永不显示通知

#### `[http]`

`[http]` 表定义了HTTP行为设置。包括获取crate的依赖和访问远程git仓库。

##### `http.debug`
* Type: boolean
* Default: false
* Environment: `CARGO_HTTP_DEBUG`

如果 `true` ，启用对HTTP请求的调试。调试信息可以通过设置 `CARGO_LOG=cargo::ops::registry=debug` 环境变量查看(或者使用 `trace` 获取更多信息) 。

当把这个输出的日志发布到公开位置时，要小心谨慎。该输出可能包括带有认证令牌的头信息，你不希望泄漏这些信息。在发布日志之前，一定要审查日志。

##### `http.proxy`
* Type: 字符串
* Default: none
* Environment: `CARGO_HTTP_PROXY` 或 `HTTPS_PROXY` 或 `https_proxy` 或 `http_proxy`

设置一个要使用的HTTP和HTTPS代理。其格式为 [libcurl格式] ，如 `[protocol://]host[:port]` 。
如果没有设置，Cargo也会检查你全局git配置中的 `http.proxy` 设置。
如果这些都没有设置， `HTTPS_PROXY` 或 `https_proxy` 环境变量为HTTPS请求设置代理， `http_proxy` 为HTTP请求设置。

##### `http.timeout`
* Type: 整数
* Default: 30
* Environment: `CARGO_HTTP_TIMEOUT` 或 `HTTP_TIMEOUT`

设置每个HTTP请求的超时，单位为秒。

##### `http.cainfo`
* Type: 字符串 (path)
* Default: none
* Environment: `CARGO_HTTP_CAINFO`

CA证书绑定文件的路径，用于验证TLS证书。如果没有指定，Cargo会尝试使用系统证书。

##### `http.check-revoke`
* Type: boolean
* Default: true (Windows) false (all others)
* Environment: `CARGO_HTTP_CHECK_REVOKE`

这决定了是否应该进行TLS证书撤销检查。仅适用于Windows。

##### `http.ssl-version`
* Type: string 或 min/max table
* Default: none
* Environment: `CARGO_HTTP_SSL_VERSION`

此设置要使用的最小TLS版本。它需要一个字符串，可能的值是 "default"、"tlsv1"、"tlsv1.0"、"tlsv1.1"、"tlsv1.2"、"tlsv1.3" 之一。

这可能是有两个键的表，`min` 和 `max` ，每个键都有相同的字符串值，指定要使用的TLS版本的最小和最大范围。

默认情况下，最小版本为 "tlsv1.0" ，最大版本为你的平台上支持的最新版本，通常为 "tlsv1.3" 。

##### `http.low-speed-limit`
* Type: 整数
* Default: 10
* Environment: `CARGO_HTTP_LOW_SPEED_LIMIT`

此设置控制过慢连接超时行为。
如果以字节/秒为单位的平均传输速度低于[`http.timeout`](#httptimeout)秒的给定值(默认为30秒)，那么该连接被认为太慢，Cargo将中止并重试。

##### `http.multiplexing`
* Type: boolean
* Default: true
* Environment: `CARGO_HTTP_MULTIPLEXING`

当 `true` 时，Cargo将尝试使用多路复用的HTTP2协议。
这允许多个请求使用同一个连接，通常可以提高获取多文件的性能。
如果 `false` ，Cargo将使用HTTP1.1，没有管道。

##### `http.user-agent`
* Type: 字符串
* Default: Cargo的版本
* Environment: `CARGO_HTTP_USER_AGENT`

指定要使用的自定义user-agent header。如果没有指定，默认是一个包括Cargo版本的字符串。

#### `[install]`

`[install]` 表定义了 [`cargo install`] 命令的默认值。

##### `install.root`
* Type: 字符串 (path)
* Default: Cargo的主目录
* Environment: `CARGO_INSTALL_ROOT`

为 [`cargo install`] 设置安装可执行文件的根目录的路径。可执行文件会进入根目录下的 `bin` 目录。

为了跟踪已安装的可执行文件的信息，一些附加文件，如 `.crates.toml` 和 `.crates2.json` 也会在这个根下创建。

如果没有指定，默认是Cargo的主目录 (默认为你的主目录中 `.cargo` ) 。

可以用 `--root` 命令行选项来覆盖。

#### `[net]`

`[net]` 表控制网络配置。

##### `net.retry`
* Type: 整数
* Default: 2
* Environment: `CARGO_NET_RETRY`

可能是虚假网络的错误重试次数。

##### `net.git-fetch-with-cli`
* Type: boolean
* Default: false
* Environment: `CARGO_NET_GIT_FETCH_WITH_CLI`

如果这是 `true` ，那么Cargo将使用 `git` 可执行程序来获取注册中心索引和git依赖。如果是 `false` ，那么它将使用内置的 `git` 库。

如果你有特殊的认证要求，而Cargo不支持的话，将此设置为 `true` 会有帮助。
参阅 [Git Authentication](../appendix/git-authentication.md)以了解更多关于设置git认证的信息。

##### `net.offline`
* Type: boolean
* Default: false
* Environment: `CARGO_NET_OFFLINE`

如果是 `true` ，那么Cargo将避免访问网络，并尝试使用本地缓存的数据。
如果是 `false` ，Cargo将根据需要访问网络，如果遇到网络错误，将产生一个错误。

可以用 `--offline` 命令行选项来覆盖。

#### `[patch]`

就像你可以用[`[patch]` in `Cargo.toml`](overriding-dependencies.md#the-patch-section)覆盖依赖一样，
你可以在cargo配置文件中覆盖它们，将这些补丁应用于任何受影响的构建。其格式与 `Cargo.toml` 中的格式相同。

由于 `.cargo/config.toml` 文件通常不会被检查到源代码控制中，你应该尽可能选择使用 `Cargo.toml` 来打补丁，以确保其他开发者可以在自己的环境中编译你的crate。
一般来说，只有当补丁部分由外部构建工具自动生成时，通过cargo配置文件进行修补才是合适的。

如果特定的依赖在cargo配置文件和 `Cargo.toml` 文件中都有补丁，则使用配置文件中的补丁。
如果多个配置文件对同一个依赖打了补丁，则使用标准的cargo配置合并，它更倾向于使用离当前目录最近的定义值。
`$HOME/.cargo/config.toml` 的优先级最低。

在这样的 `[patch]` 部分中的相对 `path` 依赖是相对于它们出现配置文件的。

#### `[profile]`

`[profile]` 表可以用来全局改变配置文件的设置，并覆盖 `Cargo.toml` 中指定的设置。
它的语法和选项与 `Cargo.toml` 中指定的配置文件相同。
关于选项的详细信息，请参阅 [配置文件章节] 。

[Profiles chapter]: profiles.md

##### `[profile.<name>.build-override]`
* Environment: `CARGO_PROFILE_<name>_BUILD_OVERRIDE_<key>`

构建覆盖表覆盖构建脚本、进程宏和其依赖的设置。
它的键值与普通配置文件相同。
参见 [覆盖部分](profiles.md#overrides) 以了解更多细节。

##### `[profile.<name>.package.<name>]`
* Environment: 不支持

包表覆盖特定包的设置。
它和普通的配置文件有相同的键，除 `panic` 、 `lto` 和 `rpath` 设置。
参阅 [overrides section](profiles.md#overrides) 以了解更多细节。

##### `profile.<name>.codegen-units`
* Type: 整数
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_CODEGEN_UNITS`

参阅 [codegen-units](profiles.md#codegen-units) 。

##### `profile.<name>.debug`
* Type: 整数或布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_DEBUG`

参阅 [debug](profiles.md#debug)。

##### `profile.<name>.split-debuginfo`
* Type: 字符串
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_SPLIT_DEBUGINFO`

参阅 [split-debuginfo](profiles.md#split-debuginfo)。

##### `profile.<name>.debug-assertions`
* Type: 布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_DEBUG_ASSERTIONS`

参阅 [debug-assertions](profiles.md#debug-assertions)。

##### `profile.<name>.incremental`
* Type: 布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_INCREMENTAL`

参阅 [incremental](profiles.md#incremental).

##### `profile.<name>.lto`
* Type: 字符串或布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_LTO`

参阅 [lto](profiles.md#lto) 。

##### `profile.<name>.overflow-checks`
* Type: 布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_OVERFLOW_CHECKS`

参阅 [overflow-checks](profiles.md#overflow-checks) 。

##### `profile.<name>.opt-level`
* Type: 字符串或布尔
* Default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_OPT_LEVEL`

参阅 [opt-level](profiles.md#opt-level) 。

##### `profile.<name>.panic`
* Type: 字符串
* default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_PANIC`

参阅 [panic](profiles.md#panic) 。

##### `profile.<name>.rpath`
* Type: 布尔
* default: 参阅配置文件文档。
* Environment: `CARGO_PROFILE_<name>_RPATH`

参阅 [rpath](profiles.md#rpath) 。


#### `[registries]`

`[注册表]` 表用于指定附加的[注册中心]。
它由各个命名的注册中心的子表组成。

##### `registries.<name>.index`
* Type: 字符串 (url)
* Default: none
* Environment: `CARGO_REGISTRIES_<name>_INDEX`

指定注册中心git索引的URL。

##### `registries.<name>.token`
* Type: 字符串
* Default: none
* Environment: `CARGO_REGISTRIES_<name>_TOKEN`

指定给定注册中心的认证令牌。
这个值应该只出现在 [credentials](#credentials) 文件中。
这用于需要认证的注册中心命令，如 [`cargo publish`] 。

可以用 `--token` 命令行选项来覆盖。

#### `[registry]`

`[注册中心]` 表控制在没有指定的情况下使用的默认注册中心。

##### `registry.index`

不再接受此值，不应使用。

##### `registry.default`
* Type: 字符串
* Default: `"crates-io"`
* Environment: `CARGO_REGISTRY_DEFAULT`

注册中心的名称(来自[ `registries` 表](#registries))，默认用于 [`cargo publish`] 等注册中心命令。

可以用 `--registry` 命令行选项来覆盖。

##### `registry.token`
* Type: 字符串
* Default: none
* Environment: `CARGO_REGISTRY_TOKEN`

指定 [crates.io] 的认证令牌。
这个值应该只出现在 [credentials](#credentials) 文件中。
这用于像 [`cargo publish`] 这样的需要认证的注册中心命令。

可以用 `--token` 命令行选项来覆盖。

#### `[source]`

`[source]` 表定义了可用的注册中心源。
更多信息见[源替换]。
它由每个命名的源的一个子表组成。
源应该只定义为一种(目录、注册中心、本地注册或git)。

##### `source.<name>.replace-with`
* Type: 字符串
* Default: none
* Environment: 不支持

如果设置，用给定的命名源或命名注册中心替换这个源。

##### `source.<name>.directory`
* Type: 字符串 (path)
* Default: none
* Environment: 不支持

设置目录路径，作为目录源使用。

##### `source.<name>.registry`
* Type: 字符串 (url)
* Default: none
* Environment: 不支持

设置用于注册中心源的URL。

##### `source.<name>.local-registry`
* Type: 字符串 (path)
* Default: none
* Environment: 不支持

设置目录路径，用作本地注册源。

##### `source.<name>.git`
* Type: 字符串 (url)
* Default: none
* Environment: 不支持

设置用于git仓库源的URL。

##### `source.<name>.branch`
* Type: 字符串
* Default: none
* Environment: 不支持

设置用于git仓库的分支名称。

如果没有设置 `branch` 、 `tag` 或 `rev` ，则默认为 `master` 分支。

##### `source.<name>.tag`
* Type: 字符串
* Default: none
* Environment: 不支持

设置用于git仓库的tag名称。

如果没有设置 `branch` 、 `tag` 或 `rev` ，则默认为 `master` 分支。

##### `source.<name>.rev`
* Type: 字符串
* Default: none
* Environment: 不支持

设置用于git仓库的[修订]。

如果没有设置 `branch` 、 `tag` 或 `rev` ，则默认为 `master` 分支。


#### `[target]`

`[target]` 表用于指定特定平台目标的设置。
它由子表组成，这个子表是平台三元组或 [`cfg()` 表达式] 。
如果目标平台与 `<triple>` 值或 `<cfg>` 表达式匹配，将使用给定的值。

```toml
[target.thumbv7m-none-eabi]
linker = "arm-none-eabi-gcc"
runner = "my-emulator"
rustflags = ["…", "…"]

[target.'cfg(all(target_arch = "arm", target_os = "none"))']
runner = "my-arm-wrapper"
rustflags = ["…", "…"]
```

`cfg` 值来自编译器内置的值 (运行 `rustc --print=cfg` 查看)，由[构建脚本]设置的值，以及传递给 `rustc` 的附加 `--cfg` 标志(例如在 `RUSTFLAGS` 中定义的标志)。
不要在 `debug_assertions` 或 Cargo 特性(如 `feature="foo"` )上尝试match。

如果使用目标规格的JSON文件，`<triple>` 值是文件名。
例如， `--target foo/bar.json` 将匹配 `[target.bar]` 。

##### `target.<triple>.ar`

该选项已被废弃，未被使用。

##### `target.<triple>.linker`
* Type: 字符串 (程序路径)
* Default: none
* Environment: `CARGO_TARGET_<triple>_LINKER`

指定在编译 `<triple>` 时传递给 `rustc` (通过[`-C linker`]) 的链接器。
默认情况下，链接器不可覆盖。

##### `target.<triple>.runner`
* Type: 字符串或者字符串数组 ([带参数的程序路径])
* Default: none
* Environment: `CARGO_TARGET_<triple>_RUNNER`

如果提供了运行器，目标 `<triple>` 的可执行文件将通过调用指定的运行器和作为参数传递的实际可执行文件来执行。
这适用于 [`cargo run`], [`cargo test`] 和 [`cargo bench`] 命令。
默认情况下，编译后的可执行文件被直接执行。

##### `target.<cfg>.runner`

这类似于 [target runner](#targettriplerunner) ，但使用 [`cfg()` 表达式] 。
如果同时有 `<triple>` 和 `<cfg>` 运行器匹配， `<triple>` 将优先使用。
如果有一个以上的 `<cfg>` 运行器与当前目标匹配，则错误。

##### `target.<triple>.rustflags`
* Type: 字符串或字符串数组
* Default: none
* Environment: `CARGO_TARGET_<triple>_RUSTFLAGS`

为这个 `<triple>` 向编译器传递一组自定义标志。
该值可以是字符串数组或以空格分隔的字符串。

参阅 [`build.rustflags`](#buildrustflags) ，以了解更多关于特定附加标志的不同方式的细节。

##### `target.<cfg>.rustflags`

这类似于 [target rustflags](#targettriplerustflags) ，但使用 [`cfg()` 表达式] 。
如果有几个 `<cfg>` 和 `<triple>` 条目与当前的目标相匹配，这些标志就会被连在一起。

##### `target.<triple>.<links>`

链接子表提供了一种[覆盖构建脚本]的方法。
当指定时，给定的 `links` 库的构建脚本将不会运行，而会使用给定的值。

```toml
[target.x86_64-unknown-linux-gnu.foo]
rustc-link-lib = ["foo"]
rustc-link-search = ["/path/to/foo"]
rustc-flags = "-L /some/path"
rustc-cfg = ['key="value"']
rustc-env = {key = "value"}
rustc-cdylib-link-arg = ["…"]
metadata_key1 = "value"
metadata_key2 = "value"
```

#### `[term]`

`[term]` 表控制终端输出和交互。

##### `term.quiet`
* Type: 布尔
* Default: false
* Environment: `CARGO_TERM_QUIET`

控制Cargo是否显示日志信息。

指定 `--quiet` 标志将覆盖和强制静默输出。
指定 `--verbose` 标志将覆盖和禁用静默输出。

##### `term.verbose`
* Type: 布尔
* Default: false
* Environment: `CARGO_TERM_VERBOSE`

控制Cargo是否显示附加的详细信息。

指定 `--quiet` 标志将覆盖并禁用粗略输出。
指定 `--verbose` 标志将覆盖并强制进行粗略输出。

##### `term.color`
* Type: 字符串
* Default: "auto"
* Environment: `CARGO_TERM_COLOR`

控制是否在终端中使用彩色输出。可能的值:

* `auto` (默认): 自动检测终端是否有颜色支持。
* `always`: 允许显示颜色。
* `never`: 不允许显示颜色。

可以用 `--color` 命令行选项来覆盖。

##### `term.progress.when`
* Type: 字符串
* Default: "auto"
* Environment: `CARGO_TERM_PROGRESS_WHEN`

控制是否在终端中显示进度条。可能的值:

* `auto` (默认): 智能地猜测是否显示进度条。
* `always`: 允许显示进度条。
* `never`: 不允许显示进度条。

##### `term.progress.width`
* Type: 整数
* Default: none
* Environment: `CARGO_TERM_PROGRESS_WIDTH`

设置进度条的宽度。

[`cargo bench`]: ../commands/cargo-bench.md
[`cargo login`]: ../commands/cargo-login.md
[`cargo doc`]: ../commands/cargo-doc.md
[`cargo new`]: ../commands/cargo-new.md
[`cargo publish`]: ../commands/cargo-publish.md
[`cargo run`]: ../commands/cargo-run.md
[`cargo rustc`]: ../commands/cargo-rustc.md
[`cargo test`]: ../commands/cargo-test.md
[`cargo rustdoc`]: ../commands/cargo-rustdoc.md
[`cargo install`]: ../commands/cargo-install.md
[env]: environment-variables.md
[`cfg()` 表达式]: ../../reference/conditional-compilation.html
[build scripts]: build-scripts.md
[`-C linker`]: ../../rustc/codegen-options/index.md#linker
[override a build script]: build-scripts.md#overriding-build-scripts
[toml]: https://toml.io/
[incremental compilation]: profiles.md#incremental
[带参数的程序路径]: #executable-paths-with-arguments
[libcurl format]: https://everything.curl.dev/libcurl/proxies#proxy-types
[源替换]: source-replacement.md
[修订]: https://git-scm.com/docs/gitrevisions
[registries]: registries.md
[crates.io]: https://crates.io/
