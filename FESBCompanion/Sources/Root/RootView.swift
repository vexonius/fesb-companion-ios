import SwiftUI
import ComposableArchitecture

@ViewAction(for: RootReducer.self)
struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>

    @Bindable var homeStore = Store(initialState: HomeReducer.State(), reducer: HomeReducer.init)

    @State private var selection: Int = 1

    var body: some View {
        TabView(selection: $selection) {
            HomeView(store: homeStore, name: .xcard)
                .tabItem {
                    Label(String.xcard, image: .card)
                }
                .tag(1)
            HomeView(store: homeStore, name: .attendance)
                .tabItem {
                    Label(String.attendance, image: .pieChart)
                }
                .tag(2)

            HomeView(store: homeStore, name: .home)
                .tabItem {
                    Label(String.home, image: "home")
                }
                .tag(3)

            HomeView(store: homeStore, name: .timetable)
                .tabItem {
                    Label(String.timetable, image: .calendar)
                }
                .tag(4)

            HomeView(store: homeStore, name: String.studomat)
                .tabItem {
                    Label(String.studomat, image: .hexagon)
                }
                .tag(5)
        }
        .sheet(item: $store.scope(state: \.presentedItem, action: \.presentedItem)) { store in
            WelcomeView(store: store)
        }
    }

}

struct RootView_Previews: PreviewProvider {

    @State private static var store = Store(initialState: RootReducer.State(), reducer: RootReducer.init)

    static var previews: some View {
        RootView(store: store)
    }

}
