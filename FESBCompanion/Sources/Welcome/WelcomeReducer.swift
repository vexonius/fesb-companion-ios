import ComposableArchitecture

@Reducer
struct WelcomeReducer {

    @ObservableState
    struct State: Equatable {
        var router = StackState<AppRouter.State>()
    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}