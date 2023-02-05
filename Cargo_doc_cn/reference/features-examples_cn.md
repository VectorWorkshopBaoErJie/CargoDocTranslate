{==+==}
## Features Examples
{==+==}
## 特性示例
{==+==}


{==+==}
The following illustrates some real-world examples of features in action.
{==+==}
下面说明一些实际中的特性示例。
{==+==}


{==+==}
### Minimizing build times and file sizes
{==+==}
### 最大限度地减少构建时间和文件大小
{==+==}


{==+==}
Some packages use features so that if the features are not enabled, it reduces
the size of the crate and reduces compile time. Some examples are:
{==+==}
一些包使用了特性，如果不启用这些特性，就会减小crate的大小并减少编译时间。一些例子是:
{==+==}


{==+==}
* [`syn`] is a popular crate for parsing Rust code. Since it is so popular, it
  is helpful to reduce compile times since it affects so many projects. It has
  a [clearly documented list][syn-features] of features which can be used to
  minimize the amount of code it contains.
{==+==}
* [`syn`] 是用于解析Rust代码的crate，对于减少编译时间很有帮助，是个流行的项目。
  它有一个 [清晰记录列表][syn-features] 的特性，可以用来减少所包含的代码量。
{==+==}


{==+==}
* [`regex`] has a [several features][regex-features] that are [well
  documented][regex-docs]. Cutting out Unicode support can reduce the
  resulting file size as it can remove some large tables.
{==+==}
* [`regex`] 有 [几个特性][regex-features] ，这些特性都有 [很好的文档][regex-docs] 。
  移除Unicode支持，将删除一些很大表，可以减少产生文件的大小。
{==+==}


{==+==}
* [`winapi`] has [a large number][winapi-features] of features that
  limit which Windows API bindings it supports.
{==+==}
* [`winapi`] 有 [大量][winapi-features] 的特性，以限制它支持哪些Windows API绑定。
{==+==}


{==+==}
* [`web-sys`] is another example similar to `winapi` that provides a [huge
  surface area][web-sys-features] of API bindings that are limited by using
  features.
{==+==}
* [`web-sys`] 是另一个类似于 `winapi` 的例子，它提供了 [大量][web-sys-features] 的API绑定，可以使用特性限制这些绑定。
{==+==}


{==+==}
[`winapi`]: https://crates.io/crates/winapi
[winapi-features]: https://github.com/retep998/winapi-rs/blob/0.3.9/Cargo.toml#L25-L431
[`regex`]: https://crates.io/crates/regex
[`syn`]: https://crates.io/crates/syn
[syn-features]: https://docs.rs/syn/1.0.54/syn/#optional-features
[regex-features]: https://github.com/rust-lang/regex/blob/1.4.2/Cargo.toml#L33-L101
[regex-docs]: https://docs.rs/regex/1.4.2/regex/#crate-features
[`web-sys`]: https://crates.io/crates/web-sys
[web-sys-features]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/crates/web-sys/Cargo.toml#L32-L1395
{==+==}

{==+==}


{==+==}
### Extending behavior
{==+==}
### 扩展行为
{==+==}


{==+==}
The [`serde_json`] package has a [`preserve_order` feature][serde_json-preserve_order]
which [changes the behavior][serde_json-code] of JSON maps to preserve the
order that keys are inserted. Notice that it enables an optional dependency
[`indexmap`] to implement the new behavior.
{==+==}
[`serde_json`] 包有 [`preserve_order` 特性][serde_json-preserve_order] ，它 [改变JSON映射行为][serde_json-code] ，以保持键的插入顺序。
请注意，它启用了一个可选的依赖 [`indexmap`] 来实现新的行为。
{==+==}


{==+==}
When changing behavior like this, be careful to make sure the changes are
[SemVer compatible]. That is, enabling the feature should not break code that
usually builds with the feature off.
{==+==}
当改变这样的行为时，要注意确保这些改变是 [语义化兼容][SemVer compatible] 的。
也就是说，启用该特性不应该破坏通常在该特性关闭时构建的代码。
{==+==}


{==+==}
[`serde_json`]: https://crates.io/crates/serde_json
[serde_json-preserve_order]: https://github.com/serde-rs/json/blob/v1.0.60/Cargo.toml#L53-L56
[SemVer compatible]: features.md#semver-compatibility
[serde_json-code]: https://github.com/serde-rs/json/blob/v1.0.60/src/map.rs#L23-L26
[`indexmap`]: https://crates.io/crates/indexmap
{==+==}

