import ComposableArchitecture

@Reducer
struct RootReducer {

    @ObservableState
    struct State: Equatable {
        var router = StackState<AppRouter.State>()
        @Presents var presentedItem: WelcomeReducer.State? = WelcomeReducer.State()

    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)
        case presentedItem(PresentationAction<WelcomeReducer.Action>)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .ifLet(\.$presentedItem, action: \.presentedItem) {
            WelcomeReducer()
        }
    }
}
