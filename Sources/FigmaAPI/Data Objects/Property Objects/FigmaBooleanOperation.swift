
import Foundation

public enum FigmaBooleanOperation: String, Codable {
    case union = "UNION"
    case intersect = "INTERSECT"
    case subtract = "SUBTRACT"
    case exclude = "EXCLUDE"
}
