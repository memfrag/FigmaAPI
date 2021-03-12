
import Foundation

/// Defines the scrolling behavior of the frame, if there exist contents
/// outside of the frame boundaries. The frame can either scroll
/// vertically, horizontally, or in both directions to the extents of
/// the content contained within it. This behavior can be observed in
/// a prototype.
public enum FigmaOverflowDirection: String, Codable {
    case none = "NONE"
    case horizontalScrolling = "HORIZONTAL_SCROLLING"
    case verticalScrolling = "VERTICAL_SCROLLING"
    case horizontalAndVerticalScrolling = "HORIZONTAL_AND_VERTICAL_SCROLLING"
}
