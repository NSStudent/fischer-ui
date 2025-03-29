// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FischerUI",
    products: [
        .library(
            name: "FischerUI",
            targets: ["FischerUI"]),
    ],
    targets: [
        .target(
            name: "FischerUI"),
        .testTarget(
            name: "FischerUITests",
            dependencies: ["FischerUI"]
        )
    ]
)
