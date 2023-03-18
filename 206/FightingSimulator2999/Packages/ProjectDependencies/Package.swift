// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProjectDependencies",
    platforms: [ .iOS(.v16), .macOS(.v13) ],
    products: [
        .library(
            name: "ProjectDependencies",
            targets: [ "ProjectDependencies" ]
        ),
    ],
    dependencies: [
//        .package(url: "https://...", from: "4.0.0"),
        .package(path: "../Services"),
    ],
    targets: [
        .target(
            name: "ProjectDependencies",
            dependencies: [
                .product(
                    name: "FightingServices",
                    package: "Services"
                ),
                .product(
                    name: "PlayerServices",
                    package: "Services"
                ),
            ],
            path: "ProjectDependencies"
        ),
    ]
)
