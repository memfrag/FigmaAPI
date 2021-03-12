
import Foundation

public class FigmaRectangleNode: FigmaVectorNode {
    
    /// Radius of each corner of the rectangle if a single radius is set for
    /// all corners
    public let cornerRadius: Double?
    
    /// Array of length 4 of the radius of each corner of the rectangle,
    /// starting in the top left and proceeding clockwise
    public let rectangleCornerRadii: [Double]?
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case cornerRadius
        case rectangleCornerRadii
    }
        
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cornerRadius = try container.decodeIfPresent(Double.self, forKey: .cornerRadius)
        rectangleCornerRadii = try container.decodeIfPresent([Double].self, forKey: .rectangleCornerRadii)
        try super.init(from: decoder)
    }
}
