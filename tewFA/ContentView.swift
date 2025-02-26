import SwiftUI
import WebKit

struct ContentView: View {
    @State private var webView = WKWebView()
    @StateObject private var timerManager = TimerManager()
        
    var body: some View {
        WebView(urlString: "https://tewfa.pages.dev/", webView: webView)
            .onAppear() {
                timerManager.start2FATimer()
            }
            .background(VisualEffectView(material: .sidebar, blendingMode: .behindWindow).ignoresSafeArea())
            .toolbar() {
                ToolbarItem {
                    Button(action: {
                        executeJavaScript("show('add-token-modal')")
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }

                ToolbarItem {
                    Button(action: {
                        executeJavaScript("openSettings()")
                    }) {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                }
            }
    }

    // Function to execute JavaScript inside the WebView
    private func executeJavaScript(_ script: String) {
        webView.evaluateJavaScript(script, completionHandler: { result, error in
            if let error = error {
                print("JavaScript execution error: \(error)")
            }
        })
    }
}

struct WebView: NSViewRepresentable {
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView finished loading, executing JavaScript...")
            parent.webView.evaluateJavaScript("setupClient()", completionHandler: { result, error in
                if let error = error {
                    print("JavaScript execution error after load: \(error)")
                }
            })
        }
    }
    
    let urlString: String
    let webView: WKWebView

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        config.userContentController = userContentController
        
        webView.setValue(false, forKey: "drawsBackground")
        webView.configuration.userContentController = userContentController
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: URL(string: urlString)!))

        return webView
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(parent: self)
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
