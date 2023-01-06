{==+==}
## Web API
{==+==}

{==+==}


{==+==}
A registry may host a web API at the location defined in `config.json` to
support any of the actions listed below.
{==+==}
注册机构可以在 `config.json` 中定义的位置托管一个网络API，以支持下面列出的任何动作。
{==+==}


{==+==}
Cargo includes the `Authorization` header for requests that require
authentication. The header value is the API token. The server should respond
with a 403 response code if the token is not valid. Users are expected to
visit the registry's website to obtain a token, and Cargo can store the token
using the [`cargo login`] command, or by passing the token on the
command-line.
{==+==}
对于需要认证的请求，Cargo包含 `Authorization` 头。该头的值是API token。如果 token 无效，服务器应以403代码进行响应。用户应该访问注册中心的网站来获得token ，Cargo可以使用 [`cargo login`] 命令来存储token，或者在命令行中传递token。
{==+==}


{==+==}
Responses use the 200 response code for success.
Errors should use an appropriate response code, such as 404.
Failure
responses should have a JSON object with the following structure:
{==+==}
响应使用200代码表示成功。
错误应使用适当的响应代码，如404。
失败响应应该有一个JSON对象，其结构如下:
{==+==}


{==+==}
```javascript
{
    // Array of errors to display to the user.
    "errors": [
        {
            // The error message as a string.
            "detail": "error message text"
        }
    ]
}
```
{==+==}
```javascript
{
    // 要显示给用户的错误数组。
    "errors": [
        {
            // 作为字符串的错误消息。
            "detail": "error message text"
        }
    ]
}
```
{==+==}


{==+==}
If the response has this structure Cargo will display the detailed message to the user, even if the response code is 200.
If the response code indicates an error and the content does not have this structure, Cargo will display to the user a
 message intended to help debugging the server error. A server returning an `errors` object allows a registry to provide a more
detailed or user-centric error message.
{==+==}
如果响应有这种结构，Cargo会向用户显示详细的信息，即使响应代码是200。
如果响应代码表明有错误，而且内容没有这种结构，Cargo会向用户显示一条旨在帮助调试服务器错误的信息。
服务器返回一个 `errors` 对象，允许注册中心提供更详细的或以用户为中心的错误信息。
{==+==}


{==+==}
For backwards compatibility, servers should ignore any unexpected query
parameters or JSON fields. If a JSON field is missing, it should be assumed to
be null. The endpoints are versioned with the `v1` component of the path, and
Cargo is responsible for handling backwards compatibility fallbacks should any
be required in the future.
{==+==}
为了向后兼容，服务器应该忽略任何意外的查询参数或JSON字段。
如果缺少的JSON字段，应该假定它为空。端点以路径中的 `v1` 部分为版本，如果将来有任何需要，Cargo负责处理向后兼容的回调。
{==+==}


{==+==}
Cargo sets the following headers for all requests:
{==+==}
Cargo为所有请求设置了以下头信息:
{==+==}


{==+==}
- `Content-Type`: `application/json`
- `Accept`: `application/json`
- `User-Agent`: The Cargo version such as `cargo 1.32.0 (8610973aa
  2019-01-02)`. This may be modified by the user in a configuration value.
  Added in 1.29.
{==+==}

{==+==}


{==+==}
### Publish
{==+==}
### 发布
{==+==}


{==+==}
- Endpoint: `/api/v1/crates/new`
- Method: PUT
- Authorization: Included
{==+==}

{==+==}


{==+==}
The publish endpoint is used to publish a new version of a crate. The server
should validate the crate, make it available for download, and add it to the
index.
{==+==}
发布端点用于发布新版本的crate。服务器应该验证该crate，使其可供下载，并将其添加到索引中。
{==+==}


{==+==}
The body of the data sent by Cargo is:
{==+==}
Cargo发送的数据体:
{==+==}


