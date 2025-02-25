import Foundation
import SwiftUI

struct CalendarMetadataModel: Identifiable, Equatable {

    let id: String
    let name: String
    let startDate: Date
    let endDate: Date
    let startDateText: String
    let endDateText: String
    let colorCode: MetadataColorCode
    let isWorking: Bool
    let isOneDayEvent: Bool

    var dateInterval: DateInterval {
        DateInterval(start: startDate.endOfDay(using: .current), end: endDate.endOfDay(using: .current))
    }

    func contains(_ date: Date) -> Bool {
        dateInterval.contains(date)
    }

    var description: String {
        guard !isOneDayEvent else { return startDateText.capitalized }

        return String(format: .calendarEventDescriptionFormat, startDateText.capitalized, endDateText.capitalized)
    }

    var color: Color {
        switch colorCode {
        case .blue:
                .eventBlue
        case .red:
                .eventRed
        case .orange:
                .eventOrange
        case .yellow:
                .eventYellow
        case .white:
                .white
        case .purple:
                .eventPurple
        case .green:
                .eventGreen
        default:
                .eventGrey
        }
    }

}
