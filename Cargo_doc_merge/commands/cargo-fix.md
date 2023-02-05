# cargo-fix(1)



## 定义

cargo-fix - 自动修复由rustc报告的lint警告

## 概要

`cargo fix` [_options_]

## 描述

这个Cargo子命令会自动从诊断中获取rustc的建议，如警告，并将其应用于你的源代码。
帮助自动化那些rustc本身已经知道如何告诉你怎样修复的任务。

执行 `cargo fix` 将在引擎下执行 [cargo-check(1)](cargo-check.html) 。
自动修复包所有警告(如果可能的话)，在检查结束后显示剩余所有警告。
比如，想把所有修正应用于当前包，可以运行:

    cargo fix

其行为与 `cargo check --all-targets` 相同。

`cargo fix` 只能够修复用 `cargo check` 常规编译的代码。
如果代码有条件地启用了可选特性，你需要启用这些特性才能对该代码进行分析。

    cargo fix --features foo

同样，其他 `cfg` 表达式，如平台特定的代码，将需要传递 `--target` 来修复给定目标的代码。

    cargo fix --target x86_64-pc-windows-gnu

如果你在使用 `cargo fix` 时遇到任何问题，或者有其他功能需求，请在 <https://github.com/rust-lang/cargo> 上提issue。

### 版次迁移

`cargo fix` 子命令也可以用来将包从一个[Edition]版次迁移到另一个版次。通常的过程是:

1. 运行 `cargo fix --edition` 。如果项目有多个特性，也可以考虑使用 `--all-features` 标志。
   如果你的项目有特定平台的代码被 `cfg` 属性控制，你可能需要使用不同的 `--target` 标志，多次运行 `cargo fix --edition` 。
2. 修改 `Cargo.toml` ，将[edition field]设置为新版本。
3. 运行你的项目测试，以验证所有内容是否仍然有效。如果有新的警告，你可以考虑再次运行 `cargo fix` (没有 `--edition` 标志) 来应用编译器给出的任何建议。

希望这样就可以了! 请记住上面提到的注意事项， `cargo fix` 不能更新非活动特性或 `cfg` 表达式的代码。
另外，在某些罕见的情况下，编译器无法自动将所有代码迁移到新版本，这可能需要在用新版本构建后进行手动修改。

[edition]: https://doc.rust-lang.org/edition-guide/editions/transitioning-an-existing-project-to-a-new-edition.html
[edition field]: ../reference/manifest.html#the-edition-field

## 选项

### 修复选项

<dl>

<dt class="option-term" id="option-cargo-fix---broken-code"><a class="option-anchor" href="#option-cargo-fix---broken-code"></a><code>--broken-code</code></dt>
<dd class="option-desc">即使代码已有编译错误，仍然修复。如果<code>cargo fix</code>不能应用修改，这就很有用。
它将应用这些变化，并在工作目录中留下破坏的代码以便检查和手动修复。</dd>


<dt class="option-term" id="option-cargo-fix---edition"><a class="option-anchor" href="#option-cargo-fix---edition"></a><code>--edition</code></dt>
<dd class="option-desc">应用修改，将代码更新到下一个版次。
这将不会更新 <code>Cargo.toml</code> 配置清单中的版次。必须在<code>cargo fix --edition</code>完成后手动更新。</dd>


<dt class="option-term" id="option-cargo-fix---edition-idioms"><a class="option-anchor" href="#option-cargo-fix---edition-idioms"></a><code>--edition-idioms</code></dt>
<dd class="option-desc">应用建议，将代码更新为当前版次的首选样式。</dd>


<dt class="option-term" id="option-cargo-fix---allow-no-vcs"><a class="option-anchor" href="#option-cargo-fix---allow-no-vcs"></a><code>--allow-no-vcs</code></dt>
<dd class="option-desc">即使没有检测到VCS，也可以修复代码。</dd>


<dt class="option-term" id="option-cargo-fix---allow-dirty"><a class="option-anchor" href="#option-cargo-fix---allow-dirty"></a><code>--allow-dirty</code></dt>
<dd class="option-desc">即使工作目录VCS有变化，也可以修复代码。</dd>


<dt class="option-term" id="option-cargo-fix---allow-staged"><a class="option-anchor" href="#option-cargo-fix---allow-staged"></a><code>--allow-staged</code></dt>
<dd class="option-desc">即使工作目录有VCS暂存变化，也能修复代码。</dd>


