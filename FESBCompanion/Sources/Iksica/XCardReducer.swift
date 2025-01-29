import ComposableArchitecture

@Reducer
struct XCardReducer {

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<XCardViewModel> = .loading
        @Presents var receiptDetails: ReceiptDetailsReducer.State?
    }

    enum Action: Equatable, ViewAction {

        case updateState(XCardViewModel)
        case receiptDetails(PresentationAction<ReceiptDetailsReducer.Action>)
        case view(View)

        enum View: Equatable {

            case fetch
            case details(ReceiptModel)

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.details(let model)):
                state.receiptDetails = ReceiptDetailsReducer.State(model: model)

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
            ReceiptDetailsReducer()
        }
    }
}