{==+==}


{==+==}
### `no_std` support
{==+==}
### `no_std` 支持
{==+==}


{==+==}
Some packages want to support both [`no_std`] and `std` environments. This is
useful for supporting embedded and resource-constrained platforms, but still
allowing extended capabilities for platforms that support the full standard
library.
{==+==}
一些包希望同时支持 [`no_std`] 和 `std` 环境。
这对于支持嵌入式和资源受限的平台是很有用的，在对于支持完整标准库的平台，仍然需要扩展功能。
{==+==}


{==+==}
The [`wasm-bindgen`] package defines a [`std` feature][wasm-bindgen-std] that
is [enabled by default][wasm-bindgen-default]. At the top of the library, it
[unconditionally enables the `no_std` attribute][wasm-bindgen-no_std]. This
ensures that `std` and the [`std` prelude] are not automatically in scope.
Then, in various places in the code ([example1][wasm-bindgen-cfg1],
[example2][wasm-bindgen-cfg2]), it uses `#[cfg(feature = "std")]` attributes
to conditionally enable extra functionality that requires `std`.
{==+==}
[`wasm-bindgen`] 包定义了 [`std` 特性][wasm-bindgen-std] ， [默认启用][wasm-bindgen-default] 。
在库的顶部，它 [非可选的启用 `no_std` 属性][wasm-bindgen-no_std] 。
这确保了 `std` 和 [`std` prelude] 不会自动进入作用域。
然后，在代码的不同地方( [example1][wasm-bindgen-cfg1] , [example2][wasm-bindgen-cfg2] )，它使用 `#[cfg(feature = "std")]` 属性，有条件地启用需要 `std` 的附加功能。
{==+==}


{==+==}
[`no_std`]: ../../reference/names/preludes.html#the-no_std-attribute
[`wasm-bindgen`]: https://crates.io/crates/wasm-bindgen
[`std` prelude]: ../../std/prelude/index.html
[wasm-bindgen-std]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/Cargo.toml#L25
[wasm-bindgen-default]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/Cargo.toml#L23
[wasm-bindgen-no_std]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/src/lib.rs#L8
[wasm-bindgen-cfg1]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/src/lib.rs#L270-L273
[wasm-bindgen-cfg2]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/src/lib.rs#L67-L75
{==+==}

{==+==}


{==+==}
### Re-exporting dependency features
{==+==}
### 重新导出依赖特性
{==+==}


{==+==}
It can be convenient to re-export the features from a dependency. This allows
the user depending on the crate to control those features without needing to
specify those dependencies directly. For example, [`regex`] [re-exports the
features][regex-re-export] from the [`regex_syntax`][regex_syntax-features]
package. Users of `regex` don't need to know about the `regex_syntax` package,
but they can still access the features it contains.
{==+==}
从依赖中重新导出特性可能是很方便的。
这允许依赖于 crate 的用户控制这些特性，而不需要直接指定这些依赖。
例如， [`regex`] [重新导出特性][regex-re-export] 来自 [`regex_syntax`][regex_syntax-features] 包。
`regex` 的用户不需要知道 `regex_syntax` 包，但他们仍然可以访问它所包含的功能。
{==+==}


{==+==}
[regex-re-export]: https://github.com/rust-lang/regex/blob/1.4.2/Cargo.toml#L65-L89
[regex_syntax-features]: https://github.com/rust-lang/regex/blob/1.4.2/regex-syntax/Cargo.toml#L17-L32
{==+==}

{==+==}


{==+==}
### Vendoring of C libraries
{==+==}
### C库支持
{==+==}


{==+==}
Some packages provide bindings to common C libraries (sometimes referred to as
["sys" crates][sys]). Sometimes these packages give you the choice to use the
C library installed on the system, or to build it from source. For example,
the [`openssl`] package has a [`vendored` feature][openssl-vendored] which
enables the corresponding `vendored` feature of [`openssl-sys`]. The
`openssl-sys` build script has some [conditional logic][openssl-sys-cfg] which
causes it to build from a local copy of the OpenSSL source code instead of
using the version from the system.
{==+==}
一些包提供了与普通C库的绑定(有时被称为 ["sys" crates][sys]) 。
有时，这些包让你选择使用系统上安装的C库，或者从源代码中构建它。
例如， [`openssl`] 包有一个 [`vendored` 特性][openssl-vendored] ，它可以启用 [`openssl-sys`] 的相应 `vendored` 特性。
`openssl-sys` 构建脚本有一些 [条件逻辑][openssl-sys-cfg] ，使其从OpenSSL源代码的本地副本构建，而不是使用系统版本。
{==+==}


