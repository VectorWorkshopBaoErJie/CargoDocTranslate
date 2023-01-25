# cargo-fetch(1)




## 名称

cargo-fetch - 从网络中下载一个包的依赖。

## 概要

`cargo fetch` [_options_]

## 描述

如果有一个可用的 `Cargo.lock` ，则该命令可以保证所有的 git 依赖和/或 registry 依赖都会被下载且本地可用。`cargo fetch` 之后的命令都可以离线 (offline) 执行，除非 lock file 发生改变。 

如果 lock file 不可用，则该命令会在下载依赖之前生成 lock file。

如果没有指定 `--target` ，则所有 target 的依赖都会被下载。

另见 [cargo-prefetch](https://crates.io/crates/cargo-prefetch) 插件，其可以添加一个命令来下载流行的 crates。如果你打算在无网络的环境使用 Cargo (使用 `--offline`)，那么这个命令可能会很有用。

## 选项

### fetch 选项

<dl>
<dt class="option-term" id="option-cargo-fetch---target"><a class="option-anchor" href="#option-cargo-fetch---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定的架构而下载依赖，默认为所有架构下载。triple 的格式为 
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。 执行 <code>rustc --print target-list</code> 可以展示支持的 target 的列表。该标志可以指定多次。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>


</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-fetch--v"><a class="option-anchor" href="#option-cargo-fetch--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-fetch---verbose"><a class="option-anchor" href="#option-cargo-fetch---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>


<dt class="option-term" id="option-cargo-fetch--q"><a class="option-anchor" href="#option-cargo-fetch--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-fetch---quiet"><a class="option-anchor" href="#option-cargo-fetch---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-fetch---color"><a class="option-anchor" href="#option-cargo-fetch---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-fetch---manifest-path"><a class="option-anchor" href="#option-cargo-fetch---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。 默认情况下，Cargo 在当前目录或任意的父目录中查找 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-fetch---frozen"><a class="option-anchor" href="#option-cargo-fetch---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-fetch---locked"><a class="option-anchor" href="#option-cargo-fetch---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-fetch---offline"><a class="option-anchor" href="#option-cargo-fetch---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-fetch-+toolchain"><a class="option-anchor" href="#option-cargo-fetch-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-fetch---config"><a class="option-anchor" href="#option-cargo-fetch---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-fetch--h"><a class="option-anchor" href="#option-cargo-fetch--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-fetch---help"><a class="option-anchor" href="#option-cargo-fetch---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-fetch--Z"><a class="option-anchor" href="#option-cargo-fetch--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 下载所有的依赖: 

       cargo fetch

## 其他参考
[cargo(1)](cargo.html), [cargo-update(1)](cargo-update.html), [cargo-generate-lockfile(1)](cargo-generate-lockfile.html)
