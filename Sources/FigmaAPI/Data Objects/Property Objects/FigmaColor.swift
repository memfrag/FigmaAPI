
import Foundation

/// An RGBA color
public struct FigmaColor: Codable {

    /// Red channel value, between 0 and 1
    public let r: Double
    
    /// Green channel value, between 0 and 1
    public let g: Double
    
    /// Blue channel value, between 0 and 1
    public let b: Double
    
    /// Alpha channel value, between 0 and 1
    public let a: Double
}

public extension FigmaColor {
    static let white = FigmaColor(r: 1, g: 1, b: 1, a: 1)
    static let black = FigmaColor(r: 0, g: 0, b: 0, a: 1)
}
