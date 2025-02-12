import SwiftUI

struct TimetableSkeleton: View {

    @State private var enablePulse: Bool = false

    let containerWidth: CGFloat
    let model: TimetableModel

    var verticalSpacing: CGFloat = 60

    var xSpacing: CGFloat {
        containerWidth / 5
    }

    var ySpacing: CGFloat {
        verticalSpacing
    }

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(.adaptive(minimum: 50)), count: 5),
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
        .overlay(alignment: .top) {
            LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
                .maxWidth()
                .frame(height: 40)
        }
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

    TimetableSkeleton(
        containerWidth: containerWidth,
        model: TimetableModel(date: .now, events: []))
    .onGeometryChange(for: CGSize.self, of: \.size) {
        containerWidth = $0.width
    }

}
