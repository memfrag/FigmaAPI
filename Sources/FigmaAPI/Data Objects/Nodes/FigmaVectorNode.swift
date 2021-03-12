
import Foundation

public class FigmaVectorNode: FigmaNode {
    
    /// If true, layer is locked and cannot be edited
    public let locked: Bool // default: false
    
    /// An array of export settings representing images to export from node
    public let exportSettings: [FigmaExportSetting] // default: []
    
    /// How this node blends with nodes behind it in the scene (see blend mode
    /// section for more details)
    public let blendMode: FigmaBlendMode
     
    /// Keep height and width constrained to same ratio
    public let preserveRatio: Bool // default: false
     
    /// How the layer is aligned inside an auto-layout frame. This property is
    /// only provided for direct children of auto-layout frames.
    ///
    /// In horizontal auto-layout frames, "MIN" and "MAX" correspond to "TOP"
    /// and "BOTTOM". In vertical auto-layout frames, "MIN" and "MAX"
    /// correspond to "LEFT" and "RIGHT".
    public let layoutAlign: FigmaLayoutAlignment?
    
    /// Horizontal and vertical layout constraints for node
    public let constraints: FigmaLayoutConstraint
     
    /// Node ID of node to transition to in prototyping
    public let transitionNodeID: String? // default: null
     
    /// The duration of the prototyping transition on this node (in millisec)
    public let transitionDuration: Double? // default: null
     
    /// The easing curve used in the prototyping transition on this node
    public let transitionEasing: FigmaEasingType? // default: null
     
    /// Opacity of the node
    public let opacity: Double // default: 1
    
    /// Bounding box of the node in absolute space coordinates
    public let absoluteBoundingBox: FigmaRectangle
     
    /// An array of effects attached to this node (see effects section for
    /// more details)
    public let effects: [FigmaEffect] // default: []
     
    /// Width and height of element. This is different from the width and
    /// height of the bounding box in that the absolute bounding box represents
    /// the element after scaling and rotation. Only present if geometry=paths
    /// is passed
    public let size: FigmaVector?
     
    /// The top two rows of a matrix that represents the 2D transform of this
    /// node relative to its parent. The bottom row of the matrix is implicitly
    /// always (0, 0, 1). Use to transform coordinates in geometry. Only
    /// present if geometry=paths is passed
    public var relativeTransform: FigmaTransform // default: figmaTransformIdentity
     
    /// Does this node mask sibling nodes in front of it?
    public let isMask: Bool // default: false
     
    /// An array of fill paints applied to the node
    public let fills: [FigmaPaint] // default: []
    
    /// Only specified if parameter geometry=paths is used. An array of paths
    /// representing the object fill
    public let fillGeometry: [FigmaPath]?
     
    /// An array of stroke paints applied to the node
    public let strokes: [FigmaPaint] // default: []
    
    /// The weight of strokes on the node
    public let strokeWeight: Double
     
    /// A string enum with value of "NONE", "ROUND", "SQUARE", "LINE_ARROW",
    /// or "TRIANGLE_ARROW", describing the end caps of vector paths.
    public let strokeCap: FigmaStrokeCap // default: "NONE"
     
    /// A string enum with value of "MITER", "BEVEL", or "ROUND", describing
    /// how corners in vector paths are rendered.
    public let strokeJoin: FigmaStrokeJoin // default: "MITER"
     
    /// An array of floating point numbers describing the pattern of dash
    /// length and gap lengths that the vector path follows. For example a
    /// value of [1, 2] indicates that the path has a dash of length 1
    /// followed by a gap of length 2, repeated.
    public let strokeDashes: [Double] // default: []
     
    /// Only valid if strokeJoin is "MITER". The corner angle, in degrees,
    /// below which strokeJoin will be set to "BEVEL" to avoid super sharp
    /// corners. By default this is 28.96 degrees.
    public let strokeMiterAngle: Double // default: 28.96
     
