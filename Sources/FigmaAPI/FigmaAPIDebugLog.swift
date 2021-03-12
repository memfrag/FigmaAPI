
import Foundation

// MARK: - Debug Logging

#if DEBUG

public enum APILogType {
    case url
    case urlRequest
    case requestBody
    case responseCode
    case responseBody
}

public var apiLogTypes: [APILogType] = []

#endif
