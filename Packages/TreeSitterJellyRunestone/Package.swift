// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TreeSitterJellyRunestone",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "TreeSitterJellyRunestone", targets: ["TreeSitterJellyRunestone"]),
    ],
    dependencies: [
        .package(url: "https://github.com/simonbs/Runestone", from: "0.2.10"),
        .package(url: "https://github.com/ActuallyTaylor/tree-sitter-jelly", branch: "main")
    ],
    targets: [
        .target(name: "TreeSitterJellyRunestone", dependencies: [
            "Runestone",
            .product(name: "TreeSitterJelly", package: "tree-sitter-jelly"),
            .product(name: "TreeSitterJellyQueries", package: "tree-sitter-jelly")
        ])
    ]
)
