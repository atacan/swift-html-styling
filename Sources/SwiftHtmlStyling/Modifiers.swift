import SwiftCss
import SwiftHtml

extension Tag {
    public func padding(_ value: String) -> Self {
        let property = Property(name: "padding", value: value)
        return style(property)
    }

    /// Sets all the Padding properties in one declaration
    public func padding(_ value: PaddingValue = .length(.zero)) -> Self {
        style(Padding(value))
    }

    public func padding(_ value: Unit = .zero) -> Self {
        style(Padding(value))
    }

    public func padding(horizontal: PaddingValue = .length(.zero), vertical: PaddingValue = .length(.zero)) -> Self {
        style(Padding(horizontal: horizontal, vertical: vertical))
    }

    public func padding(horizontal: Unit = .zero, vertical: Unit = .zero) -> Self {
        style(Padding(horizontal: horizontal, vertical: vertical))
    }

    public func padding(
        top: PaddingValue = .length(.zero),
        right: PaddingValue = .length(.zero),
        bottom: PaddingValue = .length(.zero),
        left: PaddingValue = .length(.zero)
    ) -> Self {
        style(Padding(top: top, right: right, bottom: bottom, left: left))
    }

    public func padding(top: Unit = .zero, right: Unit = .zero, bottom: Unit = .zero, left: Unit = .zero) -> Self {
        style(Padding(top: top, right: right, bottom: bottom, left: left))
    }
}
