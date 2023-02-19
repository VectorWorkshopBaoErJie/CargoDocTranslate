{==+==}
## Tests
{==+==}
## 测试
{==+==}

{==+==}
Cargo can run your tests with the `cargo test` command. Cargo looks for tests
to run in two places: in each of your `src` files and any tests in `tests/`.
Tests in your `src` files should be unit tests and [documentation tests].
Tests in `tests/` should be integration-style tests. As such, you’ll need to
import your crates into the files in `tests`.
{==+==}
Cargo 可以通过 `cargo test` 命令运行您的测试。
Cargo 在两个地方寻找测试来运行：您的 `src` 文件中的每个测试和 `tests/` 目录中的任何测试。
`src` 文件中的测试应该是单元测试和 [文档测试][documentation tests] 。`tests/` 中的测试应该是集成测试。
因此，您需要将您的 crate 导入到 `tests` 文件中。
{==+==}


{==+==}
Here's an example of running `cargo test` in our [package][def-package], which
currently has no tests:
{==+==}
以下是对应包中执行 `cargo test` 的例子，这个包目前还没有测试项:
{==+==}

{==+==}
```console
$ cargo test
   Compiling regex v1.5.0 (https://github.com/rust-lang/regex.git#9f9f693)
   Compiling hello_world v0.1.0 (file:///path/to/package/hello_world)
     Running target/test/hello_world-9c2b65bbb79eabce

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```
{==+==}

{==+==}


{==+==}
If our package had tests, we would see more output with the correct number of
tests.
{==+==}
如果包含有测试项，将会看到更多的输出，其中包含测试正确的数量。
{==+==}


{==+==}
You can also run a specific test by passing a filter:
{==+==}
你也可以通过过滤，来运行指定的测试:
{==+==}


{==+==}
```console
$ cargo test foo
```
{==+==}

{==+==}


{==+==}
This will run any test with `foo` in its name.
{==+==}
这种情况会执行所有名字中包含 `foo` 的测试。
{==+==}


{==+==}
`cargo test` runs additional checks as well. It will compile any examples
you’ve included to ensure they still compile. It also runs documentation
tests to ensure your code samples from documentation comments compile.
Please see the [testing guide][testing] in the Rust documentation for a general
view of writing and organizing tests. See [Cargo Targets: Tests] to learn more
about different styles of tests in Cargo.
{==+==}
`cargo test` 不仅运行单元测试和集成测试，还会执行其他检查。它将编译您包含的示例，以确保它们能够通过编译。
它还运行文档测试，以确保文档注释中的代码示例可以编译。请查看 Rust 文档中的 [测试指南][testing] 了解编写和组织测试的相关内容。
请查看 [Cargo Targets: Tests] 了解 Cargo 中不同测试样式的更多信息。
{==+==}


{==+==}
[documentation tests]: ../../rustdoc/write-documentation/documentation-tests.html
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
[testing]: ../../book/ch11-00-testing.html
[Cargo Targets: Tests]: ../reference/cargo-targets.html#tests
{==+==}

{==+==}

