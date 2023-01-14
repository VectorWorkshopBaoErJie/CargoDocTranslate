{==+==}
## Running a Registry
{==+==}
## 动行注册中心
{==+==}


{==+==}
A minimal registry can be implemented by having a git repository that contains
an index, and a server that contains the compressed `.crate` files created by
[`cargo package`]. Users won't be able to use Cargo to publish to it, but this
may be sufficient for closed environments. The index format is described in
[Registry Index].
{==+==}
最小的注册中心可以通过拥有包含索引的git仓库和包含由 [`cargo package`] 创建的压缩的 `.crate` 文件的服务器来实现。
用户不能使用 Cargo 来发布内容，但这对于封闭环境来说可能已经足够了。索引格式在 [Registry Index] 中描述。
{==+==}


{==+==}
A full-featured registry that supports publishing will additionally need to
have a web API service that conforms to the API used by Cargo. The web API is
described in [Registry Web API].
{==+==}
支持发布的完整功能的注册中心还需要有符合Cargo使用的API的Web API服务。该网络API在[Registry Web API]中描述。
{==+==}


{==+==}
Commercial and community projects are available for building and running a
registry. See <https://github.com/rust-lang/cargo/wiki/Third-party-registries>
for a list of what is available.
{==+==}
商业和社区项目可用于建立和运行注册中心。参见 <https://github.com/rust-lang/cargo/wiki/Third-party-registries>，了解可用的列表。
{==+==}


{==+==}
[Registry Web API]: registry-web-api.md
[Registry Index]: registry-index.md
[`cargo publish`]: ../commands/cargo-publish.md
[`cargo package`]: ../commands/cargo-package.md
{==+==}

{==+==}