
import Foundation

class FigmaAPIRequestBuilder {
    
    private let environmentProvider: FigmaAPIEnvironmentProvider

    init(environmentProvider: FigmaAPIEnvironmentProvider) {
        self.environmentProvider = environmentProvider
    }

    func makeRequest<T>(path: String,
                        method: APIHTTPMethod,
                        parameters: [String: Any] = [:],
                        body: Data? = nil,
                        completion: @escaping APIDecodingRequest<T>.ResultHandler<T>) throws -> APIDecodingRequest<T> {

        let environment = environmentProvider.apiEnvironment

        var requestParameters: [String: Any] = environment.figmaAPI.parameters
        
        for (name, value) in parameters {
            requestParameters[name] = value
        }

        let endpointURL = environment.figmaAPI.url
            .appendingPathComponent(path)
        
        let url = URL.buildURL(baseURL: endpointURL,
                               parameters: requestParameters)

        var urlRequest = URLRequest(url: url)
        urlRequest.setMethod(method)
        urlRequest.httpBody = body
        
        urlRequest.setValue(environment.figmaAPI.accessToken, forHTTPHeaderField: "X-Figma-Token")

        let request = APIDecodingRequest(urlRequest: urlRequest,
                                         completion: completion)
        
        return request
    }
}
