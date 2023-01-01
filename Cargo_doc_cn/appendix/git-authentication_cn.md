{==+==}
# Git Authentication
{==+==}
# Git 认证
{==+==}

{==+==}
Cargo supports some forms of authentication when using git dependencies and
registries. This appendix contains some information for setting up git
authentication in a way that works with Cargo.
{==+==}
在使用git依赖和注册中心时，Cargo支持一些形式的认证。本附录包含一些关于设置git认证的内容，以便与Cargo配合使用。
{==+==}

{==+==}
If you need other authentication methods, the [`net.git-fetch-with-cli`]
config value can be set to cause Cargo to execute the `git` executable to
handle fetching remote repositories instead of using the built-in support.
This can be enabled with the `CARGO_NET_GIT_FETCH_WITH_CLI=true` environment
variable.
{==+==}
如果你需要其他的认证方法，可以设置 [`net.git-fetch-with-cli`] 配置值，使Cargo执行 `git` 可执行文件来处理获取远程仓库，而不是使用内置支持。
这可以通过 `CARGO_NET_GIT_FETCH_WITH_CLI=true` 环境变量来启用。
{==+==}

{==+==}
## HTTPS authentication
{==+==}
## HTTPS 认证
{==+==}

{==+==}
HTTPS authentication requires the [`credential.helper`] mechanism. There are
multiple credential helpers, and you specify the one you want to use in your
global git configuration file.
{==+==}
HTTPS认证需要 [`credential.helper`] 机制。有多个凭证辅助工具，你在全局git配置文件中指定你要使用那个。
{==+==}

{==+==}
```ini
# ~/.gitconfig

[credential]
helper = store
```
{==+==}
```ini
# ~/.gitconfig

[credential]
helper = store
```
{==+==}

{==+==}
Cargo does not ask for passwords, so for most helpers you will need to give
the helper the initial username/password before running Cargo. One way to do
this is to run `git clone` of the private git repo and enter the
username/password.
{==+==}
Cargo不要求密码，所以对于大多数辅助工具来说，你需要在运行Cargo之前给辅助工具提供用户名及密码。一种方式是运行私有git仓库的 `git clone` 并输入用户名及密码。
{==+==}

{==+==}
> **Tip:**<br>
> macOS users may want to consider using the osxkeychain helper.<br>
> Windows users may want to consider using the [GCM] helper.
{==+==}
> **提示:**<br>
> macOS用户可能要考虑使用osxkeychain辅助工具。<br>
> Windows用户可能要考虑使用[GCM]辅助工具。
{==+==}

{==+==}
> **Note:** Windows users will need to make sure that the `sh` shell is
> available in your `PATH`. This typically is available with the Git for
> Windows installation.
{==+==}
> **注意:** Windows用户需要确保 `sh` shell在你的 `PATH` 中可用。
> 这通常是在安装Git for Windows时才有。
{==+==}

{==+==}
## SSH authentication
{==+==}
## SSH 认证
{==+==}

{==+==}
SSH authentication requires `ssh-agent` to be running to acquire the SSH key.
Make sure the appropriate environment variables are set up (`SSH_AUTH_SOCK` on
most Unix-like systems), and that the correct keys are added (with `ssh-add`).
{==+==}
SSH 认证需要运行 `ssh-agent` 来获取 SSH 密钥。确保设置了适当的环境变量(在大多数类似 Unix 的系统上为 `SSH_AUTH_SOCK`)，并添加了正确的密钥(用 `ssh-add`)。
{==+==}

{==+==}
Windows can use Pageant (part of [PuTTY]) or `ssh-agent`.
To use `ssh-agent`, Cargo needs to use the OpenSSH that is distributed as part
of Windows, as Cargo does not support the simulated Unix-domain sockets used
by MinGW or Cygwin.
{==+==}
Windows可以使用Pageant([PuTTY]的一部分)或 `ssh-agent` 。要使用 `ssh-agent` ，Cargo需要使用作为Windows一部分分发的OpenSSH，因为Cargo不支持MinGW或Cygwin使用的模拟Unix-domain套接字。
{==+==}

{==+==}
More information about installing with Windows can be found at the [Microsoft
installation documentation] and the page on [key management] has instructions
on how to start `ssh-agent` and to add keys.
{==+==}
关于用Windows安装的更多信息可以在[微软安装文档]找到，[密钥管理]页面有关于如何启动 `ssh-agent` 和添加密钥的说明。
{==+==}

{==+==}
> **Note:** Cargo does not support git's shorthand SSH URLs like
> `git@example.com:user/repo.git`. Use a full SSH URL like
> `ssh://git@example.com/user/repo.git`.
{==+==}
> **注意:** Cargo不支持git的简化SSH URL，如 `git@example.com:user/repo.git` 。
> 使用完整的SSH URL 如 `ssh://git@example.com/user/repo.git` .
{==+==}

{==+==}
> **Note:** SSH configuration files (like OpenSSH's `~/.ssh/config`) are not
> used by Cargo's built-in SSH library. More advanced requirements should use
> [`net.git-fetch-with-cli`].
{==+==}
> **注意:** Cargo的内置SSH库不使用SSH配置文件(如OpenSSH的`~/.ssh/config`)。
> 高级选项应使用 [`net.git-fetch-with-cli`] 。
{==+==}

{==+==}
[`credential.helper`]: https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
[`net.git-fetch-with-cli`]: ../reference/config.md#netgit-fetch-with-cli
[GCM]: https://github.com/microsoft/Git-Credential-Manager-Core/
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/
[Microsoft installation documentation]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
[key management]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
{==+==}
[`credential.helper`]: https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
[`net.git-fetch-with-cli`]: ../reference/config.md#netgit-fetch-with-cli
[GCM]: https://github.com/microsoft/Git-Credential-Manager-Core/
[PuTTY]: https://www.chiark.greenend.org.uk/~sgtatham/putty/
[微软安装文档]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
[密钥管理]: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
{==+==}