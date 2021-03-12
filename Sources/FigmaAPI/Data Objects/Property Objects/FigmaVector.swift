
import Foundation

/// A 2d vector
public struct FigmaVector: Codable {
    
    /// X coordinate of the vector
    public let x: Double
    
    /// Y coordinate of the vector
    public let y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decodeIfPresent(Double.self, forKey: .x) ?? .nan
        self.y = try container.decodeIfPresent(Double.self, forKey: .y) ?? .nan
    }
}

public extension FigmaVector {
    static let zero = FigmaVector(x: 0, y: 0)
}
