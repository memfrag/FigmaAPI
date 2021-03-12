
import Foundation

/// A position color pair representing a gradient stop.
public struct FigmaColorStop: Codable {

    /// Value between 0 and 1 representing position along gradient axis
    public let position: Double

    /// Color attached to corresponding position
    public let color: FigmaColor
}
