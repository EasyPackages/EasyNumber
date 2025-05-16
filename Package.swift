// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EasyNumber",
    products: [
        .library(name: "EasyNumber", targets: ["EasyNumber"]),
    ],
    dependencies: [
        .package(path: "../EasyCore")
    ],
    targets: [
        .target(name: "EasyNumber", dependencies: ["EasyCore"]),
        .testTarget(
            name: "EasyNumberTests",
            dependencies: ["EasyNumber"]
        ),
    ]
)
