{==+==}
## Package Layout
{==+==}
## 包的布局
{==+==}

{==+==}
Cargo uses conventions for file placement to make it easy to dive into a new
Cargo [package][def-package]:
{==+==}
Cargo在文件布局上使用一系列约定，从而可以容易地创建新的包:
{==+==}

{==+==}
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
{==+==}

{==+==}


{==+==}
* `Cargo.toml` and `Cargo.lock` are stored in the root of your package (*package
  root*).
* Source code goes in the `src` directory.
* The default library file is `src/lib.rs`.
* The default executable file is `src/main.rs`.
    * Other executables can be placed in `src/bin/`.
* Benchmarks go in the `benches` directory.
* Examples go in the `examples` directory.
* Integration tests go in the `tests` directory.
{==+==}
*  `Cargo.toml` 和 `Cargo.lock` 保存在你包的根目录。
* 源代码放在`src`。
* 默认的库crate根文件是 `src/lib.rs` 。
* 默认的可执行crate根文件是 `src/main.rs` 。
    * 其他可执行crate文件可以放在 `src/bin/` 目录。
* 基准放在 `benches` 目录。
* 示例放在 `examples` 目录.
* 集成测试文件放在 `tests` 目录.
{==+==}


{==+==}
If a binary, example, bench, or integration test consists of multiple source
files, place a `main.rs` file along with the extra [*modules*][def-module]
within a subdirectory of the `src/bin`, `examples`, `benches`, or `tests`
directory. The name of the executable will be the directory name.
{==+==}
如果一个binary、example、bench 或集成测试具有多个源文件，把 `main.rs` 和其他模块([*modules*][def-module])一起放在原目录( `src/bin` 、`examples` 、`benches` 或 `tests` )的一个子目录下，可执行crate的名字就是该子目录的名字。
{==+==}


{==+==}
You can learn more about Rust's module system in [the book][book-modules].
{==+==}
你可以在[the book][book-modules]中了解更多关于Rust模块系统的知识。
{==+==}


{==+==}
See [Configuring a target] for more details on manually configuring targets.
See [Target auto-discovery] for more information on controlling how Cargo
automatically infers target names.
{==+==}
见[Configuring a target]一节中更多关于手动设置编译目标的细节。
见[Target auto-discovery]一节中更多关于控制Cargo如何自动推断目标名的知识。
{==+==}


{==+==}
[book-modules]: ../../book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html
[Configuring a target]: ../reference/cargo-targets.md#configuring-a-target
[def-package]:           ../appendix/glossary.md#package          '"package" (glossary entry)'
[def-module]:            ../appendix/glossary.md#module           '"module" (glossary entry)'
[Target auto-discovery]: ../reference/cargo-targets.md#target-auto-discovery
{==+==}

{==+==}
