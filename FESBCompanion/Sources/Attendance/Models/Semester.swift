enum Semester: Int, CaseIterable {

    case winter = 1
    case summer

    var title: String {
        switch self {
        case .winter: .winterSemester
        case .summer: .summerSemester
        }
    }

}

extension Semester: Identifiable {

    var id: Int { rawValue }

}
