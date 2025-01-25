import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView(urlString: "https://tewfa.pages.dev/")
            .background(VisualEffectView(material: .sidebar, blendingMode: .behindWindow))
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: NSViewRepresentable {
    let urlString: String
    
    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        // CSS Injection
        let cssInjectionScript = WKUserScript(
            source: """
            (function() {
                var style = document.createElement('style');
                style.innerHTML = `
                    body {
                        background: transparent;
                    }
            
                    #passcode-setup-screen, #passcode-lock-screen, #add-token-form {
                        background: transparent;
                    }
            
                    #export-button {
                        display: none;
                    }
                `;
                document.head.appendChild(style);
            })();
            """,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        
        userContentController.addUserScript(cssInjectionScript)
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        // Configure WebView appearance
        webView.setValue(false, forKey: "drawsBackground")
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {}
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = .active
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
