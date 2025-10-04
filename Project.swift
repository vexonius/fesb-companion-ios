import ProjectDescription

let project = Project(
    name: "FESBCompanion",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.22.3"),
        .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.5.1"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.1")
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
                    "UIAppFonts": [
                        "Inter-Regular.otf",
                        "Inter-SemiBold.otf",
                        "Inter-Bold.otf",
                        "Inter-Medium.otf",
                        "Inter-Black.otf"
                    ]
                ]
            ),
            sources: ["FESBCompanion/Sources/**"],
            resources: ["FESBCompanion/Resources/**"],
            scripts: [
                .post(path: .path("./FESBCompanion/Scripts/swiftlint.sh"), arguments: "", name: "Swiftlint")
            ],
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "Algorithms"),
                .xcframework(path: "./shared.xcframework")
            ],
            settings: .settings(
                base: SettingsDictionary()
                    .automaticCodeSigning(devTeam: "G94YBLPX8A")
                )
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
