
import Foundation

/// Describes how corners in vector paths are rendered.
public enum FigmaStrokeJoin: String, Codable {
    case miter = "MITER"
    case bevel = "BEVEL"
    case round = "ROUND"
}
