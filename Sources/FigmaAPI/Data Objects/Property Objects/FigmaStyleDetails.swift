
import Foundation

/// A set of properties that can be applied to nodes and published. Styles for
/// a property can be created in the corresponding property's panel while
/// editing a file.
public struct FigmaStyleDetails: Codable {
    
    enum CodingKeys: String, CodingKey {
        case key
        case fileKey = "file_key"
        case nodeID = "node_id"
        case styleType = "style_type"
        case thumbnailURL = "thumbnail_url"
        case name
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
        case sortPosition = "sort_position"
    }

    /// The unique identifier of the style
    public let key: String

    /// The unique identifier of the file which contains the style
    public let fileKey: String

    /// Id of the style node within the figma file
    public let nodeID: FigmaNodeID

    /// The type of style
    public let styleType: FigmaStyleType

    /// URL link to the style's thumbnail image
    public let thumbnailURL: String

    /// Name of the style
    public let name: String

    /// The description of the style as entered by the publisher
    public let description: String

    /// The UTC ISO 8601 time at which the style was created
    public let createdAt: String

    /// The UTC ISO 8601 time at which the style was updated
    public let updatedAt: String

    /// The user who last updated the style
    public let user: FigmaUser

    /// A user specified order number by which the style can be sorted
    public let sortPosition: String

}
