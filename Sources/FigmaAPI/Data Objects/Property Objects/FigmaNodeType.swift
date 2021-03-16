
import Foundation

public enum FigmaNodeType: String, Decodable {
    case document = "DOCUMENT"
    case canvas = "CANVAS"
    case frame = "FRAME"
    case group = "GROUP"
    case vector = "VECTOR"
    case booleanOperation = "BOOLEAN_OPERATION"
    case star = "STAR"
    case line = "LINE"
    case ellipse = "ELLIPSE"
    case regularPolygon = "REGULAR_POLYGON"
    case rectangle = "RECTANGLE"
    case text = "TEXT"
    case slice = "SLICE"
    case component = "COMPONENT"
    case componentSet = "COMPONENT_SET"
    case instance = "INSTANCE"
}
