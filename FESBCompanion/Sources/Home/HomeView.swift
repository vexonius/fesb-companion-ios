import SwiftUI
import ComposableArchitecture

@ViewAction(for: HomeReducer.self)
struct HomeView: View {

    @Bindable var store: StoreOf<HomeReducer>
    var name: String

    var body: some View {
        NavigationStack(path: $store.scope(state: \.router, action: \.router)) {
            Color.clear
                .navigationTitle(name)
        } destination: { store in
            switch store.case {
            default:
                EmptyView()
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: HomeReducer.State(), 
        reducer: HomeReducer.init)

    static var previews: some View {
        HomeView(store: store, name: "Home")
    }

}
