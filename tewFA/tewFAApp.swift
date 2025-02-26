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
                .onAppear {
                    if let window = NSApplication.shared.windows.first {
                        window.titlebarAppearsTransparent = true
                        window.isOpaque = false
                        window.backgroundColor = .clear // Set the background color to clear
                        window.styleMask.insert(.fullSizeContentView)
                    }
                }
                .frame(minWidth: 550, minHeight: 350)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About tewFA") {
                    AboutWindowController.shared.showAboutView()
                }
            }
        }
        .defaultSize(CGSize(width: 1024, height: 768))
    }
}
