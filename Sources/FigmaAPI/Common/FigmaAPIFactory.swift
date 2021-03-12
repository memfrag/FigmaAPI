
import Foundation

public class FigmaAPIFactory {
    
    // MARK: - Make API

    public static func makeAPI(accessToken: String) -> FigmaAPI {
        
        let apiConfig = FigmaAPIEnvironment.FigmaAPIConfig(url: URL(valid: "https://api.figma.com/v1"), parameters: [:], accessToken: accessToken)
        
        let environment = FigmaAPIEnvironment(figmaAPI: apiConfig)
        
        let provider = FigmaAPIDefaultEnvironmentProvider(apiEnvironment: environment)
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 4
        config.timeoutIntervalForRequest = 60
        let urlSession = URLSession(configuration: config)
        let performer = FigmaAPIRequestPerformer(urlSession: urlSession,
                                                 environmentProvider: provider)
        let figmaAPI = FigmaAPI(environmentProvider: provider,
                                requestPerformer: performer)

        return figmaAPI
    }
}
