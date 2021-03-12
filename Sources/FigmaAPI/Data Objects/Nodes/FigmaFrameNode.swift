
import Foundation

public class FigmaFrameNode: FigmaNode {
    
    /// An array of nodes that are direct children of this node
    public let children: [FigmaNode]
       
    /// If true, layer is locked and cannot be edited
    public let locked: Bool // default: false
       
    /// An array of fill paints applied to the node
    public let fills: [FigmaPaint] // default: []

    /// An array of stroke paints applied to the node
    public let strokes: [FigmaPaint] // default: []
       
    /// The weight of strokes on the node
    public let strokeWeight: Double

    /// Position of stroke relative to vector outline, as a string enum
    public let strokeAlign: FigmaStrokeAlign
    
    /// Radius of each corner of the frame if a single radius is set for
    /// all corners
    public let cornerRadius: Double?
    
    /// Array of length 4 of the radius of each corner of the frame, starting
    /// in the top left and proceeding clockwise
    public let rectangleCornerRadii: [Double]?
    
    /// An array of export settings representing images to export from node
    public let exportSettings: [FigmaExportSetting] // default: []
       
    /// How this node blends with nodes behind it in the scene (see blend
    /// mode section for more details)
    public let blendMode: FigmaBlendMode
       
    /// Keep height and width constrained to same ratio
    public let preserveRatio: Bool // default: false
       
    /// Horizontal and vertical layout constraints for node
    public let constraints: FigmaLayoutConstraint
       
    /// How the layer is aligned inside an auto-layout frame. This property is
    /// only provided for direct children of auto-layout frames.
    public let layoutAlign: FigmaLayoutAlignment?

    /// Node ID of node to transition to in prototyping
    public let transitionNodeID: String? // default: null
    
    /// The duration of the prototyping transition on this node (in millisec.)
    public let transitionDuration: Double? // default: null
    
    /// The easing curve used in the prototyping transition on this node
    public let transitionEasing: FigmaEasingType? // default: null
       
    /// Opacity of the node
    public let opacity: Double // default: 1
           
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
    public let relativeTransform: FigmaTransform // default: figmaTransformIdentity
    
    /// Whether or not this node clip content outside of its bounds
    public let clipsContent: Bool
    
    /// Whether this layer uses auto-layout to position its children.
    public let layoutMode: FigmaLayoutMode // default: NONE
    
    /// Whether the counter axis has a fixed length (determined by the user)
    /// or an automatic length (determined by the layout engine). This
    /// property is only applicable for auto-layout frames.
    public let counterAxisSizingMode: FigmaCountryAxisSizingMode // default: AUTO

    /// The horizontal padding between the borders of the frame and its
    /// children. This property is only applicable for auto-layout frames.
    public let horizontalPadding: Double // default: 0
       
    /// The vertical padding between the borders of the frame and its children.
    /// This property is only applicable for auto-layout frames.
    public let verticalPadding: Double // default: 0
       
    /// The distance between children of the frame. This property is only
    /// applicable for auto-layout frames.
    public let itemSpacing: Double // default: 0
    
    /// An array of layout grids attached to this node (see layout grids
    /// section for more details). GROUP nodes do not have this attribute
    public let layoutGrids: [FigmaLayoutGrid] // default: []
       
    /// Defines the scrolling behavior of the frame, if there exist contents
    /// outside of the frame boundaries. The frame can either scroll
    /// vertically, horizontally, or in both directions to the extents of
    /// the content contained within it. This behavior can be observed in
    /// a prototype.
    public let overflowDirection: FigmaOverflowDirection // default: NONE
      
    /// An array of effects attached to this node (see effects section for
    /// more details)
    public let effects: [FigmaEffect] // default: []
       
    /// Does this node mask sibling nodes in front of it?
    public let isMask: Bool // default: false
    
