
import Foundation
import Combine

public extension FigmaAPI {

    typealias FileResult = APIResult<FigmaFile>

    // MARK: - Get File

    /// Get file
    ///
    /// Returns the document refered to by :key as a JSON object. The file key
    /// can be parsed from any Figma file url: https://www.figma.com/file/:key/:title.
    /// The name, lastModified, thumbnailUrl, and version attributes are all
    /// metadata of the retrieved file. The document attribute contains a Node
    /// of type DOCUMENT.
    ///
    /// The components key contains a mapping from node IDs to component
    /// metadata. This is to help you determine which components each instance
    /// comes from.
    ///
    /// - Parameter fileID: File to export JSON from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: Comma separated list of nodes that you care about
    ///                  in the document. If specified, only a subset of the
    ///                  document will be returned corresponding to the nodes
    ///                  listed, their children, and everything between the
    ///                  root node and the listed nodes.
    /// - Parameter depth: Optional positive integer representing how deep
    ///                    into the document tree to traverse. For example,
    ///                    setting this to 1 returns only Pages, setting it
    ///                    to 2 returns Pages and all top level objects on
    ///                    each page. Not setting this parameter returns all
    ///                    nodes.
    /// - Parameter paths: Set to true to export vector data.
    /// - Parameter pluginData: A comma separated list of plugin IDs and/or
    ///                         the string "shared". Any data present in the
    ///                         document written by those plugins will be
    ///                         included in the result in the `pluginData`
    ///                         and `sharedPluginData` properties.
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    ///
    func getFile(_ fileID: String,
                 version: String? = nil,
                 ids: [String] = [],
                 depth: Int? = nil,
                 paths: Bool = true,
                 pluginIDs: [String] = [],
                 completion: @escaping ResultHandler<FigmaFile>) {
        do {
            var parameters: [String: Any] = [:]
            
            if let version = version {
                parameters["version"] = version
            }
            
            if ids.count > 0 {
                parameters["ids"] = ids.joined(separator: ",")
            }
            
            if let depth = depth {
                parameters["depth"] = depth
            }
            
            if paths {
                parameters["geometry"] = "paths"
            }
            
            if pluginIDs.count > 0 {
                parameters["plugin_data"] = pluginIDs.joined(separator: ",")
            }
            
            let request = try requestBuilder.makeRequest(
                path: "files/\(fileID)",
                method: .get,
                parameters: parameters) { (result: FileResult) in
               switch result {
               case .success(let file):
                   completion(.success(file))
               case .failure(let error):
                   completion(.failure(error))
               }
            }
            
            requestPerformer.perform(request)
            
        } catch {
            completion(.failure(FigmaAPIError.general(error)))
        }
    }
    
    /// Get file
    ///
    /// Returns the document refered to by :key as a JSON object. The file key
    /// can be parsed from any Figma file url: https://www.figma.com/file/:key/:title.
    /// The name, lastModified, thumbnailUrl, and version attributes are all
    /// metadata of the retrieved file. The document attribute contains a Node
    /// of type DOCUMENT.
    ///
    /// The components key contains a mapping from node IDs to component
    /// metadata. This is to help you determine which components each instance
    /// comes from.
    ///
    /// - Parameter fileID: File to export JSON from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: Comma separated list of nodes that you care about
    ///                  in the document. If specified, only a subset of the
    ///                  document will be returned corresponding to the nodes
    ///                  listed, their children, and everything between the
    ///                  root node and the listed nodes.
    /// - Parameter depth: Optional positive integer representing how deep
    ///                    into the document tree to traverse. For example,
    ///                    setting this to 1 returns only Pages, setting it
    ///                    to 2 returns Pages and all top level objects on
    ///                    each page. Not setting this parameter returns all
    ///                    nodes.
    /// - Parameter paths: Set to true to export vector data.
    /// - Parameter pluginData: A comma separated list of plugin IDs and/or
    ///                         the string "shared". Any data present in the
    ///                         document written by those plugins will be
    ///                         included in the result in the `pluginData`
    ///                         and `sharedPluginData` properties.
    func getFile(_ fileID: String,
                 version: String? = nil,
                 ids: [String] = [],
                 depth: Int? = nil,
                 paths: Bool = false,
                 pluginIDs: [String] = []) -> AnyPublisher<FigmaFile, FigmaAPIError> {
        Future { [weak self] promise in
            self?.getFile(fileID,
                          version: version,
                          ids: ids,
                          depth: depth,
                          paths: paths,
                          pluginIDs: pluginIDs) { result in
                switch result {
                case .success(let figmaFile):
                    promise(.success(figmaFile))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
