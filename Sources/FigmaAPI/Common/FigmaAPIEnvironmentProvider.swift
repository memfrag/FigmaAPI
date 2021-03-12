
import Foundation

public protocol FigmaAPIEnvironmentProvider {
    var apiEnvironment: FigmaAPIEnvironment { get }
}

// MARK: - Default Implementation

public struct FigmaAPIDefaultEnvironmentProvider: FigmaAPIEnvironmentProvider {
    public let apiEnvironment: FigmaAPIEnvironment
}
