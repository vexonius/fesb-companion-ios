import SwiftUI

struct AttendanceSkeleton: View {

    @State private var isInitialState = false

    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack(spacing: .base) {
                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 120, height: 30)

                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 120, height: 30)
            }
            .maxWidth(alignment: .leading)
            .padding(.top, .base)

            RoundedRectangle(cornerRadius: 30)
                .maxWidth()
                .frame(height: 240)
                .foregroundColor(Color.container)

            RoundedRectangle(cornerRadius: 30)
                .maxWidth()
                .frame(height: 240)
                .foregroundColor(Color.container)
        }
        .maxWidth()
        .pushedTop()
        .padding(.horizontal, .medium)
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
