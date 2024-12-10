import SwiftUI

struct IksicaSkeleton: View {

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.container)
                    .aspectRatio(1.5, contentMode: .fit)
                    .maxWidth()
                    .padding(.horizontal, 40)
                    .frame(height: 300)

                VStack(spacing: .small) {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 300)

                    Rectangle()
                        .fill(Color.container)
                        .frame(height: 100)

                    Rectangle()
                        .fill(Color.container)
                        .frame(height: 100)

                    Rectangle()
                        .fill(Color.container)
                        .frame(height: 100)

                    Rectangle()
                        .fill(Color.container)
                        .frame(height: 100)
                }
            }
            .maxSize()
            .shimmer()
            .background(Color.surface.ignoresSafeArea())
            .navigationTitle(String.xcard)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

#Preview {
    IksicaSkeleton()
}
