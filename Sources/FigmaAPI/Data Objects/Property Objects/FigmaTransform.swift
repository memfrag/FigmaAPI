
import Foundation

/// A 2D affine transformation matrix that can be used to calculate the affine
/// transforms applied to a layer, including scaling, rotation, shearing, and
/// translation.
///
/// The form of the matrix is given as an array of 2 arrays of 3 numbers each.
/// E.g. the identity matrix would be [[1, 0, 0], [0, 1, 0]]
public struct FigmaTransform: Codable {

    public let matrix: [[Double]]

    public init(matrix: [[Double]]) {
        self.matrix = matrix
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            matrix = try container.decode([[Double]].self)
        } catch {
            matrix = [[.nan, .nan, .nan], [.nan, .nan, .nan]]
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(matrix)
    }
}


public let figmaTransformIdentity = FigmaTransform(matrix: [[1, 0, 0], [0, 1, 0]])
