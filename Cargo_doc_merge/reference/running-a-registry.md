## 运行注册中心

最小的注册中心可以通过拥有包含索引的git仓库和包含由 [`cargo package`] 创建的压缩的 `.crate` 文件的服务器来实现。
用户不能使用 Cargo 来发布内容，但这对于封闭环境来说可能已经足够了。索引格式在 [Registry Index] 中描述。

支持发布的完整功能的注册中心还需要有符合Cargo使用的API的Web API服务。该网络API在 [Registry Web API] 中描述。

商业和社区项目可用于建立和运行注册中心。参见 <https://github.com/rust-lang/cargo/wiki/Third-party-registries>，了解可用的列表。

[Registry Web API]: registry-web-api.md
[Registry Index]: registry-index.md
[`cargo publish`]: ../commands/cargo-publish.md
[`cargo package`]: ../commands/cargo-package.md
