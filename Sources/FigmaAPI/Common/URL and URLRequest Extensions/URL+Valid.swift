
import Foundation

extension URL {

    init(valid: String) {
        // swiftlint:disable force_unwrapping
        self.init(string: valid)!
        // swiftlint:enable force_unwrapping
    }
}
