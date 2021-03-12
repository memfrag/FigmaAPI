
import Foundation

/// The unit of the line height value specified by the user.
public enum FigmaLineHeightUnit: String, Codable {
    case pixels = "PIXELS"
    case fontSizePercent = "FONT_SIZE_%"
    case intrinsic = "INTRINSIC_%"
}
