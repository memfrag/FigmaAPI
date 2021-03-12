
import Foundation

public enum FigmaPaintType: String, Codable {
    case solid = "SOLID"
    case gradientLinear = "GRADIENT_LINEAR"
    case gradientRadial = "GRADIENT_RADIAL"
    case gradientAngular = "GRADIENT_ANGULAR"
    case gradientDiamond = "GRADIENT_DIAMOND"
    case image = "IMAGE"
    case emoji = "EMOJI"
}
