
import Foundation

/// Metadata for character formatting
public struct FigmaTypeStyle {

    /// Font family of text (standard name)
    public let fontFamily: String?
    
    /// PostScript font name
    public let fontPostScriptName: String?
    
    /// Space between paragraphs in px, 0 if not present
    public let paragraphSpacing: Double // default: 0
    
    /// Paragraph indentation in px, 0 if not present
    public let paragraphIndent: Double // default: 0
    
    /// Whether or not text is italicized
    public let italic: Bool
    
    /// Numeric font weight
    public let fontWeight: Double?
    
    /// Font size in px
    public let fontSize: Double?
    
    /// Text casing applied to the node, default is the original casing
    public let textCase: FigmaTextCase // default: ORIGINAL
    
    /// Text decoration applied to the node, default is none
    public let textDecoration: FigmaTextDecoration // default: NONE
    
    /// Dimensions along which text will auto resize, default is that the text
    /// does not auto-resize.
    public let textAutoResize: FigmaTextAutoResize // default: NONE
    
    /// Horizontal text alignment as string enum
    public let textAlignHorizontal: FigmaTextAlignHorizontal?
    
    /// Vertical text alignment as string enum
    public let textAlignVertical: FigmaTextAlignVertical?
    
    /// Space between characters in px
    public let letterSpacing: Double?
    
    /// Paints applied to characters
    public let fills: [FigmaPaint]

    /// Link to a URL or frame
    public let hyperlink: FigmaHyperlink?

    /// A map of OpenType feature flags to 1 or 0, 1 if it is enabled and 0 if
    /// it is disabled. Note that some flags aren't reflected here. For
    /// example, SMCP (small caps) is still represented by the textCase field.
    public let opentypeFlagsMap: [String: Int] // default: [:]

    /// Line height in px
    public let lineHeightPx: Double?
    
    /// Line height as a percentage of the font size. Only returned when
    /// lineHeightPercent is not 100.
    public let lineHeightPercentFontSize: Double?

    /// The unit of the line height value specified by the user.
    public let lineHeightUnit: FigmaLineHeightUnit?
}

extension FigmaTypeStyle: Codable {
    
    enum CodingKeys: String, CodingKey {
        case fontFamily
        case fontPostScriptName
        case paragraphSpacing
        case paragraphIndent
        case italic
        case fontWeight
        case fontSize
        case textCase
        case textDecoration
        case textAutoResize
        case textAlignHorizontal
        case textAlignVertical
        case letterSpacing
        case fills
        case hyperlink
        case opentypeFlagsMap
        case lineHeightPx
        case lineHeightPercentFontSize
        case lineHeightUnit
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fontFamily = try container.decodeIfPresent(String.self, forKey: .fontFamily)
        fontPostScriptName = try container.decodeIfPresent(String.self, forKey: .fontPostScriptName)
        paragraphSpacing = try container.decodeIfPresent(Double.self, forKey: .paragraphSpacing) ?? 0
        paragraphIndent = try container.decodeIfPresent(Double.self, forKey: .paragraphIndent) ?? 0
        italic = try container.decodeIfPresent(Bool.self, forKey: .italic) ?? false
        fontWeight = try container.decodeIfPresent(Double.self, forKey: .fontWeight)
        fontSize = try container.decodeIfPresent(Double.self, forKey: .fontSize)
        textCase = try container.decodeIfPresent(FigmaTextCase.self, forKey: .textCase) ?? .original
        textDecoration = try container.decodeIfPresent(FigmaTextDecoration.self, forKey: .textDecoration) ?? .none
        textAutoResize = try container.decodeIfPresent(FigmaTextAutoResize.self, forKey: .textAutoResize) ?? .none
        textAlignHorizontal = try container.decodeIfPresent(FigmaTextAlignHorizontal.self, forKey: .textAlignHorizontal)
        textAlignVertical = try container.decodeIfPresent(FigmaTextAlignVertical.self, forKey: .textAlignVertical)
        letterSpacing = try container.decodeIfPresent(Double.self, forKey: .letterSpacing)
        fills = try container.decodeIfPresent([FigmaPaint].self, forKey: .fills) ?? []
        hyperlink = try container.decodeIfPresent(FigmaHyperlink.self, forKey: .hyperlink)
        opentypeFlagsMap = try container.decodeIfPresent([String: Int].self, forKey: .opentypeFlagsMap) ?? [:]
        lineHeightPx = try container.decodeIfPresent(Double.self, forKey: .lineHeightPx)
        lineHeightPercentFontSize = try container.decodeIfPresent(Double.self, forKey: .lineHeightPercentFontSize)
        lineHeightUnit = try container.decodeIfPresent(FigmaLineHeightUnit.self, forKey: .lineHeightUnit)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fontFamily, forKey: .fontFamily)
        try container.encodeIfPresent(fontPostScriptName, forKey: .fontPostScriptName)
        try container.encode(paragraphSpacing, forKey: .paragraphSpacing)
        try container.encode(paragraphIndent, forKey: .paragraphIndent)
        try container.encode(italic, forKey: .italic)
        try container.encodeIfPresent(fontWeight, forKey: .fontWeight)
        try container.encodeIfPresent(fontSize, forKey: .fontSize)
        try container.encode(textCase, forKey: .textCase)
        try container.encode(textDecoration, forKey: .textDecoration)
        try container.encode(textAutoResize, forKey: .textAutoResize)
        try container.encodeIfPresent(textAlignHorizontal, forKey: .textAlignHorizontal)
        try container.encodeIfPresent(textAlignVertical, forKey: .textAlignVertical)
        try container.encodeIfPresent(letterSpacing, forKey: .letterSpacing)
        try container.encode(fills, forKey: .fills)
        try container.encodeIfPresent(hyperlink, forKey: .hyperlink)
        try container.encode(opentypeFlagsMap, forKey: .opentypeFlagsMap)
        try container.encodeIfPresent(lineHeightPx, forKey: .lineHeightPx)
        try container.encodeIfPresent(lineHeightPercentFontSize, forKey: .lineHeightPercentFontSize)
        try container.encodeIfPresent(lineHeightUnit, forKey: .lineHeightUnit)
    }
}
