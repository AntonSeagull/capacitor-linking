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
        let canOpen = UIApplication.shared.canOpenURL(url)
        call.resolve([
            "canOpen": canOpen
        ])
    }
}