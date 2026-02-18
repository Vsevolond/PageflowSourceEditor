// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PageflowSourceEditor",
    platforms: [.macOS(.v13)],
    products: [
        // A source editor with useful features for code editing.
        .library(
            name: "PageflowSourceEditor",
            targets: ["PageflowSourceEditor"]
        )
    ],
    dependencies: [
        // A fast, efficient, text view for code.
        .package(
            url: "https://github.com/CodeEditApp/CodeEditTextView.git",
            from: "0.12.1"
        ),
        // tree-sitter languages
        .package(
            url: "https://github.com/Vsevolond/PageflowLanguage.git",
            from: "0.1.0"
        ),
        // CodeEditSymbols
        .package(
            url: "https://github.com/CodeEditApp/CodeEditSymbols.git",
            exact: "0.2.3"
        ),
        // Rules for indentation, pair completion, whitespace
        .package(
            url: "https://github.com/ChimeHQ/TextFormation",
            from: "0.8.2"
        )
    ],
    targets: [
        // A source editor with useful features for code editing.
        .target(
            name: "PageflowSourceEditor",
            dependencies: [
                "CodeEditTextView",
                "PageflowLanguage",
                "TextFormation",
                "CodeEditSymbols"
            ]
        )
    ]
)
