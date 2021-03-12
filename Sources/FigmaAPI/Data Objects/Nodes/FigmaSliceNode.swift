
import Foundation

public class FigmaSliceNode: FigmaNode {
    
    /// An array of export settings representing images to export from
    /// this node
    public let exportSettings: [FigmaExportSetting]
    
    /// Bounding box of the node in absolute space coordinates
    public let absoluteBoundingBox: FigmaRectangle
    
    /// Width and height of element. This is different from the width and
    /// height of the bounding box in that the absolute bounding box
    /// represents the element after scaling and rotation. Only present if
    /// geometry=paths is passed
    public let size: FigmaVector?
    
    /// The top two rows of a matrix that represents the 2D transform of this
    /// node relative to its parent. The bottom row of the matrix is implicitly
    /// always (0, 0, 1). Use to transform coordinates in geometry. Only
    /// present if geometry=paths is passed
    public let relativeTransform: FigmaTransform?
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case exportSettings
        case absoluteBoundingBox
        case size
        case relativeTransform
    }
        
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        exportSettings = try container.decodeIfPresent([FigmaExportSetting].self, forKey: .exportSettings) ?? []
        absoluteBoundingBox = try container.decode(FigmaRectangle.self, forKey: .absoluteBoundingBox)
        size = try container.decodeIfPresent(FigmaVector.self, forKey: .size)
        relativeTransform = try container.decodeIfPresent(FigmaTransform.self, forKey: .relativeTransform)
        try super.init(from: decoder)
    }
}
