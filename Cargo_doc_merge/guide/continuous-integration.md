## 持续集成

### Travis CI

为了在 Travis CI 测试你的包，这里有一个样例配置文件 `.travis.yml` :

```yaml
language: rust
rust:
  - stable
  - beta
  - nightly
matrix:
  allow_failures:
    - rust: nightly
```

这将同时测试三个release channel，但是nightly中的问题不会导致整个构建的失败。查看[Travis CI Rust documentation](https://docs.travis-ci.com/user/languages/rust/)获得更多信息。

### GitHub Actions

为在Github Actions中测试你的包，这里有一个样例配置文件 `.github/workflows/ci.yml` :

```yaml
name: Cargo Build & Test

on:
  push:
  pull_request:

env: 
  CARGO_TERM_COLOR: always

jobs:
  build_and_test:
    name: Rust project - latest
    runs-on: ubuntu-latest
    strategy:
      matrix:
        toolchain:
          - stable
          - beta
          - nightly
    steps:
      - uses: actions/checkout@v3
      - run: rustup update ${{ matrix.toolchain }} && rustup default ${{ matrix.toolchain }}
      - run: cargo build --verbose
      - run: cargo test --verbose
  
```

这将测试全部的三个release channel(注意任意toolchain版本的失败会导致整个流程的失败)。你也可以在Github界面中点击 `"Actions" > "new workflow"`，并在其中选择Rust来为你的库添加[默认设置](https://github.com/actions/starter-workflows/blob/main/ci/rust.yml)。访问[GitHub Actions documentation](https://docs.github.com/en/actions)以获得更多信息。

### GitLab CI

为在GitLab CI测试你的包，这里有一个样例配置文件 `.gitlab-ci.yml` :

```yaml
stages:
  - build

rust-latest:
  stage: build
  image: rust:latest
  script:
    - cargo build --verbose
    - cargo test --verbose

rust-nightly:
  stage: build
  image: rustlang/rust:nightly
  script:
    - cargo build --verbose
    - cargo test --verbose
  allow_failure: true
```

这将测试 stable channel 和 nightly channel，但nightly中的任何失败不会导致整个构建的失败。请查看[GitLab CI documentation](https://docs.gitlab.com/ce/ci/yaml/index.html)获取更多信息。

### builds.sr.ht

为在 sr.ht 测试你的包，这里有一个样例设置文件 `.build.yml` 。
注意将 `<your repo>` 和 `<your project>` 修改为你要clone的库以及其被clone到的目录。

```yaml
image: archlinux
packages:
  - rustup
sources:
  - <your repo>
tasks:
  - setup: |
      rustup toolchain install nightly stable
      cd <your project>/
      rustup run stable cargo fetch
  - stable: |
      rustup default stable
      cd <your project>/
      cargo build --verbose
      cargo test --verbose
  - nightly: |
      rustup default nightly
      cd <your project>/
      cargo build --verbose ||:
      cargo test --verbose  ||:
  - docs: |
      cd <your project>/
      rustup run stable cargo doc --no-deps
      rustup run nightly cargo doc --no-deps ||:
```

这将为stable channel和nightly channel进行测试和构建文档，nightly上的问题不会导致整个构建的失败。请查看[builds.sr.ht documentation](https://man.sr.ht/builds.sr.ht/)以获取更多信息。

[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
