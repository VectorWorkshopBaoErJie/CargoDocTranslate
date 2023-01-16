{==+==}
## Package ID Specifications
{==+==}
## 包ID规范
{==+==}


{==+==}
### Package ID specifications
{==+==}
### 包ID规范
{==+==}


{==+==}
Subcommands of Cargo frequently need to refer to a particular package within a
dependency graph for various operations like updating, cleaning, building, etc.
To solve this problem, Cargo supports *Package ID Specifications*. A specification
is a string which is used to uniquely refer to one package within a graph of
packages.
{==+==}
Cargo的子命令经常需要引用依赖图中的某个特定包来进行各种操作，如更新、清理、构建等。
为了解决这个问题，Cargo支持 *包ID规范* 。规范是一个字符串，用来唯一地指代包图中的一个包。
{==+==}


{==+==}
The specification may be fully qualified, such as
`https://github.com/rust-lang/crates.io-index#regex@1.4.3` or it may be
abbreviated, such as `regex`. The abbreviated form may be used as long as it
uniquely identifies a single package in the dependency graph. If there is
ambiguity, additional qualifiers can be added to make it unique. For example,
if there are two versions of the `regex` package in the graph, then it can be
qualified with a version to make it unique, such as `regex@1.4.3`.
{==+==}
该规范可以是完整标准的，例如 `https://github.com/rust-lang/crates.io-index#regex@1.4.3` ，也可以是缩写的，例如 `regex` 。
缩写的形式可以使用，只要它在依赖图中唯一地标识了一个包。如果有歧义，可以添加额外的限定词来使其唯一。
例如，如果图中有两个版本的 `regex` 包，那么可以用一个版本来限定，使其唯一，如 `regex@1.4.3` 。
{==+==}


{==+==}
#### Specification grammar
{==+==}
#### 规范语法
{==+==}


{==+==}
The formal grammar for a Package Id Specification is:
{==+==}
包Id规范形式的语法是:
{==+==}


{==+==}
```notrust
spec := pkgname
       | proto "://" hostname-and-path [ "#" ( pkgname | semver ) ]
pkgname := name [ ("@" | ":" ) semver ]

proto := "http" | "git" | ...
```
{==+==}

{==+==}


{==+==}
Here, brackets indicate that the contents are optional.
{==+==}
这里，方括号表示内容是可选的。
{==+==}


{==+==}
The URL form can be used for git dependencies, or to differentiate packages
that come from different sources such as different registries.
{==+==}
URL形式可用于git依赖，或区分来自不同来源的包，如不同的注册中心。
{==+==}


{==+==}
#### Example specifications
{==+==}
#### 示例规范
{==+==}


{==+==}
The following are references to the `regex` package on `crates.io`:
{==+==}
以下是对 `crates.io` 上的 `regex` 包的引用:
{==+==}


{==+==}
| Spec                                                        | Name    | Version |
|:------------------------------------------------------------|:-------:|:-------:|
| `regex`                                                     | `regex` | `*`     |
| `regex@1.4.3`                                               | `regex` | `1.4.3` |
| `https://github.com/rust-lang/crates.io-index#regex`        | `regex` | `*`     |
| `https://github.com/rust-lang/crates.io-index#regex@1.4.3`  | `regex` | `1.4.3` |
{==+==}

{==+==}


{==+==}
The following are some examples of specs for several different git dependencies:
{==+==}
下面是几个不同的git依赖的规范例子:
{==+==}


{==+==}
| Spec                                                      | Name             | Version  |
|:----------------------------------------------------------|:----------------:|:--------:|
| `https://github.com/rust-lang/cargo#0.52.0`               | `cargo`          | `0.52.0` |
| `https://github.com/rust-lang/cargo#cargo-platform@0.1.2` | <nobr>`cargo-platform`</nobr> | `0.1.2`  |
| `ssh://git@github.com/rust-lang/regex.git#regex@1.4.3`    | `regex`          | `1.4.3`  |
{==+==}

{==+==}


{==+==}
Local packages on the filesystem can use `file://` URLs to reference them:
{==+==}
文件系统上的本地包可以使用 `file://` URL来引用它们:
{==+==}


{==+==}
| Spec                                   | Name  | Version |
|:---------------------------------------|:-----:|:-------:|
| `file:///path/to/my/project/foo`       | `foo` | `*`     |
| `file:///path/to/my/project/foo#1.1.8` | `foo` | `1.1.8` |
{==+==}

{==+==}


{==+==}
#### Brevity of specifications
{==+==}
#### 规范简略
{==+==}


{==+==}
The goal of this is to enable both succinct and exhaustive syntaxes for
referring to packages in a dependency graph. Ambiguous references may refer to
one or more packages. Most commands generate an error if more than one package
could be referred to with the same specification.
{==+==}
这样做的目的是为了使在依赖图中引用包的语法既简明又详尽。模糊的引用可能指的是一个或多个包。
如果有一个以上的包可以用相同的规范引用，大多数命令会产生一个错误。
{==+==}