# cargo-clean(1)



## 名称

cargo-clean - 删除生成的产物

## 概要

`cargo clean` [_options_]

## 描述

删除目标 (target) 文件夹中的构建产物。

未附带选项时，`cargo clean` 会删除整个目标文件夹。

## 选项

### 包的选择

如果没有选择哪个包，工作空间中所有的包和依赖都将被删除。

<dl>
<dt class="option-term" id="option-cargo-clean--p"><a class="option-anchor" href="#option-cargo-clean--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-clean---package"><a class="option-anchor" href="#option-cargo-clean---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只清除选中的包。这个标志可以指定多次。可从<a href="cargo-pkgid.html">cargo-pkgid(1)</a> 了解 SPEC 格式的相关信息。</dd>

</dl>

### 清除选项

<dl>

<dt class="option-term" id="option-cargo-clean---doc"><a class="option-anchor" href="#option-cargo-clean---doc"></a><code>--doc</code></dt>
<dd class="option-desc">此选项会使得 <code>cargo clean</code> 只清除目标文件夹中的 <code>doc</code> 文件夹。</dd>


<dt class="option-term" id="option-cargo-clean---release"><a class="option-anchor" href="#option-cargo-clean---release"></a><code>--release</code></dt>
<dd class="option-desc">清除 <code>release</code> 文件夹中的所有产物。</dd>


<dt class="option-term" id="option-cargo-clean---profile"><a class="option-anchor" href="#option-cargo-clean---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">清除构建预设 (profile) 名为 name 的文件夹中的所有产物。</dd>


<dt class="option-term" id="option-cargo-clean---target-dir"><a class="option-anchor" href="#option-cargo-clean---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc"> 存放构建产物和中间文件的文件夹。也可以用 <code>CARGO_TARGET_DIR</code> 环境变量来设置，或者 <code>build.target-dir</code> <a href="../reference/config.html">设置选项</a>。默认会放在工作空间根目录的 <code>target</code> 子目录下。</p>



<dt class="option-term" id="option-cargo-clean---target"><a class="option-anchor" href="#option-cargo-clean---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">清除指定架构 (architecture) 的产物。默认为宿主架构。通常的 triple 格式为<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。 运行 <code>rustc --print target-list</code> 可以获取所有支持的架构的列表。此标志可以指定多次。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">选项</a>进行设置。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标产物会放在单独的目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>



</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-clean--v"><a class="option-anchor" href="#option-cargo-clean--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-clean---verbose"><a class="option-anchor" href="#option-cargo-clean---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">选项</a>进行配置 。</dd>


<dt class="option-term" id="option-cargo-clean--q"><a class="option-anchor" href="#option-cargo-clean--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-clean---quiet"><a class="option-anchor" href="#option-cargo-clean---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">选项</a>进行配置。</dd>


<dt class="option-term" id="option-cargo-clean---color"><a class="option-anchor" href="#option-cargo-clean---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">选项</a>进行配置。</dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-clean---manifest-path"><a class="option-anchor" href="#option-cargo-clean---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。 默认情况下，Cargo 在当前目录或任意的父目录中查找 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-clean---frozen"><a class="option-anchor" href="#option-cargo-clean---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-clean---locked"><a class="option-anchor" href="#option-cargo-clean---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-clean---offline"><a class="option-anchor" href="#option-cargo-clean---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-clean-+toolchain"><a class="option-anchor" href="#option-cargo-clean-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-clean---config"><a class="option-anchor" href="#option-cargo-clean---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-clean--h"><a class="option-anchor" href="#option-cargo-clean--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-clean---help"><a class="option-anchor" href="#option-cargo-clean---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-clean--Z"><a class="option-anchor" href="#option-cargo-clean--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 清除整个 target 文件夹: 

       cargo clean

2. 只清除 release 产物:

       cargo clean --release

## 其他参考
[cargo(1)](cargo.html), [cargo-build(1)](cargo-build.html)
