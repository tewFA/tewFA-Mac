//
//  tewFAApp.swift
//  tewFA
//
//  Created by ash on 11/28/24.
//

import SwiftUI

@main
struct tewFAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .background(VisualEffectView(material: .sidebar, blendingMode: .withinWindow))
                .frame(minWidth: 800, minHeight: 500)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .defaultSize(CGSize(width: 1024, height: 768))
    }
}
