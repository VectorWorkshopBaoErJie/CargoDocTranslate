{==+==}
# Reporting build timings
The `--timings` option gives some information about how long each compilation
takes, and tracks concurrency information over time.
{==+==}
# 报告构建时间
`--timings` 选项提供了一些关于每次编译所需时间的信息，并跟踪时间推移的并发送信息。
{==+==}


{==+==}
```sh
cargo build --timings
```
{==+==}

{==+==}


{==+==}
This writes an HTML report in `target/cargo-timings/cargo-timing.html`. This
also writes a copy of the report to the same directory with a timestamp in the
filename, if you want to look at older runs.
{==+==}
这将在 `target/cargo-timings/cargo-timing.html` 中写入一个HTML报告。如果你想查看更早的运行情况，也会将报告的副本写到同一目录下，文件名有时间戳。
{==+==}


{==+==}
#### Reading the graphs
{==+==}
#### 阅读图表
{==+==}


{==+==}
There are two graphs in the output. The "unit" graph shows the duration of
each unit over time. A "unit" is a single compiler invocation. There are lines
that show which additional units are "unlocked" when a unit finishes. That is,
it shows the new units that are now allowed to run because their dependencies
are all finished. Hover the mouse over a unit to highlight the lines. This can
help visualize the critical path of dependencies. This may change between runs
because the units may finish in different orders.
{==+==}
在输出中，有两个图表。"unit" 图显示每个单元随时间变化的持续时间。一个 "unit" 是单一的编译器调用。
有几行显示了当一个单元结束时，哪些额外的单元被 "解锁" 。也就是说，它显示现在允许运行的新单元，因为它们的依赖已经全部完成。
将鼠标悬停在一个单元上，可以突出这些线条。这可以帮助直观地看到依赖的关键路径。由于单元可能以不同的顺序完成，这在运行中可能会发生变化。
{==+==}


{==+==}
The "codegen" times are highlighted in a lavender color. In some cases, build
pipelining allows units to start when their dependencies are performing code
generation. This information is not always displayed (for example, binary
units do not show when code generation starts).
{==+==}
"codegen" 的时间以淡紫色突出显示。在某些情况下，构建管道允许单元在其依赖执行代码生成时开始。
这一信息并不总是显示(例如，二进制单元不显示代码生成开始时间)。
{==+==}


{==+==}
The "custom build" units are `build.rs` scripts, which when run are
highlighted in orange.
{==+==}
"custom build" 单元是 `build.rs` 脚本，运行时以橙色显示。
{==+==}


{==+==}
The second graph shows Cargo's concurrency over time. The background
indicates CPU usage. The three lines are:
{==+==}
第二张图显示了Cargo在一段时间内的并发量。背景表示CPU使用率。这三条线是:
{==+==}


{==+==}
- "Waiting" (red) — This is the number of units waiting for a CPU slot to
  open.
- "Inactive" (blue) — This is the number of units that are waiting for their
  dependencies to finish.
- "Active" (green) — This is the number of units currently running.
{==+==}
- "等待" (红色) — 这是等待CPU槽开放的单元的数量。
- "不活跃" (蓝色) — 这是正在等待其依赖完成的单元的数量。
- "活跃" (绿色) — 这是目前正在运行的单元的数量。
{==+==}


{==+==}
Note: This does not show the concurrency in the compiler itself. `rustc`
coordinates with Cargo via the "job server" to stay within the concurrency
limit. This currently mostly applies to the code generation phase.
{==+==}
注意：这并不显示编译器本身的并发量。 `rustc` 通过 "作业服务" 与Cargo协调，以保持在并发量限制之内。目前这主要适用于代码生成阶段。
{==+==}


{==+==}
Tips for addressing compile times:
- Look for slow dependencies.
    - Check if they have features that you may wish to consider disabling.
    - Consider trying to remove the dependency completely.
- Look for a crate being built multiple times with different versions. Try to
  remove the older versions from the dependency graph.
- Split large crates into smaller pieces.
- If there are a large number of crates bottlenecked on a single crate, focus
  your attention on improving that one crate to improve parallelism.
{==+==}
编译时间的提示:
- 寻找缓慢的依赖。
    - 检查它们是否有你可能希望考虑禁用的特性。
    - 考虑尝试完全删除依赖。
- 寻找crate在不同版本中被多次构建。尝试从依赖图中删除旧版本。
- 将大crate拆成小块。
- 如果有大量的crate在一个crate上出现瓶颈，那么就把注意力集中在改善这一crate上，以提高并行性。
{==+==}