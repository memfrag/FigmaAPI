
import Foundation
import Combine

public extension FigmaAPI {
    
    typealias FileStylesResult = APIResult<FigmaAPIMetaResponse<FigmaStyles>>

    // MARK: - Get File Styles

    /// Get a list of published styles within a file library
    ///
    /// - Parameter fileID: File to get JSON styles from
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    ///
    func getFileStyles(_ fileID: String,
                       completion: @escaping ResultHandler<[FigmaStyleDetails]>) {
        do {
            let request = try requestBuilder.makeRequest(
                path: "files/\(fileID)/styles",
                method: .get) { (result: FileStylesResult) in
               switch result {
               case .success(let meta):
                completion(.success(meta.meta.styles))
               case .failure(let error):
                   completion(.failure(error))
               }
            }
            
            requestPerformer.perform(request)
            
        } catch {
            completion(.failure(FigmaAPIError.general(error)))
        }
    }
    
    /// Get a list of published styles within a file library
    ///
    /// - Parameter fileID: File to get JSON styles from
    func getFileStyles(_ fileID: String) -> AnyPublisher<[FigmaStyleDetails], FigmaAPIError> {
        Future { [weak self] promise in
            self?.getFileStyles(fileID) { result in
                switch result {
                case .success(let styles):
                    promise(.success(styles))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
