
import Foundation

/// Whether the counter axis has a fixed length (determined by the user)
/// or an automatic length (determined by the layout engine).
public enum FigmaCountryAxisSizingMode: String, Codable {
    case fixed = "FIXED"
    case auto = "AUTO"
}
