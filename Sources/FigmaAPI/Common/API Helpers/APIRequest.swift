
import Foundation

public protocol APIRequest: AnyObject {
    
    #if DEBUG
    var id: Int { get }
    #endif
    
    /// Number of times this request has been tried. Increased when perform is called.
    var tryCount: Int { get }

    /// Maximum number of times this request should be retried if it fails due to e.g. 429.
    var maxTryCount: Int { get }

    /// The actual `URLRequest` to perform using `URLSession`.
    var urlRequest: URLRequest { get }

    /// Handle the response data from a performed request.
    /// Typical behavior would be to decode the data and pass the value on to a completion handler.
    func handleResponse(data: Data) throws

    /// Handle failure of a performed request.
    /// Typical behavior would be to pass the error on to a completion handler.
    func handleFailure(error: FigmaAPIError)

    /// Called when the request is performed to increase the `tryCount` property.
    func incrementTryCount()
}
