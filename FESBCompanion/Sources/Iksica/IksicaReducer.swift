import ComposableArchitecture

@Reducer
struct IksicaReducer {

    @ObservableState
    struct State: Equatable {

        @Presents var receiptDetails: DummyReducer.State?
    }

    enum Action: Equatable, ViewAction {

        case receiptDetails(PresentationAction<DummyReducer.Action>)
        case view(View)

        enum View: Equatable {

            case details

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.details):
                state.receiptDetails = DummyReducer.State()

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
