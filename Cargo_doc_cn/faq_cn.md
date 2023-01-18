{==+==}
## Frequently Asked Questions
{==+==}
## 常见问题
{==+==}

{==+==}
### Is the plan to use GitHub as a package repository?
{==+==}
### 有计划使用 GitHub 作为包存储仓库吗？
{==+==}

{==+==}
No. The plan for Cargo is to use [crates.io], like npm or Rubygems do with
[npmjs.com][1] and [rubygems.org][3].
{==+==}
没有。Cargo 会使用 [crates.io]，就像 npm 的 [npmjs.com][1] 和 Rubygems 的 [rubygems.org][3] 。
{==+==}

{==+==}
We plan to support git repositories as a source of packages forever,
because they can be used for early development and temporary patches,
even when people use the registry as the primary source of packages.
{==+==}
我们将永远支持使用 git 仓库作为包的一个来源，因为其可以用在早期开发和临时覆盖中，但是人们还是会将 registry 作为包的主要来源。
{==+==}

{==+==}
### Why build crates.io rather than use GitHub as a registry?
{==+==}
### 为什么建立 crates.io 而不是使用 GitHub 作为 registry ？
{==+==}

{==+==}
We think that it’s very important to support multiple ways to download
packages, including downloading from GitHub and copying packages into
your package itself.
{==+==}
我们认为支持多种下载包的方式是很重要的，其中包括从 GitHub 下载并将其拷贝到你的包中。
{==+==}

{==+==}
That said, we think that [crates.io] offers a number of important benefits, and
will likely become the primary way that people download packages in Cargo.
{==+==}
尽管如此，我们还是认为 [crates.io] 提供了一些重要的便利，会成为人们用 Cargo 下载包的主要方式。 
{==+==}

{==+==}
For precedent, both Node.js’s [npm][1] and Ruby’s [bundler][2] support both a
central registry model as well as a Git-based model, and most packages
are downloaded through the registry in those ecosystems, with an
important minority of packages making use of git-based packages.
{==+==}
作为先例，Node.js 的 [npm][1] 和 Ruby 的 [bundler][2] 都同时支持一个中心化的 registry 模型和基于 git 的模型，大部分的包都是从它们生态的 registry 中下载的，少数的包使用基于 git 的下载。
{==+==}

{==+==}
[1]: https://www.npmjs.com
[2]: https://bundler.io
[3]: https://rubygems.org
{==+==}

{==+==}

{==+==}
Some of the advantages that make a central registry popular in other
languages include:
{==+==}
让中心化 registry 在这些语言中得以流行的优势有:
{==+==}

{==+==}
* **Discoverability**. A central registry provides an easy place to look
  for existing packages. Combined with tagging, this also makes it
  possible for a registry to provide ecosystem-wide information, such as a
  list of the most popular or most-depended-on packages.
* **Speed**. A central registry makes it possible to easily fetch just
  the metadata for packages quickly and efficiently, and then to
  efficiently download just the published package, and not other bloat
  that happens to exist in the repository. This adds up to a significant
  improvement in the speed of dependency resolution and fetching. As
  dependency graphs scale up, downloading all of the git repositories bogs
  down fast. Also remember that not everybody has a high-speed,
  low-latency Internet connection.
{==+==}
* **可发现性**。一个中心 registry 提供了一个方便的地方来查找已有的包。结合标记技术，一个 registry 可以提供生态广度的信息，诸如最受欢迎或最被依赖的包的列表。
* **速度**。一个中心 registry 可以让我们快速有效地获取包的元数据，然后高效地只下载那些被发布的包，而不会下载那些碰巧保存在 git 仓库中的无用内容。这显著提高了依赖解析和下载的速度。随着依赖图的增大，从 git 仓库中下载的方式很快就会陷入困境。而且要明白不是每个人都拥有高速低延迟的网络。
{==+==}

{==+==}
### Will Cargo work with C code (or other languages)?
{==+==}
### Cargo 可以和 C 代码(或者其他语言)一起工作吗
{==+==}

