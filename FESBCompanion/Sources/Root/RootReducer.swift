import ComposableArchitecture

@Reducer
struct RootReducer {

    @ObservableState
    struct State: Equatable {

        var router = StackState<AppRouter.State>()

        var home = HomeReducer.State()
        var attendance = AttendanceReducer.State()
        var iksica = IksicaReducer.State()
        var timetable = TimetableReducer.State()

    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)
        case home(HomeReducer.Action)
        case attendance(AttendanceReducer.Action)
        case iksica(IksicaReducer.Action)
        case timetable(TimetableReducer.Action)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Scope(state: \.attendance, action: \.attendance) {
            AttendanceReducer()
        }
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        Scope(state: \.iksica, action: \.iksica) {
            IksicaReducer()
        }
        Scope(state: \.timetable, action: \.timetable) {
            TimetableReducer()
        }
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }

}
