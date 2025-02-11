import shared

extension TimetableType {

    init(from type: TimetableTypeResponse) {
        switch type {
        case .auditoryClasses:
            self = .auditoryClasses
        case .exams:
            self = .exams
        case .colloquiums:
            self = .colloquiums
        case .constructs:
            self = .constructs
        case .labs:
            self = .labs
        case .classes:
            self = .classes
        case .seminars:
            self = .seminars
        default:
            self = .other
        }
    }

}
