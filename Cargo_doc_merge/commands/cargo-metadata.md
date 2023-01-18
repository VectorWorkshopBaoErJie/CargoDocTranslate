# cargo-metadata(1)

## 名称

cargo-metadata - 输出当前包的机器可读的元数据

## 概要

`cargo metadata` [_options_]

## 描述

在 stdout 中输出工作空间成员的信息和当前包已解析的依赖。

建议在使用时添加 `--format-version` 标志以保证未来也会以你预期的格式进行输出。

另见 [cargo_metadata crate](https://crates.io/crates/cargo_metadata) 查看读取该元数据的 Rust API。

## 输出格式

输出格式如下: 

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

## 选项

### 输出选项

<dl>

<dt class="option-term" id="option-cargo-metadata---no-deps"><a class="option-anchor" href="#option-cargo-metadata---no-deps"></a><code>--no-deps</code></dt>
<dd class="option-desc">仅输出工作空间成员的信息而不下载依赖</dd>


<dt class="option-term" id="option-cargo-metadata---format-version"><a class="option-anchor" href="#option-cargo-metadata---format-version"></a><code>--format-version</code> <em>version</em></dt>
<dd class="option-desc">指定输出格式的版本。目前 <code>1</code> 是唯一的合法值。</dd>


<dt class="option-term" id="option-cargo-metadata---filter-platform"><a class="option-anchor" href="#option-cargo-metadata---filter-platform"></a><code>--filter-platform</code> <em>triple</em></dt>
<dd class="option-desc">这会过滤 <code>解析信息</code> 的输出，仅包括对于特定目标 (target triple) 的结果。
如果不加这个标志，解析会包括所有的目标 (targets)。</p>
<p>注意， &quot;packages&quot; 数组仍然会包含所有的依赖。每个 package 的信息是 <code>Cargo.toml</code> 中信息的不做修改的再现。</dd>


</dl>

### 选择 feature

feature 标志可以用于控制启用哪些 feature。当没有提供这个选项时，会使用 `default` feature。

查看 [features 文档](../reference/features.html#command-line-feature-options) 获取更多信息。

<dl>

<dt class="option-term" id="option-cargo-install--F"><a class="option-anchor" href="#option-cargo-install--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-install---features"><a class="option-anchor" href="#option-cargo-install---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">用空格或逗号来分隔多个启用的 feature。 工作空间成员的 feature 可以通过 <code>package-name/feature-name</code> 语法来启用。 该标志可以设置多次，最终将启用指定的所有 feature 。</dd>


<dt class="option-term" id="option-cargo-install---all-features"><a class="option-anchor" href="#option-cargo-install---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc"> 启用指定包的所有可用 feature。</dd>


<dt class="option-term" id="option-cargo-install---no-default-features"><a class="option-anchor" href="#option-cargo-install---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不使用指定包的 <code>default</code> feature 。</dd>


</dl>


### 显示选项

<dl>
<dt class="option-term" id="option-cargo-install--v"><a class="option-anchor" href="#option-cargo-install--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-install---verbose"><a class="option-anchor" href="#option-cargo-install---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置选项</a> 来指定。</dd>


<dt class="option-term" id="option-cargo-install--q"><a class="option-anchor" href="#option-cargo-install--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-install---quiet"><a class="option-anchor" href="#option-cargo-install---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置选项</a>来指定。</dd>


<dt class="option-term" id="option-cargo-install---color"><a class="option-anchor" href="#option-cargo-install---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置选项</a>中设置。</dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-locate-project---manifest-path"><a class="option-anchor" href="#option-cargo-locate-project---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code> 文件的路径。默认情况下，Cargo 会从当前目录或任意的上级目录搜索 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-install---frozen"><a class="option-anchor" href="#option-cargo-install---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-install---locked"><a class="option-anchor" href="#option-cargo-install---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-install---offline"><a class="option-anchor" href="#option-cargo-install---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-install-+toolchain"><a class="option-anchor" href="#option-cargo-install-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-install---config"><a class="option-anchor" href="#option-cargo-install---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-install--h"><a class="option-anchor" href="#option-cargo-install--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-install---help"><a class="option-anchor" href="#option-cargo-install---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-install--Z"><a class="option-anchor" href="#option-cargo-install--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 以 JSON 格式输出当前包的信息: 

       cargo metadata --format-version=1

## 其他参考
[cargo(1)](cargo.html)
