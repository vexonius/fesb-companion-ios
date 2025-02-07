import SwiftUI

extension TimetableType {

    var color: Color {
        switch self {
        case .`classes`:
            .eventBlue
        case .exams:
            .eventPurple
        case .auditoryClasses:
            .eventGreen
        case .colloquiums:
            .eventPurple
        case .labs:
            .eventYellow
        case .other:
            .eventGrey
        case .seminars:
            .eventBlue
        case .constructs:
            .eventGrey
        }
    }

    var title: String {
        switch self {
        case .`classes`:
            .classes
        case .exams:
            .exams
        case .auditoryClasses:
            .auditoryClasses
        case .colloquiums:
            .colloquiums
        case .labs:
            .labs
        case .other:
            .other
        case .seminars:
            .seminars
        case .constructs:
            .constructs
        }
    }

}
