{==+==}
## Publishing on crates.io
{==+==}
## 发布到crates.io
{==+==}


{==+==}
Once you've got a library that you'd like to share with the world, it's time to
publish it on [crates.io]! Publishing a crate is when a specific
version is uploaded to be hosted on [crates.io].
{==+==}
你有一个想与世界分享的库，就该在[crates.io]上发布它，发布crate是指将特定版本上传到[crates.io]上托管。
{==+==}


{==+==}
Take care when publishing a crate, because a publish is **permanent**. The
version can never be overwritten, and the code cannot be deleted. There is no
limit to the number of versions which can be published, however.
{==+==}
在发布crate时要小心，发布将是**永久的**，永远不能覆盖该版本，不能删除代码。然而，对可以发布的版本数量没有限制。
{==+==}


{==+==}
### Before your first publish
{==+==}
### 在你第一次发布之前
{==+==}


{==+==}
First things first, you’ll need an account on [crates.io] to acquire
an API token. To do so, [visit the home page][crates.io] and log in via a GitHub
account (required for now). After this, visit your [Account
Settings](https://crates.io/me) page and run the [`cargo login`] command.
{==+==}
首先，你需要一个[crates.io]的账户来获取API token。要做到这一点，[访问主页][crates.io]并通过GitHub账户登录(目前需要)。
之后，访问你的[账户设置](https://crates.io/me)页面并运行[`cargo login`]命令。
{==+==}


{==+==}
```console
$ cargo login
```
{==+==}

{==+==}


{==+==}
Then at the prompt put in the token specified.
```console
please paste the API Token found on https://crates.io/me below
abcdefghijklmnopqrstuvwxyz012345
```
{==+==}
然后在提示中输入指定的Token。
```console
please paste the API Token found on https://crates.io/me below
abcdefghijklmnopqrstuvwxyz012345
```
{==+==}


{==+==}
This command will inform Cargo of your API token and store it locally in your
`~/.cargo/credentials.toml`. Note that this token is a **secret** and should not be
shared with anyone else. If it leaks for any reason, you should revoke it
immediately.
{==+==}
这个命令会将你的API token告知Cargo，并将其保存在你本地的 `~/.cargo/credentials.toml` 中。
请注意，这个token是**私密的**，不应该与其他人分享。如果因某些原因泄露，你应该立即撤销它。
{==+==}


{==+==}
### Before publishing a new crate
{==+==}
### 在发布新crate之前
{==+==}


{==+==}
Keep in mind that crate names on [crates.io] are allocated on a first-come-first-serve
basis. Once a crate name is taken, it cannot be used for another crate.
{==+==}
[cates.io]上的crate名称是以先到先得的方式分配的。一旦一个crate的名字被占用，就不能用于其他crate。
{==+==}


{==+==}
Check out the [metadata you can specify](manifest.md) in `Cargo.toml` to
ensure your crate can be discovered more easily! Before publishing, make sure
you have filled out the following fields:
{==+==}
检查 `Cargo.toml` 中的[你能指定的元数据](manifest.md)，让使用者更容易发现你crate! 在发布之前，请确保已经填写了以下字段:
{==+==}


{==+==}
- [`license` or `license-file`]
- [`description`]
- [`homepage`]
- [`documentation`]
- [`repository`]
- [`readme`]
{==+==}

{==+==}


{==+==}
It would also be a good idea to include some [`keywords`] and [`categories`],
though they are not required.
{==+==}
尽管不是必须的，包含一些 [`keywords`] 和 [`categories`] 也会很好。
{==+==}


{==+==}
If you are publishing a library, you may also want to consult the [Rust API
Guidelines].
{==+==}
如果你要发布库，可能还需要参考一下[Rust API Guidelines]。
{==+==}


{==+==}
#### Packaging a crate
{==+==}
#### 打包crate
{==+==}


{==+==}
The next step is to package up your crate and upload it to [crates.io]. For
this we’ll use the [`cargo publish`] subcommand. This command performs the following
steps:
{==+==}
下一步是将你的crate打包并上传到[crates.io]。为此使用 [`cargo publish`] 子命令。
这个命令会执行以下步骤:
{==+==}


{==+==}
1. Perform some verification checks on your package.
2. Compress your source code into a `.crate` file.
3. Extract the `.crate` file into a temporary directory and verify that it
   compiles.
4. Upload the `.crate` file to [crates.io].
5. The registry will perform some additional checks on the uploaded package
   before adding it.
{==+==}
1. 对包进行一些验证检查。
2. 将源代码压缩成 `.crate` 文件。
3. 将 `.crate` 文件解压缩到临时目录中，并验证它是否可以编译。
4. 将 `.crate` 文件上传到[crates.io]。
5. 注册中心将在添加之前对上传的包进行一些额外的检查。
{==+==}


{==+==}
It is recommended that you first run `cargo publish --dry-run` (or [`cargo
package`] which is equivalent) to ensure there aren't any warnings or errors
before publishing. This will perform the first three steps listed above.
{==+==}
建议你首先运行 `cargo publish --dry-run` (或[`cargo package`]) ，
以确保在发布前没有任何警告或错误。这将执行上面列出的前三个步骤。
{==+==}


{==+==}
```console
$ cargo publish --dry-run
```
{==+==}

{==+==}


{==+==}
You can inspect the generated `.crate` file in the `target/package` directory.
[crates.io] currently has a 10MB size limit on the `.crate` file. You may want
to check the size of the `.crate` file to ensure you didn't accidentally
package up large assets that are not required to build your package, such as
test data, website documentation, or code generation. You can check which
files are included with the following command:
{==+==}
你可以在 `target/package` 目录下检查生成的 `.crate` 文件。
[crates.io]目前对 `.crate` 文件有10MB的大小限制。你需要检查 `.crate` 文件的大小，
以确保没有意外地打包了构建包所不需要的大型资产，如测试数据、网站文档或代码生成。
你可以用下面的命令来检查包含了哪些文件:
{==+==}


{==+==}
```console
$ cargo package --list
```
{==+==}

{==+==}


{==+==}
Cargo will automatically ignore files ignored by your version control system
when packaging, but if you want to specify an extra set of files to ignore you
can use the [`exclude` key](manifest.md#the-exclude-and-include-fields) in the
manifest:
{==+==}
Cargo在打包时将自动忽略您的版本控制系统所忽略的文件，如果想额外指定一组要忽略的文件，
可以在配置清单中使用[`exclude` 键](manifest.md#the-exclude-and-include-fields)。
{==+==}


{==+==}
```toml
[package]
# ...
exclude = [
    "public/assets/*",
    "videos/*",
]
```
{==+==}

{==+==}


{==+==}
If you’d rather explicitly list the files to include, Cargo also supports an
`include` key, which if set, overrides the `exclude` key:
{==+==}
如果你想明确地列出要包括的文件，Cargo也支持 `include` 键，如果设置了这个键，就可以覆盖 `exclude` 键。
{==+==}


{==+==}
```toml
[package]
# ...
include = [
    "**/*.rs",
    "Cargo.toml",
]
```
{==+==}

{==+==}


{==+==}
### Uploading the crate
{==+==}
### 上传crate
{==+==}


{==+==}
When you are ready to publish, use the [`cargo publish`] command
to upload to [crates.io]:
{==+==}
当你准备好发布时，使用 [`cargo publish`] 命令上传至 [crates.io] :
{==+==}


{==+==}
```console
$ cargo publish
```
{==+==}

{==+==}


{==+==}
And that’s it, you’ve now published your first crate!
{==+==}
这样，你现在已经发布了第一个 crate !
{==+==}


{==+==}
### Publishing a new version of an existing crate
{==+==}
### 发布现有crate的新版本
{==+==}


{==+==}
In order to release a new version, change [the `version` value](manifest.md#the-version-field) specified in your `Cargo.toml` manifest.
Keep in mind [the SemVer rules](semver.md) which provide guidelines on what is a compatible change.
Then run [`cargo publish`] as described above to upload the new version.
{==+==}
为了发布新版本，请更改 `Cargo.toml` 清单中指定的 [`version` 值](manifest.md#the-version-field)。
请记住 [语义化版本规范](semver.md)，该规范提供了关于什么是兼容性改变的指南。
然后如上所述运行 [`cargo publish`] 来上传新版本。
{==+==}


{==+==}
### Managing a crates.io-based crate
{==+==}
### 管理基于crate.io的crate
{==+==}


{==+==}
Management of crates is primarily done through the command line `cargo` tool
rather than the [crates.io] web interface. For this, there are a few subcommands
to manage a crate.
{==+==}
crate的管理主要是通过命令行 `cargo` 工具而不是 [crates.io] 网络界面来完成。
因此，有几个子命令来管理crate。
{==+==}


{==+==}
#### `cargo yank`
{==+==}

{==+==}


{==+==}
Occasions may arise where you publish a version of a crate that actually ends up
being broken for one reason or another (syntax error, forgot to include a file,
etc.). For situations such as this, Cargo supports a “yank” of a version of a
crate.
{==+==}
偶尔会出现这样的情况：你发布的版本由于某种原因(语法错误、忘记包含某个文件等)，实际上已经坏了。
对于这样的情况，Cargo支持 "删除" crate 的一个版本。
{==+==}


{==+==}
```console
$ cargo yank --version 1.0.1
$ cargo yank --version 1.0.1 --undo
```
{==+==}

{==+==}


{==+==}
A yank **does not** delete any code. This feature is not intended for deleting
accidentally uploaded secrets, for example. If that happens, you must reset
those secrets immediately.
{==+==}
yank **不会** 删除任何代码。这个功能不能删除意外上传的秘密。如果发生这种情况，请立即重置这些秘密。
{==+==}


{==+==}
The semantics of a yanked version are that no new dependencies can be created
against that version, but all existing dependencies continue to work. One of the
major goals of [crates.io] is to act as a permanent archive of crates that does
not change over time, and allowing deletion of a version would go against this
goal. Essentially a yank means that all packages with a `Cargo.lock` will not
break, while any future `Cargo.lock` files generated will not list the yanked
version.
{==+==}
被删除版本的语义是，不能针对该版本创建新的依赖，但继续使用已有的依赖。
[crates.io]的主要目标之一是作为一个不随时间变化的永久档案，允许删除一个版本将违背这一目标。
从本质上讲，yank 意味着所有带有 `Cargo.lock` 的包都不会损坏，而未来生成的任何 `Cargo.lock` 文件都不会列出被yank的版本。
{==+==}


{==+==}
#### `cargo owner`
{==+==}

{==+==}


{==+==}
A crate is often developed by more than one person, or the primary maintainer
may change over time! The owner of a crate is the only person allowed to publish
new versions of the crate, but an owner may designate additional owners.
{==+==}
crate通常是由多人开发的，或者主要的维护者可能会随着时间的推移而改变!
crate的所有者是唯一允许发布crate新版本的人，其所有者可以指定其他所有者。
{==+==}


{==+==}
```console
$ cargo owner --add github-handle
$ cargo owner --remove github-handle
$ cargo owner --add github:rust-lang:owners
$ cargo owner --remove github:rust-lang:owners
```
{==+==}

{==+==}


{==+==}
The owner IDs given to these commands must be GitHub user names or GitHub teams.
{==+==}
给予这些命令的所有者ID必须是GitHub用户名或GitHub团队。
{==+==}


{==+==}
If a user name is given to `--add`, that user is invited as a “named” owner, with
full rights to the crate. In addition to being able to publish or yank versions
of the crate, they have the ability to add or remove owners, *including* the
owner that made *them* an owner. Needless to say, you shouldn’t make people you
don’t fully trust into a named owner. In order to become a named owner, a user
must have logged into [crates.io] previously.
{==+==}
如果一个用户名被赋予 `--add` ，该用户就会被邀请为 "命名" 的所有者，拥有对该crate的全部权利。
除了能够发布或取消crate的版本外，他们还能够添加或删除所有者，*包括* 使他们成为所有者的所有者。
不用说，你不应该把不完全信任的人变成指定的所有者。为了成为指定的所有者，用户必须在之前登录过[cates.io]。
{==+==}


{==+==}
If a team name is given to `--add`, that team is invited as a “team” owner, with
restricted right to the crate. While they have permission to publish or yank
versions of the crate, they *do not* have the ability to add or remove owners.
In addition to being more convenient for managing groups of owners, teams are
just a bit more secure against owners becoming malicious.
{==+==}
如果一个团队的名字被赋予 `--add` ，该团队被邀请为 "团队" 所有者，对crate的权利受到限制。
虽然他们有权限发布或删除crate的版本，但他们*没有*能力添加或删除所有者。
团队在管理所有者群体方面方便，在防止所有者成为恶意的。
{==+==}


{==+==}
The syntax for teams is currently `github:org:team` (see examples above).
In order to invite a team as an owner one must be a member of that team. No
such restriction applies to removing a team as an owner.
{==+==}
目前团队的语法是 `github:org:team` (见上面的例子)。
为了邀请一个团队成为所有者，其必须是该团队的成员。
在删除一个团队的所有者时没有这种限制。
{==+==}


{==+==}
### GitHub permissions
{==+==}
### GitHub 许可
{==+==}


{==+==}
Team membership is not something GitHub provides simple public access to, and it
is likely for you to encounter the following message when working with them:
{==+==}
团队成员资格不是GitHub提供的简单的公共访问，你在与他们合作时很可能会遇到以下信息:
{==+==}


{==+==}
> It looks like you don’t have permission to query a necessary property from
GitHub to complete this request. You may need to re-authenticate on [crates.io]
to grant permission to read GitHub org memberships.
{==+==}
> 看起来你没有权限从GitHub查询一个必要的属性来完成这个请求。你可能需要在 [crates.io] 上重新认证，以授予读取 GitHub org 会员资格的权限。
{==+==}


{==+==}
This is basically a catch-all for “you tried to query a team, and one of the
five levels of membership access control denied this”. That is not an
exaggeration. GitHub’s support for team access control is Enterprise Grade.
{==+==}
大体会说："你试图查询一个团队，但五级成员访问控制拒绝了这一点" 。
这并不夸张。GitHub对团队访问控制的支持是企业级的。
{==+==}


{==+==}
The most likely cause of this is simply that you last logged in before this
feature was added. We originally requested *no* permissions from GitHub when
authenticating users, because we didn’t actually ever use the user’s token for
anything other than logging them in. However to query team membership on your
behalf, we now require [the `read:org` scope][oauth-scopes].
{==+==}
最有可能的原因是，你最后一次登录是在这个功能添加之前。我们最初在认证用户时*没有*要求GitHub提供权限，
因为我们除了登录用户外，实际上没有使用过用户的令牌。然而，为了查询团队成员身份，我们现在需要 [`read:org` 域][oauth-scopes]。
{==+==}


{==+==}
You are free to deny us this scope, and everything that worked before teams
were introduced will keep working. However you will never be able to add a team
as an owner, or publish a crate as a team owner. If you ever attempt to do this,
you will get the error above. You may also see this error if you ever try to
publish a crate that you don’t own at all, but otherwise happens to have a team.
{==+==}
你可以自由地拒绝这个域，在进入团队之前的一切工作都将继续。
然而，你将无法作为所有者添加一个团队，或作为团队所有者发布crate。如果你试图这样做,会得到上面的错误。
如果你试图发布一个根本不属于你的crate，但恰好有一个团队，也可能看到这个错误。
{==+==}


{==+==}
If you ever change your mind, or just aren’t sure if [crates.io] has sufficient
permission, you can always go to <https://crates.io/> and re-authenticate,
which will prompt you for permission if [crates.io] doesn’t have all the scopes
it would like to.
{==+==}
如果你改变了主意，或者只是不确定[crates.io]是否有足够的权限，
你可以随时去<https://crates.io/>重新认证，如果[crates.io]没有所有它想拥有的域，会提示你的权限。
{==+==}


{==+==}
An additional barrier to querying GitHub is that the organization may be
actively denying third party access. To check this, you can go to:
{==+==}
查询GitHub的另一个障碍是，该组织可能主动拒绝第三方访问。要检查这一点，你可以去:
{==+==}


{==+==}
```text
https://github.com/organizations/:org/settings/oauth_application_policy
```
{==+==}

{==+==}


{==+==}
where `:org` is the name of the organization (e.g., `rust-lang`). You may see
something like:
{==+==}
其中 `:org` 是组织的名称(例如，`rust-lang`)。你可能会看到类似的情形:
{==+==}


{==+==}
![Organization Access Control](../images/org-level-acl.png)
{==+==}
![组织访问控制](../images/org-level-acl.png)
{==+==}


{==+==}
Where you may choose to explicitly remove [crates.io] from your organization’s
blacklist, or simply press the “Remove Restrictions” button to allow all third
party applications to access this data.
{==+==}
在这里，你可以选择从组织黑名单中明确删除 [crates.io] ，
或者直接按下 "移除限制" 按钮，允许所有第三方应用程序访问这些数据。
{==+==}


{==+==}
Alternatively, when [crates.io] requested the `read:org` scope, you could have
explicitly whitelisted [crates.io] querying the org in question by pressing
the “Grant Access” button next to its name:
{==+==}
另外，当[crates.io]请求 "read:org" 域时，你可以通过按下其名称旁边的 "Grant Access" 按钮，明确地将[crates.io]查询有关的组织列为白名单。
{==+==}


{==+==}
![Authentication Access Control](../images/auth-level-acl.png)
{==+==}
![认证访问控制](../images/auth-level-acl.png)
{==+==}


{==+==}
#### Troubleshooting GitHub team access errors
{==+==}
#### 解决GitHub团队访问错误
{==+==}


{==+==}
When trying to add a GitHub team as crate owner, you may see an error like:
{==+==}
当试图添加GitHub团队作为 crate 所有者时，你可能会看到类似的错误:
{==+==}


{==+==}
```text
error: failed to invite owners to crate <crate_name>: api errors (status 200 OK): could not find the github team org/repo
```
{==+==}

{==+==}


{==+==}
In that case, you should go to [the GitHub Application settings page] and
check if crates.io is listed in the `Authorized OAuth Apps` tab.
If it isn't, you should go to <https://crates.io/> and authorize it.
Then go back to the Application Settings page on GitHub, click on the
crates.io application in the list, and make sure you or your organization is
listed in the "Organization access" list with a green check mark. If there's
a button labeled `Grant` or `Request`, you should grant the access or
request the org owner to do so.
{==+==}
在这种情况下，你应该去[the GitHub Application settings page]，检查crates.io是否被列在 "授权的OAuth应用程序" 标签中。
如果没有，你应该去<https://crates.io/>并授权它。
然后回到GitHub上的应用设置页面，点击列表中的crates.io应用，确保你或你的组织被列在 "组织访问" 列表中，并打上绿色的勾。
如果有标注 "Grant" 或 "Request" 的按钮，你应该授予权限或要求组织所有者这样做。
{==+==}


{==+==}
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
{==+==}

{==+==}