{==+==}
- 32-bit unsigned little-endian integer of the length of JSON data.
- Metadata of the package as a JSON object.
- 32-bit unsigned little-endian integer of the length of the `.crate` file.
- The `.crate` file.
{==+==}
- JSON数据长度的32位无符号小端整数。
- 作为JSON对象的包的元数据。
- `.crate` 文件长度的32位无符号小端整数。
- `.crate` 文件。
{==+==}


{==+==}
The following is a commented example of the JSON object. Some notes of some
restrictions imposed by [crates.io] are included only to illustrate some
suggestions on types of validation that may be done, and should not be
considered as an exhaustive list of restrictions [crates.io] imposes.
{==+==}
下面是JSON对象注释的例子。包括一些由[crates.io]所限制的说明，
只是为了说明一些关于可能进行的验证类型的建议，而不是[crates.io]所限制的详尽清单。
{==+==}


{==+==}
```javascript
{
    // The name of the package.
    "name": "foo",
    // The version of the package being published.
    "vers": "0.1.0",
    // Array of direct dependencies of the package.
    "deps": [
        {
            // Name of the dependency.
            // If the dependency is renamed from the original package name,
            // this is the original name. The new package name is stored in
            // the `explicit_name_in_toml` field.
            "name": "rand",
            // The semver requirement for this dependency.
            "version_req": "^0.6",
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
            "kind": "normal",
            // The URL of the index of the registry where this dependency is
            // from as a string. If not specified or null, it is assumed the
            // dependency is in the current registry.
            "registry": null,
            // If the dependency is renamed, this is a string of the new
            // package name. If not specified or null, this dependency is not
            // renamed.
            "explicit_name_in_toml": null,
        }
    ],
{==+==}
```javascript
{
    // 包的名称。
    "name": "foo",
    // 发布的包的版本。
    "vers": "0.1.0",
    // 包的直接依赖的数组。
    "deps": [
        {
            // 依赖的名称。
            // 如果依赖是由源包名重新命名的，这就是原来的名字。新的包名被保存在 `explicit_name_in_toml` 字段中。
            "name": "rand",
            // 这个依赖的语义化版本要求。
            "version_req": "^0.6",
            // 为该依赖启用的特性数组(以字符串形式)。
            "features": ["i128_support"],
            // 布尔值，表示这是否是可选的依赖。
            "optional": false,
            // 是否启用默认特性的布尔值。
            "default_features": true,
            // 依赖的目标平台。
            // 如果不是目标依赖，则为空。
            // 否则，就是字符串，如 "cfg(windows)" 。
            "target": null,
            // 依赖的类别。
            // "dev", "build", or "normal".
            "kind": "normal",
            // 该依赖所在的注册中心索引的URL，是字符串。如果没有指定或为空，则假定该依赖在当前注册中心中。
            "registry": null,
            // 如果依赖被重新命名，这是新包名称的字符串。如果没有指定或为空，则该依赖未重命名。
            "explicit_name_in_toml": null,
        }
    ],
{==+==}


{==+==}
    // Set of features defined for the package.
    // Each feature maps to an array of features or dependencies it enables.
    // Cargo does not impose limitations on feature names, but crates.io
    // requires alphanumeric ASCII, `_` or `-` characters.
    "features": {
        "extras": ["rand/simd_support"]
    },
    // List of strings of the authors.
    // May be empty.
    "authors": ["Alice <a@example.com>"],
    // Description field from the manifest.
    // May be null. crates.io requires at least some content.
    "description": null,
    // String of the URL to the website for this package's documentation.
    // May be null.
    "documentation": null,
    // String of the URL to the website for this package's home page.
    // May be null.
    "homepage": null,
    // String of the content of the README file.
    // May be null.
    "readme": null,
    // String of a relative path to a README file in the crate.
    // May be null.
    "readme_file": null,
    // Array of strings of keywords for the package.
    "keywords": [],
    // Array of strings of categories for the package.
    "categories": [],
    // String of the license for the package.
    // May be null. crates.io requires either `license` or `license_file` to be set.
    "license": null,
    // String of a relative path to a license file in the crate.
    // May be null.
    "license_file": null,
    // String of the URL to the website for the source repository of this package.
    // May be null.
    "repository": null,
    // Optional object of "status" badges. Each value is an object of
    // arbitrary string to string mappings.
    // crates.io has special interpretation of the format of the badges.
    "badges": {
        "travis-ci": {
            "branch": "master",
            "repository": "rust-lang/cargo"
        }
    },
    // The `links` string value from the package's manifest, or null if not
    // specified. This field is optional and defaults to null.
    "links": null
}
```
{==+==}
    // 为该包定义的一组特性。
    // 每个特性都映射到它所启用的特性或依赖数组。
    // Cargo对特性名称不做限制，但crates.io需要字母数字的ASCII、 `_` 或 `-` 字符。
    "features": {
        "extras": ["rand/simd_support"]
    },
    // 作者的字符串列表.
    // 可能为空。
    "authors": ["Alice <a@example.com>"],
    // 来自配置清单的描述字段。
    // 可能为空。crates.io 至少需要一些内容。
    "description": null,
    // 这个包的文档的网站的URL字符串。
    // 可为空。
    "documentation": null,
    // 这个包的主页的网站的URL字符串。
    // 可为空。
    "homepage": null,
    // README文件内容的字符串。
    // 可为空。
    "readme": null,
    // crate中的README文件的相对路径字符串。
    // 可为空。
    "readme_file": null,
    // 包的关键词的字符串数组。
    "keywords": [],
    // 包的类别字符串的数组。
    "categories": [],
    // 包的许可证的字符串。
    // 可为空。 crates.io 要求设置 `license` 或 `license_file` 。
    "license": null,
    // 许可证文件的相对路径字符串。
    // 可为空。
    "license_file": null,
    // 包的源码库网站的URL字符串。
    // 可为空。
    "repository": null,
    // 可选的 "状态" 标志的对象。每个值是字符串到字符串映射的对象。
    // crates.io对标志的格式有特殊解释。
    "badges": {
        "travis-ci": {
            "branch": "master",
            "repository": "rust-lang/cargo"
        }
    },
    // 包清单中的 `links` 字符串值，如果没有指定则为空。这个字段是可选的，默认为空。
    "links": null
}
```
{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}
响应成功包括JSON对象:
{==+==}


