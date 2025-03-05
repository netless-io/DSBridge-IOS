// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NTLBridge",
    products: [
        .library(
            name: "NTLBridge",
            targets: ["NTLBridge"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NTLBridge",
            dependencies: [],
            path: "dsbridge",
            publicHeadersPath: ".",
            cSettings: [.headerSearchPath(".")])
    ]
)
