import Foundation

extension Date {

    func next(
        _ weekday: Weekday,
        direction: Calendar.SearchDirection = .forward,
        considerToday: Bool = true
    ) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday.rawValue)

        if considerToday && calendar.component(.weekday, from: self) == weekday.rawValue {
            return self
        }

        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }

    func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }

}

public enum Weekday: Int {

    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

}
