# CTVFL: Compile-Time Visual Format Language

[![Build Status](https://travis-ci.com/WeZZard/CTVFL.svg?branch=master)](https://travis-ci.com/WeZZard/CTVFL)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

[中文](./使用說明.md)

CTVFL is a tiny framework offers compile-time safe Visual Format Langauge to
make Auto Layout painless on Apple platforms.

## Examples

### Making Native Cocoa Constraints

```swift
// [button]-[textField]
let constraint0 = withVFL(H: button - textField, options: [])

// [button(>=50)]
let constraint1 = withVFL(H: button.where(>=50))

// |-50-[purpleBox]-50-|
let constraint2 = withVFL(H: |-50 - purpleBox - 50-|)

// V:[topField]-10-[bottomField]
let constraint3 = withVFL(V: topField - 10 - bottomField)

// [maroonView][blueView]
let constraint4 = withVFL(H: maroonView | blueView)

// [button(100@20)]
let constraint5 = withVFL(H: button.where(200 ~ 20))

// [button1(==button2)]
let constraint6 = withVFL(H: button1.where(==button2))

// [flexibleButton(>=70,<=100)]
let constraint7 = withVFL(H: flexibleButton.where(>=70, <=100))

// |-[find]-[findNext]-[findField(>=20)]-|
let constraint8 = withVFL(H: |-find - findNext - findField.where(>=20)-|)
```

### Making and Installing Constraints with a Collective Control Point

Wrapping `withVFL` function calls with `constrain` function's closure makes
the framework installs the generated constraints and encapsulates them in
a `CTVFLConstraintGroup` instance. You can control the whole group of
generated constriants with this instance.

```swift
var view1VerticalConstraints = [NSLayoutConstraint]!

let constraintGroup = constrain {
    withVFL(H: |-view1 - 100 - view2-|)

    view1VerticalConstraints = withVFL(V: |-view1-|)

    withVFL(V: |-view2-|)
}

view1VerticalConstraints.forEach({$0.isActive = false})
```

```swift
// ... something happened

if !constraintGroup.areAllAcrive {
    constraintGroup.setActive(true)
}
```

```swift
// ... something happened

constraintGroup.uninstall()
```

## Helping Debugging

The framework mangles each view's name in the internal visual format string
by generating a random string for it, which is quite bad for debugging.

To help your debugging, you can use `setVariableName(_: for:)` function to
set a human-readable variable name for any view.

```swift
constrain(
    setVariableName("view1", for: view1)
)
```

Calling `setVariableName(_: for:)` outsides a `constrain` closure doesn't
have any work.

## License

MIT License
