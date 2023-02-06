{==+==}
## Registries
{==+==}
## 注册中心
{==+==}

{==+==}
Cargo installs crates and fetches dependencies from a "registry". The default
registry is [crates.io]. A registry contains an "index" which contains a
searchable list of available crates. A registry may also provide a web API to
support publishing new crates directly from Cargo.
{==+==}
Cargo 安装 crate 并从 "注册中心" 中获取依赖。
默认的注册中心是 [crates.io] 。注册中心包含一个 "索引" ，其中包含可搜索的可用 crate 的列表 。
注册中心也可以提供网络 API ，支持通过 Cargo 直接发布新的 crate 。
{==+==}

{==+==}
> Note: If you are interested in mirroring or vendoring an existing registry,
> take a look at [Source Replacement].
{==+==}
> 注意: 如果你对镜像或拓展现有的注册中心感兴趣，请查看 [源替换][Source Replacement] 。
{==+==}

{==+==}
If you are implementing a registry server, see [Running at Registry] for more
details about the protocol between Cargo and a registry.
{==+==}
如果你想搭建注册中心服务器，请参阅 [运行注册中心][Running at Registry] 了解更多关于Cargo和注册中心之间协议的细节。
{==+==}

{==+==}
### Using an Alternate Registry
{==+==}
### 使用备用注册中心
{==+==}

{==+==}
To use a registry other than [crates.io], the name and index URL of the
registry must be added to a [`.cargo/config.toml` file][config]. The `registries`
table has a key for each registry, for example:
{==+==}
要使用 [crates.io] 以外的注册中心，必须将注册中心的名称和URL索引添加到 [`.cargo/config.toml` file][config] 。 `registries` 表中每个键对应一个注册中心，例如:
{==+==}

{==+==}
```toml
[registries]
my-registry = { index = "https://my-intranet:8080/git/index" }
```
{==+==}

{==+==}


{==+==}
The `index` key should be a URL to a git repository with the registry's index.
A crate can then depend on a crate from another registry by specifying the
`registry` key and a value of the registry's name in that dependency's entry
in `Cargo.toml`:
{==+==}
`index` 键应该是一个指向具有注册中心索引的git仓库的URL。
通过指定 `registry` 键和 `Cargo.toml` 中的依赖中的注册中心名称， crate 可以依赖不同注册中心的 crate。
{==+==}


{==+==}
```toml
# Sample Cargo.toml
[package]
name = "my-project"
version = "0.1.0"
edition = "2021"
{==+==}

{==+==}

{==+==}
[dependencies]
other-crate = { version = "1.0", registry = "my-registry" }
```
{==+==}

{==+==}

{==+==}
As with most config values, the index may be specified with an environment
variable instead of a config file. For example, setting the following
environment variable will accomplish the same thing as defining a config file:
{==+==}
就像大多数配置一样，索引可以用环境变量而不是配置文件来指定。
例如，设置以下环境变量将与定义配置文件完成相同的事情:
{==+==}

{==+==}
```ignore
CARGO_REGISTRIES_MY_REGISTRY_INDEX=https://my-intranet:8080/git/index
```
{==+==}

{==+==}

{==+==}
> Note: [crates.io] does not accept packages that depend on crates from other
> registries.
{==+==}
> 注意: [crates.io] 不接受依赖其他注册中心的crate的包。
{==+==}

{==+==}
### Publishing to an Alternate Registry
{==+==}
### 发布到备用注册中心
{==+==}

{==+==}
If the registry supports web API access, then packages can be published
directly to the registry from Cargo. Several of Cargo's commands such as
[`cargo publish`] take a `--registry` command-line flag to indicate which
registry to use. For example, to publish the package in the current directory:
{==+==}
如果注册中心支持 Web API 访问，那么包可以直接从 Cargo 发布到注册中心。
Cargo 的一些命令，如 [`cargo publish`] ，可以通过 `--registry` 命令行标志来指示使用哪个注册中心。
例如，要发布当前目录下的包:
{==+==}

