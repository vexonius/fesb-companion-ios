import SwiftUI
import ComposableArchitecture

@ViewAction(for: RootReducer.self)
struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>

    @Bindable var homeStore = Store(initialState: HomeReducer.State(), reducer: HomeReducer.init)

    @State private var selection: Int = 1

    var body: some View {
//        NavigationStack(path: $store.scope(state: \.router, action: \.router)) {
            TabView(selection: $selection) {
                HomeView(store: homeStore, name: .xcard)
                    .tabItem {
                        Label(String.xcard, systemImage: "creditcard")
                    }
                    .tag(1)

                HomeView(store: homeStore, name: .attendance)
                    .tabItem {
                        Label(String.attendance, systemImage: "chart.pie")
                    }
                    .tag(2)

                HomeView(store: homeStore, name: .home)
                    .tabItem {
                        Label(String.home, systemImage: "house")
                    }
                    .tag(3)

                HomeView(store: homeStore, name: .timetable)
                    .tabItem {
                        Label(String.timetable, systemImage: "calendar")
                    }
                    .tag(4)

                HomeView(store: homeStore, name: String.studomat)
                    .tabItem {
                        Label(String.studomat, systemImage: "books.vertical")
                    }
                    .tag(5)
            }
//        } destination: { store in
//            switch store.case {
//            default:
//                EmptyView()
//            }
//        }
    }

}

struct RootView_Previews: PreviewProvider {

    @State private static var store = Store(initialState: RootReducer.State(), reducer: RootReducer.init)

    static var previews: some View {
        RootView(store: store)
    }

}
