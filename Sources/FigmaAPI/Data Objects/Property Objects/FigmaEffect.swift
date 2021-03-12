
import Foundation

public enum FigmaEffectType: String, Codable {
    case innerShadow = "INNER_SHADOW"
    case dropShadow = "DROP_SHADOW"
    case layerBlur = "LAYER_BLUR"
    case backgroundBlur = "BACKGROUND_BLUR"
}

/// A visual effect such as a shadow or blur
public struct FigmaEffect: Codable {
    
    /// Type of effect as a string enum
    public let type: FigmaEffectType
    
    /// Is the effect active?
    public let visible: Bool
    
    /// Radius of the blur effect (applies to shadows as well)
    public let radius: Double
    
    // The following properties are for shadows only:
    
    /// The color of the shadow
    public let color: FigmaColor
    
    /// Blend mode of the shadow
    public let blendMode: FigmaBlendMode
    
    /// How far the shadow is projected in the x and y directions
    public let offset: FigmaVector
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case type
        case visible
        case radius
        case color
        case blendMode
        case offset
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(FigmaEffectType.self, forKey: .type)
        visible = try container.decode(Bool.self, forKey: .visible)
        radius = try container.decode(Double.self, forKey: .radius)
        
        color = try container.decodeIfPresent(FigmaColor.self, forKey: .color) ?? FigmaColor.white
        blendMode = try container.decodeIfPresent(FigmaBlendMode.self, forKey: .blendMode) ?? FigmaBlendMode.normal
        offset = try container.decodeIfPresent(FigmaVector.self, forKey: .offset) ?? FigmaVector.zero
    }
}
