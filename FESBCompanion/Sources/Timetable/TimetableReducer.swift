import Foundation
import ComposableArchitecture
import shared

@Reducer
struct TimetableReducer {

    @Dependency(\.timetableRepository) private var repository: any TimetableRepository
    @Dependency(\.continuousClock) var clock

    @ObservableState
    struct State: Equatable {

        let minZoomFactor: CGFloat = 0.8
        let maxZoomFactor: CGFloat = 2

        var router = StackState<AppRouter.State>()

        var selectedDate = Date.now
        var viewState: Loadable<TimetableModel> = .initial

        var timelineOffset: CGFloat = 0

        var weekdayNames: [(String, String)] {
            let monday = selectedDate.next(.monday, direction: .backward, considerToday: true)
            let saturday = monday.next(.saturday, direction: .forward)

            let daysWithName = Calendar.current.generateDays(for: .init(start: monday, end: saturday))
                .map { day in
                    return (
                        DateFormatter.string(withFormat: .dayName, date: day),
                        DateFormatter.string(withFormat: .day, date: day)
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
        case presentCalendar
        case fetchTimetable
        case timeline
        case updateTimeline

        enum View: Equatable {

            case fetchTimetable
            case eventDetails(model: TimetableEventModel)
            case calendar
            case startTimeline

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.fetchTimetable):

                return .send(.fetchTimetable)
            case .fetchTimetable:
                state.viewState = .loading

                let date = state.selectedDate

                let startDate = date.next(.monday, direction: .backward)
                let endDate = startDate.next(.saturday, direction: .forward)
                let minDate = DateFormatter.string(date: startDate)
                let maxDate = DateFormatter.string(date: endDate)

                let username = ProcessInfo.processInfo.environment["userId"] ?? ""

                return .run { send in
                    do {
                        let models = try await repository.getTimetableEvents(
                            username: username,
                            minDate: minDate,
                            maxDate: maxDate)
                        .map(TimetableEventModel.init)

                        await send(.updateState(models: models, date: date))
                    } catch {
                        debugPrint(error)
                    }
                }
            case .view(.eventDetails(let model)):
                return .send(.eventDetails(model: model))
            case .view(.calendar):
                return .send(.presentCalendar)
            case .updateState(let models, let date):
                state.viewState = .loaded(.init(date: date, events: models))

                return .none
            case .view(.startTimeline):
                return .send(.timeline)
            case .timeline:
                return .run { send in
                    // Fire right away and then follow the pattern
                    await send(.updateTimeline)

                    for await _ in self.clock.timer(interval: .seconds(30)) {
                        await send(.updateTimeline)
                    }
                }
            case .updateTimeline:
                let date = Date.now
                let dateComponents = Calendar.init(identifier: .gregorian).dateComponents([.hour, .minute], from: date)
                let currentMinute = (dateComponents.hour?.inMinutes ?? 0) + (dateComponents.minute ?? 0)

                state.timelineOffset = currentMinute.asCGFloat

                return .none
            default:
                return .none
            }
        }
    }

}
