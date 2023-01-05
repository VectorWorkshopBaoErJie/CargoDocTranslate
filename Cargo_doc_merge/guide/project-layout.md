## 项目结构

Cargo在文件布局上使用一系列约定，从而可以很容易地创建一个新的包:

```text
.
├── Cargo.lock
├── Cargo.toml
├── src/
│   ├── lib.rs
│   ├── main.rs
│   └── bin/
│       ├── named-executable.rs
│       ├── another-executable.rs
│       └── multi-file-executable/
│           ├── main.rs
│           └── some_module.rs
├── benches/
│   ├── large-input.rs
│   └── multi-file-bench/
│       ├── main.rs
│       └── bench_module.rs
├── examples/
│   ├── simple.rs
│   └── multi-file-example/
│       ├── main.rs
│       └── ex_module.rs
└── tests/
    ├── some-integration-tests.rs
    └── multi-file-test/
        ├── main.rs
        └── test_module.rs
```

*  `Cargo.toml` 和 `Cargo.lock` 保存在你包的根目录。
* 源代码放在`src`。
* 默认的库crate根文件是 `src/lib.rs` 。
* 默认的可执行crate根文件是 `src/main.rs` 。
    * 其他可执行crate文件可以放在 `src/bin/` 目录。
* Benchmarks放在 `benches` 目录。
* Examples放在 `examples` 目录.
* 集成测试文件放在 `tests` 目录.

如果一个binary、example、bench 或集成测试具有多个源文件，把 `main.rs` 和和其他模块([*modules*][def-module])一起放在原目录( `src/bin` 、`examples` 、`benches` 或 `tests` )的一个子目录下，可执行crate的名字就是该子目录的名字。

你可以在[the book][book-modules]中了解更多关于Rust模块系统的知识。

见[Configuring a target]一节中更多关于手动设置编译目标的细节。
见[Target auto-discovery]一节中更多关于控制Cargo如何自动推断目标名的知识。

[book-modules]: ../../book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
[Configuring a target]: ../reference/cargo-targets.md#configuring-a-target
[def-package]:           ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-module]:            ../appendix/glossary.md#module           '"module" (glossary entry)'
[Target auto-discovery]: ../reference/cargo-targets.md#target-auto-discovery
