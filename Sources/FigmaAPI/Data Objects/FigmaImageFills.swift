
import Foundation

public struct FigmaImageFills: Decodable {
    
    public struct Meta: Decodable {
        public let images: [String: String]
    }
    
    public let meta: Meta
}
