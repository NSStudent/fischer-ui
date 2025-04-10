// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FischerUI",
    platforms: [
        .iOS(.v18),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "FischerUI",
            targets: ["FischerUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/NSStudent/fischer-core.git", branch: "feature/public-access")
    ],
    targets: [
        .target(
            name: "FischerUI",
            dependencies: [
                   .product(name: "FischerCore", package: "fischer-core")
               ],
            resources: [
                    .process("Assets.xcassets")
                ]
        ),
        .testTarget(
            name: "FischerUITests",
            dependencies: ["FischerUI"]
        )
    ]
)
