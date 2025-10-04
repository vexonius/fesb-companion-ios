// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "FESBCompanion",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.22.3"),
        .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.5.1"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.1"),
    ]
)
