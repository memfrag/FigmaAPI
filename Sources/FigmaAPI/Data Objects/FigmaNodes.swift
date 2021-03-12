
import Foundation

public class FigmaNodes: Decodable {

    public class Node: Decodable {

        public let document: FigmaNode

        // E.g. 0
        public let schemaVersion: Int

        public let components: [FigmaNodeID: FigmaComponent]
        
        public let styles: [FigmaNodeID: FigmaStyle]
        
        enum CodingKeys: String, CodingKey {
            case document
            case schemaVersion
            case components
            case styles
        }
        
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            document = try FigmaNode.decodeNode(container: container, forKey: .document)
            schemaVersion = try container.decode(Int.self, forKey: .schemaVersion)
            components = try container.decodeIfPresent([FigmaNodeID: FigmaComponent].self, forKey: .components) ?? [:]
            styles = try container.decodeIfPresent([FigmaNodeID: FigmaStyle].self, forKey: .styles) ?? [:]
        }
    }
    
    public let name: String
    
    public let nodes: [FigmaNodeID: Node]

    // E.g. "2020-08-18T22:35:12.366761Z"
    public let lastModified: String
    
    public let thumbnailURL: String
    
    /// E.g. "426752338"
    public let version: String
    
    /// E.g. "owner"
    public let role: String
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case name
        case nodes
        case lastModified
        case thumbnailURL = "thumbnailUrl"
        case version
        case role
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        nodes = try container.decodeIfPresent([FigmaNodeID: Node].self, forKey: .nodes) ?? [:]
        lastModified = try container.decode(String.self, forKey: .lastModified)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        version = try container.decode(String.self, forKey: .version)
        role = try container.decode(String.self, forKey: .role)
    }
}
