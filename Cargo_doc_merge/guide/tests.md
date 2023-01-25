## 测试

可以使用 `cargo test` 命令来运行你的测试(test)。Cargo 在两个地方查找测试内容： 1. `src` 中的每个文件；2.  `test` 目录中的测试项目。 `src` 中的测试是单元测试和文档测试([documentation tests])。 `tests` 中的测试是集成测试，因此你需要把crate导入(import)到 `tests` 中的文件。

下面的例子中对[包][def-package]执行 `cargo test` ，目前这个包里还没有任何测试项。

```console
$ cargo test
   Compiling regex v1.5.0 (https://github.com/rust-lang/regex.git#9f9f693)
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
     Running target/test/hello_world-9c2b65bbb79eabce

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

如果我们的包中有测试项，就可以看到更多数输出内容。

你也可以通过过滤，来运行指定的测试:

```console
$ cargo test foo
```

这种情况下会执行所有名字中包含 `foo` 的测试。

`cargo test` 会进行额外的检查。Cargo会编译每个示例，确保它们可以通过编译。同时也会运行文档测试来确保文档中的代码样例可以通过编译。
Rust文档中的[testing guide][testing]部分可以获取更多关于组织测试的知识。[Cargo Targets: Tests]中可以学到Cargo中更多不同的测试种类。

[documentation tests]: ../../rustdoc/write-documentation/documentation-tests.html
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
[testing]: ../../book/ch11-00-testing.html
[Cargo Targets: Tests]: ../reference/cargo-targets.html#tests
