
import Foundation

public class FigmaProjectFile: Decodable {

    public let name: String

    public let key: String
        
    // E.g. "2020-08-18T22:35:12.366761Z"
    public let lastModified: String
    
    public let thumbnailURL: String
        
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case lastModified = "last_modified"
        case thumbnailURL = "thumbnail_url"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        key = try container.decode(String.self, forKey: .key)
        lastModified = try container.decode(String.self, forKey: .lastModified)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
    }
}
