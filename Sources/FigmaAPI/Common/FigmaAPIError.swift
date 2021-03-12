
import Foundation

public enum FigmaAPIError: LocalizedError {

    case unknown
    case general(Error)
    case invalidURL(String)
    case httpErrorCode(Int)
    case decodingError(DecodingError)
    case invalidParameter(String)
    case errorResponse(String?)
    case tooManyRequests

    public var errorDescription: String? {
        switch self {
        case .unknown: return "Unknown API error."
        case .general(let error): return "API error: \(error.localizedDescription)"
        case .invalidURL(let urlString): return "Invalid URL: \(urlString)"
        case .httpErrorCode(let errorCode): return "HTTP Error Code: \(errorCode)"
        case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
        case .invalidParameter(let string): return "Invalid parameter: \(string)"
        case .errorResponse(let string): return "Error response: \(string ?? "Unknown error")"
        case .tooManyRequests: return "Server is currently busy."
        }
    }
}
