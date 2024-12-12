import ComposableArchitecture

@Reducer
struct IksicaReducer {

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<IksicaViewModel> = .loading
        @Presents var receiptDetails: DummyReducer.State?
    }

    enum Action: Equatable, ViewAction {

        case updateState(IksicaViewModel)
        case receiptDetails(PresentationAction<DummyReducer.Action>)
        case view(View)

        enum View: Equatable {

            case fetch
            case details

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.details):
                state.receiptDetails = DummyReducer.State()

                return .none
            case .view(.fetch):

                return .run { send in
                    try await Task.sleep(for: .seconds(2))
                    await send(.updateState(State.dummyData))
                }
            case .updateState(let model):
                state.viewState = .loaded(model)

                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$receiptDetails, action: \.receiptDetails) {
            DummyReducer()
        }
    }
}

private extension IksicaReducer.State {

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
            )
        ]
    )
}
