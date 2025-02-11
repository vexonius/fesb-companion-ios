import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct TimetableCalendarReducer {

    @Dependency(\.dismiss) private var dismiss

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
        Reduce { state, action in
            switch action {
            case .view(.apply):
                let date = state.selectedDate

                return .run { send in
                    await send(.dateSelected(date))
                    await dismiss()
                }
            case .view(.dismiss):
                return .run { _ in
                    await dismiss()
                }
            default:
                return .none
            }
        }
    }

}
