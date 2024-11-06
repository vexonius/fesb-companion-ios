import ProjectDescription

let project = Project(
    name: "FESBCompanion",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.2"),
        .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.2.2")
    ],
    targets: [
        .target(
            name: "FESBCompanion",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.etino.FESBCompanion",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["FESBCompanion/Sources/**"],
            resources: ["FESBCompanion/Resources/**"],
            dependencies: [
                .package(product: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "FESBCompanionTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.etino.FESBCompanionTests",
            infoPlist: .default,
            sources: ["FESBCompanion/Tests/**"],
            resources: [],
            dependencies: [.target(name: "FESBCompanion")]
        ),
    ]
)
