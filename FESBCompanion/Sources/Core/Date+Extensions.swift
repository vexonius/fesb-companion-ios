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

        return calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: direction
        )!
    }

    var dayOfMonth: Int {
        Calendar.current.component(.day, from: self)
    }

    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    var year: Int {
        Calendar.current.component(.year, from: self)
    }

    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? self
    }

    func add(minutes: Int) -> Date {
        advanced(by: Double(minutes * 60))
    }

}
