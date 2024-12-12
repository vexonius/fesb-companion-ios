import Foundation

struct ReceiptModel: Equatable, Identifiable {

    let id: String
    let restaurant: String
    let date: Date
    let receiptAmount: Double
    let subsidizedAmount: Double
    let paidAmount: Double
    let authorised: String
    let url: String
    let receiptDetails: [ReceiptItem]

}

struct ReceiptItem: Equatable, Identifiable {

    let id: Int
    let articleName: String
    let amount: Int
    let price: Double
    let total: Double
    let subsidizedAmount: Double

}