{==+==}
Yes!
{==+==}
当然！
{==+==}

{==+==}
Cargo handles compiling Rust code, but we know that many Rust packages
link against C code. We also know that there are decades of tooling
built up around compiling languages other than Rust.
{==+==}
Cargo 用于处理编译 Rust 代码，但我们也了解很多 Rust 包链接到 C 代码。我们也知道编译其他语言的工具已经发展了几十年的时间。
{==+==}

{==+==}
Our solution: Cargo allows a package to [specify a script](reference/build-scripts.md)
(written in Rust) to run before invoking `rustc`. Rust is leveraged to
implement platform-specific configuration and refactor out common build
functionality among packages.
{==+==}
我们的解决方案是：Cargo 允许一个包指定(用Rust写的)[一个脚本](reference/build-scripts.md)，在调用 `rustc` 之前执行。用于实现平台特定的设置和重构包之间的公共构建功能。
{==+==}

{==+==}
### Can Cargo be used inside of `make` (or `ninja`, or ...)
{==+==}
### Cargo 可以用在 `make` (或 `ninja`，...) 之中吗？
{==+==}

{==+==}
Indeed. While we intend Cargo to be useful as a standalone way to
compile Rust packages at the top-level, we know that some people will
want to invoke Cargo from other build tools.
{==+==}
当然。在我们设计让 Cargo 独立编译 Rust 包，也考虑到一些人想要在其他构建工具中调用 Cargo。
{==+==}

{==+==}
We have designed Cargo to work well in those contexts, paying attention
to things like error codes and machine-readable output modes. We still
have some work to do on those fronts, but using Cargo in the context of
conventional scripts is something we designed for from the beginning and
will continue to prioritize.
{==+==}
我们设计让Cargo在这些情境下很好地工作，花了很多精力在错误代码和机器可读的输出上。在这些上面我们还有很多工作要做，但是在常见的脚本中使用Cargo是我们从一开始就设计好的，并且会继续作为高优先级的任务。
{==+==}

{==+==}
### Does Cargo handle multi-platform packages or cross-compilation?
{==+==}
### Cargo 可以处理多平台的包或者交叉编译吗？
{==+==}

{==+==}
Rust itself provides facilities for configuring sections of code based
on the platform. Cargo also supports [platform-specific
dependencies][target-deps], and we plan to support more per-platform
configuration in `Cargo.toml` in the future.
{==+==}
Rust 本身提供了基于平台控制代码片段的功能。Cargo 也支持 [平台特定依赖][target-deps]，而且我们计划在 `Cargo.toml` 中支持为不同平台进行更多设置。
{==+==}

{==+==}
[target-deps]: reference/specifying-dependencies.md#platform-specific-dependencies
{==+==}

{==+==}

{==+==}
In the longer-term, we’re looking at ways to conveniently cross-compile
packages using Cargo.
{==+==}
长期来看，我们正在研究用 Cargo 进行交叉编译的简便方法。
{==+==}

{==+==}
### Does Cargo support environments, like `production` or `test`?
{==+==}
### Cargo 是否支持环境，比如 `production` 或 `test` ？
{==+==}

{==+==}
We support environments through the use of [profiles] to support:
{==+==}
我们通过使用编译设置([profiles])来支持环境: 
{==+==}

{==+==}
[profiles]: reference/profiles.md
{==+==}

{==+==}

{==+==}
* environment-specific flags (like `-g --opt-level=0` for development
  and `--opt-level=3` for production).
* environment-specific dependencies (like `hamcrest` for test assertions).
* environment-specific `#[cfg]`
* a `cargo test` command
{==+==}
* 环境指定标志(如 `-g --opt-level=0` 用于开发环境，而 `--opt-level=3` 用于生产环境)。
* 环境指定依赖，如 `hamcrest` 用于测试断言。
* 环境指定 `#[cfg]`。
* 一个 `cargo test` 命令。
{==+==}

{==+==}
### Does Cargo work on Windows?
{==+==}
### Cargo 可以在 Windows 上使用吗？
{==+==}

