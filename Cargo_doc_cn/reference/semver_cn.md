{==+==}
# SemVer Compatibility
{==+==}
# 语义化兼容性
{==+==}


{==+==}
This chapter provides details on what is conventionally considered a
compatible or breaking SemVer change for new releases of a package. See the
[SemVer compatibility] section for details on what SemVer is, and how Cargo
uses it to ensure compatibility of libraries.
{==+==}
本章详细介绍了对于新发布的包，什么是传统意义上的兼容或破坏性的语义化版本变化。
关于什么是语义化版本，以及Cargo如何使用它来确保库的兼容性，请参阅[SemVer compatibility]部分。
{==+==}


{==+==}
These are only *guidelines*, and not necessarily hard-and-fast rules that all
projects will obey. The [Change categories] section details how this guide
classifies the level and severity of a change. Most of this guide focuses on
changes that will cause `cargo` and `rustc` to fail to build something that
previously worked. Almost every change carries some risk that it will
negatively affect the runtime behavior, and for those cases it is usually a
judgment call by the project maintainers whether or not it is a
SemVer-incompatible change.
{==+==}
这些只是*准则*，而不一定是所有项目都会遵守的硬性规定。
[Change categories]部分详细说明了本指南如何对变更的级别和严重程度进行分类。
本指南的大部分内容都集中在那些会导致 `cargo` 和 `rustc` 不能构建以前正常工作的内容的变化。
几乎所有的改变都有可能对运行时的行为产生负面影响，对于这些情况，通常由项目维护者判断是否属于语义化不兼容的改变。
{==+==}


{==+==}
See also [rust-semverver], which is an experimental tool that attempts to
programmatically check compatibility rules.
{==+==}
也可以参见[rust-semverver]，它是一个实验性的工具，试图以编程方式检查兼容性规则。
{==+==}


{==+==}
[Change categories]: #change-categories
[rust-semverver]: https://github.com/rust-lang/rust-semverver
[SemVer compatibility]: resolver.md#semver-compatibility
{==+==}

{==+==}


{==+==}
## Change categories
{==+==}
## 更改类别
{==+==}


{==+==}
All of the policies listed below are categorized by the level of change:
{==+==}
下面列出的所有策略都是按变化的级别来分类的:
{==+==}


{==+==}
* **Major change**: a change that requires a major SemVer bump.
* **Minor change**: a change that requires only a minor SemVer bump.
* **Possibly-breaking change**: a change that some projects may consider major
  and others consider minor.
{==+==}
* **Major change**: 这种变化需要语义化版本的重要改变。
* **Minor change**: 这种变化只需要在语义化版本上做小改动。
* **Possibly-breaking change**: 一些项目可能认为是大的变化，另一些则认为是小的变化。
{==+==}


{==+==}
The "Possibly-breaking" category covers changes that have the *potential* to
break during an update, but may not necessarily cause a breakage. The impact
of these changes should be considered carefully. The exact nature will depend
on the change and the principles of the project maintainers.
{==+==}
"可能破坏" 类别涵盖了在更新期间有*潜在*破坏的变化，但不一定会导致破坏。
这些变化的影响应该被仔细考虑。确切的性质将取决于该变化和项目维护者的原则。
{==+==}


{==+==}
Some projects may choose to only bump the patch number on a minor change. It
is encouraged to follow the SemVer spec, and only apply bug fixes in patch
releases. However, a bug fix may require an API change that is marked as a
"minor change", and shouldn't affect compatibility. This guide does not take a
stance on how each individual "minor change" should be treated, as the
difference between minor and patch changes are conventions that depend on the
nature of the change.
{==+==}
有些项目可能会选择只在一个小的变化上增加补丁号。我们鼓励遵循语义化规范，只在补丁版本中应用错误修复。
然而，一个错误的修复可能需要一个被标记为 "次要改动" 的API变化，并且不应该影响兼容性。
本指南不对每个 "次要改动" 应如何处理采取立场，因为次要改动和补丁改动之间的区别是取决于改动的性质的惯例。
{==+==}


{==+==}
Some changes are marked as "minor", even though they carry the potential risk
of breaking a build. This is for situations where the potential is extremely
low, and the potentially breaking code is unlikely to be written in idiomatic
Rust, or is specifically discouraged from use.
{==+==}
有些改动被标记为 "次要"，即使它们有破坏构建的潜在风险。
这适用于潜在风险极低的情况，而且可能破坏的代码不太可能用习惯性的Rust编写，或者去特别强调不使用。
{==+==}


{==+==}
This guide uses the terms "major" and "minor" assuming this relates to a
"1.0.0" release or later. Initial development releases starting with "0.y.z"
can treat changes in "y" as a major release, and "z" as a minor release.
"0.0.z" releases are always major changes. This is because Cargo uses the
convention that only changes in the left-most non-zero component are
considered incompatible.
{==+==}
本指南使用 "主要" 和 "次要" 这两个术语是假设这与 "1.0.0" 或更高版本有关。从 "0.y.z" 开始的初始开发版本可以把 "y" 中的变化作为主要版本，而把 "z" 作为次要版本。
"0.0.z" 版本总是主要变化。这是因为Cargo使用的惯例是，只有最左边的非零部分中的变化才被认为是不兼容的。
{==+==}


