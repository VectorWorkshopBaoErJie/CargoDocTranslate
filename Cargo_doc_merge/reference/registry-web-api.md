
## Web API

注册中心可以在 `config.json` 定义主机网络API位置，以支持下面列出的任何动作。

对于需要认证的请求，Cargo包含 `Authorization` 头。该头的值是API token "令牌"。如果令牌无效，服务器应以403代码进行响应。用户应该访问注册中心的网站来获得令牌 ，Cargo可以使用 [`cargo login`] 命令来存储令牌，或者在命令行中传递令牌。

响应使用代码200表示成功。
错误应使用适当的响应代码，如404。
失败响应应该有一个JSON对象，其结构如下:

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

如果响应中有这种结构，Cargo会向用户显示详细信息，即使响应代码是200。
如果响应代码表示有错误，而且内容中没有这种结构，Cargo会向用户显示一条旨在帮助调试服务器错误的信息。
服务器返回一个 `errors` 对象，允许注册中心提供更详细的或以用户为中心的错误信息。

为了向后兼容，服务器应该忽略任何意外的查询参数或JSON字段。
如果缺少的JSON字段，应该假定它为空。终端使用路径的 `v1` 部分进行版本控制，如果将来有需要，Cargo负责处理向后兼容的回调。

Cargo为所有请求设置了以下头信息:

- `Content-Type`: `application/json`
- `Accept`: `application/json`
- `User-Agent`: The Cargo version such as `cargo 1.32.0 (8610973aa
  2019-01-02)`. This may be modified by the user in a configuration value.
  Added in 1.29.

### 发布

- Endpoint: `/api/v1/crates/new`
- Method: PUT
- Authorization: Included

发布终端用于发布新版本的crate。服务器应该验证该crate，使其可供下载，并将其添加到索引中。

Cargo发送的数据体:

- JSON数据长度的32位无符号小端整数。
- 作为JSON对象的包的元数据。
- `.crate` 文件长度的32位无符号小端整数。
- `.crate` 文件。

下面是JSON对象注释的例子。包括一些由[crates.io]所限制的说明，
只是为了说明一些关于可能进行的验证类型的建议，而不是[crates.io]所限制的详尽清单。

```javascript
{
    // 包的名称。
    "name": "foo",
    // 发布的包的版本。
    "vers": "0.1.0",
    // 包直接依赖的数组。
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

响应成功包括JSON对象:

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

### Yank

- Endpoint: `/api/v1/crates/{crate_name}/{version}/yank`
- Method: DELETE
- Authorization: Included

yank终端在索引中将给定版本的crate的 `yank` 字段设置为 `true` 。

响应成功包括JSON对象:

```javascript
{
    // 表示删除成功，始终为true。
    "ok": true,
}
```

### Unyank

- Endpoint: `/api/v1/crates/{crate_name}/{version}/unyank`
- Method: PUT
- Authorization: Included

unyank终端在索引中将给定版本的crate的 `yank` 字段设置为 `false` 。

响应成功包括JSON对象:

```javascript
{
    // 表示删除成功，始终为true。
    "ok": true,
}
```

### 所有者

Cargo没有固有的用户和所有者的概念，但它提供 `owner` 命令来帮助管理谁有控制crate的授权。
具体如何处理用户和所有者，由注册中心决定。
关于[crates.io]如何通过GitHub用户和团队处理所有者的描述，请参见[发布文档]。

#### Owners: List

- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: GET
- Authorization: Included

owners终端返回crate的所有者列表。

响应成功包括JSON对象:

```javascript
{
    // crate的所有者数组。
    "users": [
        {
            // 所有者的唯一无符号32位整数。
            "id": 70,
            // 所有者唯一的用户名。
            "login": "github:rust-lang:core",
            // 所有者的名字。
            // 这是可选的，可以为空。
            "name": "Core",
        }
    ]
}
```

#### Owners: Add

- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: PUT
- Authorization: Included

PUT请求将向注册中心发送请求，以将新的所有者添加到crate里。
如何处理这个请求是由注册中心决定。
例如，[crates.io]会向用户发送一个邀请，他们必须在被添加之前接受。

该请求应包括以下JSON对象:

```javascript
{
    // 要添加的所有者的 `login` 字符串数组。
    "users": ["login_name"]
}
```

响应成功包括JSON对象:

```javascript
{
    // 表示添加成功，始终为真。
    "ok": true,
    // 一个要显示给用户的字符串。
    "msg": "user ehuss has been invited to be an owner of crate cargo"
}
```

#### Owners: Remove

- Endpoint: `/api/v1/crates/{crate_name}/owners`
- Method: DELETE
- Authorization: Included

DELETE请求将从crate中删除一个所有者。该请求应包括以下JSON对象:

```javascript
{
    // 要删除的所有者的 `login` 字符串数组。
    "users": ["login_name"]
}
```

响应成功包括JSON对象:

```javascript
{
    // 表示删除成功，始终为真。
    "ok": true
}
```

### Search

- Endpoint: `/api/v1/crates`
- Method: GET
- Query Parameters:
    - `q`: The search query string.
    - `per_page`: Number of results, default 10, max 100.

搜索请求将使用服务器上定义的标准对caate进行搜索。

响应成功包括JSON对象:

```javascript
{
    // 结果数组
    "crates": [
        {
            // crate的名字。
            "name": "rand",
            // 可用的最高版本
            "max_version": "0.6.1",
            // crate的文字描述。
            "description": "Random number generators and other randomness functionality.\n",
        }
    ],
    "meta": {
        // 服务器上可用的结果总数。
        "total": 119
    }
}
```


### Login

- Endpoint: `/me`

"login" 终端不是实际的API请求。
它的存在仅仅是为了 [`cargo login`] 命令显示URL，指示用户在网络浏览器中访问以登录并获取API令牌。

[`cargo login`]: ../commands/cargo-login.md
[`cargo package`]: ../commands/cargo-package.md
[`cargo publish`]: ../commands/cargo-publish.md
[alphanumeric]: ../../std/primitive.char.html#method.is_alphanumeric
[config]: config.md
[crates.io]: https://crates.io/
[publishing documentation]: publishing.md#cargo-owner
