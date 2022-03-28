// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DSBridge-IOS",
    products: [
        .library(
            name: "DSBridge-IOS",
            targets: ["DSBridge-IOS"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DSBridge-IOS",
            dependencies: [],
            path: "dsbridge",
            publicHeadersPath: ".",
            cSettings: [.headerSearchPath(".")])
    ]
)
