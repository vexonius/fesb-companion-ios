import Foundation
import SwiftUI

public enum Padding: CGFloat {

    case small = 4
    case base = 8
    case medium = 16
    case large = 32

    public var value: CGFloat {
        self.rawValue
    }

}

public extension Padding {

    static func * (left: Padding, right: Double) -> CGFloat {
        CGFloat(right * left.value)
    }

    static func * (left: Double, right: Padding) -> CGFloat {
        CGFloat(left * right.value)
    }

}

public extension View {

    func padding(_ size: Padding) -> some View {
        self.padding(size.value)
    }

    func padding(_ edges: Edge.Set = .all, _ size: Padding) -> some View {
        self.padding(edges, size.value)
    }

}

extension VStack {

    init (spacing: Padding, alignment: HorizontalAlignment = .center, content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }

}

extension LazyVStack {

    init (spacing: Padding, alignment: HorizontalAlignment = .center, content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }

}

extension HStack {

    init (spacing: Padding, alignment: VerticalAlignment = .center, content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }

}

extension LazyHStack {

    init (spacing: Padding, alignment: VerticalAlignment = .center, content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }

}
