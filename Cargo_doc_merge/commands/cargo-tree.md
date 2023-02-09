# cargo-tree(1)



## 定义

cargo-tree - 用树状结构展示依赖图

## 概要

`cargo tree` [_options_]

## 说明

这个命令在终端显示一个依赖关系树。
下面是一个依赖 "rand" 包的简单项目的例子

```
myproject v0.1.0 (/myproject)
└── rand v0.7.3
    ├── getrandom v0.1.14
    │   ├── cfg-if v0.1.10
    │   └── libc v0.2.68
    ├── libc v0.2.68 (*)
    ├── rand_chacha v0.2.2
    │   ├── ppv-lite86 v0.2.6
    │   └── rand_core v0.5.1
    │       └── getrandom v0.1.14 (*)
    └── rand_core v0.5.1 (*)
[build-dependencies]
└── cc v1.0.50
```

标有 `(*)` 的包已经被 "去重" 了。
该软件包的依赖关系已经在图中的其他地方显示过了，所以没有重复。
使用 `--no-dedupe` 选项来展示重复的内容。

`-e` 标志可以用来选择要显示的依赖关系种类。
"features" 种类可以改变输出结果，以显示每个依赖关系所启用的 feature。
例如 `cargo tree -e features` :

```
myproject v0.1.0 (/myproject)
└── log feature "serde"
    └── log v0.4.8
        ├── serde v1.0.106
        └── cfg-if feature "default"
            └── cfg-if v0.1.10
```

在这棵树上，`myproject` 依赖于具有 `serde` 特性的 `log` ，
而 `log` 又依赖于具有 "default" 特性的 `cfg-if` 。
当使用 `-e feature` 时，使用 `-i` 标志来帮助展示这些特性是如何进入包的。
请看下面的例子以了解更多细节。

### 特性统一

这个命令显示更接近 Cargo 构建的特性统一(feature-unified)的图形，而不是你在 `Cargo.toml` 中列出的。
例如，如果你在 `[dependencies]` 和 `[dev-dependencies]` 中都指定了相同的依赖关系，但却使用了不同的特性。
这个命令可能会合并所有特性，并在其中一个依赖项上显示一个 `(*)` 来表示重复的特性。

因此，要得到大概相同的对 `cargo build` 工作的预览，`cargo tree -e normal,build` 是相当接近的;
要得到大概相同的对 `cargo test` 工作的预览，`cargo tree` 是相当接近的。
然而，它并不能保证与 Cargo 要构建的内容完全等同，因为编译是复杂的，取决于很多不同的因素。

