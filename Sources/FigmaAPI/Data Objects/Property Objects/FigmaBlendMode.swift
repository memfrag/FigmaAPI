
import Foundation

/// Enum describing how layer blends with layers below
public enum FigmaBlendMode: String, Codable {

    // MARK: Normal blends
    
    /// Only applicable to objects with children
    case passThrough = "PASS_THROUGH"
    case normal = "NORMAL"

    // MARK: Darken:
    case darken = "DARKEN"
    case multiply = "MULTIPLY"
    case linearBurn = "LINEAR_BURN"
    case colorBurn = "COLOR_BURN"

    // MARK: Lighten:
    case lighten = "LIGHTEN"
    case screen = "SCREEN"
    case linearDodge = "LINEAR_DODGE"
    case colorDodge = "COLOR_DODGE"

    // MARK: Contrast:
    case overlay = "OVERLAY"
    case softLight = "SOFT_LIGHT"
    case hardLight = "HARD_LIGHT"

    // MARK: Inversion:
    case difference = "DIFFERENCE"
    case exclusion = "EXCLUSION"

    // MARK: Component
    
    case hue = "HUE"
    case saturation = "SATURATION"
    case color = "COLOR"
    case luminosity = "LUMINOSITY"
}
