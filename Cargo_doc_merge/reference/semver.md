# 语义化兼容性

本章详细介绍了对于新发布的包，什么是传统意义上的兼容或破坏性的语义化版本变化。
关于什么是语义化版本，以及Cargo如何使用它来确保库的兼容性，请参阅[SemVer compatibility]部分。

这些只是*准则*，而不一定是所有项目都会遵守的硬性规定。
[Change categories]部分详细说明了本指南如何对变更的级别和严重程度进行分类。
本指南的大部分内容都集中在那些会导致 `cargo` 和 `rustc` 不能构建以前正常工作的内容的变化。
几乎所有的改变都有可能对运行时的行为产生负面影响，对于这些情况，通常由项目维护者判断是否属于语义化不兼容的改变。

也可以参见[rust-semverver]，它是一个实验性的工具，试图以编程方式检查兼容性规则。

[Change categories]: #change-categories
[rust-semverver]: https://github.com/rust-lang/rust-semverver
[SemVer compatibility]: resolver.md#semver-compatibility

## 更改类别

下面列出的所有策略都是按变化的级别来分类的:

* **Major change**: 这种变化需要语义化版本的重要改变。
* **Minor change**: 这种变化只需要在语义化版本上做小改动。
* **Possibly-breaking change**: 一些项目可能认为是大的变化，另一些则认为是小的变化。

"可能破坏" 类别涵盖了在更新期间有*潜在*破坏的变化，但不一定会导致破坏。
这些变化的影响应该被仔细考虑。确切的性质将取决于该变化和项目维护者的原则。

有些项目可能会选择只在一个小的变化上增加补丁号。我们鼓励遵循语义化规范，只在补丁版本中应用错误修复。
然而，一个错误的修复可能需要一个被标记为 "次要改动" 的API变化，并且不应该影响兼容性。
本指南不对每个 "次要改动" 应如何处理采取立场，因为次要改动和补丁改动之间的区别是取决于改动的性质的惯例。

有些改动被标记为 "次要"，即使它们有破坏构建的潜在风险。
这适用于潜在风险极低的情况，而且可能破坏的代码不太可能用习惯性的Rust编写，或者去特别强调不使用。

本指南使用 "主要" 和 "次要" 这两个术语是假设这与 "1.0.0" 或更高版本有关。从 "0.y.z" 开始的初始开发版本可以把 "y" 中的变化作为主要版本，而把 "z" 作为次要版本。
"0.0.z" 版本总是主要变化。这是因为Cargo使用的惯例是，只有最左边的非零部分中的变化才被认为是不兼容的。

