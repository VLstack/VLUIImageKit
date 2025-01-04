// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLUIImageKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLUIImageKit",
                                targets: [ "VLUIImageKit" ])
                      ],
                      targets:
                      [
                       .target(name: "VLUIImageKit")
                      ])
