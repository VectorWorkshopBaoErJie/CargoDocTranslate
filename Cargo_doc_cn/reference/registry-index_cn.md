{==+==}
## Index Format
{==+==}
## 索引格式
{==+==}


{==+==}
The following defines the format of the index. New features are occasionally
added, which are only understood starting with the version of Cargo that
introduced them. Older versions of Cargo may not be able to use packages that
make use of new features. However, the format for older packages should not
change, so older versions of Cargo should be able to use them.
{==+==}
下面定义了索引的格式。有时会增加一些新的功能，这些新功能将从新版本的 Cargo 开始识别。
旧版本的Cargo可能无法使用利用了新特性的包。而旧版本的包的格式不应改变，旧版本Cargo应能使用它们。
{==+==}


{==+==}
The index is stored in a git repository so that Cargo can efficiently fetch
incremental updates to the index. In the root of the repository is a file
named `config.json` which contains JSON information used by Cargo for
accessing the registry. This is an example of what the [crates.io] config file
looks like:
{==+==}
索引存储在git仓库中，这样Cargo就可以有效地获取索引的增量更新。
仓库的根位置有一个名为 "config.json" 的文件，包含Cargo访问注册中心时使用的JSON信息。
这是一个[crates.io]配置文件的例子，看起来像:
{==+==}


{==+==}
```javascript
{
    "dl": "https://crates.io/api/v1/crates",
    "api": "https://crates.io"
}
```
{==+==}

{==+==}


{==+==}
The keys are:
- `dl`: This is the URL for downloading crates listed in the index. The value
  may have the following markers which will be replaced with their
  corresponding value:
{==+==}
键是:
- `dl`: 这是在索引中列出的下载crates的URL。该值可能有以下标记，这些标记将被替换成其相应的值:
{==+==}


{==+==}
  - `{crate}`: The name of crate.
  - `{version}`: The crate version.
  - `{prefix}`: A directory prefix computed from the crate name. For example,
    a crate named `cargo` has a prefix of `ca/rg`. See below for details.
  - `{lowerprefix}`: Lowercase variant of `{prefix}`.
  - `{sha256-checksum}`: The crate's sha256 checksum.
{==+==}
  - `{crate}`: crate 的名称。
  - `{version}`: crate 的版本。
  - `{prefix}`: 从 crate 名称计算出来的目录前缀。例如，名为 `cargo` 的 crate 的前缀是 `ca/rg` 。详见下文。
  - `{lowerprefix}`: `{prefix}` 的小写变体。
  - `{sha256-checksum}`: crate 的sha256校验和。
{==+==}


{==+==}
  If none of the markers are present, then the value
  `/{crate}/{version}/download` is appended to the end.
- `api`: This is the base URL for the web API. This key is optional, but if it
  is not specified, commands such as [`cargo publish`] will not work. The web
  API is described below.
{==+==}
  如果没有任何标记，那么结尾将附加值 `/{crate}/{version}/download` 。
- `api`: 这是web API的基本URL。这个键是可选的，但如果没有指定，[`cargo publish`] 等命令将无法工作。下面将介绍web API。
{==+==}


{==+==}
The download endpoint should send the `.crate` file for the requested package.
Cargo supports https, http, and file URLs, HTTP redirects, HTTP1 and HTTP2.
The exact specifics of TLS support depend on the platform that Cargo is
running on, the version of Cargo, and how it was compiled.
{==+==}
下载端应发送所请求包的 `.crate` 文件。
Cargo支持https、http和文件URL、HTTP重定向、HTTP1和HTTP2。
TLS支持的具体细节取决于Cargo所运行的平台、Cargo的版本以及它的编译方式。
{==+==}


{==+==}
The rest of the index repository contains one file for each package, where the
filename is the name of the package in lowercase. Each version of the package
has a separate line in the file. The files are organized in a tier of
directories:
{==+==}
索引库的其余部分包含每个包的一个文件，其中文件名是小写包的名称。
包的每个版本在文件中都有一个单独的行。这些文件被组织在分层级的目录中。
{==+==}


{==+==}
- Packages with 1 character names are placed in a directory named `1`.
- Packages with 2 character names are placed in a directory named `2`.
- Packages with 3 character names are placed in the directory
  `3/{first-character}` where `{first-character}` is the first character of
  the package name.
