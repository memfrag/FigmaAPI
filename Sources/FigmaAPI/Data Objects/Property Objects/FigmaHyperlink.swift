
import Foundation

/// A link to either a URL or another frame (node) in the document
public enum FigmaHyperlink {
    case url(String)
    case node(id: FigmaNodeID)
}

extension FigmaHyperlink: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
        case nodeID
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        if type == "URL" {
            let url = try container.decode(String.self, forKey: .url)
            self = .url(url)
        } else if type == "NODE" {
            let nodeID = try container.decode(String.self, forKey: .nodeID)
            self = .node(id: nodeID)
        } else {
            fatalError()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .url(let url):
            try container.encode("URL", forKey: .type)
            try container.encode(url, forKey: .url)
        case .node(let nodeID):
            try container.encode("NODE", forKey: .type)
            try container.encode(nodeID, forKey: .nodeID)
        }
    }
}
