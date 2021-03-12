
import Foundation

public class FigmaProjectFiles: Decodable {
    
    public let name: String
    public let files: [FigmaProjectFile]
    
    enum CodingKeys: String, CodingKey {
        case name
        case files
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        files = try container.decode([FigmaProjectFile].self, forKey: .files)
    }
}
