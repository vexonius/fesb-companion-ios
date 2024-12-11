import MapKit
import SwiftUI
import ComposableArchitecture

struct ReceiptDetailsView: View {

    @Bindable var store: StoreOf<ReceiptDetailsReducer>

    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.51093534, longitude: 16.467434523),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

    private let kampusMenza = CLLocationCoordinate2D(
        latitude: 43.51183977571285,
        longitude: 16.46630941804453)

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
                        
                        Grid {
                            ForEach(store.model.receiptDetails) { item in
                                GridRow {
                                    Text(item.quantityFormatted)
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)
                                        .gridColumnAlignment(.leading)
                                        .gridCellAnchor(.leading)
                                    
                                    Text(item.articleName)
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)
                                        .maxWidth(alignment: .leading)
                                    
                                    Text(item.total.currencyFormat())
                                        .font(.fontBodyMedium)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.white)
                                        .gridColumnAlignment(.trailing)
                                        .gridCellAnchor(.trailing)
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
                    }
                    .maxSize()
                    .padding(.horizontal, .medium)
                }
            }
            .background(Color.surface)
            .navigationTitle(String.receiptDetails)
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

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
