import Foundation
import Capacitor

@objc(CapLinkingPlugin)
public class CapLinkingPlugin: CAPPlugin {
    public let identifier = "CapLinkingPlugin"
    public let jsName = "CapLinking"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "openURL", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "canOpenURL", returnType: CAPPluginReturnPromise)
    ]

    @objc func openURL(_ call: CAPPluginCall) {
        guard let urlString = call.getString("url"), let url = URL(string: urlString) else {
            call.reject("Invalid URL")
            return
        }
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                call.resolve()
            } else {
                call.reject("Cannot open URL")
            }
        }
    }

  @objc func canOpenURL(_ call: CAPPluginCall) {
        guard let urlString = call.getString("url"), let url = URL(string: urlString) else {
            call.reject("Invalid URL")
            return
        }

        // Check if running in an App Extension
        if Bundle.main.bundlePath.hasSuffix(".appex") {
            call.resolve(["canOpen": false])
            return
        }

        // Check if the URL can be opened
        DispatchQueue.main.async {
            let canOpen = UIApplication.shared.canOpenURL(url)
            let scheme = url.scheme?.lowercased() ?? ""

            if canOpen {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    call.resolve(["canOpen": success])
                })
            } else if !scheme.hasPrefix("http") && !scheme.hasPrefix("https") {
                // Check if the custom scheme is in LSApplicationQueriesSchemes
                if let querySchemes = Bundle.main.object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String], querySchemes.contains(where: { $0.caseInsensitiveCompare(scheme) == .orderedSame }) {
                    call.resolve(["canOpen": false])
                } else {
                    call.reject("Unable to open URL: \(urlString). Add \(scheme) to LSApplicationQueriesSchemes in your Info.plist.")
                }
            } else {
                call.resolve(["canOpen": false])
            }
        }
    }
}