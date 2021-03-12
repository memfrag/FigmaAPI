
import Foundation

public enum FigmaHorizontalConstraint: String, Codable {
    
    /// Node is laid out relative to left of the containing frame
    case left = "LEFT"
    
    /// Node is laid out relative to right of the containing frame
    case right = "RIGHT"

    /// Node is horizontally centered relative to containing frame
    case center = "CENTER"

    /// Both left and right of node are constrained relative to containing
    /// frame (node stretches with frame)
    case leftAndRight = "LEFT_RIGHT"

    /// Node scales horizontally with containing frame
    case scale = "SCALE"
}

public enum FigmaVerticalConstraint: String, Codable {
    
    /// Node is laid out relative to top of the containing frame
    case top = "TOP"
    
    /// Node is laid out relative to bottom of the containing frame
    case bottom = "BOTTOM"
    
    /// Node is vertically centered relative to containing frame
    case center = "CENTER"
    
    /// Both top and bottom of node are constrained relative to containing
    /// frame (node stretches with frame)
    case topAndBottom = "TOP_BOTTOM"
    
    /// Node scales vertically with containing frame
    case scale = "SCALE"
}

/// Layout constraint relative to containing Frame
public struct FigmaLayoutConstraint: Codable {

    /// Horizontal constraint as an enum
    public let horizontal: FigmaHorizontalConstraint

    /// Vertical constraint as an enum
    public let vertical: FigmaVerticalConstraint
}
