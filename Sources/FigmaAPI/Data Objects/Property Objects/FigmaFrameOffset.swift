
import Foundation

/// A relative offset within a frame
public struct FigmaFrameOffset: Codable {

    /// Unique id specifying the frame.
    public let nodeID: FigmaNodeID
    
    /// 2D vector offset within the frame.
    public let nodeOffset: FigmaVector
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case nodeID = "node_id"
        case nodeOffset = "node_offset"
    }
}
