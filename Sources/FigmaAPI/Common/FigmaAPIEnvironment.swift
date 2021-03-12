
import Foundation

public class FigmaAPIEnvironment {

    public struct FigmaAPIConfig {
        let url: URL
        let parameters: [String: String]
        let accessToken: String

        init(url: URL, parameters: [String: String], accessToken: String) {
            self.url = url
            self.parameters = parameters
            self.accessToken = accessToken
        }
    }
    
    public let figmaAPI: FigmaAPIConfig

    public init(figmaAPI: FigmaAPIConfig) {
        self.figmaAPI = figmaAPI
    }
}
