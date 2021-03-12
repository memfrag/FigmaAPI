
import Foundation

/// Winding rules work off a concept called the winding number, which
/// tells you for a given point how many times the path winds around
/// that point.
public enum FigmaWindingRule: String, Codable {
    
    /// An open path won’t have a fill.
    case none = "NONE"
    
    /// The point is considered inside path if the winding number is NONZERO.
    case nonZero = "NONZERO"
    
    /// The point is considered inside path if the winding number is odd.
    case evenOdd = "EVENODD"
}
