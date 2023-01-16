{==+==}
# cargo-report(1)
{==+==}

{==+==}


{==+==}
## NAME
{==+==}
## 定义
{==+==}


{==+==}
cargo-report - Generate and display various kinds of reports
{==+==}
cargo-report - 生成并显示各类报告
{==+==}


{==+==}
## SYNOPSIS
{==+==}
## 概要
{==+==}


{==+==}
`cargo report` _type_ [_options_]
{==+==}

{==+==}


{==+==}
### DESCRIPTION
{==+==}
### 说明
{==+==}


{==+==}
Displays a report of the given _type_ - currently, only `future-incompat` is supported
{==+==}
显示给定 _type_ 报告 - 目前，仅支持 `future-incompat` 。
{==+==}


{==+==}
## OPTIONS
{==+==}
## 选项
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-report---id"><a class="option-anchor" href="#option-cargo-report---id"></a><code>--id</code> <em>id</em></dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Show the report with the specified Cargo-generated id</dd>
{==+==}
<dd class="option-desc">显示具有指定的Cargo生成的ID的报告</dd>
{==+==}


{==+==}
<dt class="option-term" id="option-cargo-report--p"><a class="option-anchor" href="#option-cargo-report--p"></a><code>-p</code> <em>spec</em>...</dt>
<dt class="option-term" id="option-cargo-report---package"><a class="option-anchor" href="#option-cargo-report---package"></a><code>--package</code> <em>spec</em>...</dt>
{==+==}

{==+==}


{==+==}
<dd class="option-desc">Only display a report for the specified package</dd>
{==+==}
<dd class="option-desc">仅显示指定包的报告</dd>
{==+==}


{==+==}
## EXAMPLES
{==+==}
## 示例
{==+==}


{==+==}
1. Display the latest future-incompat report:

       cargo report future-incompat
{==+==}
1. 显示最新的future-incompat报告:

       cargo report future-incompat
{==+==}


{==+==}
2. Display the latest future-incompat report for a specific package:

       cargo report future-incompat --package my-dep:0.0.1
{==+==}
2. 显示特定包的最新future-incompat报告:

       cargo report future-incompat --package my-dep:0.0.1
{==+==}


{==+==}
## SEE ALSO
[Future incompat report](../reference/future-incompat-report.html)
{==+==}
## 参阅
[Future incompat report](../reference/future-incompat-report.html)
{==+==}


{==+==}
[cargo(1)](cargo.html)
{==+==}

{==+==}