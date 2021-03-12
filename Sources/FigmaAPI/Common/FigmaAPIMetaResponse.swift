
import Foundation

public struct FigmaAPIMetaResponse<Meta: Codable>: Codable {
    public let status: Int
    public let error: Bool
    public let meta: Meta
}
