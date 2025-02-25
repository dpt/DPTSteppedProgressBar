// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "DPTSteppedProgressBar",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "DPTSteppedProgressBar",
            targets: ["DPTSteppedProgressBar"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DPTSteppedProgressBar",
            dependencies: []),
        .testTarget(
            name: "DPTSteppedProgressBarTests",
            dependencies: ["DPTSteppedProgressBar"]),
    ]
) 