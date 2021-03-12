
import Foundation
import Combine

public extension FigmaAPI {

    typealias ImagesResult = APIResult<FigmaImages>

    // MARK: - Get Images

    /// Get Images
    ///
    /// Renders images from a file.
    ///
    /// If no error occurs, "images" will be populated with a map from node IDs
    /// to URLs of the rendered images, and "status" will be omitted. The image
    /// assets will expire after 30 days.
    ///
    /// Important: the image map may contain values that are null. This
    /// indicates that rendering of that specific node has failed. This may be
    /// due to the node id not existing, or other reasons such has the node
    /// having no renderable components. It is guaranteed that any node that
    /// was requested for rendering will be represented in this map whether or
    /// not the render succeeded.
    ///
    /// - Parameter fileID: File to export images from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: A comma separated list of node IDs to render.
    /// - Parameter scale: A number in 0.01 ... 4, the image scaling factor.
    /// - Parameter format: Export image format.
    /// - Parameter svgIncludeID: Whether to include id attributes for all
    ///                           SVG elements. Default: false.
    /// - Parameter svgSimplifyStroke: Whether to simplify inside/outside
    ///                                strokes and use stroke attribute if
    ///                                possible instead of <mask>.
    ///                                Default: true.
    /// - Parameter useAbsoluteBounds: Use the full dimensions of the node
    ///                                regardless of whether or not it is
    ///                                cropped or the space around it is empty.
    ///                                Use this to export text nodes without
    ///                                cropping. Default: false.
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    func getImages(from fileID: String,
                   version: String? = nil,
                   ids: [String],
                   scale: Float? = nil,
                   format: FigmaExportImageFormat,
                   svgIncludeID: Bool = false,
                   svgSimplifyStroke: Bool = false,
                   useAbsoluteBounds: Bool = false,
                   completion: @escaping ResultHandler<[FigmaNodeID: URL]>) {
        do {
            var parameters: [String: Any] = [:]
            
            if let version = version {
                parameters["version"] = version
            }
            
            parameters["ids"] = ids.joined(separator: ",")
            
            if let scale = scale {
                parameters["scale"] = scale
            }
            
            parameters["format"] = format.rawValue.lowercased()
            
            parameters["svg_include_id"] = svgIncludeID
            
            parameters["svg_simplify_stroke"] = svgSimplifyStroke
            
            parameters["use_absolute_bounds"] = useAbsoluteBounds
            
            let request = try requestBuilder.makeRequest(
                path: "images/\(fileID)",
                method: .get,
                parameters: parameters) { (result: ImagesResult) in
                    switch result {
                    case .success(let images):
                        let imagesWithURLs = images.images.compactMapValues {
                            $0.map(URL.init(string:)) ?? nil
                        }
                        completion(.success(imagesWithURLs))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            
            requestPerformer.perform(request)
            
        } catch {
            completion(.failure(FigmaAPIError.general(error)))
        }
    }
    
    /// Get Images
    ///
    /// Renders images from a file.
    ///
    /// If no error occurs, "images" will be populated with a map from node IDs
    /// to URLs of the rendered images, and "status" will be omitted. The image
    /// assets will expire after 30 days.
    ///
    /// Important: the image map may contain values that are null. This
    /// indicates that rendering of that specific node has failed. This may be
    /// due to the node id not existing, or other reasons such has the node
    /// having no renderable components. It is guaranteed that any node that
    /// was requested for rendering will be represented in this map whether or
    /// not the render succeeded.
    ///
    /// - Parameter fileID: File to export images from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: A comma separated list of node IDs to render.
    /// - Parameter scale: A number in 0.01 ... 4, the image scaling factor.
    /// - Parameter format: Export image format.
    /// - Parameter svgIncludeID: Whether to include id attributes for all
    ///                           SVG elements. Default: false.
    /// - Parameter svgSimplifyStroke: Whether to simplify inside/outside
    ///                                strokes and use stroke attribute if
    ///                                possible instead of <mask>.
    ///                                Default: true.
    /// - Parameter useAbsoluteBounds: Use the full dimensions of the node
    ///                                regardless of whether or not it is
    ///                                cropped or the space around it is empty.
    ///                                Use this to export text nodes without
    ///                                cropping. Default: false.
    func getImages(from fileID: String,
                   version: String? = nil,
                   ids: [String],
                   scale: Float? = nil,
                   format: FigmaExportImageFormat,
                   svgIncludeID: Bool = false,
                   svgSimplifyStroke: Bool = false,
                   useAbsoluteBounds: Bool = false) -> AnyPublisher<[FigmaNodeID: URL], FigmaAPIError> {
        Deferred {
            Future { [weak self] promise in
                self?.getImages(from: fileID,
                            version: version,
                            ids: ids,
                            scale: scale,
                            format: format,
                            svgIncludeID: svgIncludeID,
                            svgSimplifyStroke: svgSimplifyStroke,
                            useAbsoluteBounds: useAbsoluteBounds) { result in
                    switch result {
                        case .success(let images):
                            promise(.success(images))
                        case .failure(let error):
                            promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Get Images Batched
    ///
    /// Renders images from a file.
    ///
    /// If no error occurs, "images" will be populated with a map from node IDs
    /// to URLs of the rendered images, and "status" will be omitted. The image
    /// assets will expire after 30 days.
    ///
    /// Important: the image map may contain values that are null. This
    /// indicates that rendering of that specific node has failed. This may be
    /// due to the node id not existing, or other reasons such has the node
    /// having no renderable components. It is guaranteed that any node that
    /// was requested for rendering will be represented in this map whether or
    /// not the render succeeded.
    ///
    /// - Parameter fileID: File to export images from
    /// - Parameter version: A specific version ID to get. Omitting this will
    ///                      get the current version of the file.
    /// - Parameter ids: A comma separated list of node IDs to render.
    /// - Parameter batchSize: Number of images per call to API.
    /// - Parameter scale: A number in 0.01 ... 4, the image scaling factor.
    /// - Parameter format: Export image format.
    /// - Parameter svgIncludeID: Whether to include id attributes for all
    ///                           SVG elements. Default: false.
    /// - Parameter svgSimplifyStroke: Whether to simplify inside/outside
    ///                                strokes and use stroke attribute if
    ///                                possible instead of <mask>.
    ///                                Default: true.
    /// - Parameter useAbsoluteBounds: Use the full dimensions of the node
    ///                                regardless of whether or not it is
    ///                                cropped or the space around it is empty.
    ///                                Use this to export text nodes without
    ///                                cropping. Default: false.
    func getImagesBatched(
        from fileID: String,
        version: String? = nil,
        ids: [String],
        batchSize: Int = 20,
        scale: Float? = nil,
        format: FigmaExportImageFormat,
        svgIncludeID: Bool = false,
        svgSimplifyStroke: Bool = false,
        useAbsoluteBounds: Bool = false) -> AnyPublisher<[FigmaNodeID: URL], FigmaAPIError> {
        
        ids.chunks(of: batchSize).publisher
            .setFailureType(to: FigmaAPIError.self)
            .flatMap(maxPublishers: .max(1)) { [weak self] batchOfIDs -> AnyPublisher<[FigmaNodeID: URL], FigmaAPIError> in
                guard let strongSelf = self else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return strongSelf.getImages(from: fileID,
                                            version: version,
                                            ids: batchOfIDs,
                                            scale: scale,
                                            format: format,
                                            svgIncludeID: svgIncludeID,
                                            svgSimplifyStroke: svgSimplifyStroke,
                                            useAbsoluteBounds: useAbsoluteBounds)
            }
            .collect()
            .map { $0.mergeDictionaries() }
            .eraseToAnyPublisher()
    }
}

fileprivate extension Collection where Index == Int {
    
    func chunks(of size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}

fileprivate extension Sequence where Element == [FigmaNodeID: URL] {
    
    func mergeDictionaries() -> [FigmaNodeID: URL] {
        var output: [FigmaNodeID: URL] = [:]
        for dictionary in self {
            output.merge(dictionary) { _, new in new }
        }
        return output
    }
}
