
import Foundation

public class FigmaAPI {

    public typealias ResultHandler<T> = (APIResult<T>) -> Void
    public typealias NoValueResult = APIResult<APINoValue>

    let requestBuilder: FigmaAPIRequestBuilder
    let requestPerformer: APIRequestPerformer

    public init(environmentProvider: FigmaAPIEnvironmentProvider, requestPerformer: APIRequestPerformer) {
        self.requestBuilder = FigmaAPIRequestBuilder(environmentProvider: environmentProvider)
        self.requestPerformer = requestPerformer
    }
    
    // MARK: - Convenience helper
    
    public func defaultNoValueResultHandler(_ result: NoValueResult, completion: ResultHandler<Void>) {
        switch result {
        case .success(_):
            completion(.success(()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