    /// Only specified if parameter geometry=paths is used. An array of paths
    /// representing the object stroke
    public let strokeGeometry: [FigmaPath]?
     
    /// Position of stroke relative to vector outline, as a string enum
    /// INSIDE: stroke drawn inside the shape boundary
    /// OUTSIDE: stroke drawn outside the shape boundary
    /// CENTER: stroke drawn centered along the shape boundary
    public let strokeAlign: FigmaStrokeAlign
     
    /// A mapping of a StyleType to style ID (see Style) of styles present on
    /// this node. The style ID can be used to look up more information about
    /// the style in the top-level styles field.
    public let styles: [String: String] // default: [:]
     
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case locked
        case exportSettings
        case blendMode
        case preserveRatio
        case layoutAlign
        case constraints
        case transitionNodeID
        case transitionDuration
        case transitionEasing
        case opacity
        case absoluteBoundingBox
        case effects
        case size
        case relativeTransform
        case isMask
        case fills
        case fillGeometry
        case strokes
        case strokeWeight
        case strokeCap
        case strokeJoin
        case strokeDashes
        case strokeMiterAngle
        case strokeGeometry
        case strokeAlign
        case styles
    }
        
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locked = try container.decodeIfPresent(Bool.self, forKey: .locked) ?? false
        exportSettings = try container.decodeIfPresent([FigmaExportSetting].self, forKey: .exportSettings) ?? []
        blendMode = try container.decode(FigmaBlendMode.self, forKey: .blendMode)
        preserveRatio = try container.decodeIfPresent(Bool.self, forKey: .preserveRatio) ?? false
        layoutAlign = try container.decodeIfPresent(FigmaLayoutAlignment.self, forKey: .layoutAlign)
        constraints = try container.decode(FigmaLayoutConstraint.self, forKey: .constraints)
        transitionNodeID = try container.decodeIfPresent(String.self, forKey: .transitionNodeID)
        transitionDuration = try container.decodeIfPresent(Double.self, forKey: .transitionDuration)
        transitionEasing = try container.decodeIfPresent(FigmaEasingType.self, forKey: .transitionEasing)
        opacity = try container.decodeIfPresent(Double.self, forKey: .opacity) ?? 1
        absoluteBoundingBox = try container.decode(FigmaRectangle.self, forKey: .absoluteBoundingBox)
        effects = try container.decodeIfPresent([FigmaEffect].self, forKey: .effects) ?? []
        size = try container.decodeIfPresent(FigmaVector.self, forKey: .size)
        relativeTransform = try container.decodeIfPresent(FigmaTransform.self, forKey: .relativeTransform) ?? figmaTransformIdentity
        isMask = try container.decodeIfPresent(Bool.self, forKey: .isMask) ?? false
        fills = try container.decodeIfPresent([FigmaPaint].self, forKey: .fills) ?? []
        fillGeometry = try container.decodeIfPresent([FigmaPath].self, forKey: .fillGeometry)
        strokes = try container.decodeIfPresent([FigmaPaint].self, forKey: .strokes) ?? []
        strokeWeight = try container.decode(Double.self, forKey: .strokeWeight)
        strokeCap = try container.decodeIfPresent(FigmaStrokeCap.self, forKey: .strokeCap) ?? .none
        strokeJoin = try container.decodeIfPresent(FigmaStrokeJoin.self, forKey: .strokeJoin) ?? .miter
        strokeDashes = try container.decodeIfPresent([Double].self, forKey: .strokeDashes) ?? []
        strokeMiterAngle = try container.decodeIfPresent(Double.self, forKey: .strokeMiterAngle) ?? 28.96
        strokeGeometry = try container.decodeIfPresent([FigmaPath].self, forKey: .strokeGeometry)
        strokeAlign = try container.decode(FigmaStrokeAlign.self, forKey: .strokeAlign)
        styles = try container.decodeIfPresent([String: String].self, forKey: .styles) ?? [:]
        try super.init(from: decoder)        
    }
}
