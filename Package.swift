// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Analytics",
    products: [
        .library(
            name: "Analytics",
            targets: ["Analytics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.1")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.1.2")),
    ],
    targets: [
        .target(
            name: "Analytics",
            dependencies: []),
        .testTarget(
            name: "AnalyticsTests",
            dependencies: ["Analytics"]),
    ]
)
