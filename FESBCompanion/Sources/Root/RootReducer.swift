import ComposableArchitecture

@Reducer
struct RootReducer {

    @ObservableState
    struct State: Equatable {

        var router = StackState<AppRouter.State>()

        var home = HomeReducer.State()
        var attendance = AttendanceReducer.State()
        var timetable = TimetableReducer.State()
        var xCard = XCardReducer.State()

        @Presents var login: LoginReducer.State?
        @Presents var eventDetails: TimetableEventDetailsReducer.State?
        @Presents var calendar: TimetableCalendarReducer.State?

    }

    enum Action: Equatable, ViewAction {

        case view(View)
        case router(StackAction<AppRouter.State, AppRouter.Action>)
        case home(HomeReducer.Action)
        case attendance(AttendanceReducer.Action)
        case xCard(XCardReducer.Action)
        case timetable(TimetableReducer.Action)
        case login(PresentationAction<LoginReducer.Action>)
        case eventDetails(PresentationAction<TimetableEventDetailsReducer.Action>)
        case calendar(PresentationAction<TimetableCalendarReducer.Action>)

        enum View: Equatable {}

    }

    var body: some Reducer<State, Action> {
        Scope(state: \.attendance, action: \.attendance) {
            AttendanceReducer()
        }
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        Scope(state: \.xCard, action: \.xCard) {
            XCardReducer()
        }
        Scope(state: \.timetable, action: \.timetable) {
            TimetableReducer()
        }
        Reduce { state, action in
            switch action {
            case .timetable(.eventDetails(let model)):
                state.eventDetails = .init(model: model)

                return .none
            case .timetable(.presentCalendar):
                state.calendar = .init(selectedDate: state.timetable.selectedDate)

                return .none
            case .calendar(.presented(.dateSelected(let date))):
                state.timetable.selectedDate = date

                return .send(.timetable(.fetchTimetable))
            default:
                return .none
            }
        }
        .ifLet(\.$login, action: \.login) {
            LoginReducer()
        }
        .ifLet(\.$eventDetails, action: \.eventDetails) {
            TimetableEventDetailsReducer()
        }
        .ifLet(\.$calendar, action: \.calendar) {
            TimetableCalendarReducer()
        }
    }

}
