import ComposableArchitecture

@Reducer
struct LoginReducer {

    @ObservableState
    struct State: Equatable {

        var username: String = ""
        var password: String = ""

    }

    enum Action: Equatable, BindableAction, ViewAction {

        case view(View)
        case binding(BindingAction<State>)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
