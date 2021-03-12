
import Foundation

public class FigmaTeamProjects: Decodable {
    
    public let name: String
    public let projects: [FigmaProject]
    
    enum CodingKeys: String, CodingKey {
        case name
        case projects
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        projects = try container.decode([FigmaProject].self, forKey: .projects)
    }
}
