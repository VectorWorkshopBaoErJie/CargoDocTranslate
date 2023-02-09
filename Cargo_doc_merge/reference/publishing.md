## 发布到crates.io

你想与世界分享一个库，就该把它发布到 [crates.io] 上，发布crate指的是将特定版本上传到[crates.io]上托管。

在发布crate时要小心，发布将是**永久性的**，一旦发布就永远不能覆盖该版本，也不能删除代码。然后，对可发布的版本数量没有限制。

### 在你第一次发布之前

首先，你需要一个[crates.io]的账户来获取API token。要做到这一点，请 [访问主页][crates.io] 并通过GitHub账户登录(目前需要)。
之后，访问你的 [账户设置](https://crates.io/me) 页面并运行 [`cargo login`] 命令。

```console
$ cargo login
```

然后在提示中输入指定的Token。
```console
please paste the API Token found on https://crates.io/me below
abcdefghijklmnopqrstuvwxyz012345
```

这个命令会将你的API token告知Cargo，并将其保存在你本地的 `~/.cargo/credentials.toml` 中。
请注意，这个token是**私密的**，不应该与其他人分享。如果因某些原因泄露，你应该立即撤销它。

### 在发布新crate之前

[cates.io]上的crate名称是以先到先得的方式分配的。一旦一个crate的名字被占用，就不能用于其他crate。

检查 `Cargo.toml` 中的 [你能指定的元数据](manifest.md) ，让使用者更容易发现你 crate! 在发布之前，请确保已经填写了以下字段:

- [`license` or `license-file`]
- [`description`]
- [`homepage`]
- [`documentation`]
- [`repository`]
- [`readme`]

尽管不是必须的，但包含相关 [`keywords`] 和 [`categories`] 信息会更好。

如果你要发布库，可能还需要参考一下 [Rust API 指南][Rust API Guidelines] 。

#### 打包crate

下一步是将你的crate打包并上传到 [crates.io] 。这时可以使用 [`cargo publish`] 子命令。
这个命令会执行以下步骤:

1. 对包进行一些验证检查。
2. 将源代码压缩成 `.crate` 文件。
3. 将 `.crate` 文件解压缩到临时目录中，并验证它是否可以编译。
4. 将 `.crate` 文件上传到[crates.io]。
5. 注册中心将在添加之前对上传的包进行一些额外的检查。

建议你首先运行 `cargo publish --dry-run` (或[`cargo package`]) ，
以确保在发布前没有任何警告或错误。这将执行上面列出的前三个步骤。

```console
$ cargo publish --dry-run
```

你可以在 `target/package` 目录下检查生成的 `.crate` 文件。
[crates.io]目前对 `.crate` 文件有10MB的大小限制。你需要检查 `.crate` 文件的大小，
以确保没有意外地打包构建包所不需要的大量资源，如测试数据、网站文档或代码生成。
你可以用下面的命令来检查包含了哪些文件:

```console
$ cargo package --list
```

Cargo在打包时将自动忽略您的版本控制系统所忽略的文件，如果想额外指定一组要忽略的文件，
可以在配置清单中使用 [`exclude` 键](manifest.md#the-exclude-and-include-fields) 。

```toml
[package]
# ...
exclude = [
    "public/assets/*",
    "videos/*",
]
```

如果你想明确地列出要包括的文件，Cargo也支持 `include` 键，如果设置了这个键，就可以覆盖 `exclude` 键。

```toml
[package]
# ...
include = [
    "**/*.rs",
    "Cargo.toml",
]
```

### 上传crate

当你准备好发布时，使用 [`cargo publish`] 命令上传至 [crates.io] :

```console
$ cargo publish
```

这样，你现在已经发布了第一个 crate !

### 发布现有crate的新版本

为了发布新版本，请更改 `Cargo.toml` 清单中指定的 [`version` 值](manifest.md#the-version-field)。
请记住 [语义化版本规范](semver.md)，该规范提供了关于什么是兼容性改变的指南。
然后如上所述运行 [`cargo publish`] 来上传新版本。

### 管理基于crate.io的crate

crate的管理主要是通过命令行 `cargo` 工具而不是 [crates.io] 网络界面来完成。
因此，有几个子命令来管理crate。

#### `cargo yank`

偶尔会出现这样的情况：你发布的版本由于某种原因(语法错误、忘记包含某个文件等)，实际上已经坏了。
对于这样的情况，Cargo支持 "yank" crate 的一个版本。

```console
$ cargo yank --version 1.0.1
$ cargo yank --version 1.0.1 --undo
```

yank **不会** 删除任何代码。这个功能不能删除意外上传的秘密。如果发生这种情况，请立即重置这些秘密。

被yank版本的语义是，不能针对该版本创建新的依赖，但已有的依赖继续使用。
[crates.io]的主要目标之一是作为一个不随时间变化的永久档案，允许删除一个版本将违背这一目标。
从本质上讲，yank 意味着所有带有 `Cargo.lock` 的包都不会损坏，而未来生成的任何 `Cargo.lock` 文件都不会列出被yank的版本。

#### `cargo owner`

crate通常是由多人开发的，或者主要的维护者可能会随着时间的推移而改变!
crate的所有者是唯一允许发布crate新版本的人，其所有者可以指定其他所有者。

```console
$ cargo owner --add github-handle
$ cargo owner --remove github-handle
$ cargo owner --add github:rust-lang:owners
$ cargo owner --remove github:rust-lang:owners
```

给予这些命令的所有者ID必须是GitHub用户名或GitHub团队。

如果一个用户名被赋予 `--add` ，该用户就会被邀请为 "命名" 的所有者，拥有对该crate的全部权利。
除了能够发布或取消crate的版本外，他们还能够添加或删除所有者，*包括* 使他们成为所有者的所有者。
不用说，你不应该把不完全信任的人变成指定的所有者。为了成为指定的所有者，用户必须在之前登录过[cates.io]。

如果一个团队的名字被赋予 `--add` ，该团队被邀请为 "团队" 所有者，对crate的权利受到限制。
虽然他们有权限发布或删除crate的版本，但他们*没有*能力添加或删除所有者。
除了更方便管理所有者组之外，团队也更安全一点，会防止所有者变得恶意。

目前团队的语法是 `github:org:team` (见上面的例子)。
为了邀请一个团队成为所有者，其必须是该团队的成员。
在删除一个团队的所有者时没有这种限制。

### GitHub 许可

团队成员资格不是GitHub提供的简单的公共访问，你在与他们合作时很可能会遇到以下信息:

> 看起来你没有权限从GitHub查询一个必要的属性来完成这个请求。你可能需要在 [crates.io] 上重新认证，以授予读取 GitHub org 会员资格的权限。

大体会说："你试图查询一个团队，但五级成员访问控制拒绝了这一点" 。
这并不夸张。GitHub对团队访问控制的支持是企业级的。

最有可能的原因是，你最后一次登录是在这个功能添加之前。我们最初在认证用户时*没有*要求GitHub提供权限，
因为我们除了登录用户外，实际上没有使用过用户的令牌。然而，为了查询团队成员身份，我们现在需要 [`read:org` 域][oauth-scopes]。

你可以自由地拒绝这个域，在进入团队之前的一切工作都将继续。
然而，你将无法作为所有者添加一个团队，或作为团队所有者发布crate。如果你试图这样做,会得到上面的错误。
如果你试图发布一个根本不属于你的crate，但恰好有一个团队，也可能看到这个错误。

如果你改变了主意，或者只是不确定[crates.io]是否有足够的权限，
你可以随时去<https://crates.io/>重新认证，如果[crates.io]没有所有它想获得的域，会提示你的权限。

查询GitHub的另一个障碍是，该组织可能主动拒绝第三方访问。要检查这一点，你可以去:

```text
https://github.com/organizations/:org/settings/oauth_application_policy
```

其中 `:org` 是组织的名称(例如，`rust-lang`)。你可能会看到类似的情形:

![组织访问控制](../images/org-level-acl.png)

在这里，你可以选择从组织黑名单中明确删除 [crates.io] ，
或者直接按下 "移除限制" 按钮，允许所有第三方应用程序访问这些数据。

另外，当[crates.io]请求 "read:org" 域时，你可以通过按下其名称旁边的 "Grant Access" 按钮，明确地将[crates.io]查询有关的组织列为白名单。

![认证访问控制](../images/auth-level-acl.png)

#### 解决GitHub团队访问错误

当试图添加GitHub团队作为 crate 所有者时，你可能会看到类似的错误:

```text
error: failed to invite owners to crate <crate_name>: api errors (status 200 OK): could not find the github team org/repo
```
在这种情况下，你应该去[the GitHub Application settings page]，检查crates.io是否被列在 "授权的OAuth应用程序" 标签中。
如果没有，你应该去<https://crates.io/>并授权它。
然后回到GitHub上的应用设置页面，点击列表中的crates.io应用，确保你或你的组织被列在 "组织访问" 列表中，并打上绿色的勾。
如果有标注 "Grant" 或 "Request" 的按钮，你应该授予权限或要求组织所有者这样做。

[Rust API Guidelines]: https://rust-lang.github.io/api-guidelines/
[`cargo login`]: ../commands/cargo-login.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo publish`]: ../commands/cargo-publish.md
[`categories`]: manifest.md#the-categories-field
[`description`]: manifest.md#the-description-field
[`documentation`]: manifest.md#the-documentation-field
[`homepage`]: manifest.md#the-homepage-field
[`keywords`]: manifest.md#the-keywords-field
[`license` or `license-file`]: manifest.md#the-license-and-license-file-fields
[`readme`]: manifest.md#the-readme-field
[`repository`]: manifest.md#the-repository-field
[crates.io]: https://crates.io/
[oauth-scopes]: https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/
[the GitHub Application settings page]: https://github.com/settings/applications
