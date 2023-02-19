{==+==}
## Working on an Existing Cargo Package
{==+==}
## 拥有 Cargo 包
{==+==}

{==+==}
If you download an existing [package][def-package] that uses Cargo, it’s
really easy to get going.
{==+==}
如果你下载了一个已经使用 Cargo 管理的 [包][def-package] ，那么开始使用它会非常简单。
{==+==}

{==+==}
First, get the package from somewhere. In this example, we’ll use `regex`
cloned from its repository on GitHub:
{==+==}
首先，从某个地方获取包。在这个示例中，我们将使用从其 GitHub 存储库克隆的 `regex` 。
{==+==}

{==+==}
```console
$ git clone https://github.com/rust-lang/regex.git
$ cd regex
```
{==+==}

{==+==}

{==+==}
To build, use `cargo build`:
{==+==}
使用 `cargo build` 命令构建包:
{==+==}

{==+==}
```console
$ cargo build
   Compiling regex v1.5.0 (file:///path/to/package/regex)
```
{==+==}

{==+==}

{==+==}
This will fetch all of the dependencies and then build them, along with the
package.
{==+==}
这将获取所有依赖项，然后与包一起构建。
{==+==}

{==+==}
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
{==+==}

{==+==}
