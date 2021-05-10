import UIKit

enum UserAgent {
    case chrome
    case mozilla

    var value: String {
        switch self {
        case .chrome: return "Mozilla/5.0 (iPhone; CPU iPhone OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1"
        case .mozilla: return "Mozilla/5.0 (iPhone; CPU iPhone OS \(UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")) like Mac OS X) AppleWebKit/603.1.23 (KHTML, like Gecko) Version/10.0 Mobile/14E5239e Safari/602.1"
        }
    }
}
