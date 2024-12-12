import ComposableArchitecture

extension AttendanceReducer.State {

    static var dummyItems: [AttendanceModel] {
        [
            AttendanceModel(
                class: "Math",
                semester: .winter,
                items: [
                    AttendanceItem(type: "Class", attended: 8, absent: 2, required: 8, semester: 1, total: 10),
                    AttendanceItem(type: "Exam", attended: 4, absent: 2, required: 8, semester: 1, total: 10),
                ]
            ),
            AttendanceModel(
                class: "Physics",
                semester: .summer,
                items: [
                    AttendanceItem(type: "Auditory class", attended: 8, absent: 2, required: 8, semester: 1, total: 10)
                ]
            )
        ]
    }

}
