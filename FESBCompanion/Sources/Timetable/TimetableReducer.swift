import Foundation
import ComposableArchitecture
import shared

@Reducer
struct TimetableReducer {

    @Dependency(\.timetableRepository) private var repository: TimeTableRepositoryProtocol

    @ObservableState
    struct State: Equatable {

        var router = StackState<AppRouter.State>()

        let selectedDate = Date.now
        var model: TimetableModel = .init(date: .now, events: [])

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

        case updateState(models: [TimetableEventModel], date: Date)

        enum View: Equatable {

            case fetchTimetable

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.fetchTimetable):
                let date = state.selectedDate
                let formatter = DateFormatter()
                formatter.string(from: date)

                return .run { send in
                    let models = try await repository.getTimetableEvents(for: date)
                    await send(.updateState(models: models, date: date))
                }
            case .updateState(let models, let date):
                state.model = .init(date: date, events: models)

                return .none
            default:
                return .none
            }
        }
    }

}
