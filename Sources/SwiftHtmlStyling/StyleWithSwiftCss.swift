import SwiftCss
import SwiftHtml

extension Tag {
    /// Specifies one style using SwiftCss Property
    public func style(_ property: Property?, _ condition: Bool = true) -> Self {
        guard let property else {
            return self
        }
        let style = renderProperty(property)
        return attribute("style", style, condition)
    }

    /// Specifies multiple styles using SwiftCss Property
    public func style(_ properties: [Property], _ condition: Bool = true) -> Self {
        let styles = renderProperties(properties)
        return attribute("style", styles, condition)
    }

    /// Specifies multiple styles using SwiftCss @PropertyBuilder
    public func style(_ condition: Bool = true, @PropertyBuilder _ properties: () -> [Property]) -> Self {
        style(properties(), condition)
    }

    /// Specifies multiple stylenames for an element (refers to a style in a style sheet)
    public func style(_ properties: Property...) -> Self {
        style(properties)
    }

    /// Adds a single value to the style list if the condition is true
    ///
    /// Note: If the value is empty or nil it won't be added to the list
    ///
    public func style(add property: Property, _ condition: Bool = true) -> Self {
        style(add: [property], condition)
    }

    /// find an existing style attribute and return the value as an array of strings or an empty array
    private var styleArray: [String] {
        node.attributes.first { $0.key == "style" }?.value?.styleArray ?? []
    }

    /// Adds an array of values to the style list if the condition is true
    ///
    /// Note: If the value is empty it won't be added to the list
    ///
    public func style(add properties: [Property], _ condition: Bool = true) -> Self {
        guard !properties.isEmpty else {
            return self
        }
        let values = properties.map(renderProperty)
        let newValues = styleArray + values

        return style(newValues.styleString, condition)
    }

    public func style(addIf condition: Bool, @PropertyBuilder _ properties: () -> [Property]) -> Self {
        style(add: properties(), condition)
    }

    /// Removes a given style values if the condition is true
    public func style(remove property: Property, _ condition: Bool = true) -> Self {
        let value = renderProperty(property)
        return style(remove: [value], condition)
    }

    /// Removes an array of style values if the condition is true
    public func style(remove properties: [Property], _ condition: Bool = true) -> Self {
        let values = properties.map(renderProperty)
        let newClasses = styleArray.filter { !values.contains($0) }
        if newClasses.isEmpty {
            return deleteAttribute("style")
        }
        return style(newClasses, condition)
    }

    public func style(removeIf condition: Bool, @PropertyBuilder _ properties: () -> [Property]) -> Self {
        style(remove: properties(), condition)
    }
}

private func renderProperty(_ property: Property) -> String {
    property.name + ":" + property.value
}

private func renderProperties(_ properties: [Property]) -> String {
    properties.map(renderProperty).joined(separator: ";")
}

extension String {
    /// turns a list of class values (separated by a space" into an array of strings
    private var classArray: [String] {
        split(separator: " ").map { String($0) }
    }

    /// turns a list of style values (separated by a semicolon) into an array of strings
    fileprivate var styleArray: [String] {
        split(separator: ";").map { String($0) }
    }
}

extension [String] {
    private var classString: String {
        filter { !$0.isEmpty }.joined(separator: " ")
    }

    fileprivate var styleString: String {
        filter { !$0.isEmpty }.joined(separator: ";")
    }
}