</dl>

### 包的选择

默认情况下，如果没有提供选择包的选项，那么会按照选择的配置清单文件来选择包(当没有指定 `--manifest-path` 时，按照当前工目录来查找配置清单文件)。
如果工作空间根目录的配置清单文件，则会选择该工作空间的默认成员，否则仅选取配置清单文件所在的那个包。

可以通过 `workspace.default-members` 来显式设置工作空间的默认成员。如果没有设置，在虚拟工作空间下会选择所有的成员，在非虚拟工作空间下仅会选择根 package 。

<dl>

<dt class="option-term" id="option-cargo-fix--p"><a class="option-anchor" href="#option-cargo-fix--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-fix---package"><a class="option-anchor" href="#option-cargo-fix---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只修复指定的包。 见 <a href="cargo-pkgid.html">cargo-pkgid(1)</a> 了解 SPEC 格式。这个标志可以多次指定，并支持常见的 Unix 通配符模式，如 <code>*</code>, <code>?</code> 和 <code>[]</code>.
然而，为了避免shell在Cargo处理通配符模式之前意外地扩展它们，必须在每个模式周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-fix---workspace"><a class="option-anchor" href="#option-cargo-fix---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">修复工作空间的所有成员。</dd>



<dt class="option-term" id="option-cargo-fix---all"><a class="option-anchor" href="#option-cargo-fix---all"></a><code>--all</code></dt>
<dd class="option-desc">弃用的 <code>--workspace</code> 的别名。</dd>



<dt class="option-term" id="option-cargo-fix---exclude"><a class="option-anchor" href="#option-cargo-fix---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。必须与 <code>--workspace</code> 标志一起使用。
这个标志可以多次指定，并支持常见的 Unix 通配符模式，如 <code>*</code>, <code>?</code> 和 <code>[]</code> 。
然而，为了避免shell在Cargo处理通配符模式之前意外地扩展它们，必须在每个模式周围使用单引号或双引号。</dd>


</dl>


### 目标选择

当没有给出目标选择选项时， `cargo fix` 将修复所有目标(隐含 `--all-targets` )。如果二进制文件的 `required-features` 缺失，将被跳过。

传递目标选择标志将只修复指定的目标。

注意 `--bin` 、 `--example` 、 `--test` 和 `--bench` 标志也支持常见的Unix通配符模式，如 `*` 、 `?` 和 `[]` 。
然而，为了避免shell在Cargo处理通配符模式之前意外地扩展它们，必须在每个glob模式周围使用单引号或双引号。

<dl>

<dt class="option-term" id="option-cargo-fix---lib"><a class="option-anchor" href="#option-cargo-fix---lib"></a><code>--lib</code></dt>
<dd class="option-desc">修复包的库。</dd>


<dt class="option-term" id="option-cargo-fix---bin"><a class="option-anchor" href="#option-cargo-fix---bin"></a><code>--bin</code> <em>name</em>...</dt>
<dd class="option-desc">修复指定的二进制文件。这个标志可以多次指定，并支持常见的Unix通配符模式。</dd>


<dt class="option-term" id="option-cargo-fix---bins"><a class="option-anchor" href="#option-cargo-fix---bins"></a><code>--bins</code></dt>
<dd class="option-desc">修复所有二进制目标。</dd>



<dt class="option-term" id="option-cargo-fix---example"><a class="option-anchor" href="#option-cargo-fix---example"></a><code>--example</code> <em>name</em>...</dt>
<dd class="option-desc">修复指定的示例。这个标志可以多次指定，并支持常见的Unix通配符模式。</dd>


<dt class="option-term" id="option-cargo-fix---examples"><a class="option-anchor" href="#option-cargo-fix---examples"></a><code>--examples</code></dt>
<dd class="option-desc">修复所有实例目标。</dd>


<dt class="option-term" id="option-cargo-fix---test"><a class="option-anchor" href="#option-cargo-fix---test"></a><code>--test</code> <em>name</em>...</dt>
<dd class="option-desc">修复指定的集成测试。这个标志可以多次指定，并支持常见的Unix通配符模式。</dd>