{==+==}
```javascript
{
    // Optional object of warnings to display to the user.
    "warnings": {
        // Array of strings of categories that are invalid and ignored.
        "invalid_categories": [],
        // Array of strings of badge names that are invalid and ignored.
        "invalid_badges": [],
        // Array of strings of arbitrary warnings to display to the user.
        "other": []
    }
}
```
{==+==}
```javascript
{
    // 可选的警告对象，以显示给用户。
    "warnings": {
        // 无效和被忽略的类别的字符串数组。
        "invalid_categories": [],
        // 标志名称的字符串数组，这些标志名称是无效的并被忽略。
        "invalid_badges": [],
        // 向用户显示的任意警告字符串的数组。
        "other": []
    }
}
```
{==+==}


{==+==}
### Yank
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates/{crate_name}/{version}/yank`
- Method: DELETE
- Authorization: Included
{==+==}

{==+==}


{==+==}
The yank endpoint will set the `yank` field of the given version of a crate to
`true` in the index.
{==+==}
yank端点将在索引中将给定版本的crate的 `yank` 字段设置为 `true` 。
{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}
响应成功包括JSON对象:
{==+==}


{==+==}
```javascript
{
    // Indicates the delete succeeded, always true.
    "ok": true,
}
```
{==+==}
```javascript
{
    // 表示删除成功，始终为true。
    "ok": true,
}
```
{==+==}


{==+==}
### Unyank
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates/{crate_name}/{version}/unyank`
- Method: PUT
- Authorization: Included
{==+==}

{==+==}


