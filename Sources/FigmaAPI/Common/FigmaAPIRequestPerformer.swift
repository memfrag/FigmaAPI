
import Foundation

class FigmaAPIRequestPerformer: APIRequestPerformer {
    
    private let urlSession: URLSession
    
    private let environmentProvider: FigmaAPIEnvironmentProvider
    
    init(urlSession: URLSession = .shared, environmentProvider: FigmaAPIEnvironmentProvider) {
        self.urlSession = urlSession
        self.environmentProvider = environmentProvider
    }

    // MARK: - Perform Request

    func perform(_ request: APIRequest) {

        request.incrementTryCount()
        
        #if DEBUG
        logRequest(request)
        #endif

        let task = urlSession.dataTask(with: request.urlRequest) { [weak self] (data, response, error) in

            do {

                guard let data = data, let response = response as? HTTPURLResponse else {
                    throw error.map { FigmaAPIError.general($0) } ?? FigmaAPIError.unknown
                }
                
                #if DEBUG
                self?.logResponse(response, data: data, request: request)
                #endif

                switch response.statusCode {

                case 200...299: // Success
                    break

                default: // Any other status code is treated as an error
                    throw FigmaAPIError.httpErrorCode(response.statusCode)
                }
                
                try request.handleResponse(data: data)

            } catch let error as FigmaAPIError {
                request.handleFailure(error: error)
            } catch let error as DecodingError {
                request.handleFailure(error: .decodingError(error))
            } catch {
                request.handleFailure(error: .general(error))
            }
        }
        
        task.resume()
    }

    // MARK: - Retry Request

    private func retry(_ request: APIRequest) throws {

        guard request.tryCount < request.maxTryCount else {
            throw FigmaAPIError.tooManyRequests
        }

        // Exponential backoff with jitter
        let k = pow(2, Double(max(0, request.tryCount - 1)))
        let baseTime = 2.0 // seconds
        let backoffTime = jittered(value: baseTime * k, interval: 0.25) // 25% jitter

        DispatchQueue.global().asyncAfter(deadline: .now() + backoffTime) { [weak self] in
            self?.perform(request)
        }
    }

    private func jittered(value: Double, interval: Double) -> Double {
        return value * (1 + interval * (Double.random(in: 0..<1) * 2.0 - 1.0))
    }
    
    // MARK: - Debug Logging

    #if DEBUG
    private func logRequest(_ request: APIRequest) {
        guard apiLogTypes.contains(.url)
            || apiLogTypes.contains(.requestBody)
            || apiLogTypes.contains(.urlRequest) else {
            return
        }
        print("[API] ----- Request \(request.id) --- Try \(request.tryCount) -----")
        if apiLogTypes.contains(.url) {
            print("[API] Method: \(request.urlRequest.httpMethod ?? "N/A")")
            print("[API] URL: \(request.urlRequest.url?.absoluteString ?? "nil")")
        }
        if apiLogTypes.contains(.requestBody) {
            if let data = request.urlRequest.httpBody {
                print("Body:")
                if let body = prettyPrintedJSON(data: data) {
                    print(body)
                } else {
                    print(String(data: data, encoding: .utf8) ?? "<Not UTF8>")
                }
            }
        }
        if apiLogTypes.contains(.urlRequest) {
            dump(request)
        }
        print("[API] ----- End of Request \(request.id) -----\n")
    }
    
    private func logResponse(_ response: HTTPURLResponse, data: Data, request: APIRequest) {
        guard apiLogTypes.contains(.responseCode)
            || apiLogTypes.contains(.responseBody) else {
            return
        }
        print("[API] ----- Response \(request.id) --- Try \(request.tryCount) -----")
        if apiLogTypes.contains(.responseCode) {
            print("[API] Status: \(response.statusCode)")
            print("[API] Try: \(request.tryCount)")
        }
        if apiLogTypes.contains(.responseBody) {
            print("Body:")
            if let body = prettyPrintedJSON(data: data) {
                print(body)
            } else {
                print(String(data: data, encoding: .utf8) ?? "<Not UTF8>")
            }
        }
        print("[API] ----- End of Response \(request.id) -----\n")
    }
    
    private func prettyPrintedJSON(data: Data) -> String? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
            let prettifiedJSON = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(data: prettifiedJSON, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    #endif
}

let json = """
{
  "lastModified" : "2020-08-18T22:35:12.366761Z"
}
""".data(using: .utf8)!