<dt class="option-term" id="option-cargo-fix---tests"><a class="option-anchor" href="#option-cargo-fix---tests"></a><code>--tests</code></dt>
<dd class="option-desc">修复测试模式下所有设置了<code>test = true</code> 配置清单标志的目标。
默认情况下，这包括作为单元测试构建的库和二进制文件，以及集成测试。请注意，这也将构建任何所需的依赖，所以lib目标可能会被构建两次(一次作为单元测试，一次作为二进制文件、集成测试等的依赖)。
通过在目标的配置清单中设置<code>test</code>标志，可以启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-fix---bench"><a class="option-anchor" href="#option-cargo-fix---bench"></a><code>--bench</code> <em>name</em>...</dt>
<dd class="option-desc">修复指定的性能测试。这个标志可以多次指定，并支持常见的Unix通配符模式。</dd>


<dt class="option-term" id="option-cargo-fix---benches"><a class="option-anchor" href="#option-cargo-fix---benches"></a><code>--benches</code></dt>
<dd class="option-desc">修复性能测试模式下所有设置了<code>bench = true</code>配置清单标志的目标。
默认情况下，这包括作为性能测试构建的库和二进制文件，以及性能测试目标。请注意，这也将构建任何所需的依赖，所以lib目标可能会被构建两次(一次是作为性能测试，一次是作为二进制文件、性能测试等的依赖)。
通过在目标的配置清单中设置<code>bench</code>标志，可以启用或禁用目标。</dd>


<dt class="option-term" id="option-cargo-fix---all-targets"><a class="option-anchor" href="#option-cargo-fix---all-targets"></a><code>--all-targets</code></dt>
<dd class="option-desc">修复所有目标。这等同于指定 <code>--lib --bins --tests --benches --examples</code> 。</dd>


</dl>


### 特性选择

特性标志允许你控制开启哪些特性。当没有提供特性选项时，会为每个选择的包启用 `default` 特性。

