import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct TimetableCalendarReducer {

    @ObservableState
    struct State: Equatable {

        var selectedDate: Date

        var dateRange: DateInterval {
            let now = Date.now

            let start = Calendar.current.date(byAdding: DateComponents(year: -1), to: now) ?? .now
            let end = Calendar.current.date(byAdding: DateComponents(year: 1), to: now) ?? .now

            return DateInterval(start: start, end: end)
        }

        private var defaultDate: Date

        init(selectedDate: Date) {
            self.selectedDate = selectedDate
            self.defaultDate = selectedDate
        }

    }

    enum Action: Equatable, BindableAction, ViewAction {

        case view(View)
        case binding(BindingAction<State>)
        case dateSelected(Date)

        enum View: Equatable {

            case apply
            case dismiss

        }

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }

}
