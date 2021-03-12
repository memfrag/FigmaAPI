
import Foundation

public struct FigmaPath: Codable {

    /// SVG path
    public let path: String

    /// Winding rules work off a concept called the winding number, which
    /// tells you for a given point how many times the path winds around
    /// that point.
    public let windingRule: FigmaWindingRule
}
