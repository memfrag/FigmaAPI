
import Foundation

/// How the layer is aligned inside an auto-layout frame.
///
/// In horizontal auto-layout frames, "MIN" and "MAX" correspond to "TOP"
/// and "BOTTOM". In vertical auto-layout frames, "MIN" and "MAX"
/// correspond to "LEFT" and "RIGHT".
public enum FigmaLayoutAlignment: String, Codable {
    case min = "MIN"
    case center = "CENTER"
    case max = "MAX"
    case stretch = "STRETCH"
    case inherit = "INHERIT"
}
