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
            let monday = selectedDate.next(.monday, direction: .backward, considerToday: true)

            let daysWithName = Array(0...4)
                .map { ordinalDay in
                    let date = monday.addingTimeInterval(TimeInterval(86_400 * ordinalDay))

                    return (
                        DateFormatter.string(withFormat: .monthName, date: date),
                        DateFormatter.string(withFormat: .day, date: date)
                    )
                }

            return daysWithName
        }

        var dropDownText: String {
            return DateFormatter.string(withFormat: .dropDown, date: selectedDate)
        }

    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)

        case updateState(models: [TimetableEventModel], date: Date)
        case eventDetails(model: TimetableEventModel)

        enum View: Equatable {

            case fetchTimetable
            case eventDetails(model: TimetableEventModel)

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
                    do {
                        let models = try await repository.getTimetableEvents(for: date)
                        await send(.updateState(models: models, date: date))
                    } catch {
                        debugPrint(error)
                    }
                }
            case .view(.eventDetails(let model)):
                return .send(.eventDetails(model: model))
            case .updateState(let models, let date):
                state.model = .init(date: date, events: models)

                return .none
            default:
                return .none
            }
        }
    }

}
