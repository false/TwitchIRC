// swift-tools-version:5.1.0

import PackageDescription

let package = Package(
    name: "TwitchIRC",
    products: [
        .library(
            name: "TwitchIRC",
            targets: ["TwitchIRC"]),
    ],
    targets: [
        .target(name: "TwitchIRC"),
        .testTarget(
            name: "TwitchIRCTests",
            dependencies: ["TwitchIRC"]),
    ]
)
