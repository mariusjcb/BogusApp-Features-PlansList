// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BogusApp-Features-PlansList",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BogusApp-Features-PlansList",
            targets: ["BogusApp-Features-PlansList"]),
    ],
    dependencies: [
        .package(name: "BogusApp-Common-Models", url: "../../Common/BogusApp-Common-Models", .branch("master")),
        .package(name: "BogusApp-Common-Utils", url: "../../Common/BogusApp-Common-Utils", .branch("master")),
        .package(name: "BogusApp-Common-Networking", url: "../../Common/BogusApp-Common-Networking", .branch("master")),
        
        // SwiftLint & Komondor
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.28.1"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.6"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BogusApp-Features-PlansList",
            dependencies: [
                .product(name: "BogusApp-Common-Models", package: "BogusApp-Common-Models"),
                .product(name: "BogusApp-Common-Utils", package: "BogusApp-Common-Utils"),
                .product(name: "BogusApp-Common-Networking", package: "BogusApp-Common-Networking")
            ]),
        .testTarget(
            name: "BogusApp-Features-PlansListTests",
            dependencies: ["BogusApp-Features-PlansList"]),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-push": "swift test",
            "pre-commit": [
                "swift test",
                "swift run swiftlint autocorrect --path Sources/",
                "git add .",
            ],
        ],
    ]).write()
#endif

