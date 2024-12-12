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