- All other packages are stored in directories named
  `{first-two}/{second-two}` where the top directory is the first two
  characters of the package name, and the next subdirectory is the third and
  fourth characters of the package name. For example, `cargo` would be stored
  in a file named `ca/rg/cargo`.
{==+==}
- 具有1个字符名称的包被放置在一个名为 `1` 的目录中。
- 具有2个字符名称的包被放置在一个名为 `2` 的目录中。
- 名称为3个字符的包被放置在 `3/{first-character}` 目录下，其中 `{first-character}`  是包名称的第一个字符。
- 所有其他包都存储在名为 `{first-two}/{second-two}` 的目录中，其中顶部目录是包名称的前两个字符，下一个子目录是包名称的第三和第四个字符。例如，`cargo` 将被存储在一个名为 `ca/rg/cargo`的文件中。
{==+==}


{==+==}
> Note: Although the index filenames are in lowercase, the fields that contain
> package names in `Cargo.toml` and the index JSON data are case-sensitive and
> may contain upper and lower case characters.
{==+==}
> 注意: 尽管索引文件名是小写的，但 `Cargo.toml` 中包含包名的字段和索引JSON数据是区分大小写的，可能包含大写和小写字符。
{==+==}


{==+==}
The directory name above is calculated based on the package name converted to
lowercase; it is represented by the marker `{lowerprefix}`.  When the original
package name is used without case conversion, the resulting directory name is
represented by the marker `{prefix}`.  For example, the package `MyCrate` would
have a `{prefix}` of `My/Cr` and a `{lowerprefix}` of `my/cr`.  In general,
using `{prefix}` is recommended over `{lowerprefix}`, but there are pros and
cons to each choice.  Using `{prefix}` on case-insensitive filesystems results
in (harmless-but-inelegant) directory aliasing.  For example, `crate` and
`CrateTwo` have `{prefix}` values of `cr/at` and `Cr/at`; these are distinct on
Unix machines but alias to the same directory on Windows.  Using directories
with normalized case avoids aliasing, but on case-sensitive filesystems it's
harder to support older versions of Cargo that lack `{prefix}`/`{lowerprefix}`.
For example, nginx rewrite rules can easily construct `{prefix}` but can't
perform case-conversion to construct `{lowerprefix}`.
{==+==}
上面的目录名是根据转换为小写的包名计算的；它由标记 `{lowerprefix}` 表示。当使用原始包名而不进行大小写转换时，产生的目录名由标记 `{prefix}` 表示。
例如，`MyCrate` 包的 `{prefix}` 为 `My/Cr` ， `{lowerprefix}` 为 `my/cr` 。一般来说，推荐使用 `{prefix}` 而不是 `{lowerprefix}` ，但每种选择都有优点和缺点。在不区分大小写的文件系统中使用 `{prefix}` 会导致(无害但不优雅的)目录别名。
例如， `crate` 和 `CrateTwo` 的 `{prefix}` 值分别为 `cr/at` 和 `Cr/at` ；这些在Unix机器上是不同的，但在Windows上却别名为同一个目录。 使用正常大小写的目录可以避免别名，但在对大小写敏感的文件系统中，很难支持缺乏 `{prefix}`/`{lowerprefix}` 的旧版本的Cargo。
例如，nginx的重写规则可以很容易地构建 `{prefix}` ，但不能进行大小写转换以构建 `{lowerprefix}` 。
{==+==}


{==+==}
Registries should consider enforcing limitations on package names added to
their index. Cargo itself allows names with any [alphanumeric], `-`, or `_`
characters. [crates.io] imposes its own limitations, including the following:
{==+==}
注册中心应该考虑对添加到他们索引中的包名称实施限制。
Cargo本身允许名字中含有任何 [字母数字][alphanumeric] 、 `-` 或 `_` 字符。 [crates.io] 添加了自己的限制，包括以下内容:
{==+==}


{==+==}
- Only allows ASCII characters.
- Only alphanumeric, `-`, and `_` characters.
- First character must be alphabetic.
- Case-insensitive collision detection.
- Prevent differences of `-` vs `_`.
- Under a specific length (max 64).
- Rejects reserved names, such as Windows special filenames like "nul".
{==+==}
- 只允许ASCII字符。
- 只有字母数字、 `-` 和 `_` 字符。
- 第一个字符必须是英文字母。
- 对大小写不敏感冲突检测。
- 防止 `-` 与 `_` 的差异。
- 在特定长度下(最大64)。
- 抛弃保留名称，如Windows的特殊文件名，如 "nul" 。
{==+==}


