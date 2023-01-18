# cargo-build(1)



## 定义

cargo-build - 编译当前package

## 概要

`cargo build` [_options_]

## 说明

编译本地package以及它们的依赖

## 选项

### Package 的选择

默认情况下，当package选择选项没有给出时，package的选择依赖于指定的清单文件(若没有给出 `--manifest-path` 参数，则为当前目录下的清单文件)。
如果清单文件是workspace的根，那么workspace的默认成员被选择，否则，只有被定义在清单文件中的package会被选择。

workspace默认的成员可以通过根清单文件中的 `workspace.default-members` 键指定，
如果没有指定该键，则会生成一个虚拟的workspace包含所有的workspace成员
(等同于直接传入 `--workspace` 参数)，并且非虚拟的workspace将只包含根crate自身。

<dl>

<dt class="option-term" id="option-cargo-build--p"><a class="option-anchor" href="#option-cargo-build--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-build---package"><a class="option-anchor" href="#option-cargo-build---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只包含特定的package。 要了解SPEC格式，请参阅<a href="cargo-pkgid.html">cargo-pkgid(1)</a> 该标识可被指定多次，并且支持通用Unix通配符(common Unix glob patterns),例如:
<code>*</code>, <code>?</code> 和 <code>[]</code>。 然而, 为了避免shell在Cargo处理他们之前将通配符意外的展开
, 必须使用单引号或者双引号将模式串包住。</dd>


<dt class="option-term" id="option-cargo-build---workspace"><a class="option-anchor" href="#option-cargo-build---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">在workspace中构建全部成员。</dd>



<dt class="option-term" id="option-cargo-build---all"><a class="option-anchor" href="#option-cargo-build---all"></a><code>--all</code></dt>
<dd class="option-desc">是 <code>--workspace</code>已经弃用的别名。</dd>



<dt class="option-term" id="option-cargo-build---exclude"><a class="option-anchor" href="#option-cargo-build---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的package，必须与
<code>--workspace</code> 标识连用。该标识可以被指定多次，并且支持Unix通配符(common Unix glob patterns)，例如<code>*</code>, <code>?</code> 和 <code>[]</code>。 然而, 为了避免shell在Cargo处理他们之前将通配符意外的展开
, 必须使用单引号或者双引号将模式串包住。</dd>


</dl>


### 构建目标的选择

当没有目标选择选项给出的时候，`cargo build` 将构建所有的选定的package中的binary和library目标。
如果Binary的 `required-features` 有缺失，则Binary构建将被跳过

