import SwiftUI

struct GradientMask: ViewModifier {

    var alignment: Alignment
    var height: CGFloat
    var color: Color

    private var startPoint: UnitPoint {
        switch alignment {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        default:
            return .zero
        }
    }

    private var endPoint: UnitPoint {
        switch alignment {
        case .top:
            return .bottom
        case .bottom:
            return .top
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        default:
            return .zero
        }
    }

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                LinearGradient(colors: [color, .clear], startPoint: startPoint, endPoint: endPoint)
                    .maxWidth()
                    .frame(height: height)
            }
    }

}

extension View {

    func gradientMask(height: CGFloat, alignment: Alignment = .top, color: Color = .black) -> some View {
        self.modifier(GradientMask(alignment: alignment, height: height, color: color))
    }

}