{==+==}
1. `cargo login --registry=my-registry`
{==+==}

{==+==}

{==+==}
    This only needs to be done once. You must enter the secret API token
    retrieved from the registry's website. Alternatively the token may be
    passed directly to the `publish` command with the `--token` command-line
    flag or an environment variable with the name of the registry such as
    `CARGO_REGISTRIES_MY_REGISTRY_TOKEN`.
{==+==}
    这只需要执行一次。需要输入从注册中心网站获得的私密API令牌。 
    另外，令牌可以通过 `--token` 命令行标志直接传递给 `publish` 命令，或者用注册中心的名称作为环境变量，如`CARGO_REGISTRIES_MY_REGISTRY_TOKEN`。
{==+==}

{==+==}
2. `cargo publish --registry=my-registry`
{==+==}

{==+==}

{==+==}
Instead of always passing the `--registry` command-line option, the default
registry may be set in [`.cargo/config.toml`][config] with the `registry.default`
key. For example:
{==+==}
可以在 [.cargo/config.toml][config] 中用 `registry.default` 键设置默认注册中心，而不必总是传递 "--registry" 命令行选项。比如说:
{==+==}

{==+==}
```toml
[registry]
default = "my-registry"
```
{==+==}

{==+==}

{==+==}
Setting the `package.publish` key in the `Cargo.toml` manifest restricts which
registries the package is allowed to be published to. This is useful to
prevent accidentally publishing a closed-source package to [crates.io]. The
value may be a list of registry names, for example:
{==+==}
在 `Cargo.toml` 配置清单中设置 `package.publish` 键，可以限制包发布到哪些注册中心。这可以防止不小心将闭源包发布到 [crates.io] 。该值可以是一个注册中心名称的列表，例如:
{==+==}

{==+==}
```toml
[package]
# ...
publish = ["my-registry"]
```
{==+==}

{==+==}

{==+==}
The `publish` value may also be `false` to restrict all publishing, which is
the same as an empty list.
{==+==}
 `publish` 值可以是 `false` ，以限制所有发布，这与空列表相同。
{==+==}

{==+==}
The authentication information saved by [`cargo login`] is stored in the
`credentials.toml` file in the Cargo home directory (default `$HOME/.cargo`). It
has a separate table for each registry, for example:
{==+==}
由 [`cargo login`] 存储的认证信息被保存在Cargo主目录 (默认 `$HOME/.cargo`) 下的 `credentials.toml` 文件中。
对于每个注册中心对应一个单独的表，例如。
{==+==}

{==+==}
```toml
[registries.my-registry]
token = "854DvwSlUwEHtIo3kWy6x7UCPKHfzCmy"
```
{==+==}

{==+==}


{==+==}
[Source Replacement]: source-replacement.md
[Running at Registry]: running-a-registry.md
[`cargo publish`]: ../commands/cargo-publish.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo login`]: ../commands/cargo-login.md
[config]: config.md
{==+==}

{==+==}


{==+==}
<script>
(function() {
    var fragments = {
        "#running-a-registry": "running-a-registry.html",
        "#index-format": "registry-index.html",
        "#web-api": "registry-web-api.html",
        "#publish": "registry-web-api.html#publish",
        "#yank": "registry-web-api.html#yank",
        "#unyank": "registry-web-api.html#unyank",
        "#owners": "registry-web-api.html#owners",
        "#owners-list": "registry-web-api.html#owners-list",
        "#owners-add": "registry-web-api.html#owners-add",
        "#owners-remove": "registry-web-api.html#owners-remove",
        "#search": "registry-web-api.html#search",
        "#login": "registry-web-api.html#login",
    };
    var target = fragments[window.location.hash];
    if (target) {
        var url = window.location.toString();
        var base = url.substring(0, url.lastIndexOf('/'));
        window.location.replace(base + "/" + target);
    }
})();
</script>
{==+==}

{==+==}