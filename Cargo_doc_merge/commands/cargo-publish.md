# cargo-publish(1)



## 定义

cargo-publish - 上传包到注册中心

## 概要

`cargo publish` [_options_]

## 说明

该命令将在当前目录下创建一个待分发的、压缩的 `.crate` 文件，其中包含包的源代码，并将其上传到注册中心。
默认的注册中心是 <https://crates.io> 。将执行以下步骤:

1. 进行一些检查，包括:
   - 检查配置清单中的 `package.publish` 键，看是否限制发布到哪些注册中心。
2. 按照 [cargo-package(1)](cargo-package.html) 中的步骤，创建 `.crate` 文件。
3. 将crate上传到注册中心。需注意，服务器将对crate进行额外的检查。

该命令要求您使用 `--token` 选项或使用 [cargo-login(1)](cargo-login.html) 进行认证。

见 [参考](../reference/publishing.html) 了解关于包和发布的详情。

## 选项

### 发布选项

<dl>

<dt class="option-term" id="option-cargo-publish---dry-run"><a class="option-anchor" href="#option-cargo-publish---dry-run"></a><code>--dry-run</code></dt>
<dd class="option-desc">在不上传的情况下执行所有检查。</dd>


<dt class="option-term" id="option-cargo-publish---token"><a class="option-anchor" href="#option-cargo-publish---token"></a><code>--token</code> <em>token</em></dt>
<dd class="option-desc">认证时要使用的 API token。这将覆盖存储在证书文件中的令牌(由 <a href="cargo-login.html">cargo-login(1)</a>)。</p>
<p><a href="../reference/config.html">Cargo配置</a>环境变量可用于覆盖存储在证书文件中的令牌。
crates.io的令牌可以用<code>CARGO_REGISTRY_TOKEN</code>环境变量指定。其他注册中心的令牌可以用以下形式的环境变量来指定 <code>CARGO_REGISTRIES_NAME_TOKEN</code> 其 <code>NAME</code> 是注册中心的名称，全部大写字母。</dd>



<dt class="option-term" id="option-cargo-publish---no-verify"><a class="option-anchor" href="#option-cargo-publish---no-verify"></a><code>--no-verify</code></dt>
<dd class="option-desc">不通过构建来验证内容。</dd>


<dt class="option-term" id="option-cargo-publish---allow-dirty"><a class="option-anchor" href="#option-cargo-publish---allow-dirty"></a><code>--allow-dirty</code></dt>
<dd class="option-desc">允许将带有未提交修改内容的VCS工作目录打包。</dd>


<dt class="option-term" id="option-cargo-publish---index"><a class="option-anchor" href="#option-cargo-publish---index"></a><code>--index</code> <em>index</em></dt>
<dd class="option-desc">使用的注册中心索引URL。</dd>



<dt class="option-term" id="option-cargo-publish---registry"><a class="option-anchor" href="#option-cargo-publish---registry"></a><code>--registry</code> <em>registry</em></dt>
<dd class="option-desc">要发布到的注册中心名称，定义在 <a href="../reference/config.html">Cargo 配置文件</a>。 如果未指定, 在<code>Cargo.toml</code> <a href="../reference/manifest.html#the-publish-field"><code>package.publish</code></a> 字段有单独的键, 那么将发布到该注册中心。
否则，将使用默认的注册中心， 由 <a href="../reference/config.html#registrydefault"><code>registry.default</code></a> 键定义， 默认为<code>crates-io</code>。</dd>


</dl>

### 包的选择

默认情况下，选中当前工作目录下的包。可用 `-p` 标志选择工作空间中不同的包。

<dl>

<dt class="option-term" id="option-cargo-publish--p"><a class="option-anchor" href="#option-cargo-publish--p"></a><code>-p</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-publish---package"><a class="option-anchor" href="#option-cargo-publish---package"></a><code>--package</code> <em>spec</em></dt>
<dd class="option-desc">要发布的包，见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 了解 SPEC 规格。</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-publish---target"><a class="option-anchor" href="#option-cargo-publish---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">对于给定架构发布。默认是主机的架构。常规格式是三元组 <code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。
运行<code>rustc --print target-list</code>获得支持的目标列表。 这个标志可被多次指定。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>



<dt class="option-term" id="option-cargo-publish---target-dir"><a class="option-anchor" href="#option-cargo-publish---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成制品和中间文件的目录。 也可以用 <code>CARGO_TARGET_DIR</code> 环境变量, 或 <code>build.target-dir</code> <a href="../reference/config.html">配置</a>。
默认为工作空间的根<code>target</code>。</dd>



</dl>

### 特性选择

特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。

见 [特性文档](../reference/features.html#command-line-feature-options) 了解更多内容。

<dl>

<dt class="option-term" id="option-cargo-publish--F"><a class="option-anchor" href="#option-cargo-publish--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-publish---features"><a class="option-anchor" href="#option-cargo-publish---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">激活的特性列表用空格或逗号分隔。可以用<code>package-name/feature-name</code>语法启用工作空间成员的特性。这个标志可以被多次指定，从而可以启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-publish---all-features"><a class="option-anchor" href="#option-cargo-publish---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定包的所有可用特性。</dd>


<dt class="option-term" id="option-cargo-publish---no-default-features"><a class="option-anchor" href="#option-cargo-publish---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不激活所选包的<code>default</code>特性。</dd>


</dl>


### 配置选项

<dl>

<dt class="option-term" id="option-cargo-publish---manifest-path"><a class="option-anchor" href="#option-cargo-publish---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。默认, Cargo 在当前目录和任意父目录搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-publish---frozen"><a class="option-anchor" href="#option-cargo-publish---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-publish---locked"><a class="option-anchor" href="#option-cargo-publish---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-publish---offline"><a class="option-anchor" href="#option-cargo-publish---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>



</dl>

### 其它选项

<dl>
<dt class="option-term" id="option-cargo-publish--j"><a class="option-anchor" href="#option-cargo-publish--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-publish---jobs"><a class="option-anchor" href="#option-cargo-publish---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>


<dt class="option-term" id="option-cargo-publish---keep-going"><a class="option-anchor" href="#option-cargo-publish---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">尽可能的构建依赖图中的 crate ，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>


</dl>

### Display Options

<dl>
<dt class="option-term" id="option-cargo-publish--v"><a class="option-anchor" href="#option-cargo-publish--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-publish---verbose"><a class="option-anchor" href="#option-cargo-publish---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>


<dt class="option-term" id="option-cargo-publish--q"><a class="option-anchor" href="#option-cargo-publish--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-publish---quiet"><a class="option-anchor" href="#option-cargo-publish---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-publish---color"><a class="option-anchor" href="#option-cargo-publish---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>


</dl>

### 常规选项

<dl>

<dt class="option-term" id="option-cargo-publish-+toolchain"><a class="option-anchor" href="#option-cargo-publish-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-publish---config"><a class="option-anchor" href="#option-cargo-publish---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-publish--h"><a class="option-anchor" href="#option-cargo-publish--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-publish---help"><a class="option-anchor" href="#option-cargo-publish---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-publish--Z"><a class="option-anchor" href="#option-cargo-publish--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


## 环境

查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有成功完成。


## 示例

1. 发而当前的包:

       cargo publish

## 参阅
[cargo(1)](cargo.html), [cargo-package(1)](cargo-package.html), [cargo-login(1)](cargo-login.html)