* API 兼容性
    * 条目
        * [Major: 重命名/移动/移除任何公共条目](#item-remove)
        * [Minor: 添加新的公开条目](#item-new)
    * Structs
        * [Major: 当所有当前字段都为公共时，添加私有结构体字段](#struct-add-private-field-when-public)
        * [Major: 在没有私有字段时添加公共字段](#struct-add-public-field-when-no-private)
        * [Minor: 当至少有一个私有字段存在时添加或删除私有字段](#struct-private-fields-with-private)
        * [Minor: 从一个包含所有私有字段(至少包含一个字段)的元组结构体到一个普通结构体，反之亦然](#struct-tuple-normal-with-private)
    * Enums
        * [Major: 添加新的枚举变量(没有 `non_exhaustive`)](#enum-variant-new)
        * [Major: 向枚举变量添加新字段](#enum-fields-new)
    * Traits
        * [Major: 添加非默认的trait条目](#trait-new-item-no-default)
        * [Major: trait条目签名任何变化](#trait-item-signature)
        * [Possibly-breaking: 添加默认trait条目](#trait-new-default-item)
        * [Major: 添加trait条目使trait非对象安全](#trait-object-safety)
        * [Major: 添加没有默认的类型参数](#trait-new-parameter-no-default)
        * [Minor: 增加默认的trait类型参数](#trait-new-parameter-default)
    * Implementations
        * [Possibly-breaking change: 添加任何内部条目](#impl-item-new)
    * Generics
        * [Major: 收紧泛型边界](#generic-bounds-tighten)
        * [Minor: 放宽泛型边界](#generic-bounds-loosen)
        * [Minor: 添加默认类型参数](#generic-new-default)
        * [Minor: 泛化类型以使用泛型(具有等同类型)](#generic-generalize-identical)
        * [Major: 泛化类型以使用泛型(可能有不同的类型)](#generic-generalize-different)
        * [Minor: 将泛化类型改为更泛化的类型](#generic-more-generic)
    * Functions
        * [Major: 添加/删除函数参数](#fn-change-arity)
        * [Possibly-breaking: 引入新的函数类型参数](#fn-generic-new)
        * [Minor: 泛化函数以使用泛型(支持原始类型)](#fn-generalize-compatible)
        * [Major: 泛化函数以使用类型不匹配的泛型](#fn-generalize-mismatch)
    * Attributes
        * [Major: 从 `no_std` 切换到要求 `std` ](#attr-no-std-to-std)
* 工具和环境的兼容性
    * [Possibly-breaking: 改变所需的最小Rust版本](#env-new-rust)
    * [Possibly-breaking: 改变平台和环境要求](#env-change-requirements)
    * Cargo
        * [Minor: 增加新的Cargo特性](#cargo-feature-add)
        * [Major: 删除Cargo特性](#cargo-feature-remove)
        * [Major: 如果改变了特性或公共条目，从特性列表中删除一个特性](#cargo-feature-remove-another)
        * [Possibly-breaking: 删除可选的依赖](#cargo-remove-opt-dep)
        * [Minor: 改变依赖特性](#cargo-change-dep-feature)
        * [Minor: 添加依赖](#cargo-dep-add)
* [应用程序兼容性](#application-compatibility)

## API兼容性

下面所有的例子都包含三个部分：原始代码，修改后的代码，以及可能出现在另一个项目中的代码使用范例。
在次要改动中，示例用法应该成功地与前后两个版本一起构建。

<a id="item-remove"></a>
### Major: 重新命名/移动/删除任意公共条目

缺失公开暴露[条目][items]将导致对该条目的任何使用无法编译。

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

这包括添加任何种类的[`cfg` 属性]，它可以根据[conditional compilation] "条件编译"改变哪些条目或行为是可用的。

缓和策略:
* 将要删除的条目标记为[deprecated]，然后在以后的语义化版本打破性发布中删除它们。
* 将重命名的条目标记为[deprecated]，并使用 [`pub use`] 条目来重新输出旧名称。

<a id="item-new"></a>
### Minor: 添加新公共条目

增加新的、公开的[items]是次要变化。

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

请注意，在某些少见的情况下，由于通配符导入的原因，这可能是*破坏性*改变。例如，如果你添加了一个新的特性，
而一个条目使用了一个将该特性带入范围的通配符导入，并且这个新的特性引入了一个与它所实现的任意类型相冲突的关联项，这可能会因为这种混淆而导致编译时错误。例子:

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

这并不被认为是重要改变，因为通常通配符导入是一个已知的向前兼容的风险。应该避免从外部crate中导入条目的通配符。

<a id="struct-add-private-field-when-public"></a>
### Major: 当当前所有字段都是公共的时候，添加私有结构体字段

当私有字段被添加到之前拥有所有公共字段的结构体中时。
这将破坏任何试图用[struct literal]"结构体字面量"来构建该结构体的代码。

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

缓和策略:
* 不要向所有公共字段的结构体添加新字段。
* 在首次引入结构体时，将结构标记为[`#[non_exhaustive]`][non_exhaustive]，
  以阻止用户使用结构字面量语法，而是提供构造方法或 [Default] 实现。

<a id="struct-add-public-field-when-no-private"></a>
### Major: 在不存在私有字段的情况下添加公共字段

当公共字段被添加到拥有所有公共字段的结构体中时，这将破坏任何试图用[struct literal]"结构体字面量"来构建它的代码。

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

缓和策略:
* 不要向所有公共字段结构体添加新字段。
* 在首次引入结构体时，将结构体标记为[`#[non_exhaustive]`][non_exhaustive]，
  以阻止用户使用结构体字面量语法，而是提供构造方法或[Default]实现。

<a id="struct-private-fields-with-private"></a>
### Minor: 当至少有一个私有字段存在时添加或删除私有字段

当结构已经至少有一个私有字段时，从结构中添加或删除私有字段是安全的。

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

这是安全的，因为现有的代码不能使用[struct literal]来构造它，无需彻底匹配其内容。

请注意，对于元组结构体来说，如果元组包含公共字段，增加或删除私有字段会改变任何公共字段的索引，将是 **major变化** 。

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

<a id="struct-tuple-normal-with-private"></a>
### Minor: 从具有所有私有字段的元组结构体(至少有一个字段)到正常的结构体。

如果所有字段都是私有的，那么将元组结构体改变为普通结构体是安全的，反之亦然。

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

这是安全的，因为当前的代码不能使用[struct literal]来构造它，不能匹配它的内容。

<a id="enum-variant-new"></a>
### Major: 添加新的枚举条目 (没有 `non_exhaustive` ) 。

如果枚举未使用[`#[non_exhaustive]`][non_exhaustive]属性，增加新的枚举条目是破坏性的改变。

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

缓和策略:
* 在引入枚举时，将其标记为[`#[non_exhaustive]`][non_exhaustive]，以迫使用户使用[通配符模式]来捕获新的变体。

<a id="enum-fields-new"></a>
### Major: 向枚举变量添加新字段

在枚举变体中添加新的字段是一种破坏性的改变，因为所有的字段都是公开的，构造函数和匹配将无法编译。

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

缓和策略:
* 在引入枚举时，将变体标记为[`non_exhaustive`][non_exhaustive]，使其没有通配符的情况下不能构建或匹配它。
  ```rust,ignore,skip
  pub enum E {
      #[non_exhaustive]
      Variant1{f1: i32}
  }
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

<a id="trait-new-item-no-default"></a>
### Major: 添加非默认的trait条目

在特性中添加非默认的条目是一种破坏性的改变。这将破坏该特性的任何实现者。

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

缓和策略:
* 始终为新的相关trait条目提供默认的实现或值。
* 在引入trait时，使用[sealed trait]技术来防止crate外的用户实现该trait。

<a id="trait-item-signature"></a>
### Major: trait条目签名的任何变化

对trait条目的签名做任何改变都是破坏性的。可能会破坏该trait的外部实现者。

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

缓和策略:
* 引入带有默认实现的新条目，以涵盖新功能，而不是修改现有条目。
* 当引入该trait时，使用[sealed trait]来防止crate外的用户实现该trait。

<a id="trait-new-default-item"></a>
### Possibly-breaking: 添加默认的trait条目

添加默认的trait条目通常是安全的。然而，这有时会导致编译错误。
例如，如果在另一个trait中存在同名的方法，则会引入混淆。

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

注意，这种二义性并不存在于[inherent implementations]的名称冲突，因为它们优先于trait条目。

参见[trait-object-safety](#trait-object-safety)，了解添加trait条目时需要考虑的特殊情况。

缓和策略:
* 一些项目可能认为这是可以接受的破坏，特别是如果新的条目名称不太可能与任何现有的代码发生冲突。请谨慎选择名称，以有助避免这些冲突。此外，要求下游用户在更新依赖时添加[disambiguation syntax] "歧义消除语法" 以选择恰当的函数，这是可以接受的。

<a id="trait-object-safety"></a>
### Major: 添加trait条目，使trait非对象安全

增加改变trait的条目，使trait不再是[object safe]，这是破坏性的变化。

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

反之也是安全的(将非对象安全的trait变成安全的trait)。

<a id="trait-new-parameter-no-default"></a>
### Major: 添加没有默认值的类型参数

在trait中添加没有默认值的类型参数是一种破坏性的改变。

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

缓和策略:
* 见 [添加默认trait类型参数](#trait-new-parameter-default).

<a id="trait-new-parameter-default"></a>
### Minor: 添加默认trait类型参数

在trait中添加类型参数是安全的，只要它有默认值。
外部实现者将使用默认值而不需要指定参数。

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

<a id="impl-item-new"></a>
### Possibly-breaking change: 添加任意内部条目

通常情况下，向一个实现添加内部条目应该是安全的，因为内部条目比trait条目有优先权。
然而，在某些情况下，如果名称与具有不同签名的已实现的trait条目相同，则冲突会导致问题。

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

注意，如果签名匹配，就不会出现编译时错误，但可能会出现运行时行为的静默变化(因为现在执行的是一个不同的函数)。

缓和策略:
* 一些项目可能认为这是可以接受的破坏，特别是如果新的条目名称不太可能与任何现有的代码发生冲突。请谨慎选择名称，以有助避免这些冲突。此外，要求下游用户在更新依赖时添加[disambiguation syntax] "歧义消除语法" 以选择恰当的函数，这是可以接受的。

<a id="generic-bounds-tighten"></a>
### Major: 收紧泛型边界

在类型上收紧泛型边界是破坏性的改变，因为这可能会打破用户对较宽松边界的预期。

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

<a id="generic-bounds-loosen"></a>
### Minor: 放宽泛型边界

放宽类型泛型界限是安全的，因为它仅扩展了允许的范围。

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

<a id="generic-new-default"></a>
### Minor: 添加默认的类型参数

只要类型有默认值，给它添加类型参数是安全的。所有现有的引用将使用默认值，而不需要指定参数。

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

<a id="generic-generalize-identical"></a>
### Minor: 泛化类型以使用泛型(具有相同的类型)

结构体或枚举字段可以从具体类型改变为泛型类型参数，前提是这种变化带来的所有现有用例的类型相同。
例如，下面的改变是允许的。

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

因为当前 `Foo` 是 `Foo<u8>` 的缩写，产生相同的字段类型。

<a id="generic-generalize-different"></a>
### Major: 泛化类型以使用泛型(可能有不同的类型)

如果类型可以改变，将结构体或枚举字段从具体类型改为泛型类型参数就是破坏性的。

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

<a id="generic-more-generic"></a>
### Minor: 将泛型类型改为一个更泛型的类型

将一个泛型类型改为更泛型的类型是安全的。例如，下面添加了一个默认为原始类型的泛型参数，
这是安全的，因为所有现有的用户都会为两个字段使用相同的类型，默认的参数不需要被指定。

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

<a id="fn-change-arity"></a>
### Major: 添加/删除函数参数

改变函数参数是一种破坏性的改变。

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

缓和策略:
* 用新的签名引入一个新的函数，并可能[弃用][deprecated]旧的函数。
* 引入接受结构体参数的函数，其中结构体是用构建模式构建的。这允许将来在结构体中添加新的字段。

<a id="fn-generic-new"></a>
### Possibly-breaking: 引入新的函数类型参数

通常情况下，增加非默认类型参数是安全的，但在某些情况下，可能是破坏性的改变。

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

然而，这样的显式调用是非常少见的(通常可以用其他方式编写)，所以这种破坏通常是可以接受的。
我们应该考虑有问题的函数被显式类型参数调用的可能性。

<a id="fn-generalize-compatible"></a>
### Minor: 泛化函数以使用泛型(支持原始类型)

函数的参数或其返回值的类型可以被*泛化*以使用泛型，包括引入一个新类型的参数，
只要它可以被实例化为原始类型。例如，允许以下变化:

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

因为所有现有的使用都是新签名的实例化。 

也许有些令人惊讶的是，泛化也适用于trait对象，因为每个trait都实现了自己:

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

(使用 `?Sized` 是必要的，否则你就无法恢复原始签名。)

以这种方式引入泛型，有可能造成类型推断的失败。这些通常是少见的，
对于一些项目来说，可能是可以接受的故障，因为这可以通过额外的类型注解来修复。

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

<a id="fn-generalize-mismatch"></a>
### Major: 泛化函数以使用类型不匹配的泛型

如果泛型约束或改变了以前允许的类型，那么改变函数参数或返回类型就是一种破坏性的改变。
例如，下面增加了一个可能不被现有代码所满足的泛型约束:

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

<a id="attr-no-std-to-std"></a>
### Major: 从 `no_std` 转为要求 `std`

如果你的库特别支持 [`no_std`] 环境，做一个需要 `std` 的新版本是破坏性的改变。

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

缓和策略:
* 为了避免这种情况，一种常见的方式是包含 `std` [Cargo feature] ，可以选择启用 `std` 支持，当该特性关闭时，库可以在`no_std` 环境下使用。

## 工具和环境的兼容性

<a id="env-new-rust"></a>
### Possibly-breaking: 改变所需的最小Rust版本

在新版本的Rust中引入使用新的特性，会破坏使用旧版本Rust的项目。
这也包括在新版本的Cargo中使用新特性，以及要求在之前在稳定版本上工作的crate中使用只在每日构建使用的特性。

一些项目出于各种原因选择在次要版本中允许这样做。通常情况下，更新到一个较新的Rust版本是比较容易的。Rust也有一个6周的快速发布周期，一些项目会在一个发布窗口期内提供兼容性(比如当前的稳定版加上之前的N个版本)。只要记住，一些大型项目可能无法迅速更新其Rust工具链。

缓和策略:
* 使用[Cargo features]使新特性可选加入。
* 为旧版本提供更大的支持窗口期。
* 如果可能的话，复制新的标准库项目的源代码，这样你就可以继续使用旧的版本，但利用新的特性。
* 为较早的次要版本提供一个单独的分支，可以接收重要bug修复的向后移植。
* 请注意[`[cfg(version(..))]`][cfg-version]和[`#[cfg(accessible(..))]`][cfg-accessible]特性，它们为新特性提供了选择机制。这些特性目前是不稳定的，只在每日构建中可用。

<a id="env-change-requirements"></a>
### Possibly-breaking: 改变平台和环境要求

一个库对它所运行的环境有非常宽泛的假设，例如主机平台、操作系统版本、可用的服务、文件系统支持等等。如果你发布的新版本限制了以前支持的内容，例如需要新版本的操作系统，这可能是破坏性的变化。这些变化可能很难跟踪，因为你可能并不总是知道在一个没有自动测试的环境中，变化是否会形成破坏。

一些项目可能认为这是可以接受的破坏，特别是如果这种破坏对大多数用户来说是不可能的，或者项目没有资源来支持所有环境。
另一种值得注意的情况是，当供应商停止对某些硬件或操作系统的支持时，项目可能认为停止支持也是合理的。

缓和策略:
* 记录你具体支持的平台和环境。
* 在CI中，在宽泛的环境中测试你的代码。

### Cargo

<a id="cargo-feature-add"></a>
#### Minor: 增加新的Cargo特性

增加新的[Cargo features]通常是安全的。如果该特性引入了新的变化，带来破坏性，这可能会给那些有更严格的向后兼容性需求的项目带来困难。在这种情况下，应避免将该特性添加到 "默认" 列表中，并记录可能启用该特性的后果。

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

<a id="cargo-feature-remove"></a>
#### Major: 移除 Cargo 特性

移除[Cargo features]通常是一种破坏性的改变。这将导致任何启用该特性的项目出现错误。

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

缓和策略:
* 清楚地记录你的特性。如果有一个内部或实验性的特性，就把它标记为这样的特性，以便用户知道这个特性的状态。
* 在 `Cargo.toml` 中保留旧的特性，但删除其功能。记录该特性已被废弃，并在未来的语义化主要版本中删除。

<a id="cargo-feature-remove-another"></a>
#### Major: 如果改变了功能或公共条目，从特性列表中删除一个特性

如果从另一个特性中删除特性，这可能会破坏现有的用户，如果他们期望通过该特性来获得该功能。

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

<a id="cargo-remove-opt-dep"></a>
#### Possibly-breaking: 删除可选依赖

删除可选依赖可能会破坏使用你的库的项目，因为另一个项目可能通过[Cargo features]启用该依赖。

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

缓和策略:
* 清楚地记录你的特性。如果可选依赖不包括在记录的特性列表中，那么你可以决定认为改变无记录的条目是安全的。
* 留下可选择依赖，只是在你的库中不使用它。
* 用一个什么都不做的[Cargo feature]来替换这个可选依赖，并记录下它的废弃情况。
* 使用能够实现可选的依赖的高级特性，并将这些特性记录为实现扩展功能的首选方式。例如，如果你的库对 "联网" 这样的内容有可选的支持，创建一个名为 "联网" 的泛型特性，它能够实现 "联网" 所需的可选依赖。然后记录 "联网" 特性。

<a id="cargo-change-dep-feature"></a>
#### Minor: 改变依赖特性

通常情况下，改变依赖上的特性是安全的，只要该特性不引入破坏性的变化。

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

<a id="cargo-dep-add"></a>
#### Minor: 添加依赖

增加新的依赖通常是安全的，只要新的依赖没有引入新的需求而导致破坏性的变化。
例如，在一个以前在稳定版本上工作的项目中添加一个需要每日构建的新依赖，是一个重大的变化。

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

## 应用程序兼容性

Cargo项目也可能包括可执行的二进制文件，它们有自己的接口(如CLI接口、OS级交互等)。
由于这些是Cargo包的一部分，它们经常使用和共享与包相同的版本。
你需要决定是否以及如何在你对应用程序的修改中采用语义化版本约定与你的用户进行沟通。
对应用程序的潜在破坏性和兼容性的改变不胜枚举，
所以我们鼓励你使用[SemVer]规范的精神来指导你决定如何将版本控制应用于你的应用程序，或者至少记录你的承诺。

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
