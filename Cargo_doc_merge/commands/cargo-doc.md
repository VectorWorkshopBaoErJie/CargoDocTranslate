# cargo-doc(1)



## 名称

cargo-doc - 为包构建文档

## 概要

`cargo doc` [_options_]

## 描述

构建本地的包及其依赖的文档。输出以 rustdoc 的通常格式存放在 `target/doc` 路径下。

## 选项

### 文档选项

<dl>

<dt class="option-term" id="option-cargo-doc---open"><a class="option-anchor" href="#option-cargo-doc---open"></a><code>--open</code></dt>
<dd class="option-desc">构建完成后在浏览器中打开文档。这会使用到你的默认浏览器，除非你在 <code>BROWSER</code> 环境变量中指定其他的。
或者可以使用 <a href="../reference/config.html#docbrowser"><code>doc.browser</code></a> 设置选项来设置。</dd>


<dt class="option-term" id="option-cargo-doc---no-deps"><a class="option-anchor" href="#option-cargo-doc---no-deps"></a><code>--no-deps</code></dt>
<dd class="option-desc">不为依赖构建文档。</dd>


<dt class="option-term" id="option-cargo-doc---document-private-items"><a class="option-anchor" href="#option-cargo-doc---document-private-items"></a><code>--document-private-items</code></dt>
<dd class="option-desc">文档中包含非 Public 的语法元素(Rust item)。这会在二进制目标中默认启用。</dd>


</dl>

### 包的选择

默认情况下，如果没有提供选择包的选项，那么会按照选择的清单文件来选择包(当没有指定 `--manifest-path` 时，按照当前工目录来查找清单文件)。如果工作空间根目录的清单文件，则会选择该工作空间的默认成员，否则仅选取清单文件所在的那个包。

可以通过 `workspace.default-members` 来显式设置一个工作空间的默认成员。如果没有设置，在虚拟工作空间下会选择所有的成员，在非虚拟工作空间下仅会选择根 package 。

<dl>

<dt class="option-term" id="option-cargo-doc--p"><a class="option-anchor" href="#option-cargo-doc--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-doc---package"><a class="option-anchor" href="#option-cargo-doc---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅为指定的 package 构建文档。 见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 中关于 SPEC 格式的描述。此标志可以指定多次，而且支持 common Unix glob patterns ，如 <code>*</code>， <code>?</code> 和 <code>[]</code>。但是，为避免你的 shell 误在 Cargo 之前扩展这些 glob pattern，必须用单引号或双引号将每个 pattern 括起来。</dd>


<dt class="option-term" id="option-cargo-doc---workspace"><a class="option-anchor" href="#option-cargo-doc---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">为工作空间中的所有成员构建文档。</dd>



<dt class="option-term" id="option-cargo-doc---all"><a class="option-anchor" href="#option-cargo-doc---all"></a><code>--all</code></dt>
<dd class="option-desc"><code>--workspace</code> 的同义词，已弃用。</dd>



<dt class="option-term" id="option-cargo-doc---exclude"><a class="option-anchor" href="#option-cargo-doc---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code> 标志一起使用。 此标志可以指定多次，而且支持 common Unix glob patterns ，如 <code>*</code>， <code>?</code> 和 <code>[]</code>。但是，为避免你的 shell 误在 Cargo 之前扩展这些 glob pattern，必须用单引号或双引号将每个 pattern 括起来。</dd>


</dl>


### 目标选择

当没有提供目标选择选项， `cargo doc` 会为所选包的所有*二进制和库目标*构建文档。如果二进制目标的名字和库目标相同，则二进制目标会被跳过。如果二进制有丢失的 `required-features` ，则也会被跳过。

可以通过在清单文件中为 target 设置 `doc = false` 来改变默认行为。使用目标选择选项时会忽略 `doc` 标志，并且总会为所提供的目标构建文档。

<dl>
<dt class="option-term" id="option-cargo-doc---lib"><a class="option-anchor" href="#option-cargo-doc---lib"></a><code>--lib</code></dt>
<dd class="option-desc">为该包的库构建文档。</dd>


<dt class="option-term" id="option-cargo-doc---bin"><a class="option-anchor" href="#option-cargo-doc---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">为特定的二进制构建文档。这个标志可以指定多次，而且支持 common Unix glob patterns。</dd>


<dt class="option-term" id="option-cargo-doc---bins"><a class="option-anchor" href="#option-cargo-doc---bins"></a><code>--bins</code></dt>
<dd class="option-desc">为所有的二进制目标构建文档。</dd>



<dt class="option-term" id="option-cargo-doc---example"><a class="option-anchor" href="#option-cargo-doc---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">为特定的 example 构建文档。这个标志可以指定多次，而且支持 common Unix glob patterns。</dd>


<dt class="option-term" id="option-cargo-doc---examples"><a class="option-anchor" href="#option-cargo-doc---examples"></a><code>--examples</code></dt>
<dd class="option-desc">为所有的 example 目标构建文档。</dd>


</dl>

### feature 选择

