# cargo-add(1)



## 名称

cargo-add -向Cargo.toml清单文件添加依赖项

## 摘要

`cargo add` [_options_] _crate_...\
`cargo add` [_options_] `--path` _path_\
`cargo add` [_options_] `--git` _url_ [_crate_...]\


## 描述

此命令可以添加或修改依赖关系。

依赖项的源可以通过以下内容指定：

* _crate_`@`_version_: 以"_version_"的约束从注册中心取（包）
* `--path` _path_: 从指定的 _path_ 取（包）
* `--git` _url_: 从给定 _url_ 的git仓库拉取

如果没有指定源，那么尽最大努力选择一个，包括：

* 其他表中存在的依赖 (例如 `dev-dependencies`)
* 工作空间成员
* 注册中心中的最新发行版

当你添加一个已经存在的包时，将使用指定的标志更新现有条目。

一旦成功调用，指定的依赖中的启用的 (`+`) 和 禁用的 (`-`) [特性]  将在命令输出中被列出

[特性]: ../reference/features.md

## 选项

### 源选项

<dl>

<dt class="option-term" id="option-cargo-add---git"><a class="option-anchor" href="#option-cargo-add---git"></a><code>--git</code> <em>url</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#specifying-dependencies-from-git-repositories">从Git URL添加指定的crate</a>。</dd>


<dt class="option-term" id="option-cargo-add---branch"><a class="option-anchor" href="#option-cargo-add---branch"></a><code>--branch</code> <em>branch</em></dt>
<dd class="option-desc">从git添加时使用的分支。</dd>


<dt class="option-term" id="option-cargo-add---tag"><a class="option-anchor" href="#option-cargo-add---tag"></a><code>--tag</code> <em>tag</em></dt>
<dd class="option-desc">从git添加时使用的标签。</dd>


<dt class="option-term" id="option-cargo-add---rev"><a class="option-anchor" href="#option-cargo-add---rev"></a><code>--rev</code> <em>sha</em></dt>
<dd class="option-desc">从git添加时使用的特定提交</dd>


<dt class="option-term" id="option-cargo-add---path"><a class="option-anchor" href="#option-cargo-add---path"></a><code>--path</code> <em>path</em></dt>
<dd class="option-desc">要添加的本地crate的<a href="../reference/specifying-dependencies.html#specifying-path-dependencies">文件系统路径</a>。</dd>


<dt class="option-term" id="option-cargo-add---registry"><a class="option-anchor" href="#option-cargo-add---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">注册中心所使用的名称。注册中心名称被定义在<a href="../reference/config.html">Cargo配置文件</a>中。如果未指定将会使用默认注册中心，该注册中心由registry.default配置项定义，默认为<code>crates-io</code>。</dd>



</dl>

### 部分选项

<dl>

<dt class="option-term" id="option-cargo-add---dev"><a class="option-anchor" href="#option-cargo-add---dev"></a><code>--dev</code></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#development-dependencies">开发依赖</a>添加。</dd>


<dt class="option-term" id="option-cargo-add---build"><a class="option-anchor" href="#option-cargo-add---build"></a><code>--build</code></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#build-dependencies">构建依赖</a>添加。</dd>


<dt class="option-term" id="option-cargo-add---target"><a class="option-anchor" href="#option-cargo-add---target"></a><code>--target</code> <em>target</em></dt>
<dd class="option-desc">作为<a href="../reference/specifying-dependencies.html#platform-specific-dependencies">给定目标平台</a>的依赖添加。</dd>


</dl>


</dl>

### 依赖选项

<dl>

<dt class="option-term" id="option-cargo-add---dry-run"><a class="option-anchor" href="#option-cargo-add---dry-run"></a><code>--dry-run</code></dt>
<dd class="option-desc">不真的写入清单</dd>


<dt class="option-term" id="option-cargo-add---rename"><a class="option-anchor" href="#option-cargo-add---rename"></a><code>--rename</code> <em>name</em></dt>
<dd class="option-desc"><a href="../reference/specifying-dependencies.html#renaming-dependencies-in-cargotoml">重命名</a>依赖项。</dd>


<dt class="option-term" id="option-cargo-add---optional"><a class="option-anchor" href="#option-cargo-add---optional"></a><code>--optional</code></dt>
<dd class="option-desc">标记依赖为<a href="../reference/features.html#optional-dependencies">可选的</a>。</dd>


<dt class="option-term" id="option-cargo-add---no-optional"><a class="option-anchor" href="#option-cargo-add---no-optional"></a><code>--no-optional</code></dt>
<dd class="option-desc">标记依赖为<a href="../reference/features.html#optional-dependencies">必需的</a>。</dd>


<dt class="option-term" id="option-cargo-add---no-default-features"><a class="option-anchor" href="#option-cargo-add---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">禁用<a href="../reference/features.html#dependency-features">默认特性</a></dd>