{==+==}
The unyank endpoint will set the `yank` field of the given version of a crate
to `false` in the index.
{==+==}
unyank端点将在索引中将给定版本的crate的 `yank` 字段设置为 `false` 。
{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}
响应成功包括JSON对象:
{==+==}


{==+==}
```javascript
{
    // Indicates the delete succeeded, always true.
    "ok": true,
}
```
{==+==}
```javascript
{
    // 表示删除成功，始终为true。
    "ok": true,
}
```
{==+==}


{==+==}
### Owners
{==+==}
### 所有者
{==+==}


{==+==}
Cargo does not have an inherent notion of users and owners, but it does
provide the `owner` command to assist managing who has authorization to
control a crate. It is up to the registry to decide exactly how users and
owners are handled. See the [publishing documentation] for a description of
how [crates.io] handles owners via GitHub users and teams.
{==+==}

{==+==}


{==+==}
#### Owners: List
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: GET
- Authorization: Included
{==+==}

{==+==}


{==+==}
The owners endpoint returns a list of owners of the crate.
{==+==}

{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Array of owners of the crate.
    "users": [
        {
            // Unique unsigned 32-bit integer of the owner.
            "id": 70,
            // The unique username of the owner.
            "login": "github:rust-lang:core",
            // Name of the owner.
            // This is optional and may be null.
            "name": "Core",
        }
    ]
}
```
{==+==}

{==+==}


{==+==}
#### Owners: Add
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: PUT
- Authorization: Included
{==+==}

{==+==}


{==+==}
A PUT request will send a request to the registry to add a new owner to a
crate. It is up to the registry how to handle the request. For example,
[crates.io] sends an invite to the user that they must accept before being
added.
{==+==}

{==+==}


{==+==}
The request should include the following JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Array of `login` strings of owners to add.
    "users": ["login_name"]
}
```
{==+==}

{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Indicates the add succeeded, always true.
    "ok": true,
    // A string to be displayed to the user.
    "msg": "user ehuss has been invited to be an owner of crate cargo"
}
```
{==+==}

{==+==}


{==+==}
#### Owners: Remove
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: DELETE
- Authorization: Included
{==+==}

{==+==}


{==+==}
A DELETE request will remove an owner from a crate. The request should include
the following JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Array of `login` strings of owners to remove.
    "users": ["login_name"]
}
```
{==+==}

{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Indicates the remove succeeded, always true.
    "ok": true
}
```
{==+==}

{==+==}


{==+==}
### Search
{==+==}

{==+==}


{==+==}
- Endpoint: `/api/v1/crates`
- Method: GET
- Query Parameters:
    - `q`: The search query string.
    - `per_page`: Number of results, default 10, max 100.
{==+==}

{==+==}


{==+==}
The search request will perform a search for crates, using criteria defined on
the server.
{==+==}

{==+==}


{==+==}
A successful response includes the JSON object:
{==+==}

{==+==}


{==+==}
```javascript
{
    // Array of results.
    "crates": [
        {
            // Name of the crate.
            "name": "rand",
            // The highest version available.
            "max_version": "0.6.1",
            // Textual description of the crate.
            "description": "Random number generators and other randomness functionality.\n",
        }
    ],
    "meta": {
        // Total number of results available on the server.
        "total": 119
    }
}
```
{==+==}

{==+==}


{==+==}
### Login
{==+==}

{==+==}


{==+==}
- Endpoint: `/me`
{==+==}

{==+==}


{==+==}
The "login" endpoint is not an actual API request. It exists solely for the
[`cargo login`] command to display a URL to instruct a user to visit in a web
browser to log in and retrieve an API token.
{==+==}

{==+==}


{==+==}
[`cargo login`]: ../commands/cargo-login.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo publish`]: ../commands/cargo-publish.md
[alphanumeric]: ../../std/primitive.char.html#method.is_alphanumeric
[config]: config.md
[crates.io]: https://crates.io/
[publishing documentation]: publishing.md#cargo-owner
{==+==}

{==+==}