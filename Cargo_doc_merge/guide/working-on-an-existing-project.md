## 接手已有的 Cargo 包

使用 Cargo 下载已有的 [package][def-package] 非常简单。

首先，获取到包的代码。比如使用从 GitHub 克隆的 `regex` 包。

```console
$ git clone https://github.com/rust-lang/regex.git
$ cd regex
```

使用 `cargo build` 命令构建包:

```console
$ cargo build
   Compiling regex v1.5.0 (file:///path/to/package/regex)
```

这会下载并构建所有的依赖和包。

[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
