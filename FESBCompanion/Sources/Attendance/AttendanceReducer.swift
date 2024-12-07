import ComposableArchitecture

@Reducer
struct AttendanceReducer {

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<[AttendanceModel]> = .initial

        var attendanceItems: [AttendanceModel] = []
        var selectedSemester: Semester?

    }

    enum Action: Equatable, ViewAction {

        case fetched
        case filterItems(bySemester: Semester)
        case view(View)

        enum View: Equatable {

            case fetch
            case refresh
            case select(semester: Semester)

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.fetch):
                state.viewState = .loading

                return .run { send in
                    try? await Task.sleep(for: .seconds(5))
                    await send(.fetched)
                }
            case .view(.select(let semester)):
                state.selectedSemester = semester == state.selectedSemester ? nil : semester

                guard let semester = state.selectedSemester else {
                    state.viewState = .loaded(state.attendanceItems)
                    return .none
                }

                return .send(.filterItems(bySemester: semester))
            case .fetched:
                state.attendanceItems = State.dummyItems
                state.viewState = .loaded(State.dummyItems)

                return .none
            case .filterItems(let semester):
                let filteredItems = state.attendanceItems.filter { $0.semester == semester }
                state.viewState = .loaded(filteredItems)

                return .none
            default:
                return .none
            }
        }
    }
}

private extension AttendanceReducer.State {

    static var dummyItems: [AttendanceModel] {
        [
            AttendanceModel(
                class: "Math",
                semester: .winter,
                items: [
                    AttendanceItem(type: "Class", attended: 8, absent: 2, required: 8, semester: 1, total: 10),
                    AttendanceItem(type: "Exam", attended: 4, absent: 2, required: 8, semester: 1, total: 10),
                    AttendanceItem(type: "Auditory class", attended: 3, absent: 2, required: 8, semester: 1, total: 10)
                ]
            ),
            AttendanceModel(
                class: "Physics",
                semester: .summer,
                items: [
                    AttendanceItem(type: "Class", attended: 5, absent: 2, required: 8, semester: 1, total: 10),
                    AttendanceItem(type: "Exam", attended: 6, absent: 2, required: 8, semester: 1, total: 10),
                    AttendanceItem(type: "Auditory class", attended: 8, absent: 2, required: 8, semester: 1, total: 10)
                ]
            )
        ]
    }

}
