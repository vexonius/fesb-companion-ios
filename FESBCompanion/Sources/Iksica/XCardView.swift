import SwiftUI
import ComposableArchitecture

@ViewAction(for: XCardReducer.self)
struct XCardView: View {

    @Bindable var store: StoreOf<XCardReducer>
    @State private var offset: CGFloat = 0

    var body: some View {
        ZStack {
            switch store.viewState {
            case .loading, .initial:
                XCardSkeleton()
            case .loaded(let model), .fetchingMore(let model), .refreshing(let model):
                content(model: model)
            case .empty:
                EmptyView()
            }
        }
        .onAppear { send(.fetch) }
    }

    private func content(model: XCardViewModel) -> some View {
        NavigationView {
            ZStack(alignment: .top) {
                userCard(model: model.cardModel)

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

                        ForEach(model.receipts) { model in
                            receiptCard(model: model)
                                .zIndex(2)
                                .onTapGesture {
                                    send(.details(model))
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
                    action: { new, _ in
                        offset = new
                    }
                )
                .refreshable {}
            }
            .background(Color.surface.ignoresSafeArea())
            .maxSize()
            .navigationTitle(String.xcard)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $store.scope(state: \.receiptDetails, action: \.receiptDetails)) { store in
                ReceiptDetailsView(store: store)
            }
        }
    }

    private func userCard(model: CardModel) -> some View {
        VStack {
            Text(model.balance.currencyFormat())
                .font(.fontHeading4)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .trailing)
                .padding(.medium)

            Spacer()

            Text(model.fullName)
                .font(.fontBodyLarge)
                .lineLimit(0)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .leading)
                .padding(.horizontal, .medium)

            Text(model.cardNumberString)
                .font(.fontBodyMedium)
                .lineLimit(0)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .leading)
                .padding([.bottom, .horizontal], .medium)

        }
        .background(LinearGradient(colors: [.red, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
        .aspectRatio(1.5, contentMode: .fit)
        .maxWidth()
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 40 + min(30, abs(offset)))
        .frame(height: 300)
        .shadow(color: Color.red.opacity(0.8), radius: 10 - min(10, abs(offset)), x: 0, y: 0)
        .shadow(color: Color.pink.opacity(0.5), radius: 80 - min(80, abs(offset)), x: 0, y: 0)
    }

    private func receiptCard(model: ReceiptModel) -> some View {
        VStack(spacing: .small) {
            HStack {
                Text(model.restaurant.name)
                    .font(.fontHeading5)
                    .foregroundStyle(Color.white)
                    .maxWidth(alignment: .leading)

                Text(model.receiptAmount.currencyFormat())
                    .font(.fontLabelMedium)
                    .foregroundStyle(Color.white)
            }

            Text(model.dateString)
                .font(.fontBodyMedium)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .leading)
        }
        .padding(.base)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, .medium)
        .contentShape(Rectangle())
    }

}

struct XCardView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: XCardReducer.State(),
        reducer: XCardReducer.init)

    static var previews: some View {
        XCardView(store: store)
    }

}