{==+==}
* API compatibility
    * Items
        * [Major: renaming/moving/removing any public items](#item-remove)
        * [Minor: adding new public items](#item-new)
{==+==}
* API 兼容性
    * 条目
        * [Major: 重命名/移动/移除任何公共条目](#item-remove)
        * [Minor: 添加新的公开条目](#item-new)
{==+==}


{==+==}
    * Structs
        * [Major: adding a private struct field when all current fields are public](#struct-add-private-field-when-public)
        * [Major: adding a public field when no private field exists](#struct-add-public-field-when-no-private)
        * [Minor: adding or removing private fields when at least one already exists](#struct-private-fields-with-private)
        * [Minor: going from a tuple struct with all private fields (with at least one field) to a normal struct, or vice versa](#struct-tuple-normal-with-private)
{==+==}
    * Structs
        * [Major: 当所有当前字段都为公共时，添加私有结构体字段](#struct-add-private-field-when-public)
        * [Major: 在没有私有字段时添加公共字段](#struct-add-public-field-when-no-private)
        * [Minor: 当至少有一个私有字段存在时添加或删除私有字段](#struct-private-fields-with-private)
        * [Minor: 从一个包含所有私有字段(至少包含一个字段)的元组结构体到一个普通结构体，反之亦然](#struct-tuple-normal-with-private)
{==+==}


{==+==}
    * Enums
        * [Major: adding new enum variants (without `non_exhaustive`)](#enum-variant-new)
        * [Major: adding new fields to an enum variant](#enum-fields-new)
{==+==}
    * Enums
        * [Major: 添加新的枚举变量(没有 `non_exhaustive`)](#enum-variant-new)
        * [Major: 向枚举变量添加新字段](#enum-fields-new)
{==+==}


{==+==}
    * Traits
        * [Major: adding a non-defaulted trait item](#trait-new-item-no-default)
        * [Major: any change to trait item signatures](#trait-item-signature)
        * [Possibly-breaking: adding a defaulted trait item](#trait-new-default-item)
        * [Major: adding a trait item that makes the trait non-object safe](#trait-object-safety)
        * [Major: adding a type parameter without a default](#trait-new-parameter-no-default)
        * [Minor: adding a defaulted trait type parameter](#trait-new-parameter-default)
{==+==}
    * Traits
        * [Major: 添加非默认的trait条目](#trait-new-item-no-default)
        * [Major: trait条目签名任何变化](#trait-item-signature)
        * [Possibly-breaking: 添加默认trait条目](#trait-new-default-item)
        * [Major: 添加trait条目使trait非对象安全](#trait-object-safety)
        * [Major: 添加没有默认的类型参数](#trait-new-parameter-no-default)
        * [Minor: 增加默认的trait类型参数](#trait-new-parameter-default)
{==+==}


{==+==}
    * Implementations
        * [Possibly-breaking change: adding any inherent items](#impl-item-new)
{==+==}
    * Implementations
        * [Possibly-breaking change: 添加任何内部条目](#impl-item-new)
{==+==}


{==+==}
    * Generics
        * [Major: tightening generic bounds](#generic-bounds-tighten)
        * [Minor: loosening generic bounds](#generic-bounds-loosen)
        * [Minor: adding defaulted type parameters](#generic-new-default)
        * [Minor: generalizing a type to use generics (with identical types)](#generic-generalize-identical)
        * [Major: generalizing a type to use generics (with possibly different types)](#generic-generalize-different)
        * [Minor: changing a generic type to a more generic type](#generic-more-generic)
{==+==}
    * Generics
        * [Major: 收紧泛型边界](#generic-bounds-tighten)
        * [Minor: 放宽泛型边界](#generic-bounds-loosen)
        * [Minor: 添加默认类型参数](#generic-new-default)
        * [Minor: 泛化类型以使用泛型(具有等同类型)](#generic-generalize-identical)
        * [Major: 泛化类型以使用泛型(可能有不同的类型)](#generic-generalize-different)
        * [Minor: 将泛化类型改为更泛化的类型](#generic-more-generic)
{==+==}


{==+==}
    * Functions
        * [Major: adding/removing function parameters](#fn-change-arity)
        * [Possibly-breaking: introducing a new function type parameter](#fn-generic-new)
        * [Minor: generalizing a function to use generics (supporting original type)](#fn-generalize-compatible)
        * [Major: generalizing a function to use generics with type mismatch](#fn-generalize-mismatch)
{==+==}
    * Functions
        * [Major: 添加/删除函数参数](#fn-change-arity)
        * [Possibly-breaking: 引入新的函数类型参数](#fn-generic-new)
        * [Minor: 泛化函数以使用泛型(支持原始类型)](#fn-generalize-compatible)
        * [Major: 泛化函数以使用类型不匹配的泛型](#fn-generalize-mismatch)
{==+==}


{==+==}
    * Attributes
        * [Major: switching from `no_std` support to requiring `std`](#attr-no-std-to-std)
{==+==}
    * Attributes
        * [Major: 从 `no_std` 切换到要求 `std` ](#attr-no-std-to-std)
{==+==}


{==+==}
* Tooling and environment compatibility
    * [Possibly-breaking: changing the minimum version of Rust required](#env-new-rust)
    * [Possibly-breaking: changing the platform and environment requirements](#env-change-requirements)
{==+==}
* 工具和环境的兼容性
    * [Possibly-breaking: 改变所需的最小Rust版本](#env-new-rust)
    * [Possibly-breaking: 改变平台和环境要求](#env-change-requirements)
{==+==}


{==+==}
    * Cargo
        * [Minor: adding a new Cargo feature](#cargo-feature-add)
        * [Major: removing a Cargo feature](#cargo-feature-remove)
        * [Major: removing a feature from a feature list if that changes functionality or public items](#cargo-feature-remove-another)
        * [Possibly-breaking: removing an optional dependency](#cargo-remove-opt-dep)
        * [Minor: changing dependency features](#cargo-change-dep-feature)
        * [Minor: adding dependencies](#cargo-dep-add)
* [Application compatibility](#application-compatibility)
{==+==}
    * Cargo
        * [Minor: 增加新的Cargo特性](#cargo-feature-add)
        * [Major: 删除Cargo特性](#cargo-feature-remove)
        * [Major: 如果改变了特性或公共条目，从特性列表中删除一个特性](#cargo-feature-remove-another)
        * [Possibly-breaking: 删除可选的依赖](#cargo-remove-opt-dep)
        * [Minor: 改变依赖特性](#cargo-change-dep-feature)
        * [Minor: 添加依赖](#cargo-dep-add)
* [应用程序兼容性](#application-compatibility)
{==+==}


{==+==}
## API compatibility
{==+==}
## API兼容性
{==+==}


{==+==}
All of the examples below contain three parts: the original code, the code
after it has been modified, and an example usage of the code that could appear
in another project. In a minor change, the example usage should successfully
build with both the before and after versions.
{==+==}
下面所有的例子都包含三个部分：原始代码，修改后的代码，以及可能出现在另一个项目中的代码使用范例。
在次要改动中，示例用法应该成功地与前后两个版本一起构建。
{==+==}


{==+==}
<a id="item-remove"></a>
### Major: renaming/moving/removing any public items
{==+==}
<a id="item-remove"></a>
### Major: 重新命名/移动/删除任意公共条目
{==+==}


{==+==}
The absence of a publicly exposed [item][items] will cause any uses of that item to
fail to compile.
{==+==}
缺失公开暴露[条目][items]将导致对该条目的任何使用无法编译。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub fn foo() {}

///////////////////////////////////////////////////////////
// After
// ... item has been removed

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    updated_crate::foo(); // Error: cannot find function `foo`
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub fn foo() {}

///////////////////////////////////////////////////////////
// 之后
// ... 条目被移除

///////////////////////////////////////////////////////////
// 示例：将打破用法。
fn main() {
    updated_crate::foo(); // Error: 不能找到函数 `foo`
}
```
{==+==}


{==+==}
This includes adding any sort of [`cfg` attribute] which can change which
items or behavior is available based on [conditional compilation].
{==+==}
这包括添加任何种类的[`cfg` 属性]，它可以根据[conditional compilation] "条件编译"改变哪些条目或行为是可用的。
{==+==}


{==+==}
Mitigating strategies:
* Mark items to be removed as [deprecated], and then remove them at a later
  date in a SemVer-breaking release.
* Mark renamed items as [deprecated], and use a [`pub use`] item to re-export
  to the old name.
{==+==}
缓和策略:
* 将要删除的条目标记为[deprecated]，然后在以后的语义化版本打破性发布中删除它们。
* 将重命名的条目标记为[deprecated]，并使用 [`pub use`] 条目来重新输出旧名称。
{==+==}


{==+==}
<a id="item-new"></a>
### Minor: adding new public items
{==+==}
<a id="item-new"></a>
### Minor: 添加新公共条目
{==+==}


{==+==}
Adding new, public [items] is a minor change.
{==+==}
增加新的、公开的[items]是次要变化。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
// ... absence of item

///////////////////////////////////////////////////////////
// After
pub fn foo() {}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
// `foo` is not used since it didn't previously exist.
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
// ... 缺少条目

///////////////////////////////////////////////////////////
// 之后
pub fn foo() {}

///////////////////////////////////////////////////////////
// 示例：库的使用将安全工作。
// `foo` 没有被使用，因为它之前并不存在。
```
{==+==}


{==+==}
Note that in some rare cases this can be a **breaking change** due to glob
imports. For example, if you add a new trait, and a project has used a glob
import that brings that trait into scope, and the new trait introduces an
associated item that conflicts with any types it is implemented on, this can
cause a compile-time error due to the ambiguity. Example:
{==+==}
请注意，在某些少见的情况下，由于通配符导入的原因，这可能是*破坏性*改变。例如，如果你添加了一个新的特性，
而一个条目使用了一个将该特性带入范围的通配符导入，并且这个新的特性引入了一个与它所实现的任意类型相冲突的关联项，这可能会因为这种混淆而导致编译时错误。例子:
{==+==}


{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// Before
// ... absence of trait

///////////////////////////////////////////////////////////
// After
pub trait NewTrait {
    fn foo(&self) {}
}

impl NewTrait for i32 {}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::*;

pub trait LocalTrait {
    fn foo(&self) {}
}

impl LocalTrait for i32 {}

fn main() {
    123i32.foo(); // Error:  multiple applicable items in scope
}
```
{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// 之前
// ... 缺少trait

///////////////////////////////////////////////////////////
// 之后
pub trait NewTrait {
    fn foo(&self) {}
}

impl NewTrait for i32 {}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::*;

pub trait LocalTrait {
    fn foo(&self) {}
}

impl LocalTrait for i32 {}

fn main() {
    123i32.foo(); // Error:  在作用域有多个适用的条目
}
```
{==+==}


{==+==}
This is not considered a major change because conventionally glob imports are
a known forwards-compatibility hazard. Glob imports of items from external
crates should be avoided.
{==+==}
这并不被认为是重要改变，因为通常通配符导入是一个已知的向前兼容的风险。应该避免从外部crate中导入条目的通配符。
{==+==}


{==+==}
<a id="struct-add-private-field-when-public"></a>
### Major: adding a private struct field when all current fields are public
{==+==}
<a id="struct-add-private-field-when-public"></a>
### Major: 当当前所有字段都是公共的时候，添加私有结构体字段
{==+==}


{==+==}
When a private field is added to a struct that previously had all public fields,
this will break any code that attempts to construct it with a [struct literal].
{==+==}
当私有字段被添加到之前拥有所有公共字段的结构体中时。
这将破坏任何试图用[struct literal]"结构体字面量"来构建该结构体的代码。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo {
    pub f1: i32,
}

///////////////////////////////////////////////////////////
// After
pub struct Foo {
    pub f1: i32,
    f2: i32,
}

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    let x = updated_crate::Foo { f1: 123 }; // Error: cannot construct `Foo`
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo {
    pub f1: i32,
}

///////////////////////////////////////////////////////////
// 之后
pub struct Foo {
    pub f1: i32,
    f2: i32,
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    let x = updated_crate::Foo { f1: 123 }; // Error: 不能构建 `Foo`
}
```
{==+==}


{==+==}
Mitigation strategies:
* Do not add new fields to all-public field structs.
* Mark structs as [`#[non_exhaustive]`][non_exhaustive] when first introducing
  a struct to prevent users from using struct literal syntax, and instead
  provide a constructor method and/or [Default] implementation.
{==+==}
缓和策略:
* 不要向所有公共字段的结构体添加新字段。
* 在首次引入结构体时，将结构标记为[`#[non_exhaustive]`][non_exhaustive]，
  以阻止用户使用结构字面量语法，而是提供构造方法或 [Default] 实现。
{==+==}


{==+==}
<a id="struct-add-public-field-when-no-private"></a>
### Major: adding a public field when no private field exists
{==+==}
<a id="struct-add-public-field-when-no-private"></a>
### Major: 在不存在私有字段的情况下添加公共字段
{==+==}


{==+==}
When a public field is added to a struct that has all public fields, this will
break any code that attempts to construct it with a [struct literal].
{==+==}
当公共字段被添加到拥有所有公共字段的结构体中时，这将破坏任何试图用[struct literal]"结构体字面量"来构建它的代码。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo {
    pub f1: i32,
}

///////////////////////////////////////////////////////////
// After
pub struct Foo {
    pub f1: i32,
    pub f2: i32,
}

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    let x = updated_crate::Foo { f1: 123 }; // Error: missing field `f2`
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo {
    pub f1: i32,
}

///////////////////////////////////////////////////////////
// 之后
pub struct Foo {
    pub f1: i32,
    pub f2: i32,
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    let x = updated_crate::Foo { f1: 123 }; // Error: 缺失 `f2` 字段
}
```
{==+==}


{==+==}
Mitigation strategies:
* Do not add new new fields to all-public field structs.
* Mark structs as [`#[non_exhaustive]`][non_exhaustive] when first introducing
  a struct to prevent users from using struct literal syntax, and instead
  provide a constructor method and/or [Default] implementation.
{==+==}
缓和策略:
* 不要向所有公共字段结构体添加新字段。
* 在首次引入结构体时，将结构体标记为[`#[non_exhaustive]`][non_exhaustive]，
  以阻止用户使用结构体字面量语法，而是提供构造方法或[Default]实现。
{==+==}


{==+==}
<a id="struct-private-fields-with-private"></a>
### Minor: adding or removing private fields when at least one already exists
{==+==}
<a id="struct-private-fields-with-private"></a>
### Minor: 当至少有一个私有字段存在时添加或删除私有字段
{==+==}


{==+==}
It is safe to add or remove private fields from a struct when the struct
already has at least one private field.
{==+==}
当结构已经至少有一个私有字段时，从结构中添加或删除私有字段是安全的。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
#[derive(Default)]
pub struct Foo {
    f1: i32,
}

///////////////////////////////////////////////////////////
// After
#[derive(Default)]
pub struct Foo {
    f2: f64,
}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
fn main() {
    // Cannot access private fields.
    let x = updated_crate::Foo::default();
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
#[derive(Default)]
pub struct Foo {
    f1: i32,
}

///////////////////////////////////////////////////////////
// 之后
#[derive(Default)]
pub struct Foo {
    f2: f64,
}

///////////////////////////////////////////////////////////
// 示例： 使用库将是安全的。
fn main() {
    // 不能访问私有字段。
    let x = updated_crate::Foo::default();
}
```
{==+==}


{==+==}
This is safe because existing code cannot use a [struct literal] to construct
it, nor exhaustively match its contents.
{==+==}
这是安全的，因为现有的代码不能使用[struct literal]来构造它，无需彻底匹配其内容。
{==+==}


{==+==}
Note that for tuple structs, this is a **major change** if the tuple contains
public fields, and the addition or removal of a private field changes the
index of any public field.
{==+==}
请注意，对于元组结构体来说，如果元组包含公共字段，增加或删除私有字段会改变任何公共字段的索引，将是 **major变化** 。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
#[derive(Default)]
pub struct Foo(pub i32, i32);

///////////////////////////////////////////////////////////
// After
#[derive(Default)]
pub struct Foo(f64, pub i32, i32);

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    let x = updated_crate::Foo::default();
    let y = x.0; // Error: is private
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
#[derive(Default)]
pub struct Foo(pub i32, i32);

///////////////////////////////////////////////////////////
// 之后
#[derive(Default)]
pub struct Foo(f64, pub i32, i32);

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    let x = updated_crate::Foo::default();
    let y = x.0; // Error: 是私有的。
}
```
{==+==}


{==+==}
<a id="struct-tuple-normal-with-private"></a>
### Minor: going from a tuple struct with all private fields (with at least one field) to a normal struct, or vice versa
{==+==}
<a id="struct-tuple-normal-with-private"></a>
### Minor: 从具有所有私有字段的元组结构体(至少有一个字段)到正常的结构体。
{==+==}


{==+==}
Changing a tuple struct to a normal struct (or vice-versa) is safe if all
fields are private.
{==+==}
如果所有字段都是私有的，那么将元组结构体改变为普通结构体是安全的，反之亦然。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
#[derive(Default)]
pub struct Foo(i32);

///////////////////////////////////////////////////////////
// After
#[derive(Default)]
pub struct Foo {
    f1: i32,
}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
fn main() {
    // Cannot access private fields.
    let x = updated_crate::Foo::default();
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
#[derive(Default)]
pub struct Foo(i32);

///////////////////////////////////////////////////////////
// 之后
#[derive(Default)]
pub struct Foo {
    f1: i32,
}

///////////////////////////////////////////////////////////
// 示例：库的使用将是安全的。
fn main() {
    // 不能访问私有字段。
    let x = updated_crate::Foo::default();
}
```
{==+==}


{==+==}
This is safe because existing code cannot use a [struct literal] to construct
it, nor match its contents.
{==+==}
这是安全的，因为当前的代码不能使用[struct literal]来构造它，不能匹配它的内容。
{==+==}


{==+==}
<a id="enum-variant-new"></a>
### Major: adding new enum variants (without `non_exhaustive`)
{==+==}
<a id="enum-variant-new"></a>
### Major: 添加新的枚举条目 (没有 `non_exhaustive` ) 。
{==+==}


{==+==}
It is a breaking change to add a new enum variant if the enum does not use the
[`#[non_exhaustive]`][non_exhaustive] attribute.
{==+==}
如果枚举未使用[`#[non_exhaustive]`][non_exhaustive]属性，增加新的枚举条目是破坏性的改变。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub enum E {
    Variant1,
}

///////////////////////////////////////////////////////////
// After
pub enum E {
    Variant1,
    Variant2,
}

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    use updated_crate::E;
    let x = E::Variant1;
    match x { // Error: `E::Variant2` not covered
        E::Variant1 => {}
    }
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub enum E {
    Variant1,
}

///////////////////////////////////////////////////////////
// 之后
pub enum E {
    Variant1,
    Variant2,
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    use updated_crate::E;
    let x = E::Variant1;
    match x { // Error: `E::Variant2` 未涵盖
        E::Variant1 => {}
    }
}
```
{==+==}


{==+==}
Mitigation strategies:
* When introducing the enum, mark it as [`#[non_exhaustive]`][non_exhaustive]
  to force users to use [wildcard patterns] to catch new variants.
{==+==}
缓和策略:
* 在引入枚举时，将其标记为[`#[non_exhaustive]`][non_exhaustive]，以迫使用户使用[通配符模式]来捕获新的变体。
{==+==}


{==+==}
<a id="enum-fields-new"></a>
### Major: adding new fields to an enum variant
{==+==}
<a id="enum-fields-new"></a>
### Major: 向枚举变量添加新字段
{==+==}


{==+==}
It is a breaking change to add new fields to an enum variant because all
fields are public, and constructors and matching will fail to compile.
{==+==}
在枚举变体中添加新的字段是一种破坏性的改变，因为所有的字段都是公开的，构造函数和匹配将无法编译。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub enum E {
    Variant1 { f1: i32 },
}

///////////////////////////////////////////////////////////
// After
pub enum E {
    Variant1 { f1: i32, f2: i32 },
}

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    use updated_crate::E;
    let x = E::Variant1 { f1: 1 }; // Error: missing f2
    match x {
        E::Variant1 { f1 } => {} // Error: missing f2
    }
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub enum E {
    Variant1 { f1: i32 },
}

///////////////////////////////////////////////////////////
// 之后
pub enum E {
    Variant1 { f1: i32, f2: i32 },
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    use updated_crate::E;
    let x = E::Variant1 { f1: 1 }; // Error: 缺失 f2
    match x {
        E::Variant1 { f1 } => {} // Error: 缺失 f2
    }
}
```
{==+==}


{==+==}
Mitigation strategies:
* When introducing the enum, mark the variant as [`non_exhaustive`][non_exhaustive]
  so that it cannot be constructed or matched without wildcards.
  ```rust,ignore,skip
  pub enum E {
      #[non_exhaustive]
      Variant1{f1: i32}
  }
{==+==}
缓和策略:
* 在引入枚举时，将变体标记为[`non_exhaustive`][non_exhaustive]，使其没有通配符的情况下不能构建或匹配它。
  ```rust,ignore,skip
  pub enum E {
      #[non_exhaustive]
      Variant1{f1: i32}
  }
{==+==}


{==+==}
  ```
* When introducing the enum, use an explicit struct as a value, where you can
  have control over the field visibility.
  ```rust,ignore,skip
  pub struct Foo {
     f1: i32,
     f2: i32,
  }
  pub enum E {
      Variant1(Foo)
  }
  ```
{==+==}
  ```
* 在引入枚举时，使用显式结构体作为值，在这里你可以对字段可见性进行控制。
  ```rust,ignore,skip
  pub struct Foo {
     f1: i32,
     f2: i32,
  }
  pub enum E {
      Variant1(Foo)
  }
  ```
{==+==}


{==+==}
<a id="trait-new-item-no-default"></a>
### Major: adding a non-defaulted trait item
{==+==}
<a id="trait-new-item-no-default"></a>
### Major: 添加非默认的trait条目
{==+==}


{==+==}
It is a breaking change to add a non-defaulted item to a trait. This will
break any implementors of the trait.
{==+==}
在特性中添加非默认的条目是一种破坏性的改变。这将破坏该特性的任何实现者。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}

///////////////////////////////////////////////////////////
// After
pub trait Trait {
    fn foo(&self);
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}  // Error: not all trait items implemented
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait {
    fn foo(&self);
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}  // Error: 未实现所有trait条目
```
{==+==}


{==+==}
Mitigation strategies:
* Always provide a default implementation or value for new associated trait
  items.
* When introducing the trait, use the [sealed trait] technique to prevent
  users outside of the crate from implementing the trait.
{==+==}
缓和策略:
* 始终为新的相关trait条目提供默认的实现或值。
* 在引入trait时，使用[sealed trait]技术来防止crate外的用户实现该trait。
{==+==}


{==+==}
<a id="trait-item-signature"></a>
### Major: any change to trait item signatures
{==+==}
<a id="trait-item-signature"></a>
### Major: trait条目签名的任何变化
{==+==}


{==+==}
It is a breaking change to make any change to a trait item signature. This can
break external implementors of the trait.
{==+==}
对trait条目的签名做任何改变都是破坏性的。可能会破坏该trait的外部实现者。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {
    fn f(&self, x: i32) {}
}

///////////////////////////////////////////////////////////
// After
pub trait Trait {
    // For sealed traits or normal functions, this would be a minor change
    // because generalizing with generics strictly expands the possible uses.
    // But in this case, trait implementations must use the same signature.
    fn f<V>(&self, x: V) {}
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {
    fn f(&self, x: i32) {}  // Error: trait declaration has 1 type parameter
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {
    fn f(&self, x: i32) {}
}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait {
    // 对于密封的trait或普通函数，这将是次要变化，因为用泛型来泛化严格地扩展了可能的用法。
    // 但在这种情况下，trait的实现必须使用相同的签名。
    fn f<V>(&self, x: V) {}
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {
    fn f(&self, x: i32) {}  // Error: trait 声明有1个类型参数
}
```
{==+==}


{==+==}
Mitigation strategies:
* Introduce new items with default implementations to cover the new
  functionality instead of modifying existing items.
* When introducing the trait, use the [sealed trait] technique to prevent
  users outside of the crate from implementing the trait.
{==+==}
缓和策略:
* 引入带有默认实现的新条目，以涵盖新功能，而不是修改现有条目。
* 当引入该trait时，使用[sealed trait]来防止crate外的用户实现该trait。
{==+==}


{==+==}
<a id="trait-new-default-item"></a>
### Possibly-breaking: adding a defaulted trait item
{==+==}
<a id="trait-new-default-item"></a>
### Possibly-breaking: 添加默认的trait条目
{==+==}


{==+==}
It is usually safe to add a defaulted trait item. However, this can sometimes
cause a compile error. For example, this can introduce an ambiguity if a
method of the same name exists in another trait.
{==+==}
添加默认的trait条目通常是安全的。然而，这有时会导致编译错误。
例如，如果在另一个trait中存在同名的方法，则会引入混淆。
{==+==}


{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}

///////////////////////////////////////////////////////////
// After
pub trait Trait {
    fn foo(&self) {}
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Trait;
struct Foo;

trait LocalTrait {
    fn foo(&self) {}
}

impl Trait for Foo {}
impl LocalTrait for Foo {}

fn main() {
    let x = Foo;
    x.foo(); // Error: multiple applicable items in scope
}
```
{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait {
    fn foo(&self) {}
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::Trait;
struct Foo;

trait LocalTrait {
    fn foo(&self) {}
}

impl Trait for Foo {}
impl LocalTrait for Foo {}

fn main() {
    let x = Foo;
    x.foo(); // Error: 作用域内有多个符合条目
}
```
{==+==}


{==+==}
Note that this ambiguity does *not* exist for name collisions on [inherent
implementations], as they take priority over trait items.
{==+==}
注意，这种二义性并不存在于[inherent implementations]的名称冲突，因为它们优先于trait条目。
{==+==}


{==+==}
See [trait-object-safety](#trait-object-safety) for a special case to consider
when adding trait items.
{==+==}
参见[trait-object-safety](#trait-object-safety)，了解添加trait条目时需要考虑的特殊情况。
{==+==}


{==+==}
Mitigation strategies:
* Some projects may deem this acceptable breakage, particularly if the new
  item name is unlikely to collide with any existing code. Choose names
  carefully to help avoid these collisions. Additionally, it may be acceptable
  to require downstream users to add [disambiguation syntax] to select the
  correct function when updating the dependency.
{==+==}
缓和策略:
* 一些项目可能认为这是可以接受的破坏，特别是如果新的条目名称不太可能与任何现有的代码发生冲突。请谨慎选择名称，以有助避免这些冲突。此外，要求下游用户在更新依赖时添加[disambiguation syntax] "歧义消除语法" 以选择恰当的函数，这是可以接受的。
{==+==}


{==+==}
<a id="trait-object-safety"></a>
### Major: adding a trait item that makes the trait non-object safe
{==+==}
<a id="trait-object-safety"></a>
### Major: 添加trait条目，使trait非对象安全
{==+==}


{==+==}
It is a breaking change to add a trait item that changes the trait to not be
[object safe].
{==+==}
增加改变trait的条目，使trait不再是[object safe]，这是破坏性的变化。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}

///////////////////////////////////////////////////////////
// After
pub trait Trait {
    // An associated const makes the trait not object-safe.
    const CONST: i32 = 123;
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}

fn main() {
    let obj: Box<dyn Trait> = Box::new(Foo); // Error: cannot be made into an object
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait {
    // 一个相关的常量使得该trait不是对象安全的。
    const CONST: i32 = 123;
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}

fn main() {
    let obj: Box<dyn Trait> = Box::new(Foo); // Error: 不能成为一个对象
}
```
{==+==}


{==+==}
It is safe to do the converse (making a non-object safe trait into a safe
one).
{==+==}
反之也是安全的(将非对象安全的trait变成安全的trait)。
{==+==}


{==+==}
<a id="trait-new-parameter-no-default"></a>
### Major: adding a type parameter without a default
{==+==}
<a id="trait-new-parameter-no-default"></a>
### Major: 添加没有默认值的类型参数
{==+==}


{==+==}
It is a breaking change to add a type parameter without a default to a trait.
{==+==}
在trait中添加没有默认值的类型参数是一种破坏性的改变。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}

///////////////////////////////////////////////////////////
// After
pub trait Trait<T> {}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}  // Error: missing generics
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait<T> {}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}  // Error: 缺失泛型
```
{==+==}


{==+==}
Mitigating strategies:
* See [adding a defaulted trait type parameter](#trait-new-parameter-default).
{==+==}
缓和策略:
* 见 [添加默认trait类型参数](#trait-new-parameter-default).
{==+==}


{==+==}
<a id="trait-new-parameter-default"></a>
### Minor: adding a defaulted trait type parameter
{==+==}
<a id="trait-new-parameter-default"></a>
### Minor: 添加默认trait类型参数
{==+==}


{==+==}
It is safe to add a type parameter to a trait as long as it has a default.
External implementors will use the default without needing to specify the
parameter.
{==+==}
在trait中添加类型参数是安全的，只要它有默认值。
外部实现者将使用默认值而不需要指定参数。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}

///////////////////////////////////////////////////////////
// After
pub trait Trait<T = i32> {}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait<T = i32> {}

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的。
use updated_crate::Trait;
struct Foo;

impl Trait for Foo {}
```
{==+==}


{==+==}
<a id="impl-item-new"></a>
### Possibly-breaking change: adding any inherent items
{==+==}
<a id="impl-item-new"></a>
### Possibly-breaking change: 添加任意内部条目
{==+==}


{==+==}
Usually adding inherent items to an implementation should be safe because
inherent items take priority over trait items. However, in some cases the
collision can cause problems if the name is the same as an implemented trait
item with a different signature.
{==+==}
通常情况下，向一个实现添加内部条目应该是安全的，因为内部条目比trait条目有优先权。
然而，在某些情况下，如果名称与具有不同签名的已实现的trait条目相同，则冲突会导致问题。
{==+==}


{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// Before
pub struct Foo;

///////////////////////////////////////////////////////////
// After
pub struct Foo;

impl Foo {
    pub fn foo(&self) {}
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Foo;

trait Trait {
    fn foo(&self, x: i32) {}
}

impl Trait for Foo {}

fn main() {
    let x = Foo;
    x.foo(1); // Error: this function takes 0 arguments
}
```
{==+==}
```rust,ignore
// 破坏性改变示例

///////////////////////////////////////////////////////////
// 之前
pub struct Foo;

///////////////////////////////////////////////////////////
// 之后
pub struct Foo;

impl Foo {
    pub fn foo(&self) {}
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::Foo;

trait Trait {
    fn foo(&self, x: i32) {}
}

impl Trait for Foo {}

fn main() {
    let x = Foo;
    x.foo(1); // Error: 这个函数有0个参数
}
```
{==+==}


{==+==}
Note that if the signatures match, there would not be a compile-time error,
but possibly a silent change in runtime behavior (because it is now executing
a different function).
{==+==}
注意，如果签名匹配，就不会出现编译时错误，但可能会出现运行时行为的静默变化(因为现在执行的是一个不同的函数)。
{==+==}


{==+==}
<a id="generic-bounds-tighten"></a>
### Major: tightening generic bounds
{==+==}
<a id="generic-bounds-tighten"></a>
### Major: 收紧泛型边界
{==+==}


{==+==}
It is a breaking change to tighten generic bounds on a type since this can
break users expecting the looser bounds.
{==+==}
在类型上收紧泛型边界是破坏性的改变，因为这可能会打破用户对较宽松边界的预期。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo<A> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// After
pub struct Foo<A: Eq> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Foo;

fn main() {
    let s = Foo { f1: 1.23 }; // Error: the trait bound `{float}: Eq` is not satisfied
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo<A> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// 之后
pub struct Foo<A: Eq> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
use updated_crate::Foo;

fn main() {
    let s = Foo { f1: 1.23 }; // Error: trait 边界 `{float}: Eq` 不满足
}
```
{==+==}


{==+==}
<a id="generic-bounds-loosen"></a>
### Minor: loosening generic bounds
{==+==}
<a id="generic-bounds-loosen"></a>
### Minor: 放宽泛型边界
{==+==}


{==+==}
It is safe to loosen the generic bounds on a type, as it only expands what is
allowed.
{==+==}
放宽类型泛型界限是安全的，因为它仅扩展了允许的范围。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo<A: Clone> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// After
pub struct Foo<A> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::Foo;

fn main() {
    let s = Foo { f1: 123 };
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo<A: Clone> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// 之后
pub struct Foo<A> {
    pub f1: A,
}

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的。
use updated_crate::Foo;

fn main() {
    let s = Foo { f1: 123 };
}
```
{==+==}


{==+==}
<a id="generic-new-default"></a>
### Minor: adding defaulted type parameters
{==+==}
<a id="generic-new-default"></a>
### Minor: 添加默认的类型参数
{==+==}


{==+==}
It is safe to add a type parameter to a type as long as it has a default. All
existing references will use the default without needing to specify the
parameter.
{==+==}
只要类型有默认值，给它添加类型参数是安全的。所有现有的引用将使用默认值，而不需要指定参数。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
#[derive(Default)]
pub struct Foo {}

///////////////////////////////////////////////////////////
// After
#[derive(Default)]
pub struct Foo<A = i32> {
    f1: A,
}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::Foo;

fn main() {
    let s: Foo = Default::default();
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
#[derive(Default)]
pub struct Foo {}

///////////////////////////////////////////////////////////
// 之后
#[derive(Default)]
pub struct Foo<A = i32> {
    f1: A,
}

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的。
use updated_crate::Foo;

fn main() {
    let s: Foo = Default::default();
}
```
{==+==}


{==+==}
<a id="generic-generalize-identical"></a>
### Minor: generalizing a type to use generics (with identical types)
{==+==}
<a id="generic-generalize-identical"></a>
### Minor: 泛化类型以使用泛型(具有相同的类型)
{==+==}


{==+==}
A struct or enum field can change from a concrete type to a generic type
parameter, provided that the change results in an identical type for all
existing use cases. For example, the following change is permitted:
{==+==}
结构体或枚举字段可以从具体类型改变为泛型类型参数，前提是这种变化带来的所有现有用例的类型相同。
例如，下面的改变是允许的。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo(pub u8);

///////////////////////////////////////////////////////////
// After
pub struct Foo<T = u8>(pub T);

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::Foo;

fn main() {
    let s: Foo = Foo(123);
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo(pub u8);

///////////////////////////////////////////////////////////
// 之后
pub struct Foo<T = u8>(pub T);

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的。
use updated_crate::Foo;

fn main() {
    let s: Foo = Foo(123);
}
```
{==+==}


{==+==}
because existing uses of `Foo` are shorthand for `Foo<u8>` which yields the
identical field type.
{==+==}
因为当前 `Foo` 是 `Foo<u8>` 的缩写，产生相同的字段类型。
{==+==}


{==+==}
<a id="generic-generalize-different"></a>
### Major: generalizing a type to use generics (with possibly different types)
{==+==}
<a id="generic-generalize-different"></a>
### Major: 泛化类型以使用泛型(可能有不同的类型)
{==+==}


{==+==}
Changing a struct or enum field from a concrete type to a generic type
parameter can break if the type can change.
{==+==}
如果类型可以改变，将结构体或枚举字段从具体类型改为泛型类型参数就是破坏性的。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo<T = u8>(pub T, pub u8);

///////////////////////////////////////////////////////////
// After
pub struct Foo<T = u8>(pub T, pub T);

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::Foo;

fn main() {
    let s: Foo<f32> = Foo(3.14, 123); // Error: mismatched types
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo<T = u8>(pub T, pub u8);

///////////////////////////////////////////////////////////
// 之后
pub struct Foo<T = u8>(pub T, pub T);

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::Foo;

fn main() {
    let s: Foo<f32> = Foo(3.14, 123); // Error: 缺失类型。
}
```
{==+==}


{==+==}
<a id="generic-more-generic"></a>
### Minor: changing a generic type to a more generic type
{==+==}
<a id="generic-more-generic"></a>
### Minor: 将泛型类型改为一个更泛型的类型
{==+==}


{==+==}
It is safe to change a generic type to a more generic one. For example, the
following adds a generic parameter that defaults to the original type, which
is safe because all existing users will be using the same type for both
fields, the the defaulted parameter does not need to be specified.
{==+==}
将一个泛型类型改为更泛型的类型是安全的。例如，下面添加了一个默认为原始类型的泛型参数，
这是安全的，因为所有现有的用户都会为两个字段使用相同的类型，默认的参数不需要被指定。
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub struct Foo<T>(pub T, pub T);

///////////////////////////////////////////////////////////
// After
pub struct Foo<T, U = T>(pub T, pub U);

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::Foo;

fn main() {
    let s: Foo<f32> = Foo(1.0, 2.0);
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub struct Foo<T>(pub T, pub T);

///////////////////////////////////////////////////////////
// 之后
pub struct Foo<T, U = T>(pub T, pub U);

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的
use updated_crate::Foo;

fn main() {
    let s: Foo<f32> = Foo(1.0, 2.0);
}
```
{==+==}


{==+==}
<a id="fn-change-arity"></a>
### Major: adding/removing function parameters
{==+==}
<a id="fn-change-arity"></a>
### Major: 添加/删除函数参数
{==+==}


{==+==}
Changing the arity of a function is a breaking change.
{==+==}
改变函数参数是一种破坏性的改变。
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub fn foo() {}

///////////////////////////////////////////////////////////
// After
pub fn foo(x: i32) {}

///////////////////////////////////////////////////////////
// Example usage that will break.
fn main() {
    updated_crate::foo(); // Error: this function takes 1 argument
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub fn foo() {}

///////////////////////////////////////////////////////////
// 之后
pub fn foo(x: i32) {}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的。
fn main() {
    updated_crate::foo(); // Error: 这个函数需要一个参数
}
```
{==+==}


{==+==}
Mitigating strategies:
* Introduce a new function with the new signature and possibly
  [deprecate][deprecated] the old one.
* Introduce functions that take a struct argument, where the struct is built
  with the builder pattern. This allows new fields to be added to the struct
  in the future.
{==+==}
缓和策略:
* 用新的签名引入一个新的函数，并可能[弃用][deprecated]旧的函数。
* 引入接受结构体参数的函数，其中结构体是用构建模式构建的。这允许将来在结构体中添加新的字段。
{==+==}


{==+==}
<a id="fn-generic-new"></a>
### Possibly-breaking: introducing a new function type parameter
{==+==}
<a id="fn-generic-new"></a>
### Possibly-breaking: 引入新的函数类型参数
{==+==}


{==+==}
Usually, adding a non-defaulted type parameter is safe, but in some
cases it can be a breaking change:
{==+==}
通常情况下，增加非默认类型参数是安全的，但在某些情况下，可能是破坏性的改变。
{==+==}


{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// Before
pub fn foo<T>() {}

///////////////////////////////////////////////////////////
// After
pub fn foo<T, U>() {}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::foo;

fn main() {
    foo::<u8>(); // Error: this function takes 2 generic arguments but 1 generic argument was supplied
}
```
{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// 之前
pub fn foo<T>() {}

///////////////////////////////////////////////////////////
// 之后
pub fn foo<T, U>() {}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::foo;

fn main() {
    foo::<u8>(); // Error: 这个函数需要2个泛型参数，但只提供了一个泛型参数
}
```
{==+==}


{==+==}
However, such explicit calls are rare enough (and can usually be written in
other ways) that this breakage is usually acceptable. One should take into
account how likely it is that the function in question is being called with
explicit type arguments.
{==+==}
然而，这样的显式调用是非常少见的(通常可以用其他方式编写)，所以这种破坏通常是可以接受的。
我们应该考虑有问题的函数被显式类型参数调用的可能性。
{==+==}


{==+==}
<a id="fn-generalize-compatible"></a>
### Minor: generalizing a function to use generics (supporting original type)
{==+==}
<a id="fn-generalize-compatible"></a>
### Minor: 泛化函数以使用泛型(支持原始类型)
{==+==}


{==+==}
The type of a parameter to a function, or its return value, can be
*generalized* to use generics, including by introducing a new type parameter,
as long as it can be instantiated to the original type. For example, the
following changes are allowed:
{==+==}
函数的参数或其返回值的类型可以被*泛化*以使用泛型，包括引入一个新类型的参数，
只要它可以被实例化为原始类型。例如，允许以下变化:
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub fn foo(x: u8) -> u8 {
    x
}
pub fn bar<T: Iterator<Item = u8>>(t: T) {}

///////////////////////////////////////////////////////////
// After
use std::ops::Add;
pub fn foo<T: Add>(x: T) -> T {
    x
}
pub fn bar<T: IntoIterator<Item = u8>>(t: T) {}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::{bar, foo};

fn main() {
    foo(1);
    bar(vec![1, 2, 3].into_iter());
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub fn foo(x: u8) -> u8 {
    x
}
pub fn bar<T: Iterator<Item = u8>>(t: T) {}

///////////////////////////////////////////////////////////
// 之后
use std::ops::Add;
pub fn foo<T: Add>(x: T) -> T {
    x
}
pub fn bar<T: IntoIterator<Item = u8>>(t: T) {}

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的
use updated_crate::{bar, foo};

fn main() {
    foo(1);
    bar(vec![1, 2, 3].into_iter());
}
```
{==+==}


{==+==}
because all existing uses are instantiations of the new signature.
{==+==}
因为所有现有的使用都是新签名的实例化。 
{==+==}


{==+==}
Perhaps somewhat surprisingly, generalization applies to trait objects as
well, given that every trait implements itself:
{==+==}
也许有些令人惊讶的是，泛化也适用于trait对象，因为每个trait都实现了自己:
{==+==}


{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub trait Trait {}
pub fn foo(t: &dyn Trait) {}

///////////////////////////////////////////////////////////
// After
pub trait Trait {}
pub fn foo<T: Trait + ?Sized>(t: &T) {}

///////////////////////////////////////////////////////////
// Example use of the library that will safely work.
use updated_crate::{foo, Trait};

struct Foo;
impl Trait for Foo {}

fn main() {
    let obj = Foo;
    foo(&obj);
}
```
{==+==}
```rust,ignore
// MINOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub trait Trait {}
pub fn foo(t: &dyn Trait) {}

///////////////////////////////////////////////////////////
// 之后
pub trait Trait {}
pub fn foo<T: Trait + ?Sized>(t: &T) {}

///////////////////////////////////////////////////////////
// 示例：库的使用是安全的。
use updated_crate::{foo, Trait};

struct Foo;
impl Trait for Foo {}

fn main() {
    let obj = Foo;
    foo(&obj);
}
```
{==+==}


{==+==}
(The use of `?Sized` is essential; otherwise you couldn't recover the original
signature.)
{==+==}
(使用 `?Sized` 是必要的，否则你就无法恢复原始签名。)
{==+==}


{==+==}
Introducing generics in this way can potentially create type inference
failures. These are usually rare, and may be acceptable breakage for some
projects, as this can be fixed with additional type annotations.
{==+==}
以这种方式引入泛型，有可能造成类型推断的失败。这些通常是少见的，
对于一些项目来说，可能是可以接受的故障，因为这可以通过额外的类型注解来修复。
{==+==}


{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// Before
pub fn foo() -> i32 {
    0
}

///////////////////////////////////////////////////////////
// After
pub fn foo<T: Default>() -> T {
    Default::default()
}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::foo;

fn main() {
    let x = foo(); // Error: type annotations needed
}
```
{==+==}
```rust,ignore
// Breaking change example

///////////////////////////////////////////////////////////
// 之前
pub fn foo() -> i32 {
    0
}

///////////////////////////////////////////////////////////
// 之后
pub fn foo<T: Default>() -> T {
    Default::default()
}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::foo;

fn main() {
    let x = foo(); // Error: 需要类型注释
}
```
{==+==}


{==+==}
<a id="fn-generalize-mismatch"></a>
### Major: generalizing a function to use generics with type mismatch
{==+==}
<a id="fn-generalize-mismatch"></a>
### Major: 泛化函数以使用类型不匹配的泛型
{==+==}


{==+==}
It is a breaking change to change a function parameter or return type if the
generic type constrains or changes the types previously allowed. For example,
the following adds a generic constraint that may not be satisfied by existing
code:
{==+==}
如果泛型约束或改变了以前允许的类型，那么改变函数参数或返回类型就是一种破坏性的改变。
例如，下面增加了一个可能不被现有代码所满足的泛型约束:
{==+==}


{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
pub fn foo(x: Vec<u8>) {}

///////////////////////////////////////////////////////////
// After
pub fn foo<T: Copy + IntoIterator<Item = u8>>(x: T) {}

///////////////////////////////////////////////////////////
// Example usage that will break.
use updated_crate::foo;

fn main() {
    foo(vec![1, 2, 3]); // Error: `Copy` is not implemented for `Vec<u8>`
}
```
{==+==}
```rust,ignore
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
pub fn foo(x: Vec<u8>) {}

///////////////////////////////////////////////////////////
// 之后
pub fn foo<T: Copy + IntoIterator<Item = u8>>(x: T) {}

///////////////////////////////////////////////////////////
// 示例：使用是破坏性的
use updated_crate::foo;

fn main() {
    foo(vec![1, 2, 3]); // Error: `Vec<u8>` 没有实现 `Copy` 
}
```
{==+==}


{==+==}
<a id="attr-no-std-to-std"></a>
### Major: switching from `no_std` support to requiring `std`
{==+==}
<a id="attr-no-std-to-std"></a>
### Major: 从 `no_std` 转为要求 `std`
{==+==}


{==+==}
If your library specifically supports a [`no_std`] environment, it is a
breaking change to make a new release that requires `std`.
{==+==}
如果你的库特别支持 [`no_std`] 环境，做一个需要 `std` 的新版本是破坏性的改变。
{==+==}


{==+==}
```rust,ignore,skip
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// Before
#![no_std]
pub fn foo() {}

///////////////////////////////////////////////////////////
// After
pub fn foo() {
    std::time::SystemTime::now();
}

///////////////////////////////////////////////////////////
// Example usage that will break.
// This will fail to link for no_std targets because they don't have a `std` crate.
#![no_std]
use updated_crate::foo;

fn example() {
    foo();
}
```
{==+==}
```rust,ignore,skip
// MAJOR CHANGE

///////////////////////////////////////////////////////////
// 之前
#![no_std]
pub fn foo() {}

///////////////////////////////////////////////////////////
// 之后
pub fn foo() {
    std::time::SystemTime::now();
}

///////////////////////////////////////////////////////////
// 示例:使用是破坏性的
// 这将导致no_std目标的链接失败，因为它们没有 `std` crate。
#![no_std]
use updated_crate::foo;

fn example() {
    foo();
}
```
{==+==}


{==+==}
Mitigation strategies:
* A common idiom to avoid this is to include a `std` [Cargo feature] that
  optionally enables `std` support, and when the feature is off, the library
  can be used in a `no_std` environment.
{==+==}
缓和策略:
* 为了避免这种情况，一种常见的方式是包含 `std` [Cargo feature] ，可以选择启用 `std` 支持，当该特性关闭时，库可以在`no_std` 环境下使用。
{==+==}


{==+==}
## Tooling and environment compatibility
{==+==}
## 工具和环境的兼容性
{==+==}


{==+==}
<a id="env-new-rust"></a>
### Possibly-breaking: changing the minimum version of Rust required
{==+==}
<a id="env-new-rust"></a>
### Possibly-breaking: 改变所需的最小Rust版本
{==+==}


{==+==}
Introducing the use of new features in a new release of Rust can break
projects that are using older versions of Rust. This also includes using new
features in a new release of Cargo, and requiring the use of a nightly-only
feature in a crate that previously worked on stable.
{==+==}
在新版本的Rust中引入使用新的特性，会破坏使用旧版本Rust的项目。
这也包括在新版本的Cargo中使用新特性，以及要求在之前在稳定版本上工作的crate中使用只在每日构建使用的特性。
{==+==}


{==+==}
Some projects choose to allow this in a minor release for various reasons. It
is usually relatively easy to update to a newer version of Rust. Rust also has
a rapid 6-week release cycle, and some projects will provide compatibility
within a window of releases (such as the current stable release plus N
previous releases). Just keep in mind that some large projects may not be able
to update their Rust toolchain rapidly.
{==+==}
一些项目出于各种原因选择在次要版本中允许这样做。通常情况下，更新到一个较新的Rust版本是比较容易的。Rust也有一个6周的快速发布周期，一些项目会在一个发布窗口期内提供兼容性(比如当前的稳定版加上之前的N个版本)。只要记住，一些大型项目可能无法迅速更新其Rust工具链。
{==+==}


{==+==}
Mitigation strategies:
* Use [Cargo features] to make the new features opt-in.
* Provide a large window of support for older releases.
* Copy the source of new standard library items if possible so that you
  can continue to use an older version but take advantage of the new feature.
* Provide a separate branch of older minor releases that can receive backports
  of important bugfixes.
* Keep an eye out for the [`[cfg(version(..))]`][cfg-version] and
  [`#[cfg(accessible(..))]`][cfg-accessible] features which provide an opt-in
  mechanism for new features. These are currently unstable and only available
  in the nightly channel.
{==+==}
缓和策略:
* 使用[Cargo features]使新特性可选加入。
* 为旧版本提供更大的支持窗口期。
* 如果可能的话，复制新的标准库项目的源代码，这样你就可以继续使用旧的版本，但利用新的特性。
* 为较早的次要版本提供一个单独的分支，可以接收重要bug修复的向后移植。
* 请注意[`[cfg(version(..))]`][cfg-version]和[`#[cfg(accessible(..))]`][cfg-accessible]特性，它们为新特性提供了选择机制。这些特性目前是不稳定的，只在每日构建中可用。
{==+==}


{==+==}
<a id="env-change-requirements"></a>
### Possibly-breaking: changing the platform and environment requirements
{==+==}
<a id="env-change-requirements"></a>
### Possibly-breaking: 改变平台和环境要求
{==+==}


{==+==}
There is a very wide range of assumptions a library makes about the
environment that it runs in, such as the host platform, operating system
version, available services, filesystem support, etc. It can be a breaking
change if you make a new release that restricts what was previously supported,
for example requiring a newer version of an operating system. These changes
can be difficult to track, since you may not always know if a change breaks in
an environment that is not automatically tested.
{==+==}
一个库对它所运行的环境有非常宽泛的假设，例如主机平台、操作系统版本、可用的服务、文件系统支持等等。如果你发布的新版本限制了以前支持的内容，例如需要新版本的操作系统，这可能是破坏性的变化。这些变化可能很难跟踪，因为你可能并不总是知道在一个没有自动测试的环境中，变化是否会形成破坏。
{==+==}


{==+==}
Some projects may deem this acceptable breakage, particularly if the breakage
is unlikely for most users, or the project doesn't have the resources to
support all environments. Another notable situation is when a vendor
discontinues support for some hardware or OS, the project may deem it
reasonable to also discontinue support.
{==+==}
一些项目可能认为这是可以接受的破坏，特别是如果这种破坏对大多数用户来说是不可能的，或者项目没有资源来支持所有环境。
另一种值得注意的情况是，当供应商停止对某些硬件或操作系统的支持时，项目可能认为停止支持也是合理的。
{==+==}


{==+==}
Mitigation strategies:
* Document the platforms and environments you specifically support.
* Test your code on a wide range of environments in CI.
{==+==}
缓和策略:
* 记录你具体支持的平台和环境。
* 在CI中，在宽泛的环境中测试你的代码。
{==+==}


{==+==}
### Cargo

<a id="cargo-feature-add"></a>
#### Minor: adding a new Cargo feature
{==+==}
### Cargo

<a id="cargo-feature-add"></a>
#### Minor: 增加新的Cargo特性
{==+==}


{==+==}
It is usually safe to add new [Cargo features]. If the feature introduces new
changes that cause a breaking change, this can cause difficulties for projects
that have stricter backwards-compatibility needs. In that scenario, avoid
adding the feature to the "default" list, and possibly document the
consequences of enabling the feature.
{==+==}
增加新的[Cargo features]通常是安全的。如果该特性引入了新的变化，带来破坏性，这可能会给那些有更严格的向后兼容性需求的项目带来困难。在这种情况下，应避免将该特性添加到 "默认" 列表中，并记录可能启用该特性的后果。
{==+==}


{==+==}
```toml
# MINOR CHANGE

###########################################################
# Before
[features]
# ..empty

###########################################################
# After
[features]
std = []
```
{==+==}
```toml
# MINOR CHANGE

###########################################################
# 之前
[features]
# ..empty

###########################################################
# 之后
[features]
std = []
```
{==+==}


{==+==}
<a id="cargo-feature-remove"></a>
#### Major: removing a Cargo feature
{==+==}
<a id="cargo-feature-remove"></a>
#### Major: 移除 Cargo 特性
{==+==}


{==+==}
It is usually a breaking change to remove [Cargo features]. This will cause
an error for any project that enabled the feature.
{==+==}
移除[Cargo features]通常是一种破坏性的改变。这将导致任何启用该特性的项目出现错误。
{==+==}


{==+==}
```toml
# MAJOR CHANGE

###########################################################
# Before
[features]
logging = []

###########################################################
# After
[dependencies]
# ..logging removed
```
{==+==}
```toml
# MAJOR CHANGE

###########################################################
# 之前
[features]
logging = []

###########################################################
# 之后
[dependencies]
# ..logging removed
```
{==+==}


{==+==}
Mitigation strategies:
* Clearly document your features. If there is an internal or experimental
  feature, mark it as such, so that users know the status of the feature.
* Leave the old feature in `Cargo.toml`, but otherwise remove its
  functionality. Document that the feature is deprecated, and remove it in a
  future major SemVer release.
{==+==}
缓和策略:
* 清楚地记录你的特性。如果有一个内部或实验性的特性，就把它标记为这样的特性，以便用户知道这个特性的状态。
* 在 `Cargo.toml` 中保留旧的特性，但删除其功能。记录该特性已被废弃，并在未来的语义化主要版本中删除。
{==+==}


{==+==}
<a id="cargo-feature-remove-another"></a>
#### Major: removing a feature from a feature list if that changes functionality or public items
{==+==}
<a id="cargo-feature-remove-another"></a>
#### Major: 如果改变了功能或公共条目，从特性列表中删除一个特性
{==+==}


{==+==}
If removing a feature from another feature, this can break existing users if
they are expecting that functionality to be available through that feature.
{==+==}
如果从另一个特性中删除特性，这可能会破坏现有的用户，如果他们期望通过该特性来获得该功能。
{==+==}


{==+==}
```toml
# Breaking change example

###########################################################
# Before
[features]
default = ["std"]
std = []

###########################################################
# After
[features]
default = []  # This may cause packages to fail if they are expecting std to be enabled.
std = []
```
{==+==}
```toml
# Breaking change example

###########################################################
# 之前
[features]
default = ["std"]
std = []

###########################################################
# 之后
[features]
default = []  # 如果包期望启用std，这可能会导致它们失败。
std = []
```
{==+==}


{==+==}
<a id="cargo-remove-opt-dep"></a>
#### Possibly-breaking: removing an optional dependency
{==+==}
<a id="cargo-remove-opt-dep"></a>
#### Possibly-breaking: 删除可选依赖
{==+==}


{==+==}
Removing an optional dependency can break a project using your library because
another project may be enabling that dependency via [Cargo features].
{==+==}
删除可选依赖可能会破坏使用你的库的项目，因为另一个项目可能通过[Cargo features]启用该依赖。
{==+==}


{==+==}
```toml
# Breaking change example

###########################################################
# Before
[dependencies]
curl = { version = "0.4.31", optional = true }

###########################################################
# After
[dependencies]
# ..curl removed
```
{==+==}
```toml
# Breaking change example

###########################################################
# 之前
[dependencies]
curl = { version = "0.4.31", optional = true }

###########################################################
# 之后
[dependencies]
# ..curl removed
```
{==+==}


{==+==}
Mitigation strategies:
* Clearly document your features. If the optional dependency is not included
  in the documented list of features, then you may decide to consider it safe
  to change undocumented entries.
* Leave the optional dependency, and just don't use it within your library.
* Replace the optional dependency with a [Cargo feature] that does nothing,
  and document that it is deprecated.
{==+==}
缓和策略:
* 清楚地记录你的特性。如果可选依赖不包括在记录的特性列表中，那么你可以决定认为改变无记录的条目是安全的。
* 留下可选择依赖，只是在你的库中不使用它。
* 用一个什么都不做的[Cargo feature]来替换这个可选依赖，并记录下它的废弃情况。
{==+==}


{==+==}
* Use high-level features which enable optional dependencies, and document
  those as the preferred way to enable the extended functionality. For
  example, if your library has optional support for something like
  "networking", create a generic feature name "networking" that enables the
  optional dependencies necessary to implement "networking". Then document the
  "networking" feature.
{==+==}
* 使用能够实现可选的依赖的高级特性，并将这些特性记录为实现扩展功能的首选方式。例如，如果你的库对 "联网" 这样的内容有可选的支持，创建一个名为 "联网" 的泛型特性，它能够实现 "联网" 所需的可选依赖。然后记录 "联网" 特性。
{==+==}


{==+==}
<a id="cargo-change-dep-feature"></a>
#### Minor: changing dependency features
{==+==}
<a id="cargo-change-dep-feature"></a>
#### Minor: 改变依赖特性
{==+==}


{==+==}
It is usually safe to change the features on a dependency, as long as the
feature does not introduce a breaking change.
{==+==}
通常情况下，改变依赖上的特性是安全的，只要该特性不引入破坏性的变化。
{==+==}


{==+==}
```toml
# MINOR CHANGE

###########################################################
# Before
[dependencies]
rand = { version = "0.7.3", features = ["small_rng"] }


###########################################################
# After
[dependencies]
rand = "0.7.3"
```
{==+==}
```toml
# MINOR CHANGE

###########################################################
# 之前
[dependencies]
rand = { version = "0.7.3", features = ["small_rng"] }


###########################################################
# 之后
[dependencies]
rand = "0.7.3"
```
{==+==}


{==+==}
<a id="cargo-dep-add"></a>
#### Minor: adding dependencies
{==+==}
<a id="cargo-dep-add"></a>
#### Minor: 添加依赖
{==+==}


{==+==}
It is usually safe to add new dependencies, as long as the new dependency
does not introduce new requirements that result in a breaking change.
For example, adding a new dependency that requires nightly in a project
that previously worked on stable is a major change.
{==+==}
增加新的依赖通常是安全的，只要新的依赖没有引入新的需求而导致破坏性的变化。
例如，在一个以前在稳定版本上工作的项目中添加一个需要每日构建的新依赖，是一个重大的变化。
{==+==}


{==+==}
```toml
# MINOR CHANGE

###########################################################
# Before
[dependencies]
# ..empty

###########################################################
# After
[dependencies]
log = "0.4.11"
```
{==+==}
```toml
# MINOR CHANGE

###########################################################
# 之前
[dependencies]
# ..empty

###########################################################
# 之后
[dependencies]
log = "0.4.11"
```
{==+==}


{==+==}
## Application compatibility
{==+==}
## 应用程序兼容性
{==+==}


{==+==}
Cargo projects may also include executable binaries which have their own
interfaces (such as a CLI interface, OS-level interaction, etc.). Since these
are part of the Cargo package, they often use and share the same version as
the package. You will need to decide if and how you want to employ a SemVer
contract with your users in the changes you make to your application. The
potential breaking and compatible changes to an application are too numerous
to list, so you are encouraged to use the spirit of the [SemVer] spec to guide
your decisions on how to apply versioning to your application, or at least
document what your commitments are.
{==+==}
Cargo项目也可能包括可执行的二进制文件，它们有自己的接口(如CLI接口、OS级交互等)。
由于这些是Cargo包的一部分，它们经常使用和共享与包相同的版本。
你需要决定是否以及如何在你对应用程序的修改中采用语义化版本约定与你的用户进行沟通。
对应用程序的潜在破坏性和兼容性的改变不胜枚举，
所以我们鼓励你使用[SemVer]规范的精神来指导你决定如何将版本控制应用于你的应用程序，或者至少记录你的承诺。
{==+==}


{==+==}
[`cfg` attribute]: ../../reference/conditional-compilation.md#the-cfg-attribute
[`no_std`]: ../../reference/names/preludes.html#the-no_std-attribute
[`pub use`]: ../../reference/items/use-declarations.html
[Cargo feature]: features.md
[Cargo features]: features.md
[cfg-accessible]: https://github.com/rust-lang/rust/issues/64797
[cfg-version]: https://github.com/rust-lang/rust/issues/64796
[conditional compilation]: ../../reference/conditional-compilation.md
[Default]: ../../std/default/trait.Default.html
[deprecated]: ../../reference/attributes/diagnostics.html#the-deprecated-attribute
[disambiguation syntax]: ../../reference/expressions/call-expr.html#disambiguating-function-calls
[inherent implementations]: ../../reference/items/implementations.html#inherent-implementations
[items]: ../../reference/items.html
[non_exhaustive]: ../../reference/attributes/type_system.html#the-non_exhaustive-attribute
[object safe]: ../../reference/items/traits.html#object-safety
[rust-feature]: https://doc.rust-lang.org/nightly/unstable-book/
[sealed trait]: https://rust-lang.github.io/api-guidelines/future-proofing.html#sealed-traits-protect-against-downstream-implementations-c-sealed
[SemVer]: https://semver.org/
[struct literal]: ../../reference/expressions/struct-expr.html
[wildcard patterns]: ../../reference/patterns.html#wildcard-pattern
{==+==}

{==+==}