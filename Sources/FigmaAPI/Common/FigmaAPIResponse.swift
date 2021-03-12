
import Foundation

struct FigmaAPIErrorResponse {

    let status: Int
    let error: String?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension FigmaAPIErrorResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case status
        case error
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        status = try container.decode(Int.self, forKey: .status)
        error = try container.decodeIfPresent(String.self, forKey: .error)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(error, forKey: .error)
    }
}