如果集成测试或者基准测试被指定构建，则Binary目标将被自动构建。这允许了集成测试执行binary用以测试它们的行为。
在构建集成测试时设置 `CARGO_BIN_EXE_<name>` 
[环境变量](../reference/environment-variables.html#environment-variables-cargo-sets-for-crates)
以便于它可以使用[`env` 宏](https://doc.rust-lang.org/std/macro.env.html) 来定位可执行文件。


传入目标选择参数将只构建指定的目标。 

需要注意的是`--bin`, `--example`, `--test` 和 `--bench` 标志同样支持Unix通配符(common Unix glob patterns)，例如 `*`, `?` 和 `[]`。
然而, 为了避免shell在Cargo处理他们之前将通配符意外的展开, 必须使用单引号或者双引号将模式串包住。

<dl>

<dt class="option-term" id="option-cargo-build---lib"><a class="option-anchor" href="#option-cargo-build---lib"></a><code>--lib</code></dt>
<dd class="option-desc">构建package的library。</dd>


<dt class="option-term" id="option-cargo-build---bin"><a class="option-anchor" href="#option-cargo-build---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">构建指定的binary，该标识可以被指定多次，并且支持Unix通配符。</dd>


<dt class="option-term" id="option-cargo-build---bins"><a class="option-anchor" href="#option-cargo-build---bins"></a><code>--bins</code></dt>
<dd class="option-desc">构建所有的binary目标。</dd>



<dt class="option-term" id="option-cargo-build---example"><a class="option-anchor" href="#option-cargo-build---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">构建指定的示例，该标识可以被指定多次，并且支持Unix通配符。</dd>


<dt class="option-term" id="option-cargo-build---examples"><a class="option-anchor" href="#option-cargo-build---examples"></a><code>--examples</code></dt>
<dd class="option-desc">构建所有的示例。</dd>


<dt class="option-term" id="option-cargo-build---test"><a class="option-anchor" href="#option-cargo-build---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">构建指定的集成测试，该标识可以被指定多次，并且支持Unix通配符。</dd>


<dt class="option-term" id="option-cargo-build---tests"><a class="option-anchor" href="#option-cargo-build---tests"></a><code>--tests</code></dt>
<dd class="option-desc">在测试模式下构建所有清单文件中带有 <code>test = true</code> 标识的目标，默认情况下，这将包含作为单元测试和集成测试构建的library和binary
当心这也会构建所需要的依赖，因此，library目标有可能被构建两次(一次作为单元测试，一次作为binary或集成测试等目标的依赖。)。
通过在目标的清单文件设置中设置 <code>test</code> 标志，可以启用或禁用目标。 
</dd>


<dt class="option-term" id="option-cargo-build---bench"><a class="option-anchor" href="#option-cargo-build---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">构建指定的基准测试，该标识可以被指定多次，并且支持Unix通配符。</dd>


<dt class="option-term" id="option-cargo-build---benches"><a class="option-anchor" href="#option-cargo-build---benches"></a><code>--benches</code></dt>
<dd class="option-desc">在基准测试模式下构建所有清单文件中带有 <code>bench = true</code> 标识的目标，默认情况下，这将包含作为基准测试或基准测试目标构建的library和binary
当心这也会构建所需要的依赖，因此，library目标有可能被构建两次(一次作为基准测试，一次作为binary或基准测试等目标的依赖。)。
通过在目标的清单文件设置中设置 <code>bench</code> 标志，可以选择是否启用。 </dd>


<dt class="option-term" id="option-cargo-build---all-targets"><a class="option-anchor" href="#option-cargo-build---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">构建所有的目标，等同于 <code>--lib --bins --tests --benches --examples</code>.</dd>


</dl>


### 特性选择

特性选择标识可以用来控制哪些特性被启用。当没有设置特性选项时， `default` 特性将在所有被选择的package中被激活。

查阅 [the features documentation](../reference/features.html#command-line-feature-options) 以获取更多细节

<dl>

<dt class="option-term" id="option-cargo-build--F"><a class="option-anchor" href="#option-cargo-build--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-build---features"><a class="option-anchor" href="#option-cargo-build---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">要激活的特性列表，特性间用空格逗号隔开。workspace的成员的特性可以通过 <code>package-name/feature-name</code> 来启用。
该标志可以被设置多次，将启用所有给出的特性。</dd>


<dt class="option-term" id="option-cargo-build---all-features"><a class="option-anchor" href="#option-cargo-build---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活选中package的所有特性</dd>


<dt class="option-term" id="option-cargo-build---no-default-features"><a class="option-anchor" href="#option-cargo-build---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不激活选中的package的 <code>default</code> 特性</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-build---target"><a class="option-anchor" href="#option-cargo-build---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">为指定的CPU架构构建. 默认情况下是当前主机的架构. 参数中的三元组的一般格式是
<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code>. 运行 <code>rustc --print target-list</code> 来获取支持的架构列表 </p>
<p>也可以用 <code>build.target</code> <a href="../reference/config.html"> 配置 </a>。</p>
<p>需要注意的是，指定该标识将令Cargo在不同的模式下运行，其中目标产物将放到单独的目录中，详情查看
<a href="../guide/build-cache.html">build cache</a></dd>



<dt class="option-term" id="option-cargo-build--r"><a class="option-anchor" href="#option-cargo-build--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-build---release"><a class="option-anchor" href="#option-cargo-build---release"></a><code>--release</code></dt>
<dd class="option-desc">通过清单文件中 <code>release</code> 配置项目(profile)，以构建出优化过的产物。
参阅 <code>--profile</code> 选项了解如何按照指定的配置项目构建</dd>



<dt class="option-term" id="option-cargo-build---profile"><a class="option-anchor" href="#option-cargo-build---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">通过给定的profile构建
参阅 <a href="../reference/profiles.html">参考手册</a> 获取更多关于profile的细节。</dd>



<dt class="option-term" id="option-cargo-build---ignore-rust-version"><a class="option-anchor" href="#option-cargo-build---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使cargo低于项目中 <code>rust-version</code> 字段要求的cargo最低版本，也继续构建 </dd>



<dt class="option-term" id="option-cargo-build---timings=fmts"><a class="option-anchor" href="#option-cargo-build---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每个编译过程所花费的时间，以及随着时间变化的并行执行情况，可以接收通过逗号分隔的可选的参数，来定义输出的格式 <code>--timings</code> 如果后面不跟参数将，将默认看作 <code>--timings=html</code>。
给出输出格式(除了默认)是不稳定的的功能，需要加上
<code>-Zunstable-options</code>。 有效的格式有:</p>
<ul>
<li><code>html</code> (不稳定, 需要 <code>-Zunstable-options</code>): 生成一个适合人类阅读的的耗时报告文件 <code>cargo-timing.html</code> ，保存到
<code>target/cargo-timings</code> 目录下。 同时也在同目录下生成一个相同内容的用时间戳命名的报告，方便再次编译将前者覆盖后查看。
HTML 输出只适合人类阅读，并且不会提供适合机器阅读的耗时数据 </li>
<li><code>json</code> (不稳定, 需要 <code>-Zunstable-options</code>): 生成适合机器阅读的JSON格式的耗时信息</li>
</ul></dd>




</dl>

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-build---target-dir"><a class="option-anchor" href="#option-cargo-build---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc"> 所有生成目标产物以及中间文件存放的目录，也可通过 <code>CARGO_TARGET_DIR</code> 环境变量指定, 又或者通过 <code>build.target-dir</code> <a href="../reference/config.html">配置</a>。
默认将保存到workspace根目录下的<code>target</code> 目录下 </dd>



<dt class="option-term" id="option-cargo-build---out-dir"><a class="option-anchor" href="#option-cargo-build---out-dir"></a><code>--out-dir</code> <em>directory</em></dt>
<dd class="option-desc">复制最终产物到指定目录.</p>
<p>该选项是不稳定的，只在
<a href="https://doc.rust-lang.org/book/appendix-07-nightly-rust.html">nightly channel</a>
以及 <code>-Z unstable-options</code> 标志被设置才能启用。
查阅 <a href="https://github.com/rust-lang/cargo/issues/6790">https://github.com/rust-lang/cargo/issues/6790</a> 获取更多信息。</dd>


</dl>

### 显示选项

<dl>
<dt class="option-term" id="option-cargo-build--v"><a class="option-anchor" href="#option-cargo-build--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-build---verbose"><a class="option-anchor" href="#option-cargo-build---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">输出详细信息。 指定两次该选项表示 &quot;非常详细&quot; 输出诸如依赖警告或编译脚本的输出等信息。
也可通过 <code>term.verbose</code> 配置项指定 <a href="../reference/config.html">可选值</a>。</dd>


<dt class="option-term" id="option-cargo-build--q"><a class="option-anchor" href="#option-cargo-build--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-build---quiet"><a class="option-anchor" href="#option-cargo-build---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc"> 不输出cargo日志信息。也可通过<code>term.quiet</code> 配置项指定
<a href="../reference/config.html">可选值</a>.</dd>


<dt class="option-term" id="option-cargo-build---color"><a class="option-anchor" href="#option-cargo-build---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制何时输出彩色信息，可选值:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端是否支持彩色。</li>
<li><code>always</code>: 总是输出彩色信息。</li>
<li><code>never</code>: 从不输出彩色信息。</li>
</ul>
<p>也可通过 <code>term.color</code> 配置项指定
<a href="../reference/config.html">可选值</a>。</dd>



<dt class="option-term" id="option-cargo-build---message-format"><a class="option-anchor" href="#option-cargo-build---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">指定输出诊断信息的格式。可以被指定多次，值由逗号隔开，有效的值有:</p>
<ul>
<li><code>human</code> (default): 显示适合人类阅读的文本信息. 与
<code>short</code> 和 <code>json</code>冲突。</li>
<li><code>short</code>: 输出更短的, 适合人类阅读的信息。 与 <code>human</code>
和 <code>json</code>冲突</li>
<li><code>json</code>: 输出json信息到stdout。 查阅
<a href="../reference/external-tools.html#json-messages">参考手册</a>
以获取详细信息。与 <code>human</code> 和 <code>short</code>冲突。</li>
<li><code>json-diagnostic-short</code>: 确保JSON的 <code>rendered</code> 字段包含 &quot;short&quot; 由rustc渲染。 不可以与 <code>human</code> 或者 <code>short</code>同时使用。</li>
<li><code>json-diagnostic-rendered-ansi</code>: 确保JSON的 <code>rendered</code> 字段包含ANSI颜色码，以符合rustc的默认颜色方案，不可以与 <code>human</code> 或者 <code>short</code>同时使用。</li>
<li><code>json-render-diagnostics</code>: 指导Cargo输出的JSON消息不要包含rustc的诊断信息，而是让Cargo自己渲染rustc的诊断信息， 但是Cargo自己的JSON诊断和来自rustc的其他诊断保留。不可以与<code>human</code> 或者 <code>short</code>同时使用。</li>
</ul></dd>



<dt class="option-term" id="option-cargo-build---build-plan"><a class="option-anchor" href="#option-cargo-build---build-plan"></a><code>--build-plan</code></dt>
<dd class="option-desc">输出一系列的JSON消息到指示要运行的命令的stdout</p>
<p>该选项尚且不稳定，只有在
<a href="https://doc.rust-lang.org/book/appendix-07-nightly-rust.html">nightly channel</a>
且<code>-Z unstable-options</code> 被指定时才可以开启。
查阅 <a href="https://github.com/rust-lang/cargo/issues/5579">https://github.com/rust-lang/cargo/issues/5579</a> 以获取更多信息.</dd>

</dl>

### 清单选项

<dl>
<dt class="option-term" id="option-cargo-build---manifest-path"><a class="option-anchor" href="#option-cargo-build---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 的路径. 默认情况下Cargo将搜索当前目录或所有父目录下的
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-build---frozen"><a class="option-anchor" href="#option-cargo-build---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-build---locked"><a class="option-anchor" href="#option-cargo-build---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-build---offline"><a class="option-anchor" href="#option-cargo-build---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以使用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>


</dl>

### 一般选项

<dl>

<dt class="option-term" id="option-cargo-build-+toolchain"><a class="option-anchor" href="#option-cargo-build-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-build---config"><a class="option-anchor" href="#option-cargo-build---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-build--h"><a class="option-anchor" href="#option-cargo-build--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-build---help"><a class="option-anchor" href="#option-cargo-build---help"></a><code>--help</code></dt>
<dd class="option-desc">输出帮助信息。</dd>


<dt class="option-term" id="option-cargo-build--Z"><a class="option-anchor" href="#option-cargo-build--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


### 杂项

<dl>
<dt class="option-term" id="option-cargo-build--j"><a class="option-anchor" href="#option-cargo-build--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-build---jobs"><a class="option-anchor" href="#option-cargo-build---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc">并行执行的数量。也可以用 <code>build.jobs</code> 配置 <a href="../reference/config.html">可选值</a> 
默认为逻辑CPU个数。如果是给出负数，将采用逻辑逻辑CPU数量+传入的负数。</dd>


<dt class="option-term" id="option-cargo-build---keep-going"><a class="option-anchor" href="#option-cargo-build---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">在依赖关系图中构建尽可能多的crate，而不是在遇到第一个构建失败的crate就中止构建，不稳定，需要
<code>-Zunstable-options</code>选项。</dd>


<dt class="option-term" id="option-cargo-build---future-incompat-report"><a class="option-anchor" href="#option-cargo-build---future-incompat-report"></a><code>--future-incompat-report</code></dt>
<dd class="option-desc">显示一个未来兼容性报告，包含在执行命令时输出的所有的“未来不可用的”(future-incompatible)警告信息。</p>
<p>查阅 <a href="cargo-report.html">cargo-report(1)</a>获取更多信息</dd>


</dl>

## 环境

查阅 [参考手册](../reference/environment-variables.html) 获取Cargo会读取的环境变量。


## 退出状态

* `0`: Cargo 成功退出。
* `101`: Cargo 未能完成。


## 例子

1. 构建本地package以及它的全部依赖。

       cargo build

2. 带有编译优化的构建:

       cargo build --release

## 请参阅
[cargo(1)](cargo.html), [cargo-rustc(1)](cargo-rustc.html)
