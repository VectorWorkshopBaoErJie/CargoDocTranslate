{==+==}
## Continuous Integration
{==+==}
## 持续集成
{==+==}

{==+==}
### Travis CI
{==+==}
### Travis CI
{==+==}

{==+==}
To test your [package][def-package] on Travis CI, here is a sample
`.travis.yml` file:
{==+==}
对于在 Travis CI 中测试你的包，这里有一个样例配置文件 `.travis.yml` :
{==+==}

{==+==}
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
{==+==}

{==+==}


{==+==}
This will test all three release channels, but any breakage in nightly
will not fail your overall build. Please see the [Travis CI Rust
documentation](https://docs.travis-ci.com/user/languages/rust/) for more
information.
{==+==}
这将同时测试三个发布通道，每日构建中的问题不会导致整个构建的失败。
查看 [Travis CI Rust documentation](https://docs.travis-ci.com/user/languages/rust/) 获得更多信息。
{==+==}


{==+==}
### GitHub Actions
{==+==}
### GitHub Actions
{==+==}


{==+==}
To test your package on GitHub Actions, here is a sample `.github/workflows/ci.yml` file:
{==+==}
对于 Github Actions 中测试你的包，这里有一个样例配置文件 `.github/workflows/ci.yml` :
{==+==}

{==+==}
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
{==+==}

{==+==}


{==+==}
This will test all three release channels (note a failure in any toolchain version will fail the entire job). You can also click `"Actions" > "new workflow"` in the GitHub UI and select Rust to add the [default configuration](https://github.com/actions/starter-workflows/blob/main/ci/rust.yml) to your repo. See [GitHub Actions documentation](https://docs.github.com/en/actions) for more information.
{==+==}
这将测试全部的三个发布通道(注意任意 toolchain 版本的失败会导致整个流程的失败)。
你也可以在 Github 界面中点击 `"Actions" > "new workflow"` ，
并在其中选择 Rust 来为你的库添加 [default configuration](https://github.com/actions/starter-workflows/blob/main/ci/rust.yml) "默认设置"。
访问 [GitHub Actions documentation](https://docs.github.com/en/actions) 以获得更多信息。
{==+==}

{==+==}
### GitLab CI
{==+==}
### GitLab CI
{==+==}

{==+==}
To test your package on GitLab CI, here is a sample `.gitlab-ci.yml` file:
{==+==}
对于在 GitLab CI 中测试你的包，这里有一个样例配置文件 `.gitlab-ci.yml` :
{==+==}


{==+==}
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
{==+==}

{==+==}


{==+==}
This will test on the stable channel and nightly channel, but any
breakage in nightly will not fail your overall build. Please see the
[GitLab CI documentation](https://docs.gitlab.com/ce/ci/yaml/index.html) for more
information.
{==+==}
这将测试 stable 通道和 nightly 通道，每日构建中的任何失败不会导致整个构建的失败。
请查看 [GitLab CI documentation](https://docs.gitlab.com/ce/ci/yaml/index.html) 获取更多信息。
{==+==}


{==+==}
### builds.sr.ht
{==+==}
### builds.sr.ht
{==+==}

{==+==}
To test your package on sr.ht, here is a sample `.build.yml` file.
Be sure to change `<your repo>` and `<your project>` to the repo to clone and
the directory where it was cloned.
{==+==}
对于在 sr.ht 中测试你的包，这里有一个样例设置文件 `.build.yml` 。
注意将 `<your repo>` 和 `<your project>` 修改为你要 clone 的库以及其被 clone 到的目录。
{==+==}


{==+==}
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
{==+==}

{==+==}


{==+==}
This will test and build documentation on the stable channel and nightly
channel, but any breakage in nightly will not fail your overall build. Please
see the [builds.sr.ht documentation](https://man.sr.ht/builds.sr.ht/) for more
information.
{==+==}
这将为 stable 通道和 nightly 通道进行测试和构建文档，每日构建中的问题不会导致整个构建的失败。
请查看 [builds.sr.ht documentation](https://man.sr.ht/builds.sr.ht/) 以获取更多信息。
{==+==}

{==+==}
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
{==+==}

{==+==}
