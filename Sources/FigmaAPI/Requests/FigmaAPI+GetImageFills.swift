
import Foundation
import Combine

public extension FigmaAPI {

    typealias ImageFillsResult = APIResult<FigmaImageFills>

    // MARK: - Get Images

    /// Get Image Fills
    ///
    /// Returns download links for all images present in image fills in a
    /// document. Image fills are how Figma represents any user supplied
    /// images. When you drag an image into Figma, we create a rectangle
    /// with a single fill that represents the image, and the user is able
    /// to transform the rectangle (and properties on the fill) as they wish.
    ///
    /// This endpoint returns a mapping from image references to the URLs at
    /// which the images may be download. Image URLs will expire after no more
    /// than 14 days. Image references are located in the output of the GET
    /// files endpoint under the imageRef attribute in a Paint.
    ///
    /// - Parameter fileID: File to export images from
    /// - Parameter completion: The completion handler is called upon
    ///                         completion of the request.
    func getImageFills(from fileID: String,
                       completion: @escaping ResultHandler<[String: URL]>) {
        do {
            let request = try requestBuilder.makeRequest(
                path: "files/\(fileID)/images",
                method: .get,
                parameters: [:]) { (result: ImageFillsResult) in
                    switch result {
                    case .success(let imageFills):
                        let imagesWithURLs = imageFills.meta.images.mapValues { URL(string: $0)! }
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
    
    /// Get Image Fills
    ///
    /// Returns download links for all images present in image fills in a
    /// document. Image fills are how Figma represents any user supplied
    /// images. When you drag an image into Figma, we create a rectangle
    /// with a single fill that represents the image, and the user is able
    /// to transform the rectangle (and properties on the fill) as they wish.
    ///
    /// This endpoint returns a mapping from image references to the URLs at
    /// which the images may be download. Image URLs will expire after no more
    /// than 14 days. Image references are located in the output of the GET
    /// files endpoint under the imageRef attribute in a Paint.
    ///
    /// - Parameter fileID: File to export images from
    func getImageFills(from fileID: String) -> AnyPublisher<[String: URL], FigmaAPIError> {
        Future { [weak self] promise in
            self?.getImageFills(from: fileID) { result in
                switch result {
                case .success(let imageFills):
                    promise(.success(imageFills))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