见 [特性文档](../reference/features.html#command-line-feature-options) 了解更多内容。

<dl>

<dt class="option-term" id="option-cargo-fix--F"><a class="option-anchor" href="#option-cargo-fix--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-fix---features"><a class="option-anchor" href="#option-cargo-fix---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">激活的特性列表用空格或逗号分隔。可以用<code>package-name/feature-name</code>语法启用工作空间成员的特性。这个标志可以多次指定，从而可以启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-fix---all-features"><a class="option-anchor" href="#option-cargo-fix---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定包的所有可用特性。</dd>


<dt class="option-term" id="option-cargo-fix---no-default-features"><a class="option-anchor" href="#option-cargo-fix---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不激活所选包的<code>default</code>特性。</dd>


</dl>


### 编译选项

<dl>

<dt class="option-term" id="option-cargo-fix---target"><a class="option-anchor" href="#option-cargo-fix---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">对给定的架构进行修复。默认是主机架构。三元组的一般格式是<code>&lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;</code> 。
运行<code>rustc --print target-list</code>以获得支持的目标列表。这个标志可以多次指定。</p>
<p>也可以通过 <code>build.target</code> <a href="../reference/config.html">配置</a>。</p>
<p>注意，指定这个标志会使Cargo在不同的模式下运行，目标制品放在单独目录。 参见 <a href="../guide/build-cache.html">构建缓存</a> 文档了解详情。</dd>



<dt class="option-term" id="option-cargo-fix--r"><a class="option-anchor" href="#option-cargo-fix--r"></a><code>-r</code></dt>
<dt class="option-term" id="option-cargo-fix---release"><a class="option-anchor" href="#option-cargo-fix---release"></a><code>--release</code></dt>
<dd class="option-desc">修复<code>release</code>编译设置的优化制品。
参见 <code>--profile</code>选项，以按名称选择特定的编译设置。</dd>



<dt class="option-term" id="option-cargo-fix---profile"><a class="option-anchor" href="#option-cargo-fix---profile"></a><code>--profile</code> <em>name</em></dt>
<dd class="option-desc">用给定的编译设置进行修复。</p>
<p>作为一种特殊情况，指定 <code>test</code> 编译设置也将启用测试模式下的检查，这将启用检查测试并启用<code>test</code> cfg选项。
见 <a href="https://doc.rust-lang.org/rustc/tests/index.html">rustc tests</a> 了解细节。</p>
<p>见 <a href="../reference/profiles.html">参考</a> 了解编译设置细节。</dd>



<dt class="option-term" id="option-cargo-fix---ignore-rust-version"><a class="option-anchor" href="#option-cargo-fix---ignore-rust-version"></a><code>--ignore-rust-version</code></dt>
<dd class="option-desc">即使所选的Rust编译器比项目<code>rust-version</code>字段中配置的所需Rust版本更早，也可以修复目标。</dd>



<dt class="option-term" id="option-cargo-fix---timings=fmts"><a class="option-anchor" href="#option-cargo-fix---timings=fmts"></a><code>--timings=</code><em>fmts</em></dt>
<dd class="option-desc">输出每次编译需要多长时间的信息，并跟踪时间段的并发信息。
接受可选的逗号分隔的输出格式列表；没有参数的<code>--timings</code>将默认为<code>--timings=html</code>。
指定未稳定的输出格式(而不是默认)，需要<code>-Zunstable-options</code>。 有效的输出格式:</p>
<ul>
<li><code>html</code> (未稳定, 要求 <code>-Zunstable-options</code>): 在<code>target/cargo-timings</code>目录下生成可阅读的 cargo-timing.html 文件，并附编译报告。
如果你想查看更早的运行情况，也可以将报告写到同一目录下，文件名带有时间戳。
HTML输出适合人类阅读，机器不可读。</li>
<li><code>json</code> (未稳定, 要求 <code>-Zunstable-options</code>): 发送机器可读的关于时间信息的JSON。</li>
</ul></dd>




</dl>

### 输出选项

<dl>
<dt class="option-term" id="option-cargo-fix---target-dir"><a class="option-anchor" href="#option-cargo-fix---target-dir"></a><code>--target-dir</code> <em>directory</em></dt>
<dd class="option-desc">所有生成制品和中间文件的目录。 也可以用 <code>CARGO_TARGET_DIR</code> 环境变量, 或 <code>build.target-dir</code> <a href="../reference/config.html">配置</a>。
默认为工作空间的根<code>target</code>。</dd>


</dl>

### Display Options

<dl>
<dt class="option-term" id="option-cargo-fix--v"><a class="option-anchor" href="#option-cargo-fix--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-fix---verbose"><a class="option-anchor" href="#option-cargo-fix---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">进行详细输出。可以指定两遍来开启 &quot;非常详细&quot; 模式，输出更多的额外信息，像是依赖项的警告和构建脚本的输出信息。
也可以通过 <code>term.verbose</code> <a href="../reference/config.html">配置</a> 。</dd>


<dt class="option-term" id="option-cargo-fix--q"><a class="option-anchor" href="#option-cargo-fix--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-fix---quiet"><a class="option-anchor" href="#option-cargo-fix---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不打印 cargo 日志信息。
也可以通过 <code>term.quiet</code> <a href="../reference/config.html">配置</a>。</dd>


<dt class="option-term" id="option-cargo-fix---color"><a class="option-anchor" href="#option-cargo-fix---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制使用彩色输出。可选值有: </p>
<ul>
<li><code>auto</code> (默认值): 自动检测终端是否支持彩色输出。</li>
<li><code>always</code>: 总是显示彩色。</li>
<li><code>never</code>: 从不显示彩色。</li>
</ul>
<p>也可以在 <code>term.color</code> <a href="../reference/config.html">配置</a>。</dd>



<dt class="option-term" id="option-cargo-fix---message-format"><a class="option-anchor" href="#option-cargo-fix---message-format"></a><code>--message-format</code> <em>fmt</em></dt>
<dd class="option-desc">特征信息的输出格式。可以多次指定，数值由逗号分隔。有效值:</p>
<ul>
<li><code>human</code> (默认): 以人可阅读的文本格式显示。 <code>short</code> 和 <code>json</code> 冲突。</li>
<li><code>short</code>: 发出更短的、人可阅读的文本信息。 <code>human</code> 和 <code>json</code> 冲突。</li>
<li><code>json</code>: 向标准输出发送JSON信息。 见 <a href="../reference/external-tools.html#json-messages">参考</a> 了解详情.  <code>human</code> 和 <code>short</code> 冲突。</li>
<li><code>json-diagnostic-short</code>: 确保JSON消息的<code>rendered</code>字段包含rustc的&quot;short&quot;渲染。不能和 <code>human</code> <code>short</code>。</li>
<li><code>json-diagnostic-rendered-ansi</code>: 确保JSON消息的<code>rendered</code>字段包含嵌入式ANSI颜色代码，以遵从rustc的默认颜色方案。 不能和 <code>human</code> <code>short</code>。</li>
<li><code>json-render-diagnostics</code>: 指示Cargo在打印的JSON信息中不包含rustc的特征信息，而是由Cargo来渲染来自rustc的JSON信息。Cargo自身的JSON和其他来自rustc的信息仍会发送。不能和 <code>human</code> <code>short</code>。</li>
</ul></dd>


</dl>

### 配置选项

<dl>
<dt class="option-term" id="option-cargo-fix---manifest-path"><a class="option-anchor" href="#option-cargo-fix---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径。默认, Cargo 在当前目录和任意父目录搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-fix---frozen"><a class="option-anchor" href="#option-cargo-fix---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-fix---locked"><a class="option-anchor" href="#option-cargo-fix---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这些标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果lock文件丢失, 或是需要更新, Cargo会返回错误并退出，<code>--frozen</code> 选项还会阻止cargo通过网络来判断其是否过期。</p>
<p> 可以用于断言 <code>Cargo.lock</code> 文件是否最新状态(例如CI构建)或避免网络访问。</dd>


<dt class="option-term" id="option-cargo-fix---offline"><a class="option-anchor" href="#option-cargo-fix---offline"></a><code>--offline</code></dt>
<dd class="option-desc">阻止Cargo访问网络。如果不指定该选项，Cargo会在需要使用网络但不可用时停止构建并返回错误。设置该标识，Cargo将尽可能不使用网络完成构建。 </p>
<p>需注意，这样可能会导致与在线模式不同的依赖处理，Cargo将限制仅使用已下载到本地的crate，即使本地索引中有更新版本。
查阅 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令，在脱机前下载依赖。 </p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">配置</a>。</dd>


</dl>

### 常规选项

<dl>

<dt class="option-term" id="option-cargo-fix-+toolchain"><a class="option-anchor" href="#option-cargo-fix-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果Cargo已经通过rustup安装，并且第一个传给 <code>cargo</code> 的参数以 <code>+</code> 开头，
则当作rustup的工具链名称。(例如 <code>+stable</code> 或 <code>+nightly</code>).
查阅 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup 文档</a>
了解关于工具链覆盖的信息。</dd>


<dt class="option-term" id="option-cargo-fix---config"><a class="option-anchor" href="#option-cargo-fix---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖Cargo配置项的值，该参数应当为TOML <code>KEY=VALUE</code> 语法，
或者提供附加的配置文件的路径。该标识可以多次指定。
查阅 <a href="../reference/config.html#command-line-overrides">命令行覆盖部分</a> 获取更多信息</dd>


<dt class="option-term" id="option-cargo-fix--h"><a class="option-anchor" href="#option-cargo-fix--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-fix---help"><a class="option-anchor" href="#option-cargo-fix---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-fix--Z"><a class="option-anchor" href="#option-cargo-fix--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo不稳定的(每日构建)标志。运行 <code>cargo -Z help</code> 了解详情。</dd>


</dl>


### 其他选项

<dl>
<dt class="option-term" id="option-cargo-fix--j"><a class="option-anchor" href="#option-cargo-fix--j"></a><code>-j</code> <em>N</em></dt>
<dt class="option-term" id="option-cargo-fix---jobs"><a class="option-anchor" href="#option-cargo-fix---jobs"></a><code>--jobs</code> <em>N</em></dt>
<dd class="option-desc"> 并行执行的任务数。可以通过 <code>build.jobs</code> <a href="../reference/config.html">配置</a>。默认值为逻辑CPU数。如果设置为负值，则最大的并行任务数为*逻辑CPU数*加*这个负数*。该值不能为0。</dd>


<dt class="option-term" id="option-cargo-fix---keep-going"><a class="option-anchor" href="#option-cargo-fix---keep-going"></a><code>--keep-going</code></dt>
<dd class="option-desc">尽可能的构建依赖图中的 crate ，而不是一个失败就停止。功能还不稳定，需要 <code>-Zunstable-options</code>。</dd>


</dl>

## 环境

查阅 [参考](../reference/environment-variables.html) 了解Cargo读取环境变量。


## 退出状态

* `0`: Cargo 执行成功。
* `101`: Cargo 没有成功完成。


## 示例

1. 将编译器建议修复本地包:

       cargo fix

2. 更新包到下一版本前的准备:

       cargo fix --edition

3. 应用当前版本建议的首选样式:

       cargo fix --edition-idioms

## 参阅
[cargo(1)](cargo.html), [cargo-check(1)](cargo-check.html)
