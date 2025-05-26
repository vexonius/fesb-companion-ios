import ComposableArchitecture
import shared

@Reducer
struct AttendanceReducer {

    @Dependency(\.attendanceRepository) private var repository: AttendanceRepository

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<[AttendanceSemesterModel]> = .initial
        var selectedSemester: Semester?

        fileprivate var attendanceItems: [AttendanceSemesterModel] = []

    }

    enum Action: Equatable, ViewAction {

        case filterItems(bySemester: Semester)
        case view(View)
        case update(models: [AttendanceItem])

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

                return .run { @MainActor send in
                    do {
                        let models = try await repository
                            .getAttendance()
                            .map { AttendanceItem(from: $0) }

                        send(.update(models: models))
                    } catch {
                        debugPrint(error)
                    }
                }
            case .view(.select(let semester)):
                state.selectedSemester = semester == state.selectedSemester ? nil : semester

                guard let semester = state.selectedSemester else {
                    state.viewState = .loaded(state.attendanceItems)
                    return .none
                }

                return .send(.filterItems(bySemester: semester))
            case .update(let models):
                let modelsBySemester: [AttendanceSemesterModel] = Dictionary(grouping: models, by: \.class)
                    .compactMap { (className: String, items: [AttendanceItem]) -> AttendanceSemesterModel? in
                        guard
                            let firstItem = items.first,
                            let semester = Semester(rawValue: firstItem.semester)
                        else {
                            return nil
                        }

                        return AttendanceSemesterModel(class: className, semester: semester, items: items)
                    }

                state.attendanceItems = modelsBySemester
                state.viewState = .loaded(modelsBySemester)

                return .none
            case .filterItems(let semester):
                let filteredItems = state.attendanceItems.filter { $0.semester == semester }
                state.viewState = .loaded(filteredItems)

                return .none
            case .view(.refresh):
                // TODO: Implement refresh logic

                return .none
            }
        }
    }

}
