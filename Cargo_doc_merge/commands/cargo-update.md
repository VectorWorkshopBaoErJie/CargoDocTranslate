# cargo-update(1)

## 定义

cargo-update - 更新本地lock文件中记录的依赖

## 概要

`cargo update` [_options_]

## 说明

该命令将更新 `Cargo.lock` 文件中的依赖到最新版本。
如果 `Cargo.lock` 文件不存在，将以最新的可用版本创建。

## 选项

### 更新选项

<dl>

<dt class="option-term" id="option-cargo-update--p"><a class="option-anchor" href="#option-cargo-update--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-update---package"><a class="option-anchor" href="#option-cargo-update---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只更新指定的包。这个标志可以多次指定。
见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 的规格格式。</p>
<p>如果包指定为 <code>-p</code> 标志, 则将对lock文件进行保守的更新。
这表述仅规格指定的依赖更新。
只有当规格版本在不更新依赖的情况下，再不能更新时，它所传递的依赖才会被更新。
所有其他的依赖将保持锁定在其当前记录的版本。</p>
<p>如未指定 <code>-p</code> , 更新所有依赖。</dd>


<dt class="option-term" id="option-cargo-update---aggressive"><a class="option-anchor" href="#option-cargo-update---aggressive"></a><code>--aggressive</code></dt>
<dd class="option-desc">当使用 <code>-p</code>, <em>规格版本</em>的依赖强制更新。
不能和 <code>--precise</code> 使用。</dd>


<dt class="option-term" id="option-cargo-update---precise"><a class="option-anchor" href="#option-cargo-update---precise"></a><code>--precise</code> <em>precise</em></dt>
<dd class="option-desc">当使用 <code>-p</code>, 允许指定特定版本号的包。如果包来自git仓库，可以是一个git版本(比如SHA哈希或tag)。</dd>


<dt class="option-term" id="option-cargo-update--w"><a class="option-anchor" href="#option-cargo-update--w"></a><code>-w</code></dt>
<dt class="option-term" id="option-cargo-update---workspace"><a class="option-anchor" href="#option-cargo-update---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">尝试只更新工作空间中定义的包。
其他包只有在lock文件中不存在时才会更新。
这个选项对于在<code>Cargo.toml</code>中改变版本号后更新<code>Cargo.lock</code>很有用。</dd>


<dt class="option-term" id="option-cargo-update---dry-run"><a class="option-anchor" href="#option-cargo-update---dry-run"></a><code>--dry-run</code></dt>
<dd class="option-desc">显示将更新内容，实际并未写入lock文件。</dd>


</dl>

### Display Options

<dl>
<dt class="option-term" id="option-cargo-update--v"><a class="option-anchor" href="#option-cargo-update--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-update---verbose"><a class="option-anchor" href="#option-cargo-update---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两次来开启 &quot;非常详细&quot; ，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-update--q"><a class="option-anchor" href="#option-cargo-update--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-update---quiet"><a class="option-anchor" href="#option-cargo-update---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以用 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-update---color"><a class="option-anchor" href="#option-cargo-update---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">使用彩色输出。有效值:</p>
<ul>
<li><code>auto</code> (默认):自动检测终端是否支持彩色。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 总不显示彩色。</li>
</ul>
<p>也可以用 <code>term.color</code>
<a href="../reference/config.html">配置</a>。</dd>


</dl>

### 配置选项

<dl>

<dt class="option-term" id="option-cargo-update---manifest-path"><a class="option-anchor" href="#option-cargo-update---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"><code>Cargo.toml</code>文件路径。
默认情况下，Cargo会在当前目录或任何父目录下搜索<code>Cargo.toml</code>文件。</dd>



<dt class="option-term" id="option-cargo-update---frozen"><a class="option-anchor" href="#option-cargo-update---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-update---locked"><a class="option-anchor" href="#option-cargo-update---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-update---offline"><a class="option-anchor" href="#option-cargo-update---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>



</dl>

### 常规选项

<dl>

<dt class="option-term" id="option-cargo-update-+toolchain"><a class="option-anchor" href="#option-cargo-update-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-update---config"><a class="option-anchor" href="#option-cargo-update---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-update--h"><a class="option-anchor" href="#option-cargo-update--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-update---help"><a class="option-anchor" href="#option-cargo-update---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-update--Z"><a class="option-anchor" href="#option-cargo-update--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


## 环境

查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 未执行完成。


## 示例

1. 更新lock文件中的所有依赖:

       cargo update

2. 只更新特定的依赖:

       cargo update -p foo -p bar

3. 将一个特定的依赖设置为一个特定的版本:

       cargo update -p foo --precise 1.2.3

## 参阅
[cargo(1)](cargo.html), [cargo-generate-lockfile(1)](cargo-generate-lockfile.html)
