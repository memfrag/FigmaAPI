
import Foundation
import Combine

public extension FigmaAPI {

    typealias FilesResult = APIResult<FigmaProjectFiles>

    // MARK: - Get Files

    /// Get Files
    ///
    /// List the files in a given project.
    ///
    /// - Parameter projectID: ID of project to list files from
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    func getFiles(for projectID: String,
                  completion: @escaping ResultHandler<FigmaProjectFiles>) {
        do {
            let request = try requestBuilder.makeRequest(
                path: "projects/\(projectID)/files",
                method: .get,
                parameters: [:]) { (result: FilesResult) in
                    switch result {
                    case .success(let projects):
                        completion(.success(projects))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            
            requestPerformer.perform(request)
            
        } catch {
            completion(.failure(FigmaAPIError.general(error)))
        }
    }
    
    /// Get Files
    ///
    /// List the files in a given project.
    ///
    /// - Parameter projectID: ID of project to list files from
    func getFiles(for projectID: String) -> AnyPublisher<FigmaProjectFiles, FigmaAPIError> {
        Future { [weak self] promise in
            self?.getFiles(for: projectID) { result in
                switch result {
                case .success(let figmaProjectFiles):
                    promise(.success(figmaProjectFiles))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
