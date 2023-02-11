{==+==}
## Working on an Existing Cargo Package
{==+==}
## 拥有 Cargo 包
{==+==}

{==+==}
If you download an existing [package][def-package] that uses Cargo, it’s
really easy to get going.
{==+==}
通过 Cargo 下载已存在的 [package][def-package] 并使用，非常简单。
{==+==}

{==+==}
First, get the package from somewhere. In this example, we’ll use `regex`
cloned from its repository on GitHub:
{==+==}
首先，获取包。比如从 GitHub 克隆 `regex` 包。
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
这将获取包所有的依赖，然后构建依赖和包。
{==+==}

{==+==}
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
{==+==}

{==+==}
