// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TriLabelView",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "TriLabelView",
            targets: ["TriLabelView"]
        ),
    ],
    targets: [
        .target(
            name: "TriLabelView",
            path: "TriLabelView",
            exclude: ["Info.plist", "0.1.0", "TriLabelView.h"],
            sources: ["TriLabelView.swift"]
        )
    ]
) 