import SwiftUI

struct TimetableSkeleton: View {

    @State private var enablePulse: Bool = false

    let model: TimetableModel

    var ySpacing: CGFloat = 60

    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: gridItems,
                alignment: .leading,
                spacing: Padding.base.value
            ) {
                ForEach(0..<80, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.container)
                        .frame(height: 50)
                        .opacity(enablePulse ? 1 : 0.5)
                        .animation(
                            .linear(duration: 0.8).delay(.random(in: 0..<0.4)).repeatForever(autoreverses: true),
                            value: enablePulse)
                }
            }
        }
        .gradientMask(height: 40, alignment: .top)
        .onAppear {
            withAnimation {
                enablePulse = true
            }
        }
        .disabled(true)
    }

}

#Preview {

    @Previewable @State var containerWidth: CGFloat = 0

    TimetableSkeleton(model: TimetableModel(date: .now, events: []))
        .onGeometryChange(for: CGSize.self, of: \.size) {
            containerWidth = $0.width
        }

}
