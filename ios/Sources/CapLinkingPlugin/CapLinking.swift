import Foundation

@objc public class CapLinking: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
