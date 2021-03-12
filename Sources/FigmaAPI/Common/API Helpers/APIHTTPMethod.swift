
import Foundation

enum APIHTTPMethod: String {

    case head = "HEAD"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"

    var asString: String {
        rawValue
    }
}
