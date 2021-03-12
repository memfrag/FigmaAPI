
import Foundation

public class FigmaProject: Decodable {
    
    public let id: String
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
