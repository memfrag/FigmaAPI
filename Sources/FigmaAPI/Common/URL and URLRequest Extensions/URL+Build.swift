
import Foundation

extension URL {

    static func buildURL(baseURL: URL, path: String? = nil, parameters: [String: Any] = [:]) -> URL {

        let url: URL
        if let path = path {
            url = baseURL.appendingPathComponent(path)
        } else {
            url = baseURL
        }

        guard !parameters.isEmpty else {
            return url
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = parameters.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
        urlComponents?.queryItems = queryItems
        let urlWithComponents = urlComponents?.url
        return urlWithComponents ?? url
    }
}
