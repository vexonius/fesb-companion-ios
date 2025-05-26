import ComposableArchitecture
import shared

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
        case proceed

        enum View: Equatable {

            case login

        }

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.login):
                var vault: KvaultKVault = DependenciesProvider().provideKVault()

                vault.set(key: "USERNAME", stringValue: state.username)
                vault.set(key: "PASSWORD", stringValue: state.password)

                return .send(.proceed)
            default:
                return .none
            }
        }
    }

}
