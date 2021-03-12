
import Foundation

/// Position of stroke relative to vector outline
public enum FigmaStrokeAlign: String, Codable {

    /// Stroke drawn inside the shape boundary
    case inside = "INSIDE"
    
    /// Stroke drawn outside the shape boundary
    case outside = "OUTSIDE"
    
    /// Stroke drawn centered along the shape boundary
    case center = "CENTER"
}
