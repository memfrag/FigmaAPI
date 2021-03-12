
import Foundation
import Combine

public extension FigmaAPI {

    typealias ProjectsResult = APIResult<FigmaTeamProjects>

    // MARK: - Get Projects

    /// Get Projects
    ///
    /// You can use this Endpoint to get a list of all the Projects within the
    /// specified team. This will only return projects visible to the
    /// authenticated user or owner of the developer token. Note: it is not
    /// currently possible to programmatically obtain the team id of a user
    /// just from a token. To obtain a team id, navigate to a team page of a
    /// team you are a part of. The team id will be present in the URL after
    /// the word team and before your team name.
    ///
    /// - Parameter teamID: Team to list projects from
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    func getProjects(for teamID: String,
                    completion: @escaping ResultHandler<FigmaTeamProjects>) {
        do {
            let request = try requestBuilder.makeRequest(
                path: "teams/\(teamID)/projects",
                method: .get,
                parameters: [:]) { (result: ProjectsResult) in
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
    
    /// Get Projects
    ///
    /// You can use this Endpoint to get a list of all the Projects within the
    /// specified team. This will only return projects visible to the
    /// authenticated user or owner of the developer token. Note: it is not
    /// currently possible to programmatically obtain the team id of a user
    /// just from a token. To obtain a team id, navigate to a team page of a
    /// team you are a part of. The team id will be present in the URL after
    /// the word team and before your team name.
    ///
    /// - Parameter teamID: Team to list projects from
    func getProjects(for teamID: String) -> AnyPublisher<FigmaTeamProjects, FigmaAPIError> {
        Future { [weak self] promise in
            self?.getProjects(for: teamID) { result in
                switch result {
                case .success(let projects):
                    promise(.success(projects))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
