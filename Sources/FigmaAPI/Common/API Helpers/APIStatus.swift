
import Foundation

enum APIStatus {

    case ok
    case notOK

    var isOK: Bool {
        switch self {
        case .ok: return true
        default: return false
        }
    }

    var asString: String {
        switch self {
        case .ok: return "OK"
        case .notOK: return "NotOK"
        }
    }

    init(_ value: String) {
        switch value.lowercased() {
        case "ok": self = .ok
        default: self = .notOK
        }
    }
}

extension APIStatus: Codable {

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value.lowercased() {
        case "ok": self = .ok
        default: self = .notOK
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(asString)
    }
}
