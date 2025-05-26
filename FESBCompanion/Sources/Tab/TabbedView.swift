import SwiftUI
import ComposableArchitecture

@ViewAction(for: TabReducer.self)
struct TabbedView: View {

    @Bindable var store: StoreOf<TabReducer>

    @State private var selection: Int = 2

    var body: some View {
        TabView(selection: $selection) {
            AttendanceView(store: store.scope(state: \.attendance, action: \.attendance))
                .tabItem {
                    Label(String.attendance, image: .pieChart)
                }
                .tag(1)

            HomeView(store: store.scope(state: \.home, action: \.home), name: .home)
                .tabItem {
                    Label(String.home, image: ImageResource.home)
                }
                .tag(2)

            TimetableView(
                store: store.scope(state: \.timetable, action: \.timetable))
            .tabItem {
                Label(String.timetable, image: .calendar)
            }
            .tag(3)
        }
        .background(Color.surface)
        .sheet(item: $store.scope(state: \.eventDetails, action: \.eventDetails)) { store in
            TimetableEventDetailsView(store: store)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $store.scope(state: \.calendar, action: \.calendar)) { store in
            TimetableCalendarView(store: store)
                .presentationDetents([.fraction(0.6), .large])
                .presentationDragIndicator(.visible)
        }
    }

}

struct TabbedView_Previews: PreviewProvider {

    @State private static var store = Store(initialState: TabReducer.State(), reducer: TabReducer.init)

    static var previews: some View {
        TabbedView(store: store)
    }

}
