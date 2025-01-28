import Foundation
import ComposableArchitecture

@Reducer
struct TimetableReducer {

    @ObservableState
    struct State: Equatable {
        var router = StackState<AppRouter.State>()

        let selectedDate = Date.now

        var weekdayNames: [(String, String)] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE"

            let anotherDateFormatter = DateFormatter()
            anotherDateFormatter.dateFormat = "d"

            let monday = selectedDate.next(.monday, direction: .backward, considerToday: true)

            let daysWithName = Array(0...4)
                .map { ordinalDay in
                    let date = monday.addingTimeInterval(TimeInterval(86_400 * ordinalDay))

                    return (dateFormatter.string(from: date), anotherDateFormatter.string(from: date))
                }

            return daysWithName
        }

        var dropDownText: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd., yyyy"

            let formattedDate = dateFormatter.string(from: Date())

            return formattedDate
        }
    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
