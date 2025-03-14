// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorLinking",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorLinking",
            targets: ["CapLinkingPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CapLinkingPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapLinkingPlugin"),
        .testTarget(
            name: "CapLinkingPluginTests",
            dependencies: ["CapLinkingPlugin"],
            path: "ios/Tests/CapLinkingPluginTests")
    ]
)