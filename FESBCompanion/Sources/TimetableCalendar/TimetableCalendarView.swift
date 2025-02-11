import SwiftUI
import ComposableArchitecture

@ViewAction(for: TimetableCalendarReducer.self)
struct TimetableCalendarView: View {

    @Bindable var store: StoreOf<TimetableCalendarReducer>

    var body: some View {
        VStack {
            CalendarView(
                selectedDate: $store.selectedDate,
                dateRange: store.dateRange)
            .padding(.top, .medium)

            Spacer()

            HStack(spacing: .large) {
                Button(String.dismiss) {
                    send(.dismiss)
                }
                .buttonStyle(.borderless)
                .foregroundStyle(Color.secondary)
                .font(.fontButtonSmall)

                Button(String.select) {
                    send(.apply)
                }
                .buttonStyle(.borderless)
                .foregroundStyle(Color.accentBlue)
                .font(.fontButtonSmall)
            }
            .padding(.horizontal, .large)
            .maxWidth(alignment: .trailing)
        }
        .background(Color.surface)
    }

}

struct TimetableCalendarView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: TimetableCalendarReducer.State(selectedDate: .now),
        reducer: TimetableCalendarReducer.init)

    static var previews: some View {
        TimetableCalendarView(store: store)
    }

}
