
import Foundation

extension URLRequest {

    mutating func setMethod(_ method: APIHTTPMethod) {
        httpMethod = method.asString
    }

    mutating func setContentType(_ contentType: APIContentType) {
        setValue(contentType.asString, forHTTPHeaderField: "Content-Type")
    }

    mutating func setFormBody(_ form: APIForm) {
        setContentType(form.contentType)
        httpBody = form.data
    }
}
