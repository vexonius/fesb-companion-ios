import SwiftUI

struct ShimmerViewModifier: ViewModifier {

    @State private var isInitialState = false

    func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: 2, y: 2) : .init(x: 0, y: 0)),
                    endPoint: (isInitialState ? .init(x: 1, y: 1) : .init(x: -2, y: -2))
                )
            }
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear {
                isInitialState = true
            }
    }

}

extension View {

    func shimmer() -> some View {
        modifier(ShimmerViewModifier())
    }

}
