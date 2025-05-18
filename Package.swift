// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EasyNumber",
    products: [
        .library(name: "EasyNumber", targets: ["EasyNumber"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/EasyPackages/EasyCore.git",
            .upToNextMajor(from: "0.0.1")
        )
    ],
    targets: [
        .target(name: "EasyNumber", dependencies: ["EasyCore"]),
        .testTarget(
            name: "EasyNumberTests",
            dependencies: ["EasyNumber"]
        ),
    ]
)
