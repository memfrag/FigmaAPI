
import Foundation

public class FigmaFile: Decodable {

    public let name: String

    public let document: FigmaDocumentNode
    
    // E.g. 0
    public let schemaVersion: Int
    
    public let components: [FigmaNodeID: FigmaComponent]
   
    public let styles: [FigmaNodeID: FigmaStyle]
 
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
        case document
        case schemaVersion
        case components
        case styles
        case lastModified
        case thumbnailURL = "thumbnailUrl"
        case version
        case role
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        document = try container.decode(FigmaDocumentNode.self, forKey: .document)
        schemaVersion = try container.decode(Int.self, forKey: .schemaVersion)
        components = try container.decodeIfPresent([FigmaNodeID: FigmaComponent].self, forKey: .components) ?? [:]
        styles = try container.decodeIfPresent([FigmaNodeID: FigmaStyle].self, forKey: .styles) ?? [:]
        lastModified = try container.decode(String.self, forKey: .lastModified)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        version = try container.decode(String.self, forKey: .version)
        role = try container.decode(String.self, forKey: .role)
    }
}
