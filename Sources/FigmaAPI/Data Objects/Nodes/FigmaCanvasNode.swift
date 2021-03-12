
import Foundation

public class FigmaCanvasNode: FigmaNode {

    /// An array of top level layers on the canvas
    public let children: [FigmaNode]

    /// Background color of the canvas.
    public let backgroundColor: FigmaColor
        
    /// An array of export settings representing images to export from
    /// the canvas
    public let exportSettings: [FigmaExportSetting] //default: []

    /// Node ID that corresponds to the start frame for prototypes
    public let prototypeStartNodeID: String?

    /// ToDo
    public let prototypeDevice: FigmaPrototypeDevice?
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case children
        case backgroundColor
        case exportSettings
        case prototypeStartNodeID
        case prototypeDevice
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        children = try Self.decodeNodes(container: container, forKey: .children)
        backgroundColor = try container.decode(FigmaColor.self, forKey: .backgroundColor)
        exportSettings = try container.decodeIfPresent([FigmaExportSetting].self, forKey: .exportSettings) ?? []
        prototypeStartNodeID = try container.decodeIfPresent(String.self, forKey: .prototypeStartNodeID)
        prototypeDevice = try container.decodeIfPresent(FigmaPrototypeDevice.self, forKey: .prototypeDevice)

        try super.init(from: decoder)
    }
}
