import ComposableArchitecture

@Reducer
struct LoginReducer {

    @Dependency(\.dismiss) private var dismiss

    @ObservableState
    struct State: Equatable {

        var username: String = ""
        var password: String = ""

    }

    enum Action: Equatable, BindableAction, ViewAction {

        case view(View)
        case binding(BindingAction<State>)
        case dismiss

        enum View: Equatable {

            case login

        }

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.login):
                return .send(.dismiss)
            case .dismiss:
                return .run { _ in
                   await dismiss()
                }
            default:
                return .none
            }
        }
    }
}
