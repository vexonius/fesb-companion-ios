import Foundation
import ComposableArchitecture

@Reducer
struct TimetableEventDetailsReducer {

    @ObservableState
    struct State: Equatable {

        let model: TimetableEventModel

        var cellItems: [(type: EventDetailType, value: String)] {
            return [
                (EventDetailType.professor, model.professor),
                (EventDetailType.group, model.groups),
                (EventDetailType.date, DateFormatter.string(withFormat: .dayAndDotSeparatedDate, date: model.start)),
                (EventDetailType.time, DateFormatter.string(withFormat: .time, date: model.start)),
                (
                    EventDetailType.recurring,
                    String(format: model.recurringType.description, model.recurringUntilDateString))
            ]
        }

    }

    enum Action: Equatable, ViewAction {

        case view(View)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }

}
