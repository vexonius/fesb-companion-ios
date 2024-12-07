import SwiftUI

struct AttendanceSkeleton: View {

    @State private var isInitialState = true

    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack(spacing: .base) {
                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 80, height: 30)

                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 80, height: 30)
            }
            .maxWidth(alignment: .leading)

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
        .padding(.horizontal, .medium)
        .mask {
            LinearGradient(
                gradient: .init(colors: [.white, .black, .white]),
                startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
            )
        }
        .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
        .onAppear {
            isInitialState = false
        }
    }

}