{==+==}
Yes!
{==+==}
当然！
{==+==}

{==+==}
All commits to Cargo are required to pass the local test suite on Windows.
If you encounter an issue while running on Windows, we consider it a bug, so [please file an
issue][3].
{==+==}
所有提交给 Cargo 的 commit 都要求通过 Windows 上的测试。如果你在 Windows 上运行 Cargo 时遇到问题，我们将其视为一个 bug，[请提一个 issue][3]。
{==+==}

{==+==}
[3]: https://github.com/rust-lang/cargo/issues
{==+==}

{==+==}

{==+==}
### Why do binaries have `Cargo.lock` in version control, but not libraries?
{==+==}
### 为什么二进制 crate 有 `Cargo.lock`，而库 crate 却没有？
{==+==}

{==+==}
The purpose of a `Cargo.lock` lockfile is to describe the state of the world at
the time of a successful build. Cargo uses the lockfile to provide
deterministic builds on different times and different systems, by ensuring that
the exact same dependencies and versions are used as when the `Cargo.lock` file
was originally generated.
{==+==}
`Cargo.lock` 的目的在于描述一次成功构建发生时，当时世界的状态。Cargo 借助 lockfile 在不同时刻和不同系统中提供确定性的构建结果，保证使用的依赖版本与 `Cargo.lock` 被创建时使用的完全一致。
{==+==}

{==+==}
This property is most desirable from applications and packages which are at the
very end of the dependency chain (binaries). As a result, it is recommended that
all binaries check in their `Cargo.lock`.
{==+==}
这种特性最适合应用 (application) 以及那些处于依赖链末端的包 (二进制crate) 。因此，建议每个二进制 crate 都添加 `Cargo.lock`。
{==+==}

{==+==}
For libraries the situation is somewhat different. A library is not only used by
the library developers, but also any downstream consumers of the library. Users
dependent on the library will not inspect the library’s `Cargo.lock` (even if it
exists). This is precisely because a library should **not** be deterministically
recompiled for all users of the library.
{==+==}
对于库而言情况就有所不同了。一个库不仅仅是库的开发者在用，而是下游的所有使用者。依赖该库的用户不会检查这个库的 `Cargo.lock` (即使这个文件存在)。这是应该的，因为对于库的用户来说，一个库**不**应该被确定性地重新构建。
{==+==}

{==+==}
If a library ends up being used transitively by several dependencies, it’s
likely that just a single copy of the library is desired (based on semver
compatibility). If Cargo used all of the dependencies' `Cargo.lock` files,
then multiple copies of the library could be used, and perhaps even a version
conflict.
{==+==}
如果一个库被几个依赖传递性地使用，那么应该只保留该库的一份拷贝 (SemVer兼容的前提下)。如果 Cargo 使用所有依赖项的 `Cargo.lock`，就可能会使用到该库的多个版本，甚至造成版本冲突。
{==+==}

{==+==}
In other words, libraries specify SemVer requirements for their dependencies but
cannot see the full picture. Only end products like binaries have a full
picture to decide what versions of dependencies should be used.
{==+==}
换句话说，库指定了自己的依赖的 SemVer 版本，但是无法看到(依赖图的)全貌。只有像是二进制程序这样的末端产品才能看到全貌，决定使用依赖的哪个具体版本。
{==+==}

{==+==}
### Can libraries use `*` as a version for their dependencies?
{==+==}
### 库可以使用 `*` 来指定依赖的版本吗？
{==+==}

{==+==}
**As of January 22nd, 2016, [crates.io] rejects all packages (not just libraries)
with wildcard dependency constraints.**
{==+==}
**从2016年1月22日开始，[crates.io] 拒绝所有带着 `*` 依赖的包(不仅是库)。**
{==+==}

