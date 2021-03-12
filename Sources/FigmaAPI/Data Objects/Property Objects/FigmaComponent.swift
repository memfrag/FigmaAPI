
import Foundation

/// A description of a main component. Helps you identify which component
/// instances are attached to.
public struct FigmaComponent: Codable {

    /// The key of the component
    public let key: String

    /// The name of the component
    public let name: String

    /// The description of the component as entered in the editor
    public let description: String
}
