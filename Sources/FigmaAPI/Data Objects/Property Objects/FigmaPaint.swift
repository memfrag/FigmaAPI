
import Foundation

/// A solid color, gradient, or image texture that can be applied as fills
/// or strokes
public struct FigmaPaint {

    /// Type of paint as a string enum
    public let type: FigmaPaintType
        
    /// Is the paint enabled?
    public let visible: Bool // default: true
    
    /// Overall opacity of paint (colors within the paint can also have
    /// opacity values which would blend with this)
    public let opacity: Double // default: 1
    
    // MARK: For solid paints:
    
    /// Solid color of the paint
    public let color: FigmaColor // default: FigmaColor(r: 0, g: 0, b: 0, a: 0)
    
    // MARK: For gradient paints:

    /// How this node blends with nodes behind it in the scene
    /// (see blend mode section for more details)
    public let blendMode: FigmaBlendMode // default: .normal
    
    /// This field contains three vectors, each of which are a position in
    /// normalized object space (normalized object space is if the top left
    /// corner of the bounding box of the object is (0, 0) and the bottom
    /// right is (1,1)). The first position corresponds to the start of the
    /// gradient (value 0 for the purposes of calculating gradient stops),
    /// the second position is the end of the gradient (value 1), and the
    /// third handle position determines the width of the gradient. See image
    /// examples in documentation.
    public let gradientHandlePositions: [FigmaVector]
    
    /// Positions of key points along the gradient axis with the colors
    /// anchored there. Colors along the gradient are interpolated smoothly
    /// between neighboring gradient stops.
    public let gradientStops: [FigmaColorStop]
    
    // MARK: For image paints:

    /// Image scaling mode
    public let scaleMode: FigmaScaleMode // default: .fill

    /// Affine transform applied to the image, only if scaleMode is STRETCH
    public let imageTransform: FigmaTransform // default: figmaTransformIdentity
    
    /// Amount image is scaled by in tiling, only if scaleMode is TILE
    public let scalingFactor: Double // default: 1
    
    /// Image rotation, in degrees.
    public let rotation: Double // default: 0
    
    /// A reference to an image embedded in this node. To download the image
    /// using this reference, use the GET file images endpoint to retrieve the
    /// mapping from image references to image URLs
    public let imageRef: String?
    
    /// A reference to the GIF embedded in this node, if the image is a GIF.
    /// To download the image using this reference, use the GET file images
    /// endpoint to retrieve the mapping from image references to image URLs
    public let gifRef: String?
}

extension FigmaPaint: Codable {

    enum CodingKeys: String, CodingKey {
        case type
        case visible
        case opacity
        case color
        case blendMode
        case gradientHandlePositions
        case gradientStops
        case scaleMode
        case imageTransform
        case scalingFactor
        case rotation
        case imageRef
        case gifRef
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(FigmaPaintType.self, forKey: .type)
        visible = try container.decodeIfPresent(Bool.self, forKey: .visible) ?? true
        opacity = try container.decodeIfPresent(Double.self, forKey: .opacity) ?? 1
        color = try container.decodeIfPresent(FigmaColor.self, forKey: .color) ?? FigmaColor(r: 0, g: 0, b: 0, a: 0)
        blendMode = try container.decodeIfPresent(FigmaBlendMode.self, forKey: .blendMode) ?? .normal
        gradientHandlePositions = try container.decodeIfPresent([FigmaVector].self, forKey: .gradientHandlePositions) ?? []
        gradientStops = try container.decodeIfPresent([FigmaColorStop].self, forKey: .gradientStops) ?? []
        scaleMode = try container.decodeIfPresent(FigmaScaleMode.self, forKey: .scaleMode) ?? .fill
        imageTransform = try container.decodeIfPresent(FigmaTransform.self, forKey: .imageTransform) ?? figmaTransformIdentity
        scalingFactor = try container.decodeIfPresent(Double.self, forKey: .scalingFactor) ?? 1
        rotation = try container.decodeIfPresent(Double.self, forKey: .rotation) ?? 0
        imageRef = try container.decodeIfPresent(String.self, forKey: .imageRef)
        gifRef = try container.decodeIfPresent(String.self, forKey: .gifRef)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(visible, forKey: .visible)
        try container.encode(opacity, forKey: .opacity)
        try container.encode(color, forKey: .color)
        try container.encode(blendMode, forKey: .blendMode)
        try container.encode(gradientHandlePositions, forKey: .gradientHandlePositions)
        try container.encode(gradientStops, forKey: .gradientStops)
        try container.encode(scaleMode, forKey: .scaleMode)
        try container.encode(imageTransform, forKey: .imageTransform)
        try container.encode(scalingFactor, forKey: .scalingFactor)
        try container.encode(rotation, forKey: .rotation)
        try container.encodeIfPresent(imageRef, forKey: .imageRef)
        try container.encodeIfPresent(gifRef, forKey: .gifRef)
    }
}
