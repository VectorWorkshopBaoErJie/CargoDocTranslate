# cargo-report(1)

## 定义

cargo-report - 生成并显示各类报告

## 概要

`cargo report` _type_ [_options_]

### 说明

显示给定 _type_ 报告 - 目前，仅支持 `future-incompat` 。

## 选项

<dl>

<dt class="option-term" id="option-cargo-report---id"><a class="option-anchor" href="#option-cargo-report---id"></a><code>--id</code> <em>id</em></dt>
<dd class="option-desc">显示具有指定的Cargo生成的ID的报告</dd>


<dt class="option-term" id="option-cargo-report--p"><a class="option-anchor" href="#option-cargo-report--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-report---package"><a class="option-anchor" href="#option-cargo-report---package"></a><code>--package</code> <em>spec</em>...</dt>
<dd class="option-desc">仅显示指定包的报告</dd>


</dl>

## 示例

1. 显示最新的future-incompat报告:

       cargo report future-incompat

2. 显示特定包的最新future-incompat报告:

       cargo report future-incompat --package my-dep:0.0.1

## 参阅
[Future incompat report](../reference/future-incompat-report.html)

[cargo(1)](cargo.html)
