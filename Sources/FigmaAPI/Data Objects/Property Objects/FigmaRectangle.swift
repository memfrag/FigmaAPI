
import Foundation

public struct FigmaRectangle {
    
    /// X coordinate of top left corner of the rectangle
    public let x: Double

    /// Y coordinate of top left corner of the rectangle
    public let y: Double

    /// Width of the rectangle
    public let width: Double

    /// Height of the rectangle
    public let height: Double
}

extension FigmaRectangle: Decodable {
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case width
        case height
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decodeIfPresent(Double.self, forKey: .x) ?? .nan
        self.y = try container.decodeIfPresent(Double.self, forKey: .y) ?? .nan
        self.width = try container.decodeIfPresent(Double.self, forKey: .width) ?? .nan
        self.height = try container.decodeIfPresent(Double.self, forKey: .height) ?? .nan
    }
}
