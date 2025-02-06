import SwiftUI

// MARK: Dimensions
public extension View {

    func maxWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func maxHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

    func maxSize(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

}

public class ScrollData: Equatable {

    let id: String
    var value: CGFloat

    public init(id: String, value: CGFloat) {
        self.id = id
        self.value = value
    }

    public static func == (lhs: ScrollData, rhs: ScrollData) -> Bool {
        lhs.id == rhs.id && lhs.value == rhs.value
    }

}

// MARK: Scroll offset
public struct ScrollViewOffsetKey: PreferenceKey {

    public typealias Value = ScrollData

    public static var defaultValue = ScrollData(id: "", value: 0)

    public static func reduce(value: inout Value, nextValue: () -> Value) {
        let nextValue1 = nextValue()
        if value.id == nextValue1.id {
            value.value += nextValue1.value
        }
    }

}

public extension View {

    @ViewBuilder
    func publishScrollOffset(in named: String, axis: Axis = .vertical) -> some View {
        background(
            GeometryReader { proxy in
                let frame = proxy.frame(in: .named(named))
                let offset: CGFloat = (axis == .vertical) ? frame.minY : frame.minX
                Color.clear.preference(key: ScrollViewOffsetKey.self, value: ScrollData(id: named, value: offset))
            })
    }

    func observeScrollOffset(of named: String, _ handler: @escaping (CGFloat) -> Void) -> some View {
        onPreferenceChange(ScrollViewOffsetKey.self) { change in
            if change.id == named {
                handler(change.value)
            }
        }
    }

}

// MARK: Alignment
public extension View {

    func pushedTop() -> some View {
        VStack(spacing: 0) {
            self

            Spacer().maxHeight()
        }
    }

    func pushedBottom() -> some View {
        VStack(spacing: 0) {
            Spacer().maxHeight()

            self
        }
    }

    func pushedLeading() -> some View {
        HStack(spacing: 0) {
            self

            Spacer().maxWidth()
        }
    }

    func pushedTrailing() -> some View {
        HStack(spacing: 0) {
            Spacer().maxWidth()

            self
        }
    }

}

public extension GeometryProxy {

    func width(_ multiplier: CGFloat = 1) -> CGFloat {
        size.width * multiplier
    }

    func height(_ multiplier: CGFloat = 1) -> CGFloat {
        size.height * multiplier
    }

}

// MARK: Safe Area Insets
public extension View {

    func safeAreaInset(_ edge: VerticalEdge, inset: CGFloat) -> some View {
        self
            .safeAreaInset(edge: edge, spacing: .zero) {
                EmptyView()
                    .frame(height: inset)
            }
    }

    func safeAreaInset(_ edge: VerticalEdge, inset: Padding) -> some View {
        self
            .safeAreaInset(edge: edge, spacing: .zero) {
                EmptyView()
                    .frame(height: inset.rawValue)
            }
    }

}

// MARK: Border
public extension View {

    func border(cornerRadius: CGFloat = 4, color: Color = .surfaceTextPrimary, lineWidth: CGFloat = 2) -> some View {
        overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
                .padding(lineWidth / 2)
        }
        .cornerRadius(cornerRadius)
    }

}
