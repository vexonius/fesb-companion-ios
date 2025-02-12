import SwiftUI

struct TimetableEventModel: Equatable, Identifiable {

    let id: String
    let name: String
    let professor: String
    let eventType: TimetableType
    let groups: String
    let classroom: String
    let start: Date
    let end: Date
    let description: String?
    let recurring: Bool
    let recurringType: Recurring
    let recurringUntil: Date?
    let studyCode: String

    var shortName: String {
        guard name.contains(" ") else { return name }

        return name
            .split(separator: " ")
            .map { $0.first?.uppercased() ?? "" }
            .joined()
    }

    func getPosition(xSpacing: CGFloat) -> CGPoint {
        let calendar = Calendar.init(identifier: .gregorian).dateComponents([.weekday], from: start)
        let weekday = calendar.weekday ?? 1 - 1

        let xOffset: Double = CGFloat(weekday) * xSpacing
        let yOffset = Double(minutesDelta / 2)

        return CGPoint(x: xOffset, y: yOffset)
    }

    var startMinute: Int {
        let hour = Calendar.init(identifier: .gregorian).dateComponents([.hour], from: start).hour ?? 0
        let minute = Calendar.init(identifier: .gregorian).dateComponents([.minute], from: start).minute ?? 0

        return hour.inMinutes + minute
    }

    var endMinute: Int {
        let hour = Calendar.init(identifier: .gregorian).dateComponents([.hour], from: end).hour ?? 0
        let minute = Calendar.init(identifier: .gregorian).dateComponents([.minute], from: end).minute ?? 0

        return hour.inMinutes + minute
    }

    var minutesDelta: Int {
        endMinute - startMinute
    }

    var recurringUntilDateString: String {
        guard let date = recurringUntil else { return "" }

        return DateFormatter.string(withFormat: .dotSeparatedDate, date: date)
    }

}
