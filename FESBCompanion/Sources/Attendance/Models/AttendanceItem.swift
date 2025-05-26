import Foundation

struct AttendanceItem: Equatable, Identifiable {

    let id: String
    let `class`: String
    let type: String
    let attended: Int
    let absent: Int
    let required: Int
    let semester: Int
    let total: Int

}
