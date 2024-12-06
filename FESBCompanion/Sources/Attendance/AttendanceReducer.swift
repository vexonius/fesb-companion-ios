import ComposableArchitecture

@Reducer
struct AttendanceReducer {

    @ObservableState
    struct State: Equatable {
    }

    enum Action: Equatable, ViewAction {

        case view(View)

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
