#if canImport(UIKit)
import UIKit

public enum MeasurementType : CaseIterable {
    case general
    case user
    case session
    case trafficSources
    case systemInfo
    case hit
    case contentInformation
    case apps
    case events
    case socialInteractions
    case exceptions
    case customDimensions
    case customMetrics

    var required: [String] {
        switch self {
        case .events: return ["v", "tid", "ea", "ec"]
        case .hit: return ["v", "tid", "t"]
        case .socialInteractions: return ["v", "tid", "sn", "sa", "st"]
        default: return ["v", "tid"]
        }
    }
}

#endif