feature 标志允许你控制开启哪些 feature。当没有提供 feature 选项时，会使用 为每个选择的包启用 `default` feature。

查看 [the features documentation](../reference/features.html#command-line-feature-options) 获取更多信息。

<dl>

<dt class="option-term" id="option-cargo-doc--F"><a class="option-anchor" href="#option-cargo-doc--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-doc---features"><a class="option-anchor" href="#option-cargo-doc---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">用空格或逗号来分隔多个启用的 feature。 工作空间成员的 feature 可以通过 <code>package-name/feature-name</code> 语法来启用。 该标志可以设置多次，最终将启用指定的所有 feature 。</dd>


<dt class="option-term" id="option-cargo-doc---all-features"><a class="option-anchor" href="#option-cargo-doc---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc"> 启用指定包的所有可用 feature。</dd>


<dt class="option-term" id="option-cargo-doc---no-default-features"><a class="option-anchor" href="#option-cargo-doc---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不使用指定包的 <code>default</code> feature 。</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-doc---target"><a class="option-anchor" href="#option-cargo-doc---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定的架构而构建文档，默认为宿主架构。triple 的格式为 
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>。 执行 <code>rustc --print target-list</code> 可以展示支持的 target 的列表。该标志可以指定多次。</p>
<p>此功能也可以通过指定 <code>build.target</code> <a href="../reference/config.html">设置选项</a>来进行设置。</p>
<p>注意，该标志使得 Cargo 运行在不同的模式下，其会将构建产物放在单独的文件夹中。
查看 <a href="../guide/build-cache.html">build cache</a> 文档来获取更多信息。</dd>



<dt class="option-term" id="option-cargo-doc--r"><a class="option-anchor" href="#option-cargo-doc--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-doc---release"><a class="option-anchor" href="#option-cargo-doc---release"></a><code>--release</code></dt>
<dd class="option-desc">为使用 <code>release</code> profile 优化的产物构建文档。
另见 <code>--profile</code> 选项来按名称选择特定的 profile。</dd>



<dt class="option-term" id="option-cargo-doc---profile"><a class="option-anchor" href="#option-cargo-doc---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的 profile 构建文档。
见 <a href="../reference/profiles.html">the reference</a> 查看关于 profile 的详细内容。</dd>



<dt class="option-term" id="option-cargo-doc---ignore-rust-version"><a class="option-anchor" href="#option-cargo-doc---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使选择的 Rust 编译器版本落后于项目 <code>rust-version</code> 字段中指定的版本，也为其构建文档。</dd>



<dt class="option-term" id="option-cargo-doc---timings=fmts"><a class="option-anchor" href="#option-cargo-doc---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc"> 输出编译所花费时间的信息，同时跟踪并发信息。接收一个由逗号分隔的输出格式；若 <code>--timings</code> 没有参数，则默认使用 <code>--timings=html</code>。
指定输出格式 (而不是使用默认格式) 是不稳定 (unstable) 的，需要设置 <code>-Zunstable-options</code>。 可用的输出格式选项有: </p>
<ul>
<li><code>html</code> (不稳定，需要 <code>-Zunstable-options</code>): 写入一个人类可读的 <code>cargo-timing.html</code> 文件到
<code>target/cargo-timings</code> 文件夹，其中包含关于编译过程的报告。 
同时也会写入一个文件名带着时间戳 (timestamp) 的报告文件，可以让你读取之前的编译报告。HTML 输出文件只适合人类阅读，不提供机器所需的 timing 数据。</li>
<li><code>json</code> (不稳定，需要 <code>-Zunstable-options</code>): 生成机器可读的 JSON timing 信息。</li>
</ul></dd>




</dl>

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-doc---target-dir"><a class="option-anchor" href="#option-cargo-doc---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc"> 存放构建产物和中间文件的文件夹。也可以用 <code>CARGO_TARGET_DIR</code> 环境变量来设置，或者 <code>build.target-dir</code> <a href="../reference/config.html">设置选项</a>。默认会放在工作空间根目录的 <code>target</code> 子目录下。</p>


</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-doc--v"><a class="option-anchor" href="#option-cargo-doc--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-doc---verbose"><a class="option-anchor" href="#option-cargo-doc---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行 verbose 输出。可以指定两遍来开启 &quot;very verbose&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>


<dt class="option-term" id="option-cargo-doc--q"><a class="option-anchor" href="#option-cargo-doc--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-doc---quiet"><a class="option-anchor" href="#option-cargo-doc---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo log 信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-doc---color"><a class="option-anchor" href="#option-cargo-doc---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制*何时*使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>



<dt class="option-term" id="option-cargo-doc---message-format"><a class="option-anchor" href="#option-cargo-doc---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">诊断信息的输出格式。 可以指定多次，可以包含由逗号分隔的多个值。合法的值有:</p>
<ul>
<li><code>human</code> (默认值): 显示适合人类阅读的格式。与 <code>short</code> 和 <code>json</code> 互斥。</li>
<li><code>short</code>: 生成更短的适合人类阅读的格式。 与 <code>human</code> 和 <code>json</code> 互斥。</li>
<li><code>json</code>: 将 JSON 信息输出到 stdout。 从 <a href="../reference/external-tools.html#json-messages">the reference</a> 获取更多详细信息。 与 <code>human</code> 和 <code>short</code> 互斥。</li>
<li><code>json-diagnostic-short</code>: 使得 JSON 的 <code>rendered</code> 属性包含 rustc 渲染的 &quot;short&quot; 信息。不能与 <code>human</code> 和 <code>short</code> 一起使用。</li>
<li><code>json-diagnostic-rendered-ansi</code>: 使得 JSON 的 <code>rendered</code> 属性包含嵌入的 ANSI 颜色代码以符合 rustc 的默认颜色策略。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>
<li><code>json-render-diagnostics</code>: 命令 Cargo 在打印的 JSON 中不包含 rustc 的诊断信息，而是由 Cargo 自己渲染 rustc 提供的 JSON 诊断信息。Cargo 自己的 JSON 诊断信息和其他来自 rustc 的信息都会被生成。
不能与 <code>human</code> 或 <code>short</code> 一起使用。</li>
</ul></dd>


</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-doc---manifest-path"><a class="option-anchor" href="#option-cargo-doc---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。 默认情况下，Cargo 在当前目录或任意的父目录中查找 <code>Cargo.toml</code> 。</dd>



<dt class="option-term" id="option-cargo-doc---frozen"><a class="option-anchor" href="#option-cargo-doc---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-doc---locked"><a class="option-anchor" href="#option-cargo-doc---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个 flag 都需要 <code>Cargo.lock</code> 文件处于无需更新的状态。如果 lock 文件缺失，或者需要被更新，Cargo 会报错退出。 <code>--frozen</code> flag 还会阻止 Cargo 访问网络来判断 Cargo.lock 是否过期。</p>
<p>这些 flag 可以用于某些场景下你想断言 <code>Cargo.lock</code> 无需更新 (比如在CI中构建) 或者避免网络访问。</dd>


<dt class="option-term" id="option-cargo-doc---offline"><a class="option-anchor" href="#option-cargo-doc---offline"></a><code>--offline</code></dt>
<dd class="option-desc"> 阻止 Cargo 访问网络。如果没有这个 flag，当 Cargo 需要访问网络但是没有网络时，就会报错退出。加上这个 flag，Cargo 会尝试在不联网的情况下继续执行 (如果可以的话) 。 </p>
<p>要小心这会导致与在线模式不同的解析结果。Cargo 会限制自己在本地已下载的 crate 中查找版本，即使在本地的 index 拷贝中表明还有更新的版本。
<a href="cargo-fetch.html">cargo-fetch(1)</a> 命令可以在进入离线模式前下载依赖。</p>
<p>同样的功能也可以通过设置 <code>net.offline</code> <a href="../reference/config.html">配置选项</a>来实现。</dd>


</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-doc-+toolchain"><a class="option-anchor" href="#option-cargo-doc-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 由 rustup 安装，那么 <code>cargo</code> 后第一个以 <code>+</code> 开头的参数会被认为是 rustup toolchain 名字(例如 <code>+stable</code> 或 <code>+nightly</code>)。
查看 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
了解 toolchain overrides 如何工作。</dd>


<dt class="option-term" id="option-cargo-doc---config"><a class="option-anchor" href="#option-cargo-doc---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc"> 覆盖一个 Cargo 配置的值。参数应该是一个 TOML 语法的 <code>KEY=VALUE</code>，或者提供一个路径来指向一个额外的配置文件 (configuration file)。 这个标记可以指定多次。
参考 <a href="../reference/config.html#command-line-overrides">command-line overrides 一节</a> 获取更多信息。</dd>


<dt class="option-term" id="option-cargo-doc--h"><a class="option-anchor" href="#option-cargo-doc--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-doc---help"><a class="option-anchor" href="#option-cargo-doc---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-doc--Z"><a class="option-anchor" href="#option-cargo-doc--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">不稳定 (nightly-only) 的标志。 执行 <code>cargo -Z help</code> 获取详细信息。</dd>


</dl>


### 杂项

<dl>
<dt class="option-term" id="option-cargo-doc--j"><a class="option-anchor" href="#option-cargo-doc--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-doc---jobs"><a class="option-anchor" href="#option-cargo-doc---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>


<dt class="option-term" id="option-cargo-doc---keep-going"><a class="option-anchor" href="#option-cargo-doc---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">依赖图中的 crate 能构建多少就构建多少，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>


</dl>

## 环境

查看 [the reference](../reference/environment-variables.html) 获取 Cargo 读取的环境变量的更多信息。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有执行完成。


## 使用案例

1. 为本地包及其依赖构建文档，输出放在  `target/doc` 。

       cargo doc

## 其他参考
[cargo(1)](cargo.html), [cargo-rustdoc(1)](cargo-rustdoc.html), [rustdoc(1)](https://doc.rust-lang.org/rustdoc/index.html)
