import shared

extension TimetableType {

    init(from type: TimetableTypeResponse) {
        switch type {
        case .auditornaVjezba:
            self = .auditoryClasses
        case .ispit:
            self = .exams
        case .kolokvij:
            self = .colloquiums
        case .konstrukcijskaVjezba:
            self = .constructs
        case .laboratorijskaVjezba:
            self = .labs
        case .predavanje:
            self = .`classes`
        case .seminar:
            self = .seminars
        case .other:
            self = .other
        default:
            self = .other
        }
    }

}