{==+==}
The [`curl-sys`] package is another example where the [`static-curl`
feature][curl-sys-static] causes it to build libcurl from source. Notice that
it also has a [`force-system-lib-on-osx`][curl-sys-macos] feature which forces
it [to use the system libcurl][curl-sys-macos-code], overriding the
static-curl setting.
{==+==}
[`curl-sys`] 包是另一个例子， [`static-curl` 特性][curl-sys-static] 导致其从源码构建libcurl。
注意它也有 [`force-system-lib-on-osx`][curl-sys-macos] 特性，强制 [使用系统libcurl][curl-sys-macos-code] ，推翻了static-curl的设置。
{==+==}


{==+==}
[`openssl`]: https://crates.io/crates/openssl
[`openssl-sys`]: https://crates.io/crates/openssl-sys
[sys]: build-scripts.md#-sys-packages
[openssl-vendored]: https://github.com/sfackler/rust-openssl/blob/openssl-v0.10.31/openssl/Cargo.toml#L19
[build script]: build-scripts.md
[openssl-sys-cfg]: https://github.com/sfackler/rust-openssl/blob/openssl-v0.10.31/openssl-sys/build/main.rs#L47-L54
[`curl-sys`]: https://crates.io/crates/curl-sys
[curl-sys-static]: https://github.com/alexcrichton/curl-rust/blob/0.4.34/curl-sys/Cargo.toml#L49
[curl-sys-macos]: https://github.com/alexcrichton/curl-rust/blob/0.4.34/curl-sys/Cargo.toml#L52
[curl-sys-macos-code]: https://github.com/alexcrichton/curl-rust/blob/0.4.34/curl-sys/build.rs#L15-L20
{==+==}

{==+==}


{==+==}
### Feature precedence
{==+==}
### 特性优先级
{==+==}


{==+==}
Some packages may have mutually-exclusive features. One option to handle this
is to prefer one feature over another. The [`log`] package is an example. It
has [several features][log-features] for choosing the maximum logging level at
compile-time described [here][log-docs]. It uses [`cfg-if`] to [choose a
precedence][log-cfg-if]. If multiple features are enabled, the higher "max"
levels will be preferred over the lower levels.
{==+==}
一些包可能有相互排斥的特性。处理这个问题的选项是，一个特性优先于另一个。
[`log`] 包是一个例子。它有 [几个特性][log-features] ，用于在编译时选择最大的日志级别，描述在 [这里][log-docs] 。
它使用 [`cfg-if`] 来 [选择优先级][log-cfg-if] 。如果启用了多个特性，较高的 "max" 级别将优先于较低的级别。
{==+==}


{==+==}
[`log`]: https://crates.io/crates/log
[log-features]: https://github.com/rust-lang/log/blob/0.4.11/Cargo.toml#L29-L42
[log-docs]: https://docs.rs/log/0.4.11/log/#compile-time-filters
[log-cfg-if]: https://github.com/rust-lang/log/blob/0.4.11/src/lib.rs#L1422-L1448
[`cfg-if`]: https://crates.io/crates/cfg-if
{==+==}

{==+==}


{==+==}
### Proc-macro companion package
{==+==}
### 过程宏协同包
{==+==}


{==+==}
Some packages have a proc-macro that is intimately tied with it. However, not
all users will need to use the proc-macro. By making the proc-macro an
optional-dependency, this allows you to conveniently choose whether or not it
is included. This is helpful, because sometimes the proc-macro version must
stay in sync with the parent package, and you don't want to force the users to
have to specify both dependencies and keep them in sync.
{==+==}
有些包有一个与之紧密相连的过程宏。然而，并不是所有的用户都需要使用这个过程宏。
通过使过程宏成为可选的依赖，这允许你方便地选择是否包含它。
这很有帮助，因为有时过程宏的版本必须与父包保持同步，而你不想强迫用户必须指定两个依赖并保持它们同步。
{==+==}


{==+==}
An example is [`serde`] which has a [`derive`][serde-derive] feature which
enables the [`serde_derive`] proc-macro. The `serde_derive` crate is very
tightly tied to `serde`, so it uses an [equals version
requirement][serde-equals] to ensure they stay in sync.
{==+==}
一个例子是 [`serde`] ，它有一个 [`derive`][serde-derive] 特性，可以启用 [`serde_derive`] 过程宏。
`serde_derive` crate与 `serde` 紧密关联，所以它使用 [相同版本要求][serde-equals] 来确保它们保持同步。
{==+==}


