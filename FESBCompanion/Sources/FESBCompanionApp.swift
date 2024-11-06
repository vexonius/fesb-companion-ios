import SwiftUI
import ComposableArchitecture

@main
struct FESBCompanionApp: App {

    @Bindable private var store: StoreOf<RootReducer> = Store(
        initialState: RootReducer.State(), 
        reducer: RootReducer.init)

    var body: some Scene {
        WindowGroup {
            RootView(store: store)
        }
    }

}
