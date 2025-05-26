import Foundation

struct AttendanceSemesterModel: Equatable, Identifiable {

    let id = UUID()
    let `class`: String
    let semester: Semester
    let items: [AttendanceItem]

}
