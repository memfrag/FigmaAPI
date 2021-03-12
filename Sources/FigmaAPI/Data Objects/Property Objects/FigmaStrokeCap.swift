
import Foundation

/// Describes the end caps of vector paths.
public enum FigmaStrokeCap: String, Codable {
    case none = "NONE"
    case round = "ROUND"
    case square = "SQUARE"
    case lineArrow = "LINE_ARROW"
    case triangleArrow = "TRIANGLE_ARROW"
}
