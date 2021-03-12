
import Foundation

public class APIDecodingRequest<T: Decodable>: APIRequest {

    public typealias ResultHandler<T> = (APIResult<T>) -> Void

    #if DEBUG
    public var id: Int = nextRequestID()
    #endif
    
    public let completion: ResultHandler<T>

    public let maxTryCount: Int

    private(set) public var tryCount: Int = 0

    private(set) public var urlRequest: URLRequest

    public init(urlRequest: URLRequest, completion: @escaping ResultHandler<T>, maxTryCount: Int = 5) {
        self.urlRequest = urlRequest
        self.completion = completion
        self.maxTryCount = maxTryCount
    }

    public func handleResponse(data: Data) throws {
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: data)
        completion(.success(value))
    }

    public func handleFailure(error: FigmaAPIError) {
        completion(.failure(error))
    }
    
    public func incrementTryCount() {
        tryCount += 1
    }
}

private struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
    
    init(validatedStringValue: String) {
        stringValue = validatedStringValue
    }
}

#if DEBUG
var currentRequestID: Int = 0
func nextRequestID() -> Int {
    currentRequestID += 1
    return currentRequestID
}
#endif
