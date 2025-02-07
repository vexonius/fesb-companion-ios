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
                (EventDetailType.date, model.start.toString()),
                (EventDetailType.time, model.start.toString(format: "HH:mm")),
                (EventDetailType.recurring, model.recurringType)
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
