enum Semester: Int, CaseIterable {

    case winter = 1
    case summer

    var title: String {
        switch self {
        case .winter: .summerSemester
        case .summer: .winterSemester
        }
    }

}

extension Semester: Identifiable {

    var id: Int { rawValue }

}
