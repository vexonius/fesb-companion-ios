import ComposableArchitecture

@Reducer
struct AttendanceReducer {

    @ObservableState
    struct State: Equatable {

        var selectedSemester: Semester?

        var attendanceItems: [AttendanceModel] {
            guard let semester = selectedSemester else { return attendance }

            return attendance.filter { $0.semester == semester }
        }

        private var attendance: [AttendanceModel] = [
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

    enum Action: Equatable, ViewAction {

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
            case .view(.select(let semester)):
                state.selectedSemester = semester == state.selectedSemester ? nil : semester

                return .none
            default:
                return .none
            }
        }
    }
}
