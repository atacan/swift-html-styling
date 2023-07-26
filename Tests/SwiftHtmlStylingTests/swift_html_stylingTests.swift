import SwiftCss
import SwiftHtml
import XCTest

@testable import SwiftHtmlStyling

final class swift_html_stylingTests: XCTestCase {
    // MARK: - Properties

    func testStyleProperty() {
        let doc = Document {
            Span("").style(Padding(.initial))
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="padding:initial"></span>"#, html)
    }

    func testStyleProperties() {
        let doc = Document {
            Span("").style([Padding(.initial), Margin(.inherit)])
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="padding:initial;margin:inherit"></span>"#, html)
    }

    func testStylePropertyBuilder() {
        let doc = Document {
            Span("")
                .style {
                    Padding(.initial)
                    Margin(.inherit)
                }
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="padding:initial;margin:inherit"></span>"#, html)
    }

    func testStyleManipulation() {
        let doc = Document {
            Span("")
                .style(Padding(.initial), Margin(.inherit))
                .style(add: [FontFamily(.family("monospace")), FontSize(.large)])
                .style(remove: [Margin(.inherit), Padding(.initial)])
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="font-family:monospace;font-size:large"></span>"#, html)
    }

    func testAddStyle() {
        let doc = Document {
            Span("")
                .style("a", "b", "c")
                .style(add: [FontFamily(.family("monospace")), FontSize(.large)])
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="a;b;c;font-family:monospace;font-size:large"></span>"#, html)
    }

    func testRemoveStyle() {
        let doc = Document {
            Span("")
                .style([Margin(.inherit), Padding(.initial)])
                .style(removeByKey: "padding")
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="margin:inherit"></span>"#, html)
    }

    func testRemoveStyleProperty() {
        let doc = Document {
            Span("")
                .style([Margin(.inherit), Padding(.initial)])
                .style(remove: Padding(.initial))
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="margin:inherit"></span>"#, html)
    }

    func testRemoveLastStyle() {
        let doc = Document {
            Span("")
                .style(Padding(.initial), Margin(.inherit))
                .style(remove: [Margin(.inherit), Padding(.initial)])
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span></span>"#, html)
    }

    func testAddStylePropertyBuilder() {
        let doc = Document {
            Span("")
                .style("a", "b", "c")
                .style(addIf: true) {
                    FontFamily(.family("monospace"))
                    FontSize(.large)
                }
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="a;b;c;font-family:monospace;font-size:large"></span>"#, html)
    }

    func testRemoveStylePropertyBuilder() {
        let doc = Document {
            Span("")
                .style("a", "b", "c")
                .style(addIf: true) {
                    FontFamily(.family("monospace"))
                    FontSize(.large)
                }
                .style(removeIf: true) {
                    FontFamily(.family("monospace"))
                    FontSize(.large)
                }
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="a;b;c"></span>"#, html)
    }

    // MARK: - Modifiers

    func testTagStyleModifier() {
        let doc = Document {
            Span("").padding(.initial)
        }
        let html = DocumentRenderer(minify: true).render(doc)
        XCTAssertEqual(#"<span style="padding:initial"></span>"#, html)
    }
}
