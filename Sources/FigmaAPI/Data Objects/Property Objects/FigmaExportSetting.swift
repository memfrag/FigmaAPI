
import Foundation

public enum FigmaExportImageFormat: String, Codable {
    case jpeg = "JPG"
    case png = "PNG"
    case svg = "SVG"
    case pdf = "PDF"
}

/// Format and size to export an asset at.
public struct FigmaExportSetting: Decodable {
    
    /// File suffix to append to all filenames
    public let suffix: String

    /// Image type, string enum that supports values JPG, PNG, and SVG
    public let format: FigmaExportImageFormat
    
    /// Constraint that determines sizing of exported asset
    public let constraint: FigmaConstraint
}
