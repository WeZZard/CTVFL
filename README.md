# CTVFL: Compile-Time Visual Format Language

[![Build Status](https://travis-ci.com/WeZZard/CTVFL.svg?branch=master)](https://travis-ci.com/WeZZard/CTVFL)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

[中文](./使用說明.md)

CTVFL is a tiny framework offers compile-time safe Visual Format Langauge to
make Auto Layout painless on Apple platforms.

## Grammar

```swift
// Make constraints and install.

constrain {
    withVFL(H: view1 - view2)
}

constrain {
    withVFL(H: view1 - 10 - view2)
}

constrain {
    withVFL(H: view3 | view4, options: .alignAllCenterX)
}

// Just make constraints.

let constraints = withVFL(H: view1 - 10 - view2);
```

## Performance Benchmark

10000 times constraitns build time:

<div>
    <img src="https://github.com/WeZZard/CTVFL/raw/master/.README.d/benchmark-1-view.png" alt="1 View Constraining" width="200px"/>
    <img src="https://github.com/WeZZard/CTVFL/raw/master/.README.d/benchmark-2-views.png" alt="2 Views Constraining" width="200px"/>
    <img src="https://github.com/WeZZard/CTVFL/raw/master/.README.d/benchmark-3-views.png" alt="3 Views Constraining" width="200px"/>
</div>

## Advantages

- Safe
  
  No runtime exceptions anymore. All errors are eliminated at compile-time.

- High performance
  
  CTVFL implements a virtual machine to execute compile-time checked auto
  layout syntax.

- Supports layout guide.
  
  Layout guides can only to be placed at the head or tail side of the syntax.

## Usages

Most of the time, you only have to use three functions in CTVFL:

- `withVFL(H:)` generates horizontal constraints.

- `withVFL(V:)` generates vertical constraints.

- `constrain` collects constraints generated inside its closure and
  install those constraints to relative views.

### Making Native Cocoa Constraints

You can just make constraints without installing them to the views with
a call to `withVFL` outside the `constrain` function.

```swift
// [button]-[textField]
let constraint0 = withVFL(H: button - textField)

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

// view.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor)
let constraint9 = withVFL(V: view.safeAreaLayoutGuide - view)
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

## CTVFLTransaction

CTVFLTransaction runs an implicit transaction. Any constraints generated
by `withVFL` series functions would not be collected by this implicit
transaction. Once you begin an explicit transaction by calling `begin()`,
the transaction begins to collect all the layout constraints generated by
`withVFL`. Of course, calls to `CTVFLTransaction.begin()` and
`CTVFLTransaction.end()` shall be balanced.

## License

MIT License
