import ComposableArchitecture

@Reducer
struct IksicaReducer {

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<IksicaViewModel> = .loading
        @Presents var receiptDetails: ReceiptDetailsReducer.State?
        @Presents var cameras: CamerasReducer.State?
    }

    enum Action: Equatable, ViewAction {

        case updateState(IksicaViewModel)
        case receiptDetails(PresentationAction<ReceiptDetailsReducer.Action>)
        case cameras(PresentationAction<CamerasReducer.Action>)
        case view(View)

        enum View: Equatable {

            case fetch
            case details(ReceiptModel)
            case cameras

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.details(let model)):
                state.receiptDetails = ReceiptDetailsReducer.State(model: model)

                return .none
            case .view(.cameras):
                state.cameras = CamerasReducer.State()

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
        .ifLet(\.$cameras, action: \.cameras) {
            CamerasReducer()
        }
    }
}
