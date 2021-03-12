
import Foundation

public class FigmaDocumentNode: FigmaNode {
    
    /// An array of canvases attached to the document
    public let children: [FigmaNode]
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case children
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.children = try Self.decodeNodes(container: container, forKey: .children)
        
        try super.init(from: decoder)
    }
}