{==+==}
Registries should consider incorporating similar restrictions, and consider
the security implications, such as [IDN homograph
attacks](https://en.wikipedia.org/wiki/IDN_homograph_attack) and other
concerns in [UTR36](https://www.unicode.org/reports/tr36/) and
[UTS39](https://www.unicode.org/reports/tr39/).
{==+==}
注册中心应考虑纳入类似的限制，并考虑安全问题，如 [IDN同源词攻击](https://en.wikipedia.org/wiki/IDN_homograph_attack) 以及 [UTR36](https://www.unicode.org/reports/tr36/) 和 [UTS39](https://www.unicode.org/reports/tr39/)中的其他考虑。 
{==+==}


{==+==}
Each line in a package file contains a JSON object that describes a published
version of the package. The following is a pretty-printed example with comments
explaining the format of the entry.
{==+==}
包文件中的每一行都包含一个JSON对象，描述包的发布版本。下面是一个优雅的例子，其中有注释解释了条目的格式。
{==+==}


{==+==}
```javascript
{
    // The name of the package.
    // This must only contain alphanumeric, `-`, or `_` characters.
    "name": "foo",
    // The version of the package this row is describing.
    // This must be a valid version number according to the Semantic
    // Versioning 2.0.0 spec at https://semver.org/.
    "vers": "0.1.0",
    // Array of direct dependencies of the package.
    "deps": [
{==+==}
```javascript
{
    // 包的名称。
    // 这必须只包含字母数字、 `-` 或 `_` 字符。
    "name": "foo",
    // 这一行描述包的版本。
    // 根据语义化版本 2.0.0 标准，这必须是一个有效的版本号，参考网址 https://semver.org/。
    "vers": "0.1.0",
    // 包的直接依赖的数组。
    "deps": [
{==+==}


{==+==}
        {
            // Name of the dependency.
            // If the dependency is renamed from the original package name,
            // this is the new name. The original package name is stored in
            // the `package` field.
            "name": "rand",
            // The SemVer requirement for this dependency.
            // This must be a valid version requirement defined at
            // https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html.
            "req": "^0.6",
            // Array of features (as strings) enabled for this dependency.
            "features": ["i128_support"],
            // Boolean of whether or not this is an optional dependency.
            "optional": false,
            // Boolean of whether or not default features are enabled.
            "default_features": true,
            // The target platform for the dependency.
            // null if not a target dependency.
            // Otherwise, a string such as "cfg(windows)".
            "target": null,
            // The dependency kind.
            // "dev", "build", or "normal".
            // Note: this is a required field, but a small number of entries
            // exist in the crates.io index with either a missing or null
            // `kind` field due to implementation bugs.
            "kind": "normal",
            // The URL of the index of the registry where this dependency is
            // from as a string. If not specified or null, it is assumed the
            // dependency is in the current registry.
            "registry": null,
            // If the dependency is renamed, this is a string of the actual
            // package name. If not specified or null, this dependency is not
            // renamed.
            "package": null,
        }
{==+==}
        {
            // 依赖的名称。
            // 如果依赖从源包名称中重命名，这就是新的名称。源包的名称被保存在 `package` 字段中。
            "name": "rand",
            // 依赖的语义化版本要求。
            // 这必须是一个有效的版本要求，定义在https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html。
            "req": "^0.6",
            // 该依赖启用的特性数组(字符串)。
            "features": ["i128_support"],
            // 布尔值，表示这是否是一个可选的依赖。
            "optional": false,
            // 是否启用默认特性的布尔值。
            "default_features": true,
            // 依赖的目标平台。
            // 如果不是目标依赖，则为空。
            // 否则，就是一个字符串，如 "cfg(windows)" 。
            "target": null,
            // 依赖性的种类。
            // "dev", "build", or "normal".
            // 注意: 这是必需的字段，但由于执行错误，crates.io索引中存在少量的条目，其中的 `kind` 字段缺失或为空。
            "kind": "normal",
            // 该依赖所在的注册中心索引的URL，是字符串。如果没有指定或为空，则假定该依赖在当前注册中心中。
            "registry": null,
            // 如果依赖被重新命名，这是一个包实际的名称字符串。如果没有指定或为空，则该依赖未重命名。
            "package": null,
        }
{==+==}


{==+==}
    ],
    // A SHA256 checksum of the `.crate` file.
    "cksum": "d867001db0e2b6e0496f9fac96930e2d42233ecd3ca0413e0753d4c7695d289c",
    // Set of features defined for the package.
    // Each feature maps to an array of features or dependencies it enables.
    "features": {
        "extras": ["rand/simd_support"]
    },
    // Boolean of whether or not this version has been yanked.
    "yanked": false,
    // The `links` string value from the package's manifest, or null if not
    // specified. This field is optional and defaults to null.
    "links": null,
    // An unsigned 32-bit integer value indicating the schema version of this
    // entry.
    //
    // If this not specified, it should be interpreted as the default of 1.
    //
    // Cargo (starting with version 1.51) will ignore versions it does not
    // recognize. This provides a method to safely introduce changes to index
    // entries and allow older versions of cargo to ignore newer entries it
    // doesn't understand. Versions older than 1.51 ignore this field, and
    // thus may misinterpret the meaning of the index entry.
    //
    // The current values are:
    //
    // * 1: The schema as documented here, not including newer additions.
    //      This is honored in Rust version 1.51 and newer.
    // * 2: The addition of the `features2` field.
    //      This is honored in Rust version 1.60 and newer.
{==+==}
    ],
    // `.crate`文件的SHA256校验和。
    "cksum": "d867001db0e2b6e0496f9fac96930e2d42233ecd3ca0413e0753d4c7695d289c",
    // 为包定义的一组特性。
    // 每个特性都映射到它所启用的特性或依赖性数组。
    "features": {
        "extras": ["rand/simd_support"]
    },
    // 该版本是否已被撤消的布尔值。
    "yanked": false,
    // 包的配置清单中的 `links` 字符串值，如果没有指定则为空。这个字段是可选的，默认为空。
    "links": null,
    // 一个无符号的32位整数，表示该条目的模式版本。
    //
    // 如果没有指定，它应该被解释为默认的1。
    //
    // Cargo(从1.51版开始)会忽略它不认识的版本。
    // 这提供了一种方法，可以安全地对索引条目进行修改，并允许老版本的cargo忽略它不理解的新条目。1.51以上的版本会忽略这个字段，因此可能会误解索引条目的含义。
    //
    // 目前的数值是：
    //
    // * 1: 这里记录的模式，不包括较新的补充内容。
    //      这在Rust 1.51版和更新的版本中得到认可。
    // * 2: 增加了 `features2` 字段。
    //      这在Rust 1.60和更新的版本中得到认可。
{==+==}


{==+==}
    "v": 2,
    // This optional field contains features with new, extended syntax.
    // Specifically, namespaced features (`dep:`) and weak dependencies
    // (`pkg?/feat`).
    //
    // This is separated from `features` because versions older than 1.19
    // will fail to load due to not being able to parse the new syntax, even
    // with a `Cargo.lock` file.
    //
    // Cargo will merge any values listed here with the "features" field.
    //
    // If this field is included, the "v" field should be set to at least 2.
    //
    // Registries are not required to use this field for extended feature
    // syntax, they are allowed to include those in the "features" field.
    // Using this is only necessary if the registry wants to support cargo
    // versions older than 1.19, which in practice is only crates.io since
    // those older versions do not support other registries.
    "features2": {
        "serde": ["dep:serde", "chrono?/serde"]
    }
}
```
{==+==}
    "v": 2,
    // 此可选字段包含具有新的扩展语法的特性。
    // 具体来说，命名空间特性(`dep:`)和弱依赖(`pkg?/feat`)。
    //
    // 这是从 `features` 中分离出来的，因为1.19以前的版本会因为无法解析新的语法而无法加载，即使有 `Cargo.lock` 文件。
    //
    // cargo 将把这里列出的任何数值与 "features" 字段合并。
    //
    // 如果包括这个字段，"v" 字段应至少设置为 2 。
    //
    // 注册中心不需要为扩展的特性语法使用这个字段，他们可以在 "features" 字段中包括这些特性。
    // 只有当注册中心要支持1.19之前的cargo版本时，才有必要使用这个功能，实际上，这只是 crates.io ，因为这些旧版本不支持其他注册中心。
    "features2": {
        "serde": ["dep:serde", "chrono?/serde"]
    }
}
```
{==+==}


{==+==}
The JSON objects should not be modified after they are added except for the
`yanked` field whose value may change at any time.
{==+==}
除了 `yanked` 字段的值可能在任何时候改变外，JSON对象在添加后不应该被修改。
{==+==}


{==+==}
[`cargo publish`]: ../commands/cargo-publish.md
{==+==}

{==+==}
