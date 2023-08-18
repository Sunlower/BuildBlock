// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Building-WWDC23",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Building-WWDC23",
            targets: ["AppModule"],
            bundleIdentifier: "com.Ieda.DailyDoodle.BuildCastle-WWDC23",
            teamIdentifier: "QW8X8R78UC",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ],
            capabilities: [
                .fileAccess(.pictureFolder, mode: .readWrite),
                .camera(purposeString: "Building wants to access your camera to build the castle in augmented reality")
            ],
            appCategory: .kidsGames
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Sunlower/FocusEntity.git", .branch("main"))
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "FocusEntity", package: "focusentity")
            ],
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