{==+==}
[`serde`]: https://crates.io/crates/serde
[`serde_derive`]: https://crates.io/crates/serde_derive
[serde-derive]: https://github.com/serde-rs/serde/blob/v1.0.118/serde/Cargo.toml#L34-L35
[serde-equals]: https://github.com/serde-rs/serde/blob/v1.0.118/serde/Cargo.toml#L17
{==+==}

{==+==}


{==+==}
### Nightly-only features
{==+==}
### 每日构建特性
{==+==}


{==+==}
Some packages want to experiment with APIs or language features that are only
available on the Rust [nightly channel]. However, they may not want to require
their users to also use the nightly channel. An example is [`wasm-bindgen`]
which has a [`nightly` feature][wasm-bindgen-nightly] which enables an
[extended API][wasm-bindgen-unsize] that uses the [`Unsize`] marker trait that
is only available on the nightly channel at the time of this writing.
{==+==}
一些包想要试验只有在 Rust [nightly channel] 上才有的API或语言特性。
然而，他们可能不希望要求用户也使用nightly频道。
一个例子是 [`wasm-bindgen`] ，它有一个 [`nightly` 特性][wasm-bindgen-nightly] ，
它启用了 [扩展的API][wasm-bindgen-unsize] ，使用 [`Unsize`] 标记特性，在写这篇文章时，只有在nightly频道中才有。
{==+==}


{==+==}
Note that at the root of the crate it uses [`cfg_attr` to enable the nightly
feature][wasm-bindgen-cfg_attr]. Keep in mind that the [`feature` attribute]
is unrelated to Cargo features, and is used to opt-in to experimental language
features.
{==+==}
请注意，在crate的root，它使用了 [`cfg_attr` 来启用每日特性][wasm-bindgen-cfg_attr] 。
要知道， [`feature` 属性][`feature` attribute] 与Cargo特性无关，它是用来选择加入实验性语言特性的。
{==+==}


{==+==}
The [`simd_support` feature][rand-simd_support] of the [`rand`] package is another example,
which relies on a dependency that only builds on the nightly channel.
{==+==}
[`rand`] 包的 [`simd_support` 特性][rand-simd_support] 是另一个例子，它依赖于一个只在每日频道构建的依赖。
{==+==}


{==+==}
[`wasm-bindgen`]: https://crates.io/crates/wasm-bindgen
[nightly channel]: ../../book/appendix-07-nightly-rust.html
[wasm-bindgen-nightly]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/Cargo.toml#L27
[wasm-bindgen-unsize]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/src/closure.rs#L257-L269
[`Unsize`]: ../../std/marker/trait.Unsize.html
[wasm-bindgen-cfg_attr]: https://github.com/rustwasm/wasm-bindgen/blob/0.2.69/src/lib.rs#L11
[`feature` attribute]: ../../unstable-book/index.html
[`rand`]: https://crates.io/crates/rand
[rand-simd_support]: https://github.com/rust-random/rand/blob/0.7.3/Cargo.toml#L40
{==+==}

{==+==}


{==+==}
### Experimental features
{==+==}
### 实验特性
{==+==}


{==+==}
Some packages have new functionality that they may want to experiment with,
without having to commit to the stability of those APIs. The features are
usually documented that they are experimental, and thus may change or break in
the future, even during a minor release. An example is the [`async-std`]
package, which has an [`unstable` feature][async-std-unstable], which [gates
new APIs][async-std-gate] that people can opt-in to using, but may not be
completely ready to be relied upon.
{==+==}
一些包有新的特性，他们可能想进行实验，而不必承诺这些API的稳定性。
这些特性通常被记录在案，它们是实验性的，因此在未来可能会发生变化或损坏，甚至是在一个次要的版本中。
一个例子是 [async-std] 包，它有一个 [unstable] 特性 [async-std-unstable] ， [gates new APIs][async-std-gate] ，人们可以选择使用，但可能还没有完全准备好被依赖。
{==+==}


{==+==}
[`async-std`]: https://crates.io/crates/async-std
[async-std-unstable]: https://github.com/async-rs/async-std/blob/v1.8.0/Cargo.toml#L38-L42
[async-std-gate]: https://github.com/async-rs/async-std/blob/v1.8.0/src/macros.rs#L46
{==+==}

{==+==}