import ComposableArchitecture

extension XCardReducer.State {

    static let dummyData = XCardViewModel(
        cardModel: CardModel(
            name: "",
            surname: "",
            cardNumber: "",
            balance: 39.24
        ),
        receipts: [
            ReceiptModel(
                id: "1",
                restaurant: .fesb,
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
                    ),
                    ReceiptItem(
                        id: 5,
                        articleName: "Pizza",
                        quantity: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    ),
                    ReceiptItem(
                        id: 6,
                        articleName: "Pizza",
                        quantity: 1,
                        price: 0.99,
                        total: 0.99,
                        subsidizedAmount: 0.55
                    )
                ]
            ),
            ReceiptModel(
                id: "2",
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
                    )
                ]
            ),
            ReceiptModel(
                id: "3",
                restaurant: .efst,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "4",
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
                    )
                ]
            ),
            ReceiptModel(
                id: "5",
                restaurant: .fesb,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "6",
                restaurant: .fgag,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "7",
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
                    )
                ]
            ),
            ReceiptModel(
                id: "8",
                restaurant: .fgag,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "9",
                restaurant: .efst,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "10",
                restaurant: .fgag,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "11",
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
                    )
                ]
            ),
            ReceiptModel(
                id: "12",
                restaurant: .efst,
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
                    )
                ]
            ),
            ReceiptModel(
                id: "13",
                restaurant: .hostel,
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
                    )
                ]
            )
        ]
    )

}
