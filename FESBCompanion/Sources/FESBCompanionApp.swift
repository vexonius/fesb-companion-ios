import SwiftUI
import ComposableArchitecture
import shared

@main
struct FESBCompanionApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    @Bindable private var store: StoreOf<AppReducer>

    init() {
        ModuleKt.doInitKoin(vault: KvaultKVault(serviceName: nil, accessGroup: nil, accessibility: .afterfirstunlock))
        store = Store(
            initialState: AppReducer.State(),
            reducer: AppReducer.init)
    }

    var body: some Scene {
        WindowGroup {
            switch store.state {
            case .login:
                if let store = store.scope(state: \.login, action: \.login) {
                    LoginView(store: store)
                }
            case .authenticated:
                if let store = store.scope(state: \.authenticated, action: \.authenticated) {
                    TabbedView(store: store)
                }
            }
        }
    }

}
