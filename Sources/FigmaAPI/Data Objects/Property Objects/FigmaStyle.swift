
import Foundation

/// A set of properties that can be applied to nodes and published. Styles for
/// a property can be created in the corresponding property's panel while
/// editing a file.
public struct FigmaStyle: Codable {
    
    enum CodingKeys: String, CodingKey {
        case key
        case name
        case description
        case styleType
    }

    /// The key of the style
    public let key: String
    
    /// The name of the style
    public let name: String
    
    /// The description of the style
    public let description: String

    /// The type of style as string enum
    public let styleType: FigmaStyleType
}
