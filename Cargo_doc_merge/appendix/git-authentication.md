# Git 认证

在使用git依赖和注册中心时，Cargo支持一些形式的认证。本附录包含一些关于设置git认证的内容，以便与Cargo配合使用。

如果你需要其他的认证方法，可以设置 [`net.git-fetch-with-cli`] 配置值，使Cargo执行 `git` 可执行文件来处理获取远程仓库，而不是使用内置支持。
这可以通过 `CARGO_NET_GIT_FETCH_WITH_CLI=true` 环境变量来启用。

## HTTPS 认证

HTTPS认证需要 [`credential.helper`] 机制。有多个凭证辅助工具，你在全局git配置文件中指定你要使用那个。

```ini
# ~/.gitconfig

[credential]
helper = store
```

Cargo不要求密码，所以对于大多数辅助工具来说，你需要在运行Cargo之前给辅助工具提供用户名及密码。一种方式是运行私有git仓库的 `git clone` 并输入用户名及密码。

> **提示:**<br>
> macOS用户可能要考虑使用osxkeychain辅助工具。<br>
> Windows用户可能要考虑使用[GCM]辅助工具。

> **注意:** Windows用户需要确保 `sh` shell在你的 `PATH` 中可用。
> 这通常是在安装Git for Windows时才有。

## SSH 认证

SSH 认证需要运行 `ssh-agent` 来获取 SSH 密钥。确保设置了适当的环境变量(在大多数类似 Unix 的系统上为 `SSH_AUTH_SOCK`)，并添加了正确的密钥(用 `ssh-add`)。

Windows可以使用Pageant([PuTTY]的一部分)或 `ssh-agent` 。要使用 `ssh-agent` ，Cargo需要使用作为Windows一部分分发的OpenSSH，因为Cargo不支持MinGW或Cygwin使用的模拟Unix-domain套接字。
关于用Windows安装的更多信息可以在[微软安装文档]找到，[密钥管理]页面有关于如何启动 `ssh-agent` 和添加密钥的说明。

> **注意:** Cargo不支持git的简化SSH URL，如 `git@example.com:user/repo.git` 。
> 使用完整的SSH URL 如 `ssh://git@example.com/user/repo.git` .

> **注意:** Cargo的内置SSH库不使用SSH配置文件(如OpenSSH的`~/.ssh/config`)。
> 高级选项应使用 [`net.git-fetch-with-cli`] 。

[`credential.helper`]: https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
[`net.git-fetch-with-cli`]: ../reference/config.md#netgit-fetch-with-cli
[GCM]: https://github.com/microsoft/Git-Credential-Manager-Core/
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/
[微软安装文档]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
[密钥管理]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
