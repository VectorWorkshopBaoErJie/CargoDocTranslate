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
要在 Travis CI 上测试你的 [包][def-package] ，这里有一个样例 `.travis.yml` 文件:
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
这将测试所有三个发行通道。在 nightly 中出现任何问题，不会导致整个构建失败。
请参阅 [Travis CI Rust documentation](https://docs.travis-ci.com/user/languages/rust/) 以获取更多信息。
{==+==}


{==+==}
### GitHub Actions
{==+==}
### GitHub Actions
{==+==}


{==+==}
To test your package on GitHub Actions, here is a sample `.github/workflows/ci.yml` file:
{==+==}
要在 Github Actions 中测试你的包，这里有一个样例 `.github/workflows/ci.yml` 文件:
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
这将测试所有三个发行渠道 (请注意，任何工具链版本的失败都会导致整个作业失败) 。
您也可以在 GitHub UI 中单击 `"Actions" > "new workflow"` ，然后选择 Rust 将 [default configuration](https://github.com/actions/starter-workflows/blob/main/ci/rust.yml) 添加到您的仓库中。有关更多信息，请参见 [GitHub Actions documentation](https://docs.github.com/en/actions) 。
{==+==}

{==+==}
### GitLab CI
{==+==}
### GitLab CI
{==+==}

{==+==}
To test your package on GitLab CI, here is a sample `.gitlab-ci.yml` file:
{==+==}
要在 GitLab CI 中测试你的包，这里有一个样例 `.gitlab-ci.yml` 文件:
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
这将在 stable 和 nightly 通道上进行测试，但任何 nightly 通道的破坏不会导致整体构建失败。
请参阅 [GitLab CI documentation](https://docs.gitlab.com/ce/ci/yaml/index.html) 获取更多信息。
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
以下是在 sr.ht 上测试你的包的示例 `.build.yml` 文件，记得将 `<your repo>` 和 `<your project>` 更改为要克隆的仓库和克隆到的目录。
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
这将在 stable 和 nightly 两个版本的通道上进行测试和文档构建，但 nightly 通道的任何故障都不会使整个构建失败。
请查看 [builds.sr.ht documentation](https://man.sr.ht/builds.sr.ht/) 以获取更多信息。
{==+==}

{==+==}
[def-package]:  ../appendix/glossary.md#package  '"package" (glossary entry)'
{==+==}

{==+==}