要了解更多关于特性统一(feature-unified)的信息，请查看[专门的章节](../reference/features.html#feature-unification)。

## 选项

### 树选项

<dl>

<dt class="option-term" id="option-cargo-tree--i"><a class="option-anchor" href="#option-cargo-tree--i"></a><code>-i</code> <em>spec</em></dt>
<dt class="option-term" id="option-cargo-tree---invert"><a class="option-anchor" href="#option-cargo-tree---invert"></a><code>--invert</code> <em>spec</em></dt>
<dd class="option-desc">显示指定软件包的反向依赖关系。这个标志将反转树，显示依赖给定包的包。</p>
<code>-p</code> 标志可以用来显示软件包的反向依赖关系，只显示给 <code>-p</code> 的软件包的子树。
<p>注意，在工作空间中，默认情况下，它只显示当前目录下工作空间成员的树中的包的反向依赖关系。
可以使用 <code>--workspace</code> 标志来扩展它，使其在整个工作空间显示软件包的反向依赖关系。</dd>


<dt class="option-term" id="option-cargo-tree---prune"><a class="option-anchor" href="#option-cargo-tree---prune"></a><code>--prune</code> <em>spec</em></dt>
<dd class="option-desc">从依赖关系树的显示中删去给定的软件包。</dd>


<dt class="option-term" id="option-cargo-tree---depth"><a class="option-anchor" href="#option-cargo-tree---depth"></a><code>--depth</code> <em>depth</em></dt>
<dd class="option-desc">依赖关系树的最大显示深度。例如，深度为1时，显示直接依赖关系。</dd>


<dt class="option-term" id="option-cargo-tree---no-dedupe"><a class="option-anchor" href="#option-cargo-tree---no-dedupe"></a><code>--no-dedupe</code></dt>

<dd class="option-desc">不要删除重复的依赖关系。
通常情况下，当一个包已经显示了它的依赖关系，再次出现将不会重新显示它的依赖关系，并且会包括一个 <code>(*)</code> 来表示它已经被显示了。
这个标志令这些重复的内容显示出来。</dd>


<dt class="option-term" id="option-cargo-tree--d"><a class="option-anchor" href="#option-cargo-tree--d"></a><code>-d</code></dt>
<dt class="option-term" id="option-cargo-tree---duplicates"><a class="option-anchor" href="#option-cargo-tree---duplicates"></a><code>--duplicates</code></dt>
<dd class="option-desc">只显示有多个版本的依赖关系(意味着 <code>--invert</code> )。当与 <code>-p</code> 标志一起使用时，只显示指定软件包的子树中的重复内容。</p>
<p>这对构建时间和可执行文件的大小有好处，可以避免多次构建同一个软件包。
这个标志可以帮助识别冲突的软件包。然后，你可以查看包是否有相同的依赖但是依赖的版本不一，
将旧版本升级到新版本，这样就可以只构建一个实例。</dd>


<dt class="option-term" id="option-cargo-tree--e"><a class="option-anchor" href="#option-cargo-tree--e"></a><code>-e</code> <em>kinds</em></dt>
<dt class="option-term" id="option-cargo-tree---edges"><a class="option-anchor" href="#option-cargo-tree---edges"></a><code>--edges</code> <em>kinds</em></dt>
<dd class="option-desc">要显示的依赖的种类。接受一个逗号分隔的列表:</p>
<ul>
<li><code>all</code> — 展示所有最新的类型</li>
<li><code>normal</code> — 展示正常依赖</li>
<li><code>build</code> — 展示构建依赖</li>
<li><code>dev</code> — 展示开发依赖</li>
<li><code>features</code> — 显示每个依赖关系所启用的特性。如果这是唯一给出的种类，那么它将自动包括其他依赖关系的种类</li>
<li><code>no-normal</code> — 不要包含正常依赖</li>
<li><code>no-build</code> — 不要包含构建依赖</li>
<li><code>no-dev</code> — 不要包含开发依赖</li>
<li><code>no-proc-macro</code> — 不要包含程序宏依赖</li>
</ul>
<p> <code>normal</code>, <code>build</code>, <code>dev</code>, and <code>all</code> 依赖种类不能与
<code>no-normal</code>, <code>no-build</code>, or <code>no-dev</code> 依赖种类混用。</p>
<p>默认是<code>normal，build，dev</code>。</dd>


<dt class="option-term" id="option-cargo-tree---target"><a class="option-anchor" href="#option-cargo-tree---target"></a><code>--target</code> <em>triple</em></dt>
<dd class="option-desc">过滤与目标三元组匹配的依赖。默认是宿主机平台。使用 <code>all</code> 来包括 <em>所有</em> 目标。</dd>


</dl>

### 格式化树选项

<dl>

<dt class="option-term" id="option-cargo-tree---charset"><a class="option-anchor" href="#option-cargo-tree---charset"></a><code>--charset</code> <em>charset</em></dt>
<dd class="option-desc">选择树使用字符集. 有效的值为: &quot;utf8&quot; 或
&quot;ascii&quot;。 默认为 &quot;utf8&quot;。</dd>


<dt class="option-term" id="option-cargo-tree--f"><a class="option-anchor" href="#option-cargo-tree--f"></a><code>-f</code> <em>format</em></dt>
<dt class="option-term" id="option-cargo-tree---format"><a class="option-anchor" href="#option-cargo-tree---format"></a><code>--format</code> <em>format</em></dt>
<dd class="option-desc">设置每个包的格式字符串。默认是 &quot;{p}&quot;。</p>
<p>这是一个任意的字符串，它将被用来显示每个包。下列字符串将被替换成相应的值:</p>
<ul>
<li><code>{p}</code> — 包名</li>
<li><code>{l}</code> — 包证书</li>
<li><code>{r}</code> — 包的仓库地址</li>
<li><code>{f}</code> — 逗号分割的包启用的特性列表</li>
<li><code>{lib}</code> — 在 <code>use</code> 声明中使用的类库的名称</li>
</ul></dd>


<dt class="option-term" id="option-cargo-tree---prefix"><a class="option-anchor" href="#option-cargo-tree---prefix"></a><code>--prefix</code> <em>prefix</em></dt>
<dd class="option-desc">设置每行如何展示， <em>前缀</em> 可以是下面的一种:</p>
<ul>
<li><code>indent</code> (默认) — 以树的格式缩进展示每一行</li>
<li><code>depth</code> — 以列表形式显示，在每个条目前打印数字来展示深度</li>
<li><code>none</code> — 以平铺的列表的形式展示</li>
</ul></dd>


</dl>

### 选择包

默认情况下，当没有给出包选择选项时，所选包取决于所选清单文件(如果没有给出 `--manifest-path` ，则基于当前工作目录)。
如果清单是工作空间的根，那么将选择工作空间的默认成员，否则将只选择清单定义的包。

工作空间的默认成员可通过根清单中的 `workspace.default-members` 键明确设置。
如果没有设置，虚拟工作空间将包括所有工作空间成员(相当于传递 `--workspace`)，而非虚拟工作空间将只包括根 crate 本身。

<dl>

<dt class="option-term" id="option-cargo-tree--p"><a class="option-anchor" href="#option-cargo-tree--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-tree---package"><a class="option-anchor" href="#option-cargo-tree---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">只展示指定的软件包。 关于SPEC的格式，见<a href="cargo-pkgid.html">cargo-pkgid(1)</a>。
这个标志可以指定多次，并支持常见的 Unix glob pattern，比如
<code>*</code>, <code>?</code> 和 <code>[]</code>。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，你必须在每个 pattern 周围使用单引号或双引号。</dd>


<dt class="option-term" id="option-cargo-tree---workspace"><a class="option-anchor" href="#option-cargo-tree---workspace"></a><code>--workspace</code></dt>
<dd class="option-desc">展示工作空间中的所有成员。</dd>




<dt class="option-term" id="option-cargo-tree---exclude"><a class="option-anchor" href="#option-cargo-tree---exclude"></a><code>--exclude</code> <em>SPEC</em>...</dt>
<dd class="option-desc">排除指定的包。 必须与<code>--workspace</code>标志一起使用。
这个标志可以被多次指定，并且支持常见的 Unix glob pattern，比如
<code>*</code>, <code>?</code> 和 <code>[]</code>。
然而，为了避免你的 shell 在 Cargo 处理 glob pattern 之前意外地扩展它们，你必须在每个 pattern 周围使用单引号或双引号。</dd>


</dl>


### 清单选项

<dl>

<dt class="option-term" id="option-cargo-tree---manifest-path"><a class="option-anchor" href="#option-cargo-tree---manifest-path"></a><code>--manifest-path</code> <em>path</em></dt>
<dd class="option-desc"> <code>Cargo.toml</code> 文件的路径. 默认情况下，Cargo 会在当前目录或任何父目录下搜索
<code>Cargo.toml</code> 文件。</dd>



<dt class="option-term" id="option-cargo-test---frozen"><a class="option-anchor" href="#option-cargo-test---frozen"></a><code>--frozen</code></dt>
<dt class="option-term" id="option-cargo-test---locked"><a class="option-anchor" href="#option-cargo-test---locked"></a><code>--locked</code></dt>
<dd class="option-desc">这两个标志都要求 <code>Cargo.lock</code> 文件是最新的。
如果 .lock 文件缺失，或者需要更新，Cargo 将以错误退出。
<code>--frozen</code> 标志也可以防止 Cargo 访问网络以确定其是否过期。</p>
<p>
这些可以用于需要判断 <code>Cargo.lock</code> 文件是否最新（比如CI构建）或者想避免网络访问的环境中。</dd>


<dt class="option-term" id="option-cargo-tree---offline"><a class="option-anchor" href="#option-cargo-tree---offline"></a><code>--offline</code></dt>
<dd class="option-desc">
禁止 Cargo 在任何情况下访问网络。
如果没有这个标志，当 Cargo 需要访问网络而网络不可用时，它会以错误的方式停止。
有了这个标志，Cargo会尝试在没有网络的情况下进行。</p>

<p>请注意，这可能会导致与在线模式不同的依赖方案。Cargo 会将自己限制在本地的 crate 仓库上，
即使在本地拷贝的索引中可能有更新的版本也是如此。
参见 <a href="cargo-fetch.html">cargo-fetch(1)</a> 命令来在离线前下载依赖关系。</p>
<p>也可以用 <code>net.offline</code> <a href="../reference/config.html">config value</a> 来指定。</dd>



</dl>

### 选择特性

feature 标志允许你控制启用哪些特性。当没有给出特性选项时，每个选定的包都会激活默认的功能。

更多的细节请参见[the features documentation](../reference/features.html#command-line-feature-options)。

<dl>

<dt class="option-term" id="option-cargo-tree--F"><a class="option-anchor" href="#option-cargo-tree--F"></a><code>-F</code> <em>features</em></dt>
<dt class="option-term" id="option-cargo-tree---features"><a class="option-anchor" href="#option-cargo-tree---features"></a><code>--features</code> <em>features</em></dt>
<dd class="option-desc">
要激活的 feature 用空格或逗号分隔的列表指定。工作空间成员的 feature 可以用 <code>package-name/feature-name</code> 的语法来启用。
这个标志可以被多次指定，这样可以启用所有指定的特性。</dd>


<dt class="option-term" id="option-cargo-tree---all-features"><a class="option-anchor" href="#option-cargo-tree---all-features"></a><code>--all-features</code></dt>
<dd class="option-desc">激活所有选定包的所有可用 feature 。</dd>


<dt class="option-term" id="option-cargo-tree---no-default-features"><a class="option-anchor" href="#option-cargo-tree---no-default-features"></a><code>--no-default-features</code></dt>
<dd class="option-desc">不激活所选包的 <code>default</code> 特性。</dd>


</dl>


### 显示选项

<dl>

<dt class="option-term" id="option-cargo-tree--v"><a class="option-anchor" href="#option-cargo-tree--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-tree---verbose"><a class="option-anchor" href="#option-cargo-tree---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">使用 verbose 级别输出详细信息。 指定两次此选项来输出 &quot;十分详细&quot; 的输出信息，
这会包含额外的输出信息，比如依赖警告和构建脚本输出。
也可以与 <code>term.verbose</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-tree--q"><a class="option-anchor" href="#option-cargo-tree--q"></a><code>-q</code></dt>
<dt class="option-term" id="option-cargo-tree---quiet"><a class="option-anchor" href="#option-cargo-tree---quiet"></a><code>--quiet</code></dt>
<dd class="option-desc">不要打印任何 cargo 日志信息。
也可以与 <code>term.quiet</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>


<dt class="option-term" id="option-cargo-tree---color"><a class="option-anchor" href="#option-cargo-tree---color"></a><code>--color</code> <em>when</em></dt>
<dd class="option-desc">控制的日志的颜色。有效的值如下:</p>
<ul>
<li><code>auto</code> (默认): 自动检测终端颜色支持是否可用。</li>
<li><code>always</code>: 总是带颜色显示。</li>
<li><code>never</code>: 不带颜色显示.</li>
</ul>
<p>也可以与 <code>term.color</code>
<a href="../reference/config.html">config value</a> 一起使用。</dd>



</dl>

### 通用选项

<dl>

<dt class="option-term" id="option-cargo-tree-+toolchain"><a class="option-anchor" href="#option-cargo-tree-+toolchain"></a><code>+</code><em>toolchain</em></dt>
<dd class="option-desc">如果 Cargo 已经和 rustup 一起安装, 并且 <code>cargo</code> 的第一个参数以
<code>+</code> 开头, 它将被解释为一个 rustup 工具链的名字 (比如 <code>+stable</code> 或者 <code>+nightly</code>)。
更多关于工具链覆盖工作的信息，请参见 <a href="https://rust-lang.github.io/rustup/overrides.html">rustup documentation</a>
</dd>


<dt class="option-term" id="option-cargo-tree---config"><a class="option-anchor" href="#option-cargo-tree---config"></a><code>--config</code> <em>KEY=VALUE</em> or <em>PATH</em></dt>
<dd class="option-desc">覆盖一个 Cargo 配置值。参数应该使用 TOML 的 <code>KEY=VALUE</code> 语法，或者提供一个额外配置文件的路径。
这个标志可以被多次指定。更多信息请参见 <a href="../reference/config.html#command-line-overrides">command-line overrides section</a>。</dd>


<dt class="option-term" id="option-cargo-tree--h"><a class="option-anchor" href="#option-cargo-tree--h"></a><code>-h</code></dt>
<dt class="option-term" id="option-cargo-tree---help"><a class="option-anchor" href="#option-cargo-tree---help"></a><code>--help</code></dt>
<dd class="option-desc">打印帮助信息。</dd>


<dt class="option-term" id="option-cargo-tree--Z"><a class="option-anchor" href="#option-cargo-tree--Z"></a><code>-Z</code> <em>flag</em></dt>
<dd class="option-desc">Cargo 的不稳定 (仅限 nightly 版本) 标志。 更多信息请运行 <code>cargo -Z help</code>。</dd>


</dl>


## 环境

更多关于 Cargo 读取的环境变量信息，请参见[the reference](../reference/environment-variables.html)。


## 退出状态

* `0`: Cargo 成功退出.
* `101`: Cargo 错误退出.


## 示例

1. 显示当前目录下的包的树:

       cargo tree

2. 显示所有依赖 `syn` 的包:

       cargo tree -i syn

3. 显示每个软件包上启用的特性:

       cargo tree --format "{p} {f}"

4. 显示所有被多次构建的包。如果树上出现多个 semver 不兼容的版本(比如 1.0.0 和 2.0.0)，就会出现这种情况

       cargo tree -d

5. 解释为什么会启用 `syn` 包的特性:

       cargo tree -e features -i syn

`-e features` 用于显示特征。`-i` 标志用于反转图表，使其显示依赖于 `syn` 的包。
下面是命令输出的一个例子。

   ```
   syn v1.0.17
   ├── syn feature "clone-impls"
   │   └── syn feature "default"
   │       └── rustversion v1.0.2
   │           └── rustversion feature "default"
   │               └── myproject v0.1.0 (/myproject)
   │                   └── myproject feature "default" (command-line)
   ├── syn feature "default" (*)
   ├── syn feature "derive"
   │   └── syn feature "default" (*)
   ├── syn feature "full"
   │   └── rustversion v1.0.2 (*)
   ├── syn feature "parsing"
   │   └── syn feature "default" (*)
   ├── syn feature "printing"
   │   └── syn feature "default" (*)
   ├── syn feature "proc-macro"
   │   └── syn feature "default" (*)
   └── syn feature "quote"
       ├── syn feature "printing" (*)
       └── syn feature "proc-macro" (*)
   ```

要阅读这个图，你可以从根部沿着每个特性的链条看它为什么被包含。
例如，"full" 特性是由 `rustversion` crate 添加的，该 crate 是由 `myproject` (带有默认特性)包含的，
而 `myproject` 是命令行上选择的包。所有其他的 `syn` 特性都是由 "默认" 功能添加的("quote" 是由 "printing" 和 "proc-macro" 添加的，它们都是默认特性)。

如果你在交叉引用去重 `(*)` 的条目时遇到困难，可以尝试使用 `--no-dedupe` 标志来获得完整的输出。

## 另请参见
[cargo(1)](cargo.html), [cargo-metadata(1)](cargo-metadata.html)