{==+==}
While libraries _can_, strictly speaking, they should not. A version requirement
of `*` says “This will work with every version ever”, which is never going
to be true. Libraries should always specify the range that they do work with,
even if it’s something as general as “every 1.x.y version”.
{==+==}
库可以，但是，库不应该可以。一个 `*` 版本请求好像在说：“这东西在任何版本都会正常工作的”，但这是不可能的。库总是应该指定一个可以工作的版本范围，即使是“所有的 1.x.y 版本” 这种宽泛的范围。
{==+==}

{==+==}
### Why `Cargo.toml`?
{==+==}
### 为什么有 `Cargo.toml`？
{==+==}


{==+==}
As one of the most frequent interactions with Cargo, the question of why the
configuration file is named `Cargo.toml` arises from time to time. The leading
capital-`C` was chosen to ensure that the manifest was grouped with other
similar configuration files in directory listings. Sorting files often puts
capital letters before lowercase letters, ensuring files like `Makefile` and
`Cargo.toml` are placed together. The trailing `.toml` was chosen to emphasize
the fact that the file is in the [TOML configuration
format](https://toml.io/).
{==+==}
作为与 Cargo 交互最多的部分，关于为什么配置文件叫 `Cargo.toml` 的问题从来没有停过。开头的大写字母 `C` 是为了让这个清单文件和其他类似的配置文件(configuration file)放在一起。文件排序一般会把大写字母开头的文件放在小写字母开头的文件之前，这保证 `Cargo.toml` 会和 `Makefile` 这类文件放在一起。后面的 `.toml` 表示这是一个 [TOML 格式](https://toml.io/) 的配置文件。
{==+==}

{==+==}
Cargo does not allow other names such as `cargo.toml` or `Cargofile` to
emphasize the ease of how a Cargo repository can be identified. An option of
many possible names has historically led to confusion where one case was handled
but others were accidentally forgotten.
{==+==}
Cargo 不允许使用其他的配置文件名如 `cargo.toml`、`Cargofile`，从而让 Cargo 仓库更容易被识别。提供可选的其他名字在历史上经常导致某些情况被忘记处理，从而导致错误。
{==+==}

{==+==}
[crates.io]: https://crates.io/
{==+==}

{==+==}

{==+==}
### How can Cargo work offline?
{==+==}
### 如何在离线状态使用 Cargo ？
{==+==}

{==+==}
Cargo is often used in situations with limited or no network access such as
airplanes, CI environments, or embedded in large production deployments. Users
are often surprised when Cargo attempts to fetch resources from the network, and
hence the request for Cargo to work offline comes up frequently.
{==+==}
Cargo 经常被用于限制或者没有网络的场景，比如在飞机上、CI 环境、或者嵌入到大型的产品部署中。当 Cargo 尝试从网络获取资源时，用户经常感到惊讶，因此经常要求 Cargo 可以在离线环境中使用。
{==+==}

{==+==}
Cargo, at its heart, will not attempt to access the network unless told to do
so. That is, if no crates come from crates.io, a git repository, or some other
network location, Cargo will never attempt to make a network connection. As a
result, if Cargo attempts to touch the network, then it's because it needs to
fetch a required resource.
{==+==}
Cargo 其实不会主动去访问网络，除非你叫它去做。也就是说，如果不需要来自 crates.io 、 git 仓库或其他网络位置的 crate 时，Cargo 绝不会去访问网络。 反过来说，如果 Cargo 尝试访问网络，那一定是它需要通过网络来获取所需的资源。
{==+==}

{==+==}
Cargo is also quite aggressive about caching information to minimize the amount
of network activity. It will guarantee, for example, that if `cargo build` (or
an equivalent) is run to completion then the next `cargo build` is guaranteed to
not touch the network so long as `Cargo.toml` has not been modified in the
meantime. This avoidance of the network boils down to a `Cargo.lock` existing
and a populated cache of the crates reflected in the lock file. If either of
these components are missing, then they're required for the build to succeed and
must be fetched remotely.
{==+==}
Cargo 会十分激进地缓存信息以最少化网络访问。它保证，如果 `cargo build` (或其他类似的指令) 执行成功，那么下一次 `cargo build` 绝不会再访问网络，除非 `Cargo.toml` 在这期间被修改。阻止网络访问的方法归结为一个 `Cargo.lock` 文件以及相对应的对 crate 的 cache。如果两者之一丢失，那么当下次构建时还是需要访问网络。
{==+==}

{==+==}
As of Rust 1.11.0, Cargo understands a new flag, `--frozen`, which is an
assertion that it shouldn't touch the network. When passed, Cargo will
immediately return an error if it would otherwise attempt a network request.
The error should include contextual information about why the network request is
being made in the first place to help debug as well. Note that this flag *does
not change the behavior of Cargo*, it simply asserts that Cargo shouldn't touch
the network as a previous command has been run to ensure that network activity
shouldn't be necessary.
{==+==}
从 Rust 1.11.0 开始，Cargo 可以使用一个新的标志 `--frozen`，其断言 Cargo 绝不会访问网络。一旦传递了这个标志，当 Cargo 试图访问网络时会立刻报错退出。错误信息中包含需要访问网络的原因以帮助排查错误。注意，这个标志 *不会改变 Cargo 的行为*，其仅仅是在之前的命令已经准备好相应的资源后，声明 Cargo 接下来不应该访问网络。
{==+==}

{==+==}
The `--offline` flag was added in Rust 1.36.0. This flag tells Cargo to not
access the network, and try to proceed with available cached data if possible.
You can use [`cargo fetch`] in one project to download dependencies before
going offline, and then use those same dependencies in another project with
the `--offline` flag (or [configuration value][offline config]).
{==+==}
在 Rust 1.36.0 中加入了 `--offline` 标志。这个标志告诉 Cargo 不要访问网络，同时尽可能用缓存的数据完成执行(如果可能的话)。你可以用 [`cargo fetch`] 在断网之前下载好需要的依赖，然后通过 `--offline` (或者 [cargo设置选项][offline config])) 将这些依赖用在另一个项目中。
{==+==}

{==+==}
For more information about vendoring, see documentation on [source
replacement][replace].
{==+==}
在 [source replacement][replace] 获取更多信息。
{==+==}

{==+==}
[replace]: reference/source-replacement.md
[`cargo fetch`]: commands/cargo-fetch.md
[offline config]: reference/config.md#netoffline
{==+==}

{==+==}

{==+==}
### Why is Cargo rebuilding my code?
{==+==}
### 为什么 Cargo 重新构建了我的代码？
{==+==}

{==+==}
Cargo is responsible for incrementally compiling crates in your project. This
means that if you type `cargo build` twice the second one shouldn't rebuild your
crates.io dependencies, for example. Nevertheless bugs arise and Cargo can
sometimes rebuild code when you're not expecting it!
{==+==}
Cargo 负责增量编译你项目中的 crate。这意味着如果你连续进行两次 `cargo build`，第二次运行不应该重新构建你的 crates.io 依赖。然而某些时候会发生 bug 导致 Cargo 重新构建你的代码。
{==+==}

{==+==}
We've long [wanted to provide better diagnostics about
this](https://github.com/rust-lang/cargo/issues/2904) but unfortunately haven't
been able to make progress on that issue in quite some time. In the meantime,
however, you can debug a rebuild at least a little by setting the `CARGO_LOG`
environment variable:
{==+==}
我们很长时间内都想[给这个问题提供更好的诊断信息](https://github.com/rust-lang/cargo/issues/2904)，但是还没有取得进展。与此同时，你至少可以通过设置 `CARGO_LOG` 来对重新构建(rebuild)的原因进行一些诊断。
{==+==}

{==+==}
```sh
$ CARGO_LOG=cargo::core::compiler::fingerprint=info cargo build
```
{==+==}

{==+==}

{==+==}
This will cause Cargo to print out a lot of information about diagnostics and
rebuilding. This can often contain clues as to why your project is getting
rebuilt, although you'll often need to connect some dots yourself since this
output isn't super easy to read just yet. Note that the `CARGO_LOG` needs to be
set for the command that rebuilds when you think it should not. Unfortunately
Cargo has no way right now of after-the-fact debugging "why was that rebuilt?"
{==+==}
这会使得 Cargo 打印出一大堆关于诊断和重新构建的信息，里面经常会有一点线索，但是大部分时候需要你费点力气去分析，因为这些信息暂时还不是那么容易阅读。注意 `CARGO_LOG` 需要设置在你认为不应该但是却导致了重新构建的命令上。不幸的是 Cargo 目前还不支持事后分析——“为什么会发生重新构建？”
{==+==}

{==+==}
Some issues we've seen historically which can cause crates to get rebuilt are:
{==+==}
历史上的一些issue告诉我们以下情况会导致 crate 被重新构建: 
{==+==}

{==+==}
* A build script prints `cargo:rerun-if-changed=foo` where `foo` is a file that
  doesn't exist and nothing generates it. In this case Cargo will keep running
  the build script thinking it will generate the file but nothing ever does. The
  fix is to avoid printing `rerun-if-changed` in this scenario.
{==+==}
* 一个构建脚本打印了 `cargo:rerun-if-changed=foo` ，但是 `foo` 这个文件并不存在而且不会被生成。这导致 Cargo 一直执行构建脚本以生成这个文件，但是始终无法生成。这种情况的解决办法就是停止打印 `rerun-if-changed` 。
{==+==}

{==+==}
* Two successive Cargo builds may differ in the set of features enabled for some
  dependencies. For example if the first build command builds the whole
  workspace and the second command builds only one crate, this may cause a
  dependency on crates.io to have a different set of features enabled, causing
  it and everything that depends on it to get rebuilt. There's unfortunately not
  really a great fix for this, although if possible it's best to have the set of
  features enabled on a crate constant regardless of what you're building in
  your workspace.
{==+==}
* 连续的两次 Cargo build 可能会在某个依赖上启用不同的 feature。例如第一个构建命令构建整个 workspace，第二个命令仅仅构建一个 crate，这可能会导致某个依赖使用了不同的 feature，导致这个依赖和依赖它的东西被重新构建。很遗憾这没有完美的解决办法，如果可能的话，最好使得，不管你在 workspace 中构建什么时，都让一个 crate 的 feature 保持不变。
{==+==}

{==+==}
* Some filesystems exhibit unusual behavior around timestamps. Cargo primarily
  uses timestamps on files to govern whether rebuilding needs to happen, but if
  you're using a nonstandard filesystem it may be affecting the timestamps
  somehow (e.g. truncating them, causing them to drift, etc). In this scenario,
  feel free to open an issue and we can see if we can accommodate the filesystem
  somehow.
{==+==}
* 一些文件系统在时间戳(timestamp)上显示出不寻常的行为。Cargo 主要利用文件的时间戳来决定重新构建是否应该发生，但是如果你用的是一个非标准的文件系统，其可能会影响到时间戳 (例如截断，或者漂移)。在这种情况下，可以开一个 issue ，我们会试着看看能否以某种方法适配这个文件系统。
{==+==}

{==+==}
* A concurrent build process is either deleting artifacts or modifying files.
  Sometimes you might have a background process that either tries to build or
  check your project. These background processes might surprisingly delete some
  build artifacts or touch files (or maybe just by accident), which can cause
  rebuilds to look spurious! The best fix here would be to wrangle the
  background process to avoid clashing with your work.
{==+==}
* 一个并发的构建进程要么在删除构建产物，要么在修改文件。有时你有一个后台进程尝试 build 或者 check 你的项目。这个后台进程可能令人惊讶的删除了某些构建产物或者改变了文件，这会导致奇怪的重新构建。最好的解决方法是调整后台进程，避免与你的工作发生冲突。
{==+==}

{==+==}
If after trying to debug your issue, however, you're still running into problems
then feel free to [open an
issue](https://github.com/rust-lang/cargo/issues/new)!
{==+==}
如果在尝试 debug 你的问题后，还是无法解决，请随意[开一个 issue](https://github.com/rust-lang/cargo/issues/new)。
{==+==}
