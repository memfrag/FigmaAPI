
import Foundation

public class FigmaTextNode: FigmaVectorNode {
    
    /// Text contained within text box
    public let characters: String // default: ""
    
    /// Style of text including font family and weight (see type style section
    /// for more information)
    public let style: FigmaTypeStyle
    
    /// Array with same number of elements as characeters in text box, each
    /// element is a reference to the styleOverrideTable defined below and maps
    /// to the corresponding character in the characters field. Elements with
    /// value 0 have the default type style
    public let characterStyleOverrides: [Int] // default: []
    
    /// Map from ID to TypeStyle for looking up style overrides
    public let styleOverrideTable: [Int: FigmaTypeStyle] // default: [:]
    
    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case characters
        case style
        case characterStyleOverrides
        case styleOverrideTable
    }
        
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        characters = try container.decodeIfPresent(String.self, forKey: .characters) ?? ""
        style = try container.decode(FigmaTypeStyle.self, forKey: .style)
        characterStyleOverrides = try container.decodeIfPresent([Int].self, forKey: .characterStyleOverrides) ?? []
        styleOverrideTable = try container.decodeIfPresent([Int: FigmaTypeStyle].self, forKey: .styleOverrideTable) ?? [:]
        try super.init(from: decoder)
    }
}
