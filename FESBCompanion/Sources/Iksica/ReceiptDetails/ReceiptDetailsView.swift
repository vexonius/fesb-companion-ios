import MapKit
import SwiftUI
import ComposableArchitecture

struct ReceiptDetailsView: View {

    @Bindable var store: StoreOf<ReceiptDetailsReducer>

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: .small) {
                        Text(store.model.restaurant.name)
                            .font(.fontHeading5)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .leading)
                        
                        Text(store.model.dateString)
                            .font(.fontBodySmall)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .leading)
                            .padding(.bottom, .medium)
                        
                        Text(.items)
                            .font(.fontHeading5)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .leading)
                        
                        VStack(spacing: .small) {
                            ForEach(store.model.receiptDetails) { item in
                                HStack(spacing: .small) {
                                    Text(item.quantityFormatted)
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)

                                    Text(item.articleName)
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)
                                        .maxWidth(alignment: .leading)
                                    
                                    Text(item.total.currencyFormat())
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)
                                }
                            }
                        }
                        .maxWidth()
                        
                        Text(store.model.totalFormatted)
                            .font(.fontHeading4)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .trailing)

                        Text(store.model.subsidizedFormatted)
                            .font(.fontHeading4)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .trailing)

                        Text(store.model.paidFormatted)
                            .font(.fontHeading4)
                            .lineLimit(0)
                            .foregroundStyle(Color.white)
                            .maxWidth(alignment: .trailing)
                        
                        Map {
                            Marker(store.model.restaurant.name, coordinate: store.model.restaurant.coordinate)
                        }
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.top, .medium)
                        .allowsHitTesting(false)
                    }
                    .maxSize()
                    .padding(.horizontal, .medium)
                }
            }
            .background(Color.surface.ignoresSafeArea())
            .navigationTitle(String.receiptDetails)
            .toolbarBackground(Color.surface, for: .navigationBar)
            .padding(.top, .small)
        }
    }

}

#Preview {
    ReceiptDetailsView(
        store: Store(initialState: .init(model: ReceiptModel(
            id: "1",
            restaurant: .kampus,
            date: .now,
            receiptAmount: 2.99,
            subsidizedAmount: 1.99,
            paidAmount: 1.00,
            authorised: "Authorized",
            url: "",
            receiptDetails: [
                ReceiptItem(
                    id: 1,
                    articleName: "Pizza",
                    quantity: 1,
                    price: 0.99,
                    total: 0.99,
                    subsidizedAmount: 0.55
                ),
                ReceiptItem(
                    id: 2,
                    articleName: "Pizza",
                    quantity: 1,
                    price: 0.99,
                    total: 0.99,
                    subsidizedAmount: 0.55
                ),
                ReceiptItem(
                    id: 3,
                    articleName: "Pizza",
                    quantity: 1,
                    price: 0.99,
                    total: 0.99,
                    subsidizedAmount: 0.55
                ),
                ReceiptItem(
                    id: 4,
                    articleName: "Pizza",
                    quantity: 1,
                    price: 0.99,
                    total: 0.99,
                    subsidizedAmount: 0.55
                )
            ]
        )),
        reducer: ReceiptDetailsReducer.init)
    )
}
