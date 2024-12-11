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


    var dateString: String {
        date.formatted(date: .abbreviated, time: .shortened)
    }

    var totalFormatted: String {
        String(format: String.receiptTotalFormat, receiptAmount.currencyFormat())
    }

    var paidFormatted: String {
        String(format: String.receiptPaidFormat, paidAmount.currencyFormat())
    }

    var subsidizedFormatted: String {
        String(format: String.receiptSubsidizedFormat, subsidizedAmount.currencyFormat())
    }

}

struct ReceiptItem: Equatable, Identifiable {

    let id: Int
    let articleName: String
    let quantity: Int
    let price: Double
    let total: Double
    let subsidizedAmount: Double

    var quantityFormatted: String {
        String(format: String.receiptItemQuantityFormat, quantity)
    }

}
