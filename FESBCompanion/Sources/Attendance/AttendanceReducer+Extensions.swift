import ComposableArchitecture

extension AttendanceReducer.State {

    static var dummyItems: [AttendanceSemesterModel] {
        [
            AttendanceSemesterModel(
                class: "Math",
                semester: .winter,
                items: [
                    AttendanceItem(
                        id: "1",
                        class: "Math",
                        type: "Class",
                        attended: 8,
                        absent: 2,
                        required: 8,
                        semester: 1,
                        total: 10),
                    AttendanceItem(
                        id: "2",
                        class: "Math",
                        type: "Exam",
                        attended: 4,
                        absent: 2,
                        required: 8,
                        semester: 1,
                        total: 10)
                ]
            ),
            AttendanceSemesterModel(
                class: "Physics",
                semester: .summer,
                items: [
                    AttendanceItem(
                        id: "3",
                        class: "Math",
                        type: "Auditory class",
                        attended: 8,
                        absent: 2,
                        required: 8,
                        semester: 1,
                        total: 10)
                ]
            )
        ]
    }

}
