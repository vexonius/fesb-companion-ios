import SwiftUI
import ComposableArchitecture

@ViewAction(for: IksicaReducer.self)
struct IksicaView: View {

    @Bindable var store: StoreOf<IksicaReducer>
    @State private var offset: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.orange)
                    .aspectRatio(1.5, contentMode: .fit)
                    .maxWidth()
                    .padding(.horizontal, 40 + min(30, abs(offset)))
                    .frame(height: 300)
                    .shadow(color: Color.orange.opacity(0.8), radius: 10 - min(10, abs(offset)), x: 0, y: 0)
                    .shadow(color: Color.orange.opacity(0.5), radius: 80 - min(80, abs(offset)), x: 0, y: 0)

                ScrollView {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 300)

                    VStack(spacing: .small) {
                        Text(.transactions)
                            .font(.fontHeading3)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .leading)
                            .padding(.medium)

                        ForEach(0..<100, id: \.self) { item in
                            ReceiptCard()
                                .zIndex(100)
                                .onTapGesture {
                                    send(.details)
                                }

                            Divider()
                        }
                    }
                    .maxWidth()
                    .background(Material.thin)
                }
                .onScrollGeometryChange(
                    for: CGFloat.self,
                    of: { $0.contentOffset.y + $0.contentInsets.top},
                    action: { new, old in
                        debugPrint(new)
                        offset = new
                    }
                )
                .refreshable {}
            }
            .background(Color.surface)
            .sheet(item: $store.scope(state: \.receiptDetails, action: \.receiptDetails)) { store in
                EmptyView()
            }
        }
    }

    private func ReceiptCard() -> some View {
        VStack(spacing: .base) {
            HStack {
                Text("Kampus Menza")
                    .font(.fontHeading5)
                    .foregroundStyle(Color.white)
                    .maxWidth(alignment: .leading)


                Text("19.35 €")
                    .font(.fontLabelMedium)
                    .foregroundStyle(Color.white)
            }

            Text("Jučer u 16:32")
                .font(.fontBodyMedium)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .leading)
        }
        .padding(.base)
//        .background(Color.container)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, .medium)
    }

}

struct IksicaView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: IksicaReducer.State(),
        reducer: IksicaReducer.init)

    static var previews: some View {
        IksicaView(store: store)
    }

}
