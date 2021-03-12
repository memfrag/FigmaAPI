
import Foundation

/// Orientation of the grid
public enum FigmaLayoutGridPattern: String, Codable {

    /// Vertical grid
    case columns = "COLUMNS"
    
    ///Horizontal grid
    case rows = "ROWS"
    
    ///Square grid
    case grid = "GRID"
}

/// Positioning of grid
public enum FigmaLayoutGridAlignment: String, Codable {
    
    /// Grid starts at the left or top of the frame
    case min = "MIN"
    
    /// Grid is stretched to fit the frame
    case stretch = "STRETCH"
    
    /// Grid is center aligned
    case center = "CENTER"
}

/// Guides to align and place objects within a frame
public struct FigmaLayoutGrid: Codable {

    /// Orientation of the grid as a string enum
    public let pattern: FigmaLayoutGridPattern
    
    /// Width of column grid or height of row grid or square grid spacing
    public let sectionSize: Double
    
    /// Is the grid currently visible?
    public let visible: Bool

    /// Color of the grid
    public let color: FigmaColor
    
    // MARK: - The following properties are only meaningful for directional grids (COLUMNS or ROWS)

    /// Positioning of grid as a string enum
    public let alignment: FigmaLayoutGridAlignment
    
    /// Spacing in between columns and rows
    public let gutterSize: Double
    
    /// Spacing before the first column or row
    public let offset: Double
    
    /// Number of columns or rows
    public let count: Int
}