    /// Does this mask ignore fill style (like gradients) and effects?
    public let isMaskOutline: Bool // default: false
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case children
        case locked
        case fills
        case strokes
        case strokeWeight
        case strokeAlign
        case cornerRadius
        case rectangleCornerRadii
        case exportSettings
        case blendMode
        case preserveRatio
        case constraints
        case layoutAlign
        case transitionNodeID
        case transitionDuration
        case transitionEasing
        case opacity
        case absoluteBoundingBox
        case size
        case relativeTransform
        case clipsContent
        case layoutMode
        case counterAxisSizingMode
        case horizontalPadding
        case verticalPadding
        case itemSpacing
        case layoutGrids
        case overflowDirection
        case effects
        case isMask
        case isMaskOutline
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
        children = try Self.decodeNodes(container: container, forKey: .children)
        locked = try container.decodeIfPresent(Bool.self, forKey: .locked) ?? false
        fills = try container.decodeIfPresent([FigmaPaint].self, forKey: .fills) ?? []
        strokes = try container.decodeIfPresent([FigmaPaint].self, forKey: .strokes) ?? []
        strokeWeight = try container.decode(Double.self, forKey: .strokeWeight)
        strokeAlign = try container.decode(FigmaStrokeAlign.self, forKey: .strokeAlign)
        cornerRadius = try container.decodeIfPresent(Double.self, forKey: .cornerRadius)
        rectangleCornerRadii = try container.decodeIfPresent([Double].self, forKey: .rectangleCornerRadii)
        exportSettings = try container.decodeIfPresent([FigmaExportSetting].self, forKey: .exportSettings) ?? []
        blendMode = try container.decode(FigmaBlendMode.self, forKey: .blendMode)
        preserveRatio = try container.decodeIfPresent(Bool.self, forKey: .preserveRatio) ?? false
        constraints = try container.decode(FigmaLayoutConstraint.self, forKey: .constraints)
        layoutAlign = try container.decodeIfPresent(FigmaLayoutAlignment.self, forKey: .layoutAlign)
        transitionNodeID = try container.decodeIfPresent(String.self, forKey: .transitionNodeID)
        transitionDuration = try container.decodeIfPresent(Double.self, forKey: .transitionDuration)
        transitionEasing = try container.decodeIfPresent(FigmaEasingType.self, forKey: .transitionEasing)
        opacity = try container.decodeIfPresent(Double.self, forKey: .opacity) ?? 1
        absoluteBoundingBox = try container.decode(FigmaRectangle.self, forKey: .absoluteBoundingBox)
        size = try container.decodeIfPresent(FigmaVector.self, forKey: .size)
        relativeTransform = try container.decodeIfPresent(FigmaTransform.self, forKey: .relativeTransform) ?? figmaTransformIdentity
        clipsContent = try container.decode(Bool.self, forKey: .clipsContent)
        layoutMode = try container.decodeIfPresent(FigmaLayoutMode.self, forKey: .layoutMode) ?? .none
        counterAxisSizingMode = try container.decodeIfPresent(FigmaCountryAxisSizingMode.self, forKey: .counterAxisSizingMode) ?? .auto
        horizontalPadding = try container.decodeIfPresent(Double.self, forKey: .horizontalPadding) ?? 0
        verticalPadding = try container.decodeIfPresent(Double.self, forKey: .verticalPadding) ?? 0
        itemSpacing = try container.decodeIfPresent(Double.self, forKey: .itemSpacing) ?? 0
        layoutGrids = try container.decodeIfPresent([FigmaLayoutGrid].self, forKey: .layoutGrids) ?? []
        overflowDirection = try container.decodeIfPresent(FigmaOverflowDirection.self, forKey: .overflowDirection) ?? .none
        effects = try container.decodeIfPresent([FigmaEffect].self, forKey: .effects) ?? []
        isMask = try container.decodeIfPresent(Bool.self, forKey: .isMask) ?? false
        isMaskOutline = try container.decodeIfPresent(Bool.self, forKey: .isMaskOutline) ?? false
        } catch {
            dump(error)
            throw error
        }

        try super.init(from: decoder)
    }
}
