
#if canImport(UIKit)
import UIKit

public enum Error: Swift.Error, LocalizedError {
    case keys([String])

    public var localizedDescription: String {
        switch self {
        case let .keys(value): return "Required keys: \(value.joined(separator: ", "))"
        }
    }

    public var errorDescription: String? {
        switch self {
        case let .keys(value): return "Required keys: \(value.joined(separator: ", "))"
        }
    }

    public var failureReason: String? {
        switch self {
        case let .keys(value): return "Required keys: \(value.joined(separator: ", "))"
        }
    }

    public var helpAnchor: String? {
        switch self {
        case let .keys(value): return "Required keys: \(value.joined(separator: ", "))"
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .keys(value): return "Required keys: \(value.joined(separator: ", "))"
        }
    }
}

#endif
