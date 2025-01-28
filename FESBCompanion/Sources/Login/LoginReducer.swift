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

        enum View: Equatable {

            case login
            case dismiss

        }

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.dismiss):
                return .run { _ in
                   await dismiss()
                }
            default:
                return .none
            }
        }
    }
}
