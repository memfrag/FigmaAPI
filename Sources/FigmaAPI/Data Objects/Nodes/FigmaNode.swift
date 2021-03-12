
import Foundation

/// Base class for Figma node class hierarchy.
///
/// **Node Hierarchy:**
///
/// ```
/// FigmaNode
///  ├─FigmaDocumentNode
///  ├─FigmaCanvasNode
///  ├─FigmaFrameNode
///  │  ├─FigmaComponentNode
///  │  ├─FigmaGroupNode
///  │  └─FigmaInstanceNode
///  ├─FigmaSliceNode
///  └─FigmaVectorNode
///     ├─FigmaBooleanOperationNode
///     ├─FigmaEllipseNode
///     ├─FigmaLineNode
///     ├─FigmaRectangleNode
///     ├─FigmaRegularPolygonNode
///     ├─FigmaStarNode
///     └─FigmaTextNode
/// ```
public class FigmaNode: Decodable {
    
    /// A string uniquely identifying this node within the document.
    /// E.g. "1:188"
    public let id: FigmaNodeID

    /// The name given to the node by the user in the tool.
    public let name: String

    /// Whether or not the node is visible on the canvas.
    public let visible: Bool // default: true

    /// The type of the node, refer to table below for details.
    public let type: FigmaNodeType
    
    /// Data written by plugins that is visible only to the plugin that wrote it.
    /// Requires the `pluginData` to include the ID of the plugin.
    public let pluginData: String?
    
    /// Data written by plugins that is visible to all plugins. Requires the
    /// `pluginData` parameter to include the string "shared".
    public let sharedPluginData: String?
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case visible
        case type
        case pluginData
        case sharedPluginData
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown Node"
        visible = try container.decodeIfPresent(Bool.self, forKey: .visible) ?? true
        type = try container.decode(FigmaNodeType.self, forKey: .type)
        pluginData = try container.decodeIfPresent(String.self, forKey: .pluginData)
        sharedPluginData = try container.decodeIfPresent(String.self, forKey: .sharedPluginData)
    }
}

extension FigmaNode {
    
    public static func decodeNodes<T: CodingKey>(container: KeyedDecodingContainer<T>, forKey key: T) throws -> [FigmaNode] {
        var nodes: [FigmaNode] = []
        
        var nodeTypeContainer = try container.nestedUnkeyedContainer(forKey: key)
        var nodeContainer = try container.nestedUnkeyedContainer(forKey: key)
        
        while !nodeTypeContainer.isAtEnd {
            let baseNode = try nodeTypeContainer.decode(FigmaNode.self)
            let node: FigmaNode
            switch baseNode.type {
            case .document: node = try nodeContainer.decode(FigmaDocumentNode.self)
            case .canvas: node = try nodeContainer.decode(FigmaCanvasNode.self)
            case .frame: node = try nodeContainer.decode(FigmaFrameNode.self)
            case .group: node = try nodeContainer.decode(FigmaGroupNode.self)
            case .vector: node = try nodeContainer.decode(FigmaVectorNode.self)
            case .booleanOperation: node = try nodeContainer.decode(FigmaBooleanOperationNode.self)
            case .star: node = try nodeContainer.decode(FigmaStarNode.self)
            case .line: node = try nodeContainer.decode(FigmaLineNode.self)
            case .ellipse: node = try nodeContainer.decode(FigmaEllipseNode.self)
            case .regularPolygon: node = try nodeContainer.decode(FigmaRegularPolygonNode.self)
            case .rectangle: node = try nodeContainer.decode(FigmaRectangleNode.self)
            case .text: node = try nodeContainer.decode(FigmaTextNode.self)
            case .slice: node = try nodeContainer.decode(FigmaSliceNode.self)
            case .component: node = try nodeContainer.decode(FigmaComponentNode.self)
            case .instance: node = try nodeContainer.decode(FigmaInstanceNode.self)
            }
            nodes.append(node)
        }

        return nodes
    }

    public static func decodeNode<T: CodingKey>(container: KeyedDecodingContainer<T>, forKey key: T) throws -> FigmaNode {
        
        let baseNode = try container.decode(FigmaNode.self, forKey: key)
        let node: FigmaNode
        switch baseNode.type {
        case .document: node = try container.decode(FigmaDocumentNode.self, forKey: key)
        case .canvas: node = try container.decode(FigmaCanvasNode.self, forKey: key)
        case .frame: node = try container.decode(FigmaFrameNode.self, forKey: key)
        case .group: node = try container.decode(FigmaGroupNode.self, forKey: key)
        case .vector: node = try container.decode(FigmaVectorNode.self, forKey: key)
        case .booleanOperation: node = try container.decode(FigmaBooleanOperationNode.self, forKey: key)
        case .star: node = try container.decode(FigmaStarNode.self, forKey: key)
        case .line: node = try container.decode(FigmaLineNode.self, forKey: key)
        case .ellipse: node = try container.decode(FigmaEllipseNode.self, forKey: key)
        case .regularPolygon: node = try container.decode(FigmaRegularPolygonNode.self, forKey: key)
        case .rectangle: node = try container.decode(FigmaRectangleNode.self, forKey: key)
        case .text: node = try container.decode(FigmaTextNode.self, forKey: key)
        case .slice: node = try container.decode(FigmaSliceNode.self, forKey: key)
        case .component: node = try container.decode(FigmaComponentNode.self, forKey: key)
        case .instance: node = try container.decode(FigmaInstanceNode.self, forKey: key)
        }

        return node
    }
}
