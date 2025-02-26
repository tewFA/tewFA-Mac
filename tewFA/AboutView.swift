//
//  AboutView.swift
//  tewFA
//
//  Created by ash on 2/23/25.
//

import SwiftUI

class AboutWindowController: NSObject {
    private var window: NSWindow?

    static let shared = AboutWindowController()
    
    private override init() {
        super.init()
    }

    func showAboutView() {
        if window == nil {
            let aboutView = AboutView()
            let hostingController = NSHostingController(rootView: aboutView)

            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
                styleMask: [.titled, .closable, .fullSizeContentView],
                backing: .buffered,
                defer: false
            )
            
            window.center()
            window.titlebarAppearsTransparent = true
            window.contentViewController = hostingController
            window.isReleasedWhenClosed = false

            self.window = window
        }

        window?.makeKeyAndOrderFront(nil)
    }
}

struct AboutView: View {
    private var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Unknown"
    }
    
    @State private var isLatestVersion: Bool = true

    var body: some View {
        VStack {
            Image(nsImage: NSApplication.shared.applicationIconImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            HStack(spacing: 5) {
                Text("tewFA")
                    .font(.title)
                Text(appVersion)
                    .foregroundStyle(.foreground.opacity(0.8))
            }
            Spacer()
            
            Text("Thanks for using tewFA for Mac!")
            Text("Made with <3 by ash.")
        }
        .navigationTitle("About")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    if let url = URL(string: "https://github.com/tewfa/tewfa") {
                        NSWorkspace.shared.open(url)
                    }
                }) {
                    Label("GitHub", systemImage: "globe")
                }
            }
        }
        .padding(30)
        .frame(width: 300, height: 250)
        .background(VisualEffectView(material: .sidebar, blendingMode: .behindWindow).edgesIgnoringSafeArea(.all))
    }
}

struct GitHubRelease: Codable {
    var tag_name: String
}

#Preview {
    AboutView()
}
