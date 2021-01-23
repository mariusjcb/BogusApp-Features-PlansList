// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BogusApp-Features-ChannelsList",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BogusApp-Features-ChannelsList",
            targets: ["BogusApp-Features-ChannelsList"]),
    ],
    dependencies: [
        .package(name: "BogusApp-Common-Models", url: "../../Common/BogusApp-Common-Models", .branch("master")),
        .package(name: "BogusApp-Common-Utils", url: "../../Common/BogusApp-Common-Utils", .branch("master")),
        .package(name: "BogusApp-Common-Networking", url: "../../Common/BogusApp-Common-Networking", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BogusApp-Features-ChannelsList",
            dependencies: [
                .product(name: "BogusApp-Common-Models", package: "BogusApp-Common-Models"),
                .product(name: "BogusApp-Common-Utils", package: "BogusApp-Common-Utils"),
                .product(name: "BogusApp-Common-Networking", package: "BogusApp-Common-Networking")
            ]),
        .testTarget(
            name: "BogusApp-Features-ChannelsListTests",
            dependencies: ["BogusApp-Features-ChannelsList"]),
    ]
)
