
import Foundation
import Combine

public extension FigmaAPI {

    typealias NodesResult = APIResult<FigmaNodes>

    // MARK: - Get Nodes

    /// Get nodes
    ///
    /// Returns the nodes referenced to by :ids as a JSON object. The nodes
    /// are retrieved from the Figma file referenced to by :key.
    ///
    /// The node Id and file key can be parsed from any Figma node url:
    /// https://www.figma.com/file/:key/:title?node-id=:id.
    ///
    /// The name, lastModified, thumbnailUrl, and versionattributes are all
    /// metadata of the specified file.
    ///
    /// The document attribute contains a Node of type DOCUMENT.
    ///
    /// The components key contains a mapping from node IDs to component
    /// metadata. This is to help you determine which components each instance
    /// comes from.
    ///
    /// By default, no vector data is returned. To return vector data, pass the
    /// geometry=paths parameter to the endpoint.
    ///
    /// Each node can also inherit properties from applicable styles. The
    /// styles key contains a mapping from style IDs to style metadata.
    ///
    /// Important: the nodes map may contain values that are null. This may be
    /// due to the node id not existing within the specified file.
    ///
    /// - Parameter fileID: File to export JSON from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: A comma separated list of node IDs to retrieve and convert.
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
    func getNodes(from fileID: String,
                 version: String? = nil,
                 ids: [String],
                 depth: Int? = nil,
                 paths: Bool = false,
                 pluginIDs: [String] = [],
                 completion: @escaping ResultHandler<FigmaNodes>) {
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
                path: "files/\(fileID)/nodes",
                method: .get,
                parameters: parameters) { (result: NodesResult) in
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
    
    /// Get nodes
    ///
    /// Returns the nodes referenced to by :ids as a JSON object. The nodes
    /// are retrieved from the Figma file referenced to by :key.
    ///
    /// The node Id and file key can be parsed from any Figma node url:
    /// https://www.figma.com/file/:key/:title?node-id=:id.
    ///
    /// The name, lastModified, thumbnailUrl, and versionattributes are all
    /// metadata of the specified file.
    ///
    /// The document attribute contains a Node of type DOCUMENT.
    ///
    /// The components key contains a mapping from node IDs to component
    /// metadata. This is to help you determine which components each instance
    /// comes from.
    ///
    /// By default, no vector data is returned. To return vector data, pass the
    /// geometry=paths parameter to the endpoint.
    ///
    /// Each node can also inherit properties from applicable styles. The
    /// styles key contains a mapping from style IDs to style metadata.
    ///
    /// Important: the nodes map may contain values that are null. This may be
    /// due to the node id not existing within the specified file.
    ///
    /// - Parameter fileID: File to export JSON from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: A comma separated list of node IDs to retrieve and convert.
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
    func getNodes(from fileID: String,
                  version: String? = nil,
                  ids: [String],
                  depth: Int? = nil,
                  paths: Bool = false,
                  pluginIDs: [String] = []) -> AnyPublisher<FigmaNodes, FigmaAPIError> {
        Future { [weak self] promise in
            self?.getNodes(from: fileID,
                           version: version,
                           ids: ids,
                           depth: depth,
                           paths: paths,
                           pluginIDs: pluginIDs) { result in
                switch result {
                case .success(let nodes):
                    promise(.success(nodes))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
