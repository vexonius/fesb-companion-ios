import SwiftUI
import ComposableArchitecture

@ViewAction(for: RootReducer.self)
struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.router, action: \.router)) {
            Text("Hello World")
        } destination: { store in
            switch store.case {
            default:
                EmptyView()
            }
        }
    }

}

struct RootView_Previews: PreviewProvider {

    @State private static var store = Store(initialState: RootReducer.State(), reducer: RootReducer.init)

    static var previews: some View {
        RootView(store: store)
    }

}
