import Foundation

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
