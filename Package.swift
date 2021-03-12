// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FigmaAPI",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "FigmaAPI", targets: ["FigmaAPI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FigmaAPI",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ]),
    ]
)
