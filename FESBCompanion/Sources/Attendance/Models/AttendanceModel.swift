import Foundation

struct AttendanceModel: Equatable, Identifiable {

    let id = UUID()
    let `class`: String
    let semester: Semester
    let items: [AttendanceItem]

}

struct AttendanceItem: Equatable, Identifiable {

    let id = UUID()
    let type: String
    let attended: Int
    let absent: Int
    let required: Int
    let semester: Int
    let total: Int

}
