import ComposableArchitecture

extension IksicaReducer.State {

    static let dummyData = IksicaViewModel(
        cardModel: CardModel(
            name: "Stipe",
            surname: "Jurković",
            cardNumber: "0000000000000000",
            balance: 39.24
        ),
        receipts: [
            ReceiptModel(
                id: "1",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "2",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "3",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "4",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "5",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "5",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "7",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "8",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "9",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "10",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "11",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "12",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "12",
                restaurant: "Kampus Menza",
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
                        amount: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
        ]
    )
}
