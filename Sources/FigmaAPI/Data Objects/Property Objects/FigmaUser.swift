
import Foundation

/// A description of a user.
/// 
/// A user is a Figma account of an individual that has signed up for Figma and created an account.
/// Every user will have recorded ― and can be identified by ― four properties
public struct FigmaUser: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case handle
        case profileImageURL = "img_url"
        case email
    }

    /// Unique stable id of the user
    public let id: String
    
    /// Name of the user
    public let handle: String
    
    /// URL link to the user's profile image
    public let profileImageURL: String?

    /// Email associated with the user's account. This will only be present on the /v1/me endpoint.
    public let email: String?
}
