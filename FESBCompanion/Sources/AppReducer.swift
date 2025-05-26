import SwiftUI
import ComposableArchitecture
import shared

@Reducer
struct AppReducer {

    @ObservableState
    enum State: Equatable {

        case login(LoginReducer.State)
        case authenticated(TabReducer.State)

        init() {
            let kVault = DependenciesProvider().provideKVault()

            if kVault.existsObject(forKey: SecureField.username.value) {
                self = .authenticated(TabReducer.State())
            } else {
                self = .login(LoginReducer.State())
            }
        }

    }

    enum Action: Equatable {

        case login(LoginReducer.Action)
        case authenticated(TabReducer.Action)

    }

    var body: some Reducer<State, Action> {
        Scope(state: \.authenticated, action: \.authenticated) {
            TabReducer()
        }
        Scope(state: \.login, action: \.login) {
            LoginReducer()
        }
        Reduce { state, action in
            switch action {
            case .login(.proceed):
                state = State.authenticated(TabReducer.State())

                return .none
            default:
                return .none
            }
        }
    }

}