<dt class="option-term" id="option-cargo-add---default-features"><a class="option-anchor" href="#option-cargo-add---default-features"></a><code>--default-features</code></dt>
<dd class="option-desc">重新启用<a href="../reference/features.html#dependency-features">默认特性</a></dd>


<dt class="option-term" id="option-cargo-add---features"><a class="option-anchor" href="#option-cargo-add---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的以逗号或空格分隔的<a href="../reference/features.html#dependency-features">特性</a>。添加多个crate时，特定板条箱的功能可通过<code>包名称/功能名称</code>语法启用。可以多次指定该标志，从而启用所有指定的功能。</dd>


</dl>


### 显示选项

<dl>
<dt class="option-term" id="option-cargo-add--v"><a class="option-anchor" href="#option-cargo-add--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-add---verbose"><a class="option-anchor" href="#option-cargo-add---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用详细输出。对于包括额外输出(如依赖关系警告和构建脚本输出)的“非常详细”输出，可以指定两次。也可以用<code>term.verbose</code><a href="../reference/config.html">配置</a>指定。</dd>


<dt class="option-term" id="option-cargo-add--q"><a class="option-anchor" href="#option-cargo-add--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-add---quiet"><a class="option-anchor" href="#option-cargo-add---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印cargo日志信息。也可以用<code>term.quiet</code><a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-add---color"><a class="option-anchor" href="#option-cargo-add---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制何时使用彩色输出。有效值：</p>
<ul>
<li><code>auto</code> (默认)：自动检测终端是否支持颜色。</li>
<li><code>always</code>: 总是显示颜色</li>
<li><code>never</code>: 从不显示颜色</li>
</ul>
<p>也可以用<code>term.quiet</code><a href="../reference/config.html">配置</a>。</dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-add---manifest-path"><a class="option-anchor" href="#option-cargo-add---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code>文件的路径。默认情况下，Cargo在当前目录或任何父目录中搜索<code>Cargo.toml</code>文件。</dd>



<dt class="option-term" id="option-cargo-add--p"><a class="option-anchor" href="#option-cargo-add--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-add---package"><a class="option-anchor" href="#option-cargo-add---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">仅向指定的包添加依赖项。</dd>


<dt class="option-term" id="option-cargo-add---frozen"><a class="option-anchor" href="#option-cargo-add---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-add---locked"><a class="option-anchor" href="#option-cargo-add---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求<code>Cargo.lock</code>文件是最新的。如果lock文件丢失，或者需要更新，Cargo将出错退出。<code>--frozen</code>标志还防止cargo试图访问网络来确定它是否过期。
在你希望断言<code>Cargo.lock</code>文件是最新的(例如CI构建)或希望避免网络访问的环境中，可以使用这些文件。</dd>


<dt class="option-term" id="option-cargo-add---offline"><a class="option-anchor" href="#option-cargo-add---offline"></a><code>--offline</code></dt>
<dd class="option-desc">防止 Cargo 以任何理由访问网络。如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，Cargo 将出错停止。有了这个标志，如果可能的话，Cargo 将试图在没有网络的情况下前进。</p>
请注意，这可能会导致与在线模式不同的依赖关系解析。Cargo 将自己限制在本地下载的 crate 中，即使在索引的本地副本中可能有更新的版本。请参阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，以便在脱机之前下载依赖项。</p>
也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>


</dl>

### Common Options

<dl>

<dt class="option-term" id="option-cargo-add-+toolchain"><a class="option-anchor" href="#option-cargo-add-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果cargo已经安装了rustup，并且 <code>cargo</code> 的第一个参数以 <code>cargo</code> 开头，它将被解释为 rustup 工具链名称(例如 <code>+stable</code> 或 <code>+nightly</code> )。有关工具链覆盖如何工作的更多信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>。</dd>


<dt class="option-term" id="option-cargo-add---config"><a class="option-anchor" href="#option-cargo-add---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖 Cargo 配置值。该参数应该采用 <code>KEY=VALUE</code> 的 TOML 语法，或者作为额外配置文件的路径提供。可以多次指定该标志。有关更多信息，请参见 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a>。</dd>


<dt class="option-term" id="option-cargo-add--h"><a class="option-anchor" href="#option-cargo-add--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-add---help"><a class="option-anchor" href="#option-cargo-add---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-add--Z"><a class="option-anchor" href="#option-cargo-add--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (nightly-only) 标志。运行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

有关Cargo读取的环境变量的详细信息，请参见 [the reference](../reference/environment-variables.html)。


## 退出状态

* `0`: Cargo 成功.
* `101`: Cargo 未能完成.


## 示例

1. 添加 `regex` 作为依赖项

       cargo add regex

2. 添加 `trybuild` 作为开发依赖项

       cargo add --dev trybuild

3. 添加旧版本的 `nom` 作为依赖项

       cargo add nom@5

4. 添加对使用 `derive` 将数据结构序列化到json的支持

       cargo add serde serde_json -F serde/derive

## 另见
[cargo(1)](cargo.html), [cargo-remove(1)](cargo-remove.html)
