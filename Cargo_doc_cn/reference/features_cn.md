{==+==}
## Features
{==+==}
## 特性
{==+==}


{==+==}
Cargo "features" provide a mechanism to express [conditional compilation] and
[optional dependencies](#optional-dependencies). A package defines a set of
named features in the `[features]` table of `Cargo.toml`, and each feature can
either be enabled or disabled. Features for the package being built can be
enabled on the command-line with flags such as `--features`. Features for
dependencies can be enabled in the dependency declaration in `Cargo.toml`.
{==+==}
Cargo的 "特性" 提供了一种机制来表达 [条件编译] 和 [可选依赖](#optional-dependencies) 。
包在 `Cargo.toml` 的 `[features]` 表中定义了一组命名的特性，每个特性可以被启用或禁用。
正在构建的包的特性可以在命令行中用 `--features` 这样的标志启用。
依赖的特性可以在 `Cargo.toml` 的依赖声明中启用。
{==+==}


{==+==}
See also the [Features Examples] chapter for some examples of how features can
be used.
{==+==}
参阅[特性实例]章节，有关于如何使用特性的一些例子。
{==+==}


{==+==}
[conditional compilation]: ../../reference/conditional-compilation.md
[Features Examples]: features-examples.md
{==+==}
[条件编译]: ../../reference/conditional-compilation.md
[特性实例]: features-examples.md
{==+==}


{==+==}
### The `[features]` section
{==+==}
### `[features]` 部分
{==+==}


{==+==}
Features are defined in the `[features]` table in `Cargo.toml`. Each feature
specifies an array of other features or optional dependencies that it enables.
The following examples illustrate how features could be used for a 2D image
processing library where support for different image formats can be optionally
included:
{==+==}
特性在 `Cargo.toml` 的 `[features]` 表中定义。
每个特性都指定了一个其他特性的数组，或者它所启用的可选依赖。
下面的例子说明了如何将特性应用于二维图像处理库，其中对不同图像格式的支持可以选择性地包含在内:
{==+==}


{==+==}
```toml
[features]
# Defines a feature named `webp` that does not enable any other features.
webp = []
```
{==+==}
```toml
[features]
# 定义了一个名为 `webp` 的特性，它不会启用任何其他特性。
webp = []
```
{==+==}


{==+==}
With this feature defined, [`cfg` expressions] can be used to conditionally
include code to support the requested feature at compile time. For example,
inside `lib.rs` of the package could include this:
{==+==}
有了这个特性的定义，[`cfg` 表达式] 可以用来在编译时，通过条件来包含代码，以支持所要求的特性。例如，在包的 `lib.rs` 里面可以这样:
{==+==}


{==+==}
```rust
// This conditionally includes a module which implements WEBP support.
#[cfg(feature = "webp")]
pub mod webp;
```
{==+==}
```rust
// 以条件性包含实现WEBP支持的模块。
#[cfg(feature = "webp")]
pub mod webp;
```
{==+==}


{==+==}
Cargo sets features in the package using the `rustc` [`--cfg` flag], and code
can test for their presence with the [`cfg` attribute] or the [`cfg` macro].
{==+==}
Cargo使用 `rustc` [`--cfg` flag] 在包中设置特性，代码可以用[`cfg` 属性]或[`cfg` 宏]测试它们的存在。
{==+==}


{==+==}
Features can list other features to enable. For example, the ICO image format
can contain BMP and PNG images, so when it is enabled, it should make sure
those other features are enabled, too:
{==+==}
特性可以列出要启用的其他特性。例如，ICO图像格式可以包含BMP和PNG图像，所以当它被启用时，应该确保其他这些特性也被启用:
{==+==}


{==+==}
```toml
[features]
bmp = []
png = []
ico = ["bmp", "png"]
webp = []
```
{==+==}

{==+==}


{==+==}
Feature names may include characters from the [Unicode XID standard] (which
includes most letters), and additionally allows starting with `_` or digits
`0` through `9`, and after the first character may also contain `-`, `+`, or
`.`.
{==+==}
特性名称可以包括 [Unicode XID standard] (包括大多数字母)中的字符，另外，允许以 `_` 或数字 `0` 到 `9` 开头，在第一个字符之后还可以包含 `-` 、 `+` 或 `.` 。
{==+==}


{==+==}
> **Note**: [crates.io] imposes additional constraints on feature name syntax
> that they must only be [ASCII alphanumeric] characters or `_`, `-`, or `+`.
{==+==}
> **注意**: [crates.io]对特性名称的语法有额外的限制，只能是[ASCII字母数字]字符或 `_` ， `-` ，或 `+` 。
{==+==}


{==+==}
[crates.io]: https://crates.io/
[Unicode XID standard]: https://unicode.org/reports/tr31/
[ASCII alphanumeric]: ../../std/primitive.char.html#method.is_ascii_alphanumeric
[`--cfg` flag]: ../../rustc/command-line-arguments.md#option-cfg
[`cfg` expressions]: ../../reference/conditional-compilation.md
[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`cfg` macro]: ../../std/macro.cfg.html
{==+==}
[crates.io]: https://crates.io/
[Unicode XID standard]: https://unicode.org/reports/tr31/
[ASCII字母数字]: ../../std/primitive.char.html#method.is_ascii_alphanumeric
[`--cfg` flag]: ../../rustc/command-line-arguments.md#option-cfg
[`cfg` expressions]: ../../reference/conditional-compilation.md
[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`cfg` macro]: ../../std/macro.cfg.html
{==+==}


{==+==}
### The `default` feature
{==+==}
### `default` 特性
{==+==}


{==+==}
By default, all features are disabled unless explicitly enabled. This can be
changed by specifying the `default` feature:
{==+==}
默认情况下，所有特性都是禁用的，除非明确启用。这可以通过指定 `default` 特性来更改:
{==+==}


{==+==}
```toml
[features]
default = ["ico", "webp"]
bmp = []
png = []
ico = ["bmp", "png"]
webp = []
```
{==+==}

{==+==}


{==+==}
When the package is built, the `default` feature is enabled which in turn
enables the listed features. This behavior can be changed by:
{==+==}
当包被构建时，启用 `default` 特性，从而又启用了所列出的特性。这种行为可以通过以下方式改变:
{==+==}


{==+==}
* The `--no-default-features` [command-line
  flag](#command-line-feature-options) disables the default features of the
  package.
* The `default-features = false` option can be specified in a [dependency
  declaration](#dependency-features).
{==+==}
* `--no-default-features`[command-line flag](#command-line-feature-options)禁用包的默认特性。
* 可以在 [依赖声明](#dependency-features) 中指定 `default-features = false` .
{==+==}


{==+==}
> **Note**: Be careful about choosing the default feature set. The default
> features are a convenience that make it easier to use a package without
> forcing the user to carefully select which features to enable for common
> use, but there are some drawbacks. Dependencies automatically enable default
> features unless `default-features = false` is specified. This can make it
> difficult to ensure that the default features are not enabled, especially
> for a dependency that appears multiple times in the dependency graph. Every
> package must ensure that `default-features = false` is specified to avoid
> enabling them.
>
> Another issue is that it can be a [SemVer incompatible
> change](#semver-compatibility) to remove a feature from the default set, so
> you should be confident that you will keep those features.
{==+==}
> **注意**: 选择默认特性要小心。默认特性让用户更容易使用包，而不需要强迫用户仔细选择启用哪些常用特性，但也有一些缺点。
> 除非指定 `default-features = false` ，否则依赖会自动启用默认特性。
> 这可能会难以确保默认特性不被启用，特别是对于在依赖图中出现多次的依赖。
> 每个包都必须确保指定 `default-features = false` 以避免启用它们。
> 另一个问题是，从默认集合中删除特性可能是[语义版本不兼容的变化](#semver-compatibility)，所以你应该有信心时才保留这些特性。
{==+==}


{==+==}
### Optional dependencies
{==+==}
### 可选依赖
{==+==}


{==+==}
Dependencies can be marked "optional", which means they will not be compiled
by default. For example, let's say that our 2D image processing library uses
an external package to handle GIF images. This can be expressed like this:
{==+==}
依赖可以标记为 "可选"，这表示默认不会编译它们。
例如，假设2D图像处理库使用一个外部包来处理GIF图像。可以这样表达:
{==+==}


{==+==}
```toml
[dependencies]
gif = { version = "0.11.1", optional = true }
```
{==+==}

{==+==}


{==+==}
By default, this optional dependency implicitly defines a feature that looks
like this:
{==+==}
默认，这个可选依赖隐式地定义了一个看起来像这样的特性。
{==+==}


{==+==}
```toml
[features]
gif = ["dep:gif"]
```
{==+==}

{==+==}


{==+==}
This means that this dependency will only be included if the `gif`
feature is enabled.
The same `cfg(feature = "gif")` syntax can be used in the code, and the
dependency can be enabled just like any feature such as `--features gif` (see
[Command-line feature options](#command-line-feature-options) below).
{==+==}
这意味着只有在启用了 `gif` 特性的情况下才会包含这个依赖。
同样的 `cfg(feature = "gif")` 语法可以在代码中使用，并且该依赖可以像任何特性一样被启用，
例如 `--features gif` (见下面的[命令行特性选项](#command-line-feature-options))。
{==+==}


{==+==}
In some cases, you may not want to expose a feature that has the same name
as the optional dependency.
For example, perhaps the optional dependency is an internal detail, or you
want to group multiple optional dependencies together, or you just want to use
a better name.
If you specify the optional dependency with the `dep:` prefix anywhere
in the `[features]` table, that disables the implicit feature.
{==+==}
在某些情况下，你可能不想公开与可选依赖同名的特性。
例如，也许这个可选依赖是一个内部细节，或者你想把多个可选依赖组合在一起，或者你只是想使用一个更好的名字。
如果你在 `[features]` 表中的任何地方用 `dep:` 前缀来指定可选依赖，将禁用该隐式特性。
{==+==}


{==+==}
> **Note**: The `dep:` syntax is only available starting with Rust 1.60.
> Previous versions can only use the implicit feature name.
{==+==}
> **注意**: `dep:` 语法仅从Rust 1.60开始可用。
> 以前的版本只能使用隐式的特性名称。
{==+==}


{==+==}
For example, let's say in order to support the AVIF image format, our library
needs two other dependencies to be enabled:
{==+==}
例如，假设为了支持AVIF图像格式，库需要启用另外两个依赖项:
{==+==}


{==+==}
```toml
[dependencies]
ravif = { version = "0.6.3", optional = true }
rgb = { version = "0.8.25", optional = true }

[features]
avif = ["dep:ravif", "dep:rgb"]
```
{==+==}

{==+==}


{==+==}
In this example, the `avif` feature will enable the two listed dependencies.
This also avoids creating the implicit `ravif` and `rgb` features, since we
don't want users to enable those individually as they are internal details to
our crate.
{==+==}
在这个例子中， `avif` 特性将启用两个列出的依赖。
这也避免了创建隐式的 `ravif` 和 `rgb` 特性，因为不希望用户单独启用这些特性，它们是crate的内部细节。
{==+==}


{==+==}
> **Note**: Another way to optionally include a dependency is to use
> [platform-specific dependencies]. Instead of using features, these are
> conditional based on the target platform.
{==+==}
> **注意**: 另一种可选的包含依赖的方法是使用[特定平台依赖]。
> 而不是使用特性，是基于目标平台为条件。
{==+==}


{==+==}
[platform-specific dependencies]: specifying-dependencies.md#platform-specific-dependencies
{==+==}
[特定平台依赖]: specifying-dependencies.md#platform-specific-dependencies
{==+==}


{==+==}
### Dependency features
{==+==}
### 依赖特性
{==+==}


{==+==}
Features of dependencies can be enabled within the dependency declaration. The
`features` key indicates which features to enable:
{==+==}
依赖特性可以在依赖声明中启用。 `features` 键表示要启用哪些特性。
{==+==}


{==+==}
```toml
[dependencies]
# Enables the `derive` feature of serde.
serde = { version = "1.0.118", features = ["derive"] }
```
{==+==}
```toml
[dependencies]
# 启用serde的 `derive` 特性。
serde = { version = "1.0.118", features = ["derive"] }
```
{==+==}


{==+==}
The [`default` features](#the-default-feature) can be disabled using
`default-features = false`:
{==+==}
可以用 `default-features = false` 来禁用 [`default` 特性](#the-default-feature) 。
{==+==}


{==+==}
```toml
[dependencies]
flate2 = { version = "1.0.3", default-features = false, features = ["zlib"] }
```
{==+==}

{==+==}


{==+==}
> **Note**: This may not ensure the default features are disabled. If another
> dependency includes `flate2` without specifying `default-features = false`,
> then the default features will be enabled. See [feature
> unification](#feature-unification) below for more details.
{==+==}
> **注意**: 这可能无法确保默认特性被禁用。
> 如果另一个依赖包含 `flate2` 而没有指定 `default-features = false` ，那么将启用默认特性。
> 更多细节请参见下面的[特性联合](#feature-unification)。
{==+==}


{==+==}
Features of dependencies can also be enabled in the `[features]` table. The
syntax is `"package-name/feature-name"`. For example:
{==+==}
依赖的特性也可以在 `[features]` 表中启用。
语法是 `"package-name/feature-name"` 。例如:
{==+==}


{==+==}
```toml
[dependencies]
jpeg-decoder = { version = "0.1.20", default-features = false }

[features]
# Enables parallel processing support by enabling the "rayon" feature of jpeg-decoder.
parallel = ["jpeg-decoder/rayon"]
```
{==+==}
```toml
[dependencies]
jpeg-decoder = { version = "0.1.20", default-features = false }

[features]
# 通过启用jpeg解码器的 "rayon" 特性来启用并行处理支持。
parallel = ["jpeg-decoder/rayon"]
```
{==+==}


{==+==}
The `"package-name/feature-name"` syntax will also enable `package-name`
if it is an optional dependency. Often this is not what you want.
You can add a `?` as in `"package-name?/feature-name"` which will only enable
the given feature if something else enables the optional dependency.
{==+==}
`"package-name/feature-name"` 语法也将启用 `package-name` ，如果它是一个可选的依赖。通常这不是你想要的。
你可以在 `"package-name?/feature-name"` 中添加一个 `?` ，只有在其他内容启用了可选依赖时，才会启用给定的特性。
{==+==}


{==+==}
> **Note**: The `?` syntax is only available starting with Rust 1.60.
{==+==}
> **注意**: `?` 语法仅从Rust 1.60开始可用。
{==+==}


{==+==}
For example, let's say we have added some serialization support to our
library, and it requires enabling a corresponding feature in some optional
dependencies.
That can be done like this:
{==+==}
例如，假设在库中添加序列化支持，它需要在一些可选的依赖中启用相应的特性。
可以像这样做:
{==+==}


{==+==}
```toml
[dependencies]
serde = { version = "1.0.133", optional = true }
rgb = { version = "0.8.25", optional = true }

[features]
serde = ["dep:serde", "rgb?/serde"]
```
{==+==}

{==+==}


{==+==}
In this example, enabling the `serde` feature will enable the serde
dependency.
It will also enable the `serde` feature for the `rgb` dependency, but only if
something else has enabled the `rgb` dependency.
{==+==}
在这个例子中，启用 `serde` 特性将启用serde依赖。
它也将启用 `rgb` 依赖的 `serde` 特性，但只有在其他内容已经启用了 `rgb` 依赖的情况下。
{==+==}


{==+==}
### Command-line feature options
{==+==}
### 命令行可选特性
{==+==}


{==+==}
The following command-line flags can be used to control which features are
enabled:
{==+==}
以下命令行标志可以用来控制哪些特性被启用:
{==+==}


{==+==}
* `--features` _FEATURES_: Enables the listed features. Multiple features may
  be separated with commas or spaces. If using spaces, be sure to use quotes
  around all the features if running Cargo from a shell (such as `--features
  "foo bar"`). If building multiple packages in a [workspace], the
  `package-name/feature-name` syntax can be used to specify features for
  specific workspace members.
{==+==}
* `--features` _FEATURES_: 启用列出的特性。多个特性可以用逗号或空格分开。
  若使用空格，如果从shell中运行Cargo，请确保在所有特性周围使用引号(例如 `---features "foo bar"` )。
  如果在[工作空间]中构建多个包，可以使用 `package-name/feature-name` 语法来指定特定工作空间成员的特性。
{==+==}


{==+==}
* `--all-features`: Activates all features of all packages selected on the
  command-line.
{==+==}
* `--all-features`: 激活在命令行上选择的所有包的所有特性。
{==+==}


{==+==}
* `--no-default-features`: Does not activate the [`default`
  feature](#the-default-feature) of the selected packages.
{==+==}
* `--no-default-features`: 不激活所选包的[`default` 特性](#the-default-feature)。
{==+==}


{==+==}
[workspace]: workspaces.md
{==+==}

{==+==}


{==+==}
### Feature unification
{==+==}
### 特性联合
{==+==}


{==+==}
Features are unique to the package that defines them. Enabling a feature on a
package does not enable a feature of the same name on other packages.
{==+==}
特性对于定义它们的包来说是唯一的。在包上启用一个特性，不会在其他包上启用相同名称的特性。
{==+==}


{==+==}
When a dependency is used by multiple packages, Cargo will use the union of
all features enabled on that dependency when building it. This helps ensure
that only a single copy of the dependency is used. See the [features section]
of the resolver documentation for more details.
{==+==}
当依赖被多个包使用时，Cargo会在构建时使用该依赖上启用的所有特性的联合。
这有助于确保只使用该依赖的一个副本。
更多细节请参见解析器文档中的 [特性部分] 。
{==+==}


{==+==}
For example, let's look at the [`winapi`] package which uses a [large
number][winapi-features] of features. If your package depends on a package
`foo` which enables the "fileapi" and "handleapi" features of `winapi`, and
another dependency `bar` which enables the "std" and "winnt" features of
`winapi`, then `winapi` will be built with all four of those features enabled.
{==+==}
例如，来看一下 [`winapi`] 包，它使用了 [大量][winapi-features] 的特性。
如果你的包依赖于包 `foo` ，它启用了 `winapi` 的 "fileapi" 和 "handleapi" 特性，
而另一个依赖包 `bar` 启用了 `winapi` 的 "std" 和 "winnt" 特性，那么 `winapi` 将在启用所有这四种特性后被构建。
{==+==}


{==+==}
![winapi features example](../images/winapi-features.svg)
{==+==}

{==+==}


{==+==}
[`winapi`]: https://crates.io/crates/winapi
[winapi-features]: https://github.com/retep998/winapi-rs/blob/0.3.9/Cargo.toml#L25-L431
{==+==}

{==+==}


{==+==}
A consequence of this is that features should be *additive*. That is, enabling
a feature should not disable functionality, and it should usually be safe to
enable any combination of features. A feature should not introduce a
[SemVer-incompatible change](#semver-compatibility).
{==+==}
这样做的效果是，特性应该是 *增加性* 的。也就是说，启用特性不应该禁用功能，
而且启用任意特性的组合通常都是安全的。一个特性不应该引入 [不兼容语义化改变](#semver-compatibility)。
{==+==}


{==+==}
For example, if you want to optionally support [`no_std`] environments, **do
not** use a `no_std` feature. Instead, use a `std` feature that *enables*
`std`. For example:
{==+==}
例如，如果你想选择性地支持 [`no_std`] 环境，**不要**使用 `no_std` 特性。相反，使用 "std" 特性，*启用* `std` 。比如说:
{==+==}


{==+==}
```rust
#![no_std]

#[cfg(feature = "std")]
extern crate std;

#[cfg(feature = "std")]
pub fn function_that_requires_std() {
    // ...
}
```
{==+==}

{==+==}


{==+==}
[`no_std`]: ../../reference/names/preludes.html#the-no_std-attribute
[features section]: resolver.md#features
{==+==}

{==+==}


{==+==}
#### Mutually exclusive features
{==+==}
#### 互斥特性
{==+==}


{==+==}
There are rare cases where features may be mutually incompatible with one
another. This should be avoided if at all possible, because it requires
coordinating all uses of the package in the dependency graph to cooperate to
avoid enabling them together. If it is not possible, consider adding a compile
error to detect this scenario. For example:
{==+==}
在极少数情况下，特性之间可能相互不兼容。
如果可能的话，应该避免这种情况，因为这需要协调依赖图中包的所有使用，避免同时启用。
如果不可能，可以考虑增加一个编译错误来检测这种情况。比如说:
{==+==}


{==+==}
```rust,ignore
#[cfg(all(feature = "foo", feature = "bar"))]
compile_error!("feature \"foo\" and feature \"bar\" cannot be enabled at the same time");
```
{==+==}

{==+==}


{==+==}
Instead of using mutually exclusive features, consider some other options:
{==+==}
与其使用相互排斥的特性，不如考虑一些其他选择:
{==+==}


{==+==}
* Split the functionality into separate packages.
* When there is a conflict, [choose one feature over
  another][feature-precedence]. The [`cfg-if`] package can help with writing
  more complex `cfg` expressions.
* Architect the code to allow the features to be enabled concurrently, and use
  runtime options to control which is used. For example, use a config file,
  command-line argument, or environment variable to choose which behavior to
  enable.
{==+==}
* 将功能分成独立的包。
* 当有冲突时，[选择其中之一][feature-precedence]。[`cfg-if`] 包可以帮助编写更复杂的 `cfg` 表达式。
* 构建代码以允许同时启用这些特性，并使用运行时选项来控制使用哪个特性。例如，使用一个配置文件、命令行参数或环境变量来选择启用哪种行为。
{==+==}


{==+==}
[`cfg-if`]: https://crates.io/crates/cfg-if
[feature-precedence]: features-examples.md#feature-precedence
{==+==}

{==+==}


{==+==}
#### Inspecting resolved features
{==+==}
#### 检查解析特性
{==+==}


{==+==}
In complex dependency graphs, it can sometimes be difficult to understand how
different features get enabled on various packages. The [`cargo tree`] command
offers several options to help inspect and visualize which features are
enabled. Some options to try:
{==+==}
在复杂的依赖图中，有时很难理解不同的特性是如何在不同的包上被启用的。
[`cargo tree`] 命令提供了几个选项来帮助检查和可视化哪些特性被启用。可以尝试:
{==+==}


{==+==}
* `cargo tree -e features`: This will show features in the dependency graph.
  Each feature will appear showing which package enabled it.
* `cargo tree -f "{p} {f}"`: This is a more compact view that shows a
  comma-separated list of features enabled on each package.
* `cargo tree -e features -i foo`: This will invert the tree, showing how
  features flow into the given package "foo". This can be useful because
  viewing the entire graph can be quite large and overwhelming. Use this when
  you are trying to figure out which features are enabled on a specific
  package and why. See the example at the bottom of the [`cargo tree`] page on
  how to read this.
{==+==}
* `cargo tree -e features`: 这将显示依赖图中的特性。
  每个特性都会出现，显示哪个包启用了它。
* `cargo tree -f "{p} {f}"`: 这是更紧凑的视图，显示每个包上启用的特性的逗号分隔的列表。
* `cargo tree -e features -i foo`: 这将反转树形图，显示特性如何流入给定的包 "foo"。这可能很有用，因为查看整个图表可能相当大，而且令人不知所措。当你试图弄清楚哪些特性在特定的包上被启用以及为什么要这样做时，可以使用这个方法。请看[`cargo tree`]页面底部的例子，了解阅读。
{==+==}


{==+==}
[`cargo tree`]: ../commands/cargo-tree.md
{==+==}

{==+==}


{==+==}
### Feature resolver version 2
{==+==}
### 特性解析版本2
{==+==}


{==+==}
A different feature resolver can be specified with the `resolver` field in
`Cargo.toml`, like this:
{==+==}
可以用 `Cargo.toml` 中的 `resolver` 字段指定不同的特性解析器，像这样:
{==+==}


{==+==}
```toml
[package]
name = "my-package"
version = "1.0.0"
resolver = "2"
```
{==+==}

{==+==}


{==+==}
See the [resolver versions] section for more detail on specifying resolver
versions.
{==+==}
关于指定解析器版本的更多细节，请参见 [解析器版本] 部分。
{==+==}


{==+==}
The version `"2"` resolver avoids unifying features in a few situations where
that unification can be unwanted. The exact situations are described in the
[resolver chapter][resolver-v2], but in short, it avoids unifying in these
situations:
{==+==}
版本 `"2"` 的解析器在一些不需要联合的情况下避免了联合的特性。
具体的情况在 [解析器章节][resolver-v2] 中有描述，简而言之，它避免在这些情况下进行联合。
{==+==}


{==+==}
* Features enabled on [platform-specific dependencies] for targets not
  currently being built are ignored.
* [Build-dependencies] and proc-macros do not share features with normal
  dependencies.
* [Dev-dependencies] do not activate features unless building a target that
  needs them (like tests or examples).
{==+==}
* 对于目前没有被构建的目标，在[特定平台依赖]上启用的特性会被忽略。
* [Build-dependencies] 和过程宏不与常规依赖共享特性。
* [Dev-dependencies] 不会激活特性，除非构建需要它们的目标(如测试或实例)。
{==+==}


{==+==}
Avoiding the unification is necessary for some situations. For example, if a
build-dependency enables a `std` feature, and the same dependency is used as a
normal dependency for a `no_std` environment, enabling `std` would break the
build.
{==+==}
在某些情况下，避免联合是必要的。
例如，如果build-dependency启用了 `std` 特性，而同一个依赖被用作 `no_std` 环境的常规依赖，启用 `std` 会破坏构建。
{==+==}


{==+==}
However, one drawback is that this can increase build times because the
dependency is built multiple times (each with different features). When using
the version `"2"` resolver, it is recommended to check for dependencies that
are built multiple times to reduce overall build time. If it is not *required*
to build those duplicated packages with separate features, consider adding
features to the `features` list in the [dependency
declaration](#dependency-features) so that the duplicates end up with the same
features (and thus Cargo will build it only once). You can detect these
duplicate dependencies with the [`cargo tree --duplicates`][`cargo tree`]
command. It will show which packages are built multiple times; look for any
entries listed with the same version. See [Inspecting resolved
features](#inspecting-resolved-features) for more on fetching information on
the resolved features. For build dependencies, this is not necessary if you
are cross-compiling with the `--target` flag because build dependencies are
always built separately from normal dependencies in that scenario.
{==+==}
然而，一个缺点是，这可能会增加构建时间，因为依赖会被构建多次(每次都有不同的特性)。
当使用版本 `"2"` 解析器时，建议检查那些被多次构建的依赖，以减少整体构建时间。
如果不是 *必须* 要用单独的特性来构建这些重复的包，可以考虑在[依赖声明](#dependency-features)中的 `特性` 列表中添加特性，
这样重复的包最后就会有相同的特性(因此Cargo只会构建一次)。
你可以用 [`cargo tree --duplicates`][`cargo tree`] 命令检测这些重复的依赖。它将显示哪些包被多次构建；
寻找任何列出相同版本的条目。参见 [Inspecting resolved features](#inspecting-resolved-features) 获取更多关于获取已解决特性的信息。
对于构建依赖，如果你使用 `--target` 标志进行交叉编译，则没有必要这样做，因为在这种情况下，构建依赖总是与普通依赖分开构建。
{==+==}


{==+==}
#### Resolver version 2 command-line flags
{==+==}
#### 解析器版本2命令行标记
{==+==}


{==+==}
The `resolver = "2"` setting also changes the behavior of the `--features` and
`--no-default-features` [command-line options](#command-line-feature-options).
{==+==}
 `resolver = "2"` 的设置也改变了 `--features` 和 `--no-default-features` [命令行选项](#command-line-feature-options) 的行为。
{==+==}


{==+==}
With version `"1"`, you can only enable features for the package in the
current working directory. For example, in a workspace with packages `foo` and
`bar`, and you are in the directory for package `foo`, and ran the command
`cargo build -p bar --features bar-feat`, this would fail because the
`--features` flag only allowed enabling features on `foo`.
{==+==}
在版本 `"1"` 中，你只能为当前工作目录中的包启用特性。
例如，在一个有 `foo` 和 `bar` 包的工作空间中，如果你在 `foo` 包的目录下，运行 `cargo build -p bar --features bar-feat` 命令，就会失败，
因为 `--features` 标志只允许启用 `foo` 的特性。
{==+==}


{==+==}
With `resolver = "2"`, the features flags allow enabling features for any of
the packages selected on the command-line with `-p` and `--workspace` flags.
For example:
{==+==}
在 `resolver = "2"` 的情况下，特性标志允许启用任何在命令行中用 `-p` 和 `--workspace` 标志选择的包的特性。比如说:
{==+==}


{==+==}
```sh
# This command is allowed with resolver = "2", regardless of which directory
# you are in.
cargo build -p foo -p bar --features foo-feat,bar-feat

# This explicit equivalent works with any resolver version:
cargo build -p foo -p bar --features foo/foo-feat,bar/bar-feat
```
{==+==}
```sh
# 这个命令在 resolver = "2" 的情况下是允许的，无论你在哪个目录下。
cargo build -p foo -p bar --features foo-feat,bar-feat

# 这个明确的等价形式适用于任何解析器版本:
cargo build -p foo -p bar --features foo/foo-feat,bar/bar-feat
```
{==+==}


{==+==}
Additionally, with `resolver = "1"`, the `--no-default-features` flag only
disables the default feature for the package in the current directory. With
version "2", it will disable the default features for all workspace members.
{==+==}
此外，在 `resolver = "1"` 的情况下，`--no-default-features` 标志只停用当前目录下包的默认特性。
如果版本为 "2" ，它将禁用所有工作空间成员的默认特性。
{==+==}


{==+==}
[resolver versions]: resolver.md#resolver-versions
[build-dependencies]: specifying-dependencies.md#build-dependencies
[dev-dependencies]: specifying-dependencies.md#development-dependencies
[resolver-v2]: resolver.md#feature-resolver-version-2
{==+==}
[解析器版本]: resolver.md#resolver-versions
[build-dependencies]: specifying-dependencies.md#build-dependencies
[dev-dependencies]: specifying-dependencies.md#development-dependencies
[resolver-v2]: resolver.md#feature-resolver-version-2
{==+==}


{==+==}
### Build scripts
{==+==}
### 构建脚本
{==+==}


{==+==}
[Build scripts] can detect which features are enabled on the package by
inspecting the `CARGO_FEATURE_<name>` environment variable, where `<name>` is
the feature name converted to uppercase and `-` converted to `_`.
{==+==}
[构建脚本]可以通过检查 `CARGO_FEATURE_<name>` 环境变量来检测包上启用了哪些特性，其中`<name>`是转换为大写的特性名称， `-` 转换为 `_` 。
{==+==}


{==+==}
[build scripts]: build-scripts.md
{==+==}
[构建脚本]: build-scripts.md
{==+==}


{==+==}
### Required features
{==+==}
### 必须特性
{==+==}


{==+==}
The [`required-features` field] can be used to disable specific [Cargo
targets] if a feature is not enabled. See the linked documentation for more
details.
{==+==}
如果某个特性没有被启用，[`required-features` 字段]可以用来禁用特定的[Cargo 目标]。
更多细节请参阅链接的文档。
{==+==}


{==+==}
[`required-features` field]: cargo-targets.md#the-required-features-field
[Cargo targets]: cargo-targets.md
{==+==}
[`required-features` 字段]: cargo-targets.md#the-required-features-field
[Cargo 目标]: cargo-targets.md
{==+==}


{==+==}
### SemVer compatibility
{==+==}
### 语义化版本兼容
{==+==}


{==+==}
Enabling a feature should not introduce a SemVer-incompatible change. For
example, the feature shouldn't change an existing API in a way that could
break existing uses. More details about what changes are compatible can be
found in the [SemVer Compatibility chapter](semver.md).
{==+==}
启用特性不应该引入语义化不兼容的变化。
例如，该特性不应该以可能破坏现有用途的方式改变现有的API。
关于哪些变化是兼容的，可以在[语义化版本兼容性章节](semver.md)中找到更多细节。
{==+==}


{==+==}
Care should be taken when adding and removing feature definitions and optional
dependencies, as these can sometimes be backwards-incompatible changes. More
details can be found in the [Cargo section](semver.md#cargo) of the SemVer
Compatibility chapter. In short, follow these rules:
{==+==}
在添加和删除特性定义和可选的依赖时应该小心，因为这些有时可能是向后不兼容的变化。
更多细节可以在语义化版本兼容性章节的[Cargo 部分](semver.md#cargo)中找到。简而言之，遵循这些规则:
{==+==}


{==+==}
* The following is usually safe to do in a minor release:
  * Add a [new feature][cargo-feature-add] or [optional dependency][cargo-dep-add].
  * [Change the features used on a dependency][cargo-change-dep-feature].
* The following should usually **not** be done in a minor release:
  * [Remove a feature][cargo-feature-remove] or [optional dependency][cargo-remove-opt-dep].
  * [Moving existing public code behind a feature][item-remove].
  * [Remove a feature from a feature list][cargo-feature-remove-another].
{==+==}
* 在次要版本中，以下做法通常是安全的:
  * 添加 [新特性][cargo-feature-add] 或 [可选依赖][cargo-dep-add]。
  * [改变依赖上使用的特性][cargo-change-dep-feature].
* 以下内容通常**不**应该在次要版本中去做:
  * [移除特性][cargo-feature-remove] 或者 [可选依赖][cargo-remove-opt-dep].
  * [将现有的公共代码移到特性之后][item-remove].
  * [从特性列表中移除特性][cargo-feature-remove-another].
{==+==}


{==+==}
See the links for caveats and examples.
{==+==}
注意事项和实例见链接。
{==+==}


{==+==}
[cargo-change-dep-feature]: semver.md#cargo-change-dep-feature
[cargo-dep-add]: semver.md#cargo-dep-add
[cargo-feature-add]: semver.md#cargo-feature-add
[item-remove]: semver.md#item-remove
[cargo-feature-remove]: semver.md#cargo-feature-remove
[cargo-remove-opt-dep]: semver.md#cargo-remove-opt-dep
[cargo-feature-remove-another]: semver.md#cargo-feature-remove-another
{==+==}

{==+==}


{==+==}
### Feature documentation and discovery
{==+==}
### 特征文档和发现
{==+==}


{==+==}
You are encouraged to document which features are available in your package.
This can be done by adding [doc comments] at the top of `lib.rs`. As an
example, see the [regex crate source], which when rendered can be viewed on
[docs.rs][regex-docs-rs]. If you have other documentation, such as a user
guide, consider adding the documentation there (for example, see [serde.rs]).
If you have a binary project, consider documenting the features in the README
or other documentation for the project (for example, see [sccache]).
{==+==}
我们鼓励你记录你的包中有哪些特性。
这可以通过在 `lib.rs` 的顶部添加 [doc comments] 来实现。
请查看 [regex crate source]例子，它被渲染后可以在 [docs.rs][regex-docs-rs] 上查看。
如果你有其他的文档，比如用户指南，考虑将文档添加到那里(例如，参阅[serde.rs])。
如果你有一个二进制项目，考虑在README或项目的其他文档中记录这些特性(例如，参阅[sccache])。
{==+==}


{==+==}
Clearly documenting the features can set expectations about features that are
considered "unstable" or otherwise shouldn't be used. For example, if there is
an optional dependency, but you don't want users to explicitly list that
optional dependency as a feature, exclude it from the documented list.
{==+==}
明确记录特性可以为那些被认为是 "不稳定" 或不应该被使用的特性设定期望。
例如，如果有一个可选的依赖，但你不希望用户明确地把这个可选依赖列为特性，那么就把它从记录的列表中排除。
{==+==}


{==+==}
Documentation published on [docs.rs] can use metadata in `Cargo.toml` to
control which features are enabled when the documentation is built. See
[docs.rs metadata documentation] for more details.
{==+==}
在[docs.rs]上发布的文档可以使用 `Cargo.toml` 中的元数据来控制文档构建时启用哪些特性。
更多细节请参见 [docs.rs metadata documentation] 。
{==+==}


{==+==}
> **Note**: Rustdoc has experimental support for annotating the documentation
> to indicate which features are required to use certain APIs. See the
> [`doc_cfg`] documentation for more details. An example is the [`syn`
> documentation], where you can see colored boxes which note which features
> are required to use it.
{==+==}
> **注意**: Rustdoc实验性地支持对文档进行注释，以表明使用某些API需要哪些特性。
> 更多细节见 [`doc_cfg`] 文档。一个例子是[`syn` documentation]，你可以看到彩色的方框，其中指出使用哪些特性是需要的。
{==+==}


{==+==}
[docs.rs metadata documentation]: https://docs.rs/about/metadata
[docs.rs]: https://docs.rs/
[serde.rs]: https://serde.rs/feature-flags.html
[doc comments]: ../../rustdoc/how-to-write-documentation.html
[regex crate source]: https://github.com/rust-lang/regex/blob/1.4.2/src/lib.rs#L488-L583
[regex-docs-rs]: https://docs.rs/regex/1.4.2/regex/#crate-features
[sccache]: https://github.com/mozilla/sccache/blob/0.2.13/README.md#build-requirements
[`doc_cfg`]: ../../unstable-book/language-features/doc-cfg.html
[`syn` documentation]: https://docs.rs/syn/1.0.54/syn/#modules
{==+==}

{==+==}


{==+==}
#### Discovering features
{==+==}
#### 发现特性
{==+==}


{==+==}
When features are documented in the library API, this can make it easier for
your users to discover which features are available and what they do. If the
feature documentation for a package isn't readily available, you can look at
the `Cargo.toml` file, but sometimes it can be hard to track it down. The
crate page on [crates.io] has a link to the source repository if available.
Tools like [`cargo vendor`] or [cargo-clone-crate] can be used to download the
source and inspect it.
{==+==}
当特性被记录在库的API中时，这可以使你的用户更容易发现哪些特性是可用的以及它们的作用。
如果一个包的特性文档不容易获得，你可以看看 `Cargo.toml` 文件，但有时会很难追踪到它。
如果存在，[crates.io]上的crate页面有一个指向源码库的链接。
像 [`cargo vendor`] 或 [cargo-clone-crate] 这样的工具可以用来下载源码并检查它。
{==+==}


{==+==}
[`cargo vendor`]: ../commands/cargo-vendor.md
[cargo-clone-crate]: https://crates.io/crates/cargo-clone-crate
{==+==}

{==+==}


{==+==}
### Feature combinations
{==+==}
### 特性组合
{==+==}


{==+==}
Because features are a form of conditional compilation, they require an exponential number of configurations and test cases to be 100% covered. By default, tests, docs, and other tooling such as [Clippy](https://github.com/rust-lang/rust-clippy) will only run with the default set of features.
{==+==}
因为特性是一种条件编译的形式，它们需要指数级的配置和测试案例才能100%覆盖。
默认情况下，测试、文档和其他工具，如[Clippy](https://github.com/rust-lang/rust-clippy)将只在默认的特性集下运行。
{==+==}


{==+==}
We encourage you to consider your strategy and tooling in regards to different feature combinations - Every project will have different requirements in conjunction with time, resources, and the cost-benefit of covering specific scenarios. Common configurations may be with / without default features, specific combinations of features, or all combinations of features.
{==+==}
我们鼓励你考虑你的策略和工具在不同的特性组合方面 - 每个项目将有不同的要求，结合时间、资源和覆盖特定场景的成本效益。
常见的配置可能是有/无默认特性，特定的特性组合，或所有的特性组合。
{==+==}