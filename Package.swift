// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-html-styling",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "swift-html-styling",
            targets: ["swift-html-styling"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/atacan/BinaryBirds-swift-css", branch: "for-html-styling"),
        .package(url: "https://github.com/atacan/BinaryBirds-swift-html", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "swift-html-styling",
            dependencies: [
                .product(name: "SwiftCss", package: "BinaryBirds-swift-css"),
                .product(name: "SwiftHtml", package: "BinaryBirds-swift-html"),
            ]
        ),
        .testTarget(
            name: "swift-html-stylingTests",
            dependencies: ["swift-html-styling"]
        ),
    ]
)
