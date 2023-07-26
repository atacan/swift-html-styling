# swift-html-styling

This package is connecting [BinaryBirds/swift-html](https://github.com/BinaryBirds/swift-html) and [BinaryBirds/swift-css](https://github.com/BinaryBirds/swift-css). 

## `SwiftCss.Property` in `style` 

Inline styles can be added like this:
    
```swift
Span("").style {
    Padding(.initial)
    Margin(.inherit)
}
```

See the tests for more examples.

## Tag modifiers

This capability enables to have SwiftUI-style modifiers

```swift
Span("")
    .padding(.initial)
    .margin(.inherit)
```
which would render as

```html
<span style="padding:initial;margin:inherit"></span>
```

Note: Only `.padding` is implemented as proof of concept. More to come. 