
import Foundation

public enum FigmaConstraintType: String, Codable {
    case scale = "SCALE"
    case width = "WIDTH"
    case height = "HEIGHT"
}

/// Sizing constraint for exports
public struct FigmaConstraint: Codable {
    
    /// Type of constraint to apply; string enum with potential values below
    ///
    /// SCALE: Scale by value
    /// WIDTH: Scale proportionally and set width to value
    /// HEIGHT: Scale proportionally and set height to value
    public let type: FigmaConstraintType
    
    /// See type property for effect of this field
    public let value: Double
}
