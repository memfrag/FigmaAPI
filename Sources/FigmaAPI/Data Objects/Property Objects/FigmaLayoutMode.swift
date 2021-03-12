
import Foundation

/// Whether this layer uses auto-layout to position its children.
public enum FigmaLayoutMode: String, Codable {
    case none = "NONE"
    case horizontal = "HORIZONTAL"
    case vertical = "VERTICAL"
}
