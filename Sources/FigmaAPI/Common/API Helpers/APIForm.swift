
import Foundation

/// Builds a form string of content type application/x-www-form-urlencoded
struct APIForm {

    let contentType: APIContentType = .form

    let encodedString: String

    var data: Data {
        return encodedString.data(using: .utf8) ?? Data()
    }

    init(fields: [String: String]) {
        var encodedFields: [String] = []
        for (key, value) in fields {
            let encodedKey = APIForm.encode(string: key)
            let encodedValue = APIForm.encode(string: value)
            let field = "\(encodedKey)=\(encodedValue)"
            encodedFields.append(field)
        }
        encodedString = encodedFields.joined(separator: "&")
    }

    static func encode(string: String) -> String {
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved)
        return encodedString ?? string
    }
}

fileprivate extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}
