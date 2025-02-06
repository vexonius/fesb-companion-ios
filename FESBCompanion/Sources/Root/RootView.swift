import SwiftUI
import ComposableArchitecture

@ViewAction(for: RootReducer.self)
struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>

    @State private var selection: Int = 2

    var body: some View {
        TabView(selection: $selection) {
            XCardView(store: store.scope(state: \.xCard, action: \.xCard))
                .tabItem {
                    Label(String.xcard, image: .card)
                }
                .tag(1)
            AttendanceView(store: store.scope(state: \.attendance, action: \.attendance))
                .tabItem {
                    Label(String.attendance, image: .pieChart)
                }
                .tag(2)

            HomeView(store: store.scope(state: \.home, action: \.home), name: .home)
                .tabItem {
                    Label(String.home, image: "home")
                }
                .tag(3)

            TimetableView(
                store: store.scope(state: \.timetable, action: \.timetable))
            .tabItem {
                Label(String.timetable, image: .calendar)
            }
            .tag(4)

            HomeView(store: store.scope(state: \.home, action: \.home), name: String.studomat)
                .tabItem {
                    Label(String.studomat, image: .hexagon)
                }
                .tag(5)
        }
        .background(Color.surface)
        .sheet(
          item: $store.scope(state: \.login, action: \.login)
        ) { store in
            LoginView(store: store)
        }
    }

}

struct RootView_Previews: PreviewProvider {

    @State private static var store = Store(initialState: RootReducer.State(), reducer: RootReducer.init)

    static var previews: some View {
        RootView(store: store)
    }

}
