
import Foundation

public class FigmaInstanceNode: FigmaFrameNode {

    /// ID of component that this instance came from, refers to components
    /// table (see endpoints section below)
    public let componentID: String
        
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case componentID = "componentId"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        componentID = try container.decode(String.self, forKey: .componentID)
        try super.init(from: decoder)
    }
}
