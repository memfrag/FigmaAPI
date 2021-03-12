
import Foundation

public class FigmaBooleanOperationNode: FigmaVectorNode {

    /// An array of nodes that are being boolean operated on
    public let children: [FigmaNode]
    
    /// Type of boolean operation applied
    public let booleanOperation: FigmaBooleanOperation
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case children
        case booleanOperation
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        children = try Self.decodeNodes(container: container, forKey: .children)
        booleanOperation = try container.decode(FigmaBooleanOperation.self, forKey: .booleanOperation)
        try super.init(from: decoder)
    }
}
