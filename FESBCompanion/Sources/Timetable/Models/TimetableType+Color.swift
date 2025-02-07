import SwiftUI

extension TimetableType {

    var color: Color {
        switch self {
        case .class:
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

}
