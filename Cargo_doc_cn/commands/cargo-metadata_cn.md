{==+==}
# cargo-metadata(1)
{==+==}

{==+==}

{==+==}
## NAME
{==+==}
## 名称
{==+==}

{==+==}
cargo-metadata - Machine-readable metadata about the current package
{==+==}
cargo-metadata - 输出当前包的机器可读的元数据
{==+==}

{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}

{==+==}
`cargo metadata` [_options_]
{==+==}

{==+==}

{==+==}
## DESCRIPTION
{==+==}
## 描述
{==+==}

{==+==}
Output JSON to stdout containing information about the workspace members and
resolved dependencies of the current package.
{==+==}
在 stdout 中输出工作空间成员的信息和当前包已解析的依赖。
{==+==}

{==+==}
It is recommended to include the `--format-version` flag to future-proof
your code to ensure the output is in the format you are expecting.
{==+==}
建议在使用时添加 `--format-version` 标志以保证未来也会以你预期的格式进行输出。
{==+==}

{==+==}
See the [cargo_metadata crate](https://crates.io/crates/cargo_metadata)
for a Rust API for reading the metadata.
{==+==}
另见 [cargo_metadata crate](https://crates.io/crates/cargo_metadata) 查看读取该元数据的 Rust API。
{==+==}

{==+==}
## OUTPUT FORMAT
{==+==}
## 输出格式
{==+==}

{==+==}
The output has the following format:
{==+==}
输出格式如下: 
{==+==}

{==+==}
```javascript
{
    /* Array of all packages in the workspace.
       It also includes all feature-enabled dependencies unless --no-deps is used.
    */
    "packages": [
        {
            /* The name of the package. */
            "name": "my-package",
            /* The version of the package. */
            "version": "0.1.0",
            /* The Package ID, a unique identifier for referring to the package. */
            "id": "my-package 0.1.0 (path+file:///path/to/my-package)",
            /* The license value from the manifest, or null. */
            "license": "MIT/Apache-2.0",
            /* The license-file value from the manifest, or null. */
            "license_file": "LICENSE",
            /* The description value from the manifest, or null. */
            "description": "Package description.",
            /* The source ID of the package. This represents where
               a package is retrieved from.
               This is null for path dependencies and workspace members.
               For other dependencies, it is a string with the format:
               - "registry+URL" for registry-based dependencies.
                 Example: "registry+https://github.com/rust-lang/crates.io-index"
               - "git+URL" for git-based dependencies.
                 Example: "git+https://github.com/rust-lang/cargo?rev=5e85ba14aaa20f8133863373404cb0af69eeef2c#5e85ba14aaa20f8133863373404cb0af69eeef2c"
            */
            "source": null,
            /* Array of dependencies declared in the package's manifest. */
            "dependencies": [
                {
                    /* The name of the dependency. */
                    "name": "bitflags",
                    /* The source ID of the dependency. May be null, see
                       description for the package source.
                    */
                    "source": "registry+https://github.com/rust-lang/crates.io-index",
                    /* The version requirement for the dependency.
                       Dependencies without a version requirement have a value of "*".
                    */
                    "req": "^1.0",
                    /* The dependency kind.
                       "dev", "build", or null for a normal dependency.
                    */
                    "kind": null,
                    /* If the dependency is renamed, this is the new name for
                       the dependency as a string.  null if it is not renamed.
                    */
                    "rename": null,
                    /* Boolean of whether or not this is an optional dependency. */
                    "optional": false,
                    /* Boolean of whether or not default features are enabled. */
                    "uses_default_features": true,
                    /* Array of features enabled. */
                    "features": [],
                    /* The target platform for the dependency.
                       null if not a target dependency.
                    */
                    "target": "cfg(windows)",
                    /* The file system path for a local path dependency.
                       not present if not a path dependency.
                    */
                    "path": "/path/to/dep",
                    /* A string of the URL of the registry this dependency is from.
                       If not specified or null, the dependency is from the default
                       registry (crates.io).
                    */
                    "registry": null
                }
            ],
            /* Array of Cargo targets. */
            "targets": [
                {
                    /* Array of target kinds.
                       - lib targets list the `crate-type` values from the
                         manifest such as "lib", "rlib", "dylib",
                         "proc-macro", etc. (default ["lib"])
                       - binary is ["bin"]
                       - example is ["example"]
                       - integration test is ["test"]
                       - benchmark is ["bench"]
                       - build script is ["custom-build"]
                    */
                    "kind": [
                        "bin"
                    ],
                    /* Array of crate types.
                       - lib and example libraries list the `crate-type` values
                         from the manifest such as "lib", "rlib", "dylib",
                         "proc-macro", etc. (default ["lib"])
                       - all other target kinds are ["bin"]
                    */
                    "crate_types": [
                        "bin"
                    ],
                    /* The name of the target. */
                    "name": "my-package",
                    /* Absolute path to the root source file of the target. */
                    "src_path": "/path/to/my-package/src/main.rs",
                    /* The Rust edition of the target.
                       Defaults to the package edition.
                    */
                    "edition": "2018",
                    /* Array of required features.
                       This property is not included if no required features are set.
                    */
                    "required-features": ["feat1"],
                    /* Whether the target should be documented by `cargo doc`. */
                    "doc": true,
                    /* Whether or not this target has doc tests enabled, and
                       the target is compatible with doc testing.
                    */
                    "doctest": false,
                    /* Whether or not this target should be built and run with `--test`
                    */
                    "test": true
                }
            ],
            /* Set of features defined for the package.
               Each feature maps to an array of features or dependencies it
               enables.
            */
            "features": {
                "default": [
                    "feat1"
                ],
                "feat1": [],
                "feat2": []
            },
            /* Absolute path to this package's manifest. */
            "manifest_path": "/path/to/my-package/Cargo.toml",
            /* Package metadata.
               This is null if no metadata is specified.
            */
            "metadata": {
                "docs": {
                    "rs": {
                        "all-features": true
                    }
                }
            },
            /* List of registries to which this package may be published.
               Publishing is unrestricted if null, and forbidden if an empty array. */
            "publish": [
                "crates-io"
            ],
            /* Array of authors from the manifest.
               Empty array if no authors specified.
            */
            "authors": [
                "Jane Doe <user@example.com>"
            ],
            /* Array of categories from the manifest. */
            "categories": [
                "command-line-utilities"
            ],
            /* Optional string that is the default binary picked by cargo run. */
            "default_run": null,
            /* Optional string that is the minimum supported rust version */
            "rust_version": "1.56",
            /* Array of keywords from the manifest. */
            "keywords": [
                "cli"
            ],
            /* The readme value from the manifest or null if not specified. */
            "readme": "README.md",
            /* The repository value from the manifest or null if not specified. */
            "repository": "https://github.com/rust-lang/cargo",
            /* The homepage value from the manifest or null if not specified. */
            "homepage": "https://rust-lang.org",
            /* The documentation value from the manifest or null if not specified. */
            "documentation": "https://doc.rust-lang.org/stable/std",
            /* The default edition of the package.
               Note that individual targets may have different editions.
            */
            "edition": "2018",
            /* Optional string that is the name of a native library the package
               is linking to.
            */
            "links": null,
        }
    ],
    /* Array of members of the workspace.
       Each entry is the Package ID for the package.
    */
    "workspace_members": [
        "my-package 0.1.0 (path+file:///path/to/my-package)",
    ],
    // The resolved dependency graph for the entire workspace. The enabled
    // features are based on the enabled features for the "current" package.
    // Inactivated optional dependencies are not listed.
    //
    // This is null if --no-deps is specified.
    //
    // By default, this includes all dependencies for all target platforms.
    // The `--filter-platform` flag may be used to narrow to a specific
    // target triple.
    "resolve": {
        /* Array of nodes within the dependency graph.
           Each node is a package.
        */
        "nodes": [
            {
                /* The Package ID of this node. */
                "id": "my-package 0.1.0 (path+file:///path/to/my-package)",
                /* The dependencies of this package, an array of Package IDs. */
                "dependencies": [
                    "bitflags 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)"
                ],
                /* The dependencies of this package. This is an alternative to
                   "dependencies" which contains additional information. In
                   particular, this handles renamed dependencies.
                */
                "deps": [
                    {
                        /* The name of the dependency's library target.
                           If this is a renamed dependency, this is the new
                           name.
                        */
                        "name": "bitflags",
                        /* The Package ID of the dependency. */
                        "pkg": "bitflags 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)",
                        /* Array of dependency kinds. Added in Cargo 1.40. */
                        "dep_kinds": [
                            {
                                /* The dependency kind.
                                   "dev", "build", or null for a normal dependency.
                                */
                                "kind": null,
                                /* The target platform for the dependency.
                                   null if not a target dependency.
                                */
                                "target": "cfg(windows)"
                            }
                        ]
                    }
                ],
                /* Array of features enabled on this package. */
                "features": [
                    "default"
                ]
            }
        ],
        /* The root package of the workspace.
           This is null if this is a virtual workspace. Otherwise it is
           the Package ID of the root package.
        */
        "root": "my-package 0.1.0 (path+file:///path/to/my-package)"
    },
    /* The absolute path to the build directory where Cargo places its output. */
    "target_directory": "/path/to/my-package/target",
    /* The version of the schema for this metadata structure.
       This will be changed if incompatible changes are ever made.
    */
    "version": 1,
    /* The absolute path to the root of the workspace. */
    "workspace_root": "/path/to/my-package"
    /* Workspace metadata.
       This is null if no metadata is specified. */
    "metadata": {
        "docs": {
            "rs": {
                "all-features": true
            }
        }
    }
}
````
{==+==}
```javascript
{
    /* 工作空间中的所有包
       其中也包括了所有被 feature 所启用的依赖，除非设置了 --no-deps 标志。
    */
    "packages": [
        {
            /* 包的名称 */
            "name": "my-package",
            /* 包的版本 */
            "version": "0.1.0",
            /* Package ID，引用一个包的唯一标识符。 */
            "id": "my-package 0.1.0 (path+file:///path/to/my-package)",
            /* 来自清单文件中的 license 值，或为 null */
            "license": "MIT/Apache-2.0",
            /* 来自清单文件中的 license-file 值，或为 null */
            "license_file": "LICENSE",
            /* 来自清单文件中的 description 值 ，或为 null */
            "description": "Package description.",
            /* 包的 source ID ，其表示一个包是从何处获取的。
               对于 path 类型的依赖或者工作空间成员，该值为 null。
               对于其他依赖，该值为一个字符串，其格式为:
               - 对于 registry-based 的依赖，为 "registry+URL"。
                 例如: "registry+https://github.com/rust-lang/crates.io-index"
               - 对于 git-based 的依赖，为 "git+URL"。
                 例如: "git+https://github.com/rust-lang/cargo?rev=5e85ba14aaa20f8133863373404cb0af69eeef2c#5e85ba14aaa20f8133863373404cb0af69eeef2c"
            */
            "source": null,
            /* 该包的清单文件中声明的所有依赖 */
            "dependencies": [
                {
                    /* 依赖的名称 */
                    "name": "bitflags",
                    /* 依赖的 source ID，可能为 null，见 package source 的描述。
                    */
                    "source": "registry+https://github.com/rust-lang/crates.io-index",
                    /* The version requirement for the dependency.
                       Dependencies without a version requirement have a value of "*".
                    */
                    /* 对于该依赖的版本请求。没有版本请求的依赖以"*"为值 */
                    "req": "^1.0",
                    /* 依赖的种类。
                       有 "dev"， "build"，对于普通依赖来说为 null。
                    */
                    "kind": null,
                    /* 如果依赖被重命名，该值为新名，没有重命名则为 null。
                    */
                    "rename": null,
                    /* 布尔值，表示该依赖是否是可选的。 */
                    "optional": false,
                    /* 布尔值，表示该依赖是否启用了 default feature。 */
                    "uses_default_features": true,
                    /* 所有启用的 feature。 */
                    "features": [],
                    /* 该依赖的目标平台，如果不是一个平台特定依赖，则值为 null。
                    */
                    "target": "cfg(windows)",
                    /* 本地依赖(path dependency)在文件系统中的路径，如果不是本地依赖，该字段不会出现。
                    */
                    "path": "/path/to/dep",
                    /* 依赖来自的 registry 的 URL 字符串。如果没有指定或者值为 null，则该依赖来自默认的 registry (crates.io)
                    */
                    "registry": null
                }
            ],
            /* Cargo targets. */
            "targets": [
                {
                    /* target 的种类。
                       - lib targets 会陈列清单文件中的 `crate-type` 值
                         比如 "lib", "rlib", "dylib", "proc-macro"。 (默认值为 ["lib"])
                       - 二进制目标为 ["bin"]
                       - example 为 ["example"]
                       - 集成测试为 ["test"]
                       - benchmark 为 ["bench"]
                       - build script 为 ["custom-build"]
                    */
                    "kind": [
                        "bin"
                    ],
                    /* crate 的种类。
                       - lib 和 example库 会陈列清单文件中的 `crate-type` 值
                         比如 "lib", "rlib", "dylib", "proc-macro"。 (默认值为 ["lib"])
                       - 其他 target 类都为 ["bin"]
                    */
                    "crate_types": [
                        "bin"
                    ],
                    /* target 的名称 */
                    "name": "my-package",
                    /* 目标的*根*源文件的绝对路径。 */
                    "src_path": "/path/to/my-package/src/main.rs",
                    /* target 的 Rust 版本。
                       默认为 package 标注的 Rust 版本。 
                    */
                    "edition": "2018",
                    /* 启用的 feature。
                       如果没有设置 feature，则该字段不存在。
                    */
                    "required-features": ["feat1"],
                    /* 该目标是否应该使用  `cargo doc` 生成文档。 */
                    "doc": true,
                    /* 该目标是否启用文档测试，且该目标是否与文档测试兼容。
                    */
                    "doctest": false,
                    /* 该目标在运行或构建时是否设置 `--test`。
                    */
                    "test": true
                }
            ],
            /* 包中定义的 feature，每一项 feature 启用一系列 feature 或者依赖项。
            */
            "features": {
                "default": [
                    "feat1"
                ],
                "feat1": [],
                "feat2": []
            },
            /* 该包的清单文件的绝对路径 */
            "manifest_path": "/path/to/my-package/Cargo.toml",
            /* 包的元数据。
               若没有指定元数据，该项为 null。
            */
            "metadata": {
                "docs": {
                    "rs": {
                        "all-features": true
                    }
                }
            },
            /* 该包可能发布的 registry 列表。List of registries to which this package may be published.
               若为 null 则发布不受限制，若为空数组，则禁止发布。 */
            "publish": [
                "crates-io"
            ],
            /* 清单文件中的 authors。
               如果没有指定 authors，则该值为空数组。
            */
            "authors": [
                "Jane Doe <user@example.com>"
            ],
            /* 清单文件中的 categories。 */
            "categories": [
                "command-line-utilities"
            ],
            /* 可选字符串。指定 cargo run 执行的默认二进制crate。 */
            "default_run": null,
            /* 可选字符串。声明支持的最小 rust 版本。 */
            "rust_version": "1.56",
            /* 清单文件中的 keywords。 */
            "keywords": [
                "cli"
            ],
            /* 清单文件中的 readme 值，若没有指定则为 null。 */
            "readme": "README.md",
            /* 清单文件中的 repository 值，若没有指定则为 null。 */
            "repository": "https://github.com/rust-lang/cargo",
            /* 清单文件中的 homepage 值，若没有指定则为 null。 */
            "homepage": "https://rust-lang.org",
            /* 清单文件中的 documentation 值，若没有指定则为 null。 */
            "documentation": "https://doc.rust-lang.org/stable/std",
            /* 该包的默认 rust 版本。
               注意，每个 target 可能有不同的 rust 版本。
            */
            "edition": "2018",
            /* 可选字符串。指示该包链接的本地库的名称。
            */
            "links": null,
        }
    ],
    /* 工作空间的成员。
       每个条目都是一个 Package ID 。
    */
    "workspace_members": [
        "my-package 0.1.0 (path+file:///path/to/my-package)",
    ],
    // 整个工作空间的依赖解析图。启用的 feature 是基于 “当前” 的包所启用的 feature。
    // 未启用的可选依赖没有列入其中。
    //
    // 如果使用了 --no-deps 标志，则该项为 null。
    //
    // 默认情况下，该项会包含面向所有目标平台的所有依赖
    // `--filter-platform` 标志可以用来收窄到特定的目标三元组 (target triple)。
    "resolve": {
        /* 依赖图中节点组成的数组。
           每个节点(node)都是一个包(package)。
        */
        "nodes": [
            {
                /* 节点的 Package ID  */
                "id": "my-package 0.1.0 (path+file:///path/to/my-package)",
                /* 该包的依赖项，一个 Package ID 的数组。 */
                "dependencies": [
                    "bitflags 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)"
                ],
                /* 该包的依赖项。这是 "dependencies" 的另一种表示，其中包含额外的信息。比如依赖的重命名。
                */
                "deps": [
                    {
                        /* 依赖的库target的名称。The name of the dependency's library target.
                           如果该依赖被重命名，则该name是新名。
                        */
                        "name": "bitflags",
                        /* 依赖的 Package ID  */
                        "pkg": "bitflags 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)",
                        /* 依赖种类的数组，在 Cargo 1.40 中加入该项。 */
                        "dep_kinds": [
                            {
                                /* 依赖种类。
                                   "dev", "build", 普通依赖为 null。
                                */
                                "kind": null,
                                /* 依赖的目标平台，非平台特定依赖为 null。
                                */
                                "target": "cfg(windows)"
                            }
                        ]
                    }
                ],
                /* 该包中启用的 feature 。 */
                "features": [
                    "default"
                ]
            }
        ],
        /* 工作空间的 root package 。
           如果是 virtual workspace 此项为 null，其他情况为 root package 的 Package ID 。
        */
        "root": "my-package 0.1.0 (path+file:///path/to/my-package)"
    },
    /* 构建文件夹的绝对路径，Cargo 在此处存放构建输出产物。 */
    "target_directory": "/path/to/my-package/target",
    /* 此元数据的 schema 版本
       如果未来有不兼容的变化，该值会改变。
    */
    "version": 1,
    /* 工作空间根文件夹的绝对路径 */
    "workspace_root": "/path/to/my-package"
    /* 工作空间的元数据Workspace metadata.
       如果没有指定元数据，则该项为 null。 */
    "metadata": {
        "docs": {
            "rs": {
                "all-features": true
            }
        }
    }
}
````
{==+==}

{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}

{==+==}
### Output Options
{==+==}
### 输出选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---no-deps"><a class="option-anchor" href="#option-cargo-metadata---no-deps"></a><code>--no-deps</code></dt>
<dd class="option-desc">Output information only about the workspace members and don't fetch
dependencies.</dd>
{==+==}
<dt class="option-term" id="option-cargo-metadata---no-deps"><a class="option-anchor" href="#option-cargo-metadata---no-deps"></a><code>--no-deps</code></dt>
<dd class="option-desc">仅输出工作空间成员的信息而不下载依赖</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---format-version"><a class="option-anchor" href="#option-cargo-metadata---format-version"></a><code>--format-version</code> <em>version</em></dt>
<dd class="option-desc">Specify the version of the output format to use. Currently <code>1</code> is the only
possible value.</dd>
{==+==}
<dt class="option-term" id="option-cargo-metadata---format-version"><a class="option-anchor" href="#option-cargo-metadata---format-version"></a><code>--format-version</code> <em>version</em></dt>
<dd class="option-desc">指定输出格式的版本。目前 <code>1</code> 是唯一的合法值。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---filter-platform"><a class="option-anchor" href="#option-cargo-metadata---filter-platform"></a><code>--filter-platform</code> <em>triple</em></dt>
<dd class="option-desc">This filters the <code>resolve</code> output to only include dependencies for the
given target triple. Without this flag, the resolve includes all targets.</p>
<p>Note that the dependencies listed in the &quot;packages&quot; array still includes all
dependencies. Each package definition is intended to be an unaltered
reproduction of the information within <code>Cargo.toml</code>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-metadata---filter-platform"><a class="option-anchor" href="#option-cargo-metadata---filter-platform"></a><code>--filter-platform</code> <em>triple</em></dt>
<dd class="option-desc">这会过滤 <code>解析信息</code> 的输出，仅包括对于特定目标 (target triple) 的结果。
如果不加这个标志，解析会包括所有的目标 (targets)。</p>
<p>注意， &quot;packages&quot; 数组仍然会包含所有的依赖。每个 package 的信息是 <code>Cargo.toml</code> 中信息的不做修改的再现。</dd>
{==+==}


{==+==}
### Feature Selection
{==+==}
### 选择 feature
{==+==}

{==+==}
The feature flags allow you to control which features are enabled. When no
feature options are given, the `default` feature is activated for every
selected package.
{==+==}
特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。
{==+==}

{==+==}
See [the features documentation](../reference/features.html#command-line-feature-options)
for more details.
{==+==}
查看 [features 文档](../reference/features.html#command-line-feature-options) 获取更多信息。
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata--F"><a class="option-anchor" href="#option-cargo-metadata--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-metadata---features"><a class="option-anchor" href="#option-cargo-metadata---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">Space or comma separated list of features to activate. Features of workspace
members may be enabled with <code>package-name/feature-name</code> syntax. This flag may
be specified multiple times, which enables all specified features.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--F"><a class="option-anchor" href="#option-cargo-install--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-install---features"><a class="option-anchor" href="#option-cargo-install---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">用空格或逗号来分隔多个启用的 feature。 工作空间成员的 feature 可以通过 <code>package-name/feature-name</code> 语法来启用。 该标志可以设置多次，最终将启用指定的所有 feature 。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---all-features"><a class="option-anchor" href="#option-cargo-metadata---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">Activate all available features of all selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---all-features"><a class="option-anchor" href="#option-cargo-install---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc"> 启用指定包的所有可用 feature。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---no-default-features"><a class="option-anchor" href="#option-cargo-metadata---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">Do not activate the <code>default</code> feature of the selected packages.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---no-default-features"><a class="option-anchor" href="#option-cargo-install---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不使用指定包的 <code>default</code> feature 。</dd>
{==+==}


{==+==}
### Display Options
{==+==}
### 显示选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata--v"><a class="option-anchor" href="#option-cargo-metadata--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-metadata---verbose"><a class="option-anchor" href="#option-cargo-metadata---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">Use verbose output. May be specified twice for &quot;very verbose&quot; output which
includes extra output such as dependency warnings and build script output.
May also be specified with the <code>term.verbose</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata--q"><a class="option-anchor" href="#option-cargo-metadata--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-metadata---quiet"><a class="option-anchor" href="#option-cargo-metadata---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">Do not print cargo log messages.
May also be specified with the <code>term.quiet</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---color"><a class="option-anchor" href="#option-cargo-metadata---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">Control when colored output is used. Valid values:</p>
<ul>
<li><code>auto</code> (default): Automatically detect if color support is available on the
terminal.</li>
<li><code>always</code>: Always display colors.</li>
<li><code>never</code>: Never display colors.</li>
</ul>
<p>May also be specified with the <code>term.color</code>
<a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---color"><a class="option-anchor" href="#option-cargo-install---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>
{==+==}


{==+==}
### Manifest Options
{==+==}
### 清单选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---manifest-path"><a class="option-anchor" href="#option-cargo-metadata---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc">Path to the <code>Cargo.toml</code> file. By default, Cargo searches for the
<code>Cargo.toml</code> file in the current directory or any parent directory.</dd>
{==+==}
<dt class="option-term" id="option-cargo-locate-project---manifest-path"><a class="option-anchor" href="#option-cargo-locate-project---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径。默认情况下，Cargo 会从当前目录或任意的上级目录搜索 <code>Cargo.toml</code> 。</dd>
{==+==}



{==+==}
<dt class="option-term" id="option-cargo-metadata---frozen"><a class="option-anchor" href="#option-cargo-metadata---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-metadata---locked"><a class="option-anchor" href="#option-cargo-metadata---locked"></a><code>--locked</code></dt>
<dd class="option-desc">Either of these flags requires that the <code>Cargo.lock</code> file is
up-to-date. If the lock file is missing, or it needs to be updated, Cargo will
exit with an error. The <code>--frozen</code> flag also prevents Cargo from
attempting to access the network to determine if it is out-of-date.</p>
<p>These may be used in environments where you want to assert that the
<code>Cargo.lock</code> file is up-to-date (such as a CI build) or want to avoid network
access.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---frozen"><a class="option-anchor" href="#option-cargo-install---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-install---locked"><a class="option-anchor" href="#option-cargo-install---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---offline"><a class="option-anchor" href="#option-cargo-metadata---offline"></a><code>--offline</code></dt>
<dd class="option-desc">Prevents Cargo from accessing the network for any reason. Without this
flag, Cargo will stop with an error if it needs to access the network and
the network is not available. With this flag, Cargo will attempt to
proceed without the network if possible.</p>
<p>Beware that this may result in different dependency resolution than online
mode. Cargo will restrict itself to crates that are downloaded locally, even
if there might be a newer version as indicated in the local copy of the index.
See the <a href="cargo-fetch.html">cargo-fetch(1)</a> command to download dependencies before going
offline.</p>
<p>May also be specified with the <code>net.offline</code> <a href="../reference/config.html">config value</a>.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---offline"><a class="option-anchor" href="#option-cargo-install---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>
{==+==}


{==+==}
### Common Options
{==+==}
### 通用选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata-+toolchain"><a class="option-anchor" href="#option-cargo-metadata-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">If Cargo has been installed with rustup, and the first argument to <code>cargo</code>
begins with <code>+</code>, it will be interpreted as a rustup toolchain name (such
as <code>+stable</code> or <code>+nightly</code>).
See the <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
for more information about how toolchain overrides work.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install-+toolchain"><a class="option-anchor" href="#option-cargo-install-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata---config"><a class="option-anchor" href="#option-cargo-metadata---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">Overrides a Cargo configuration value. The argument should be in TOML syntax of <code>KEY=VALUE</code>,
or provided as a path to an extra configuration file. This flag may be specified multiple times.
See the <a href="../reference/config.html#command-line-overrides">command-line overrides section</a> for more information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata--h"><a class="option-anchor" href="#option-cargo-metadata--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-metadata---help"><a class="option-anchor" href="#option-cargo-metadata---help"></a><code>--help</code></dt>
<dd class="option-desc">Prints help information.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-metadata--Z"><a class="option-anchor" href="#option-cargo-metadata--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Unstable (nightly-only) flags to Cargo. Run <code>cargo -Z help</code> for details.</dd>
{==+==}
<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>
{==+==}


{==+==}
## ENVIRONMENT
{==+==}
## 环境
{==+==}

{==+==}
See [the reference](../reference/environment-variables.html) for
details on environment variables that Cargo reads.
{==+==}
查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。
{==+==}


{==+==}
## EXIT STATUS
{==+==}
## 退出状态
{==+==}

{==+==}
* `0`: Cargo succeeded.
* `101`: Cargo failed to complete.
{==+==}
* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 使用案例
{==+==}

{==+==}
1. Output JSON about the current package:

       cargo metadata --format-version=1
{==+==}
1. 以 JSON 格式输出当前包的信息: 

       cargo metadata --format-version=1
{==+==}

{==+==}
## SEE ALSO
{==+==}
## 其他参考
{==+==}

{==+==}
[cargo(1)](cargo.html)
{==+==}

{==+==}
