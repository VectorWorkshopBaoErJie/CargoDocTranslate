# cargo-version(1)

## 定义

cargo-version - 显示版本信息

## 概要

`cargo version` [_options_]

## 说明

显示Cargo的版本。

## 选项

<dl>

<dt class="option-term" id="option-cargo-version--v"><a class="option-anchor" href="#option-cargo-version--v"></a><code>-v</code></dt>
<dt class="option-term" id="option-cargo-version---verbose"><a class="option-anchor" href="#option-cargo-version---verbose"></a><code>--verbose</code></dt>
<dd class="option-desc">显示附加的版本信息。</dd>


</dl>

## 示例

1. 显示版本:

       cargo version

2. 版本也可以通过标志获得:

       cargo --version
       cargo -V

3. 显示额外的版本信息:

       cargo -Vv

## 参阅
[cargo(1)](cargo.html)
