### 未来的不兼容报告

Cargo检查所有依赖中的未来不兼容的警告。
这些警告是关于未来可能成为硬性错误的修改，导致依赖在未来的rustc版本中停止构建。
如果发现任何警告，就会显示一个小通知，说明发现了这些警告，并提供如何显示完整报告的说明。

例如，你可能会在构建结束时看到这样的内容:

```text
warning: the following packages contain code that will be rejected by a future
         version of Rust: rental v0.5.5
note: to see what the problems were, use the option `--future-incompat-report`,
      or run `cargo report future-incompatibilities --id 1`
```

完整的报告可以通过 "cargo report future-incompatibilities --id ID" 命令来显示，或者通过使用 "--future-incompat-report" 标志再次运行构建。
然后，开发者应该将他们的依赖更新到问题得到修复的版本，或者与依赖的开发者合作，帮助解决这个问题。

## 配置

这个特性可以通过 `.cargo/config.toml` 中的[`[future-incompat-report]`][config]部分来进行配置。目前，支持的选项有:

```toml
[future-incompat-report]
frequency = "always"
```

支持的频次值是 `"always"` 和 `"never"` ，它们控制在 `cargo build` / `cargo check` 结束时是否打印出信息。

[config]: config.md#future-incompat-report
