import SwiftUI
import ComposableArchitecture

@main
struct FESBCompanionApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    @Bindable private var store: StoreOf<RootReducer> = Store(
        initialState: RootReducer.State(),
        reducer: RootReducer.init)

    var body: some Scene {
        WindowGroup {
            RootView(store: store)
        }
    }

}
