// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LifeOSCompanion",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [.library(name: "LifeOSCore", targets: ["LifeOSCore"])],
    targets: [
        .target(name: "LifeOSCore"),
        .testTarget(name: "LifeOSCoreTests", dependencies: ["LifeOSCore"],
                    resources: [.copy("Fixtures")])
    ]
)
