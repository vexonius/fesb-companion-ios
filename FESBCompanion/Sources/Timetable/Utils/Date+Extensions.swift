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

public enum Weekday: Int {

    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

}

extension Calendar {

    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start))
    }

    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]

        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }

            guard date < dateInterval.end else {
                stop = true
                return
            }

            dates.append(date)
        }

        return dates
    }

    func previousMonthDate(of currentDate: Date) -> Date? {
        date(byAdding: .month, value: -1, to: currentDate)
    }

    func nextMonthDate(of currentDate: Date) -> Date? {
        date(byAdding: .month, value: 1, to: currentDate)
    }

}
