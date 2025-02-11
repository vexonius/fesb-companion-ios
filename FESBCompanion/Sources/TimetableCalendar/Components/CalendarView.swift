import SwiftUI

public struct CalendarView: View {

    @Binding private var selectedDate: Date
    @State private var dateForVisibleMonth: Date

    private let daysInWeek = 7

    private let dateRange: DateInterval
    private var calendar: Calendar

    public init(
        selectedDate: Binding<Date>,
        dateRange: DateInterval,
        calendar: Calendar = .current
    ) {
        self._selectedDate = selectedDate
        self.dateForVisibleMonth = selectedDate.wrappedValue
        self.dateRange = dateRange
        self.calendar = calendar
    }

    public var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                Section(header: headerViewProvider(month)) {
                    ForEach(days.prefix(daysInWeek), id: \.self, content: daysOfWeekViewProvider)
                    ForEach(days, id: \.self) { date in
                        let dateIsInRange = dateRange.contains(date)
                        let dateIsSelectedMonth = calendar.isDate(date, equalTo: month, toGranularity: .month)

                        if dateIsInRange {
                            if dateIsSelectedMonth {
                                selectedMonthItemViewProvider(date)
                                    .font(.fontBodySmall)
                                    .maxSize()
                                    .background(circleHighlight(for: date))
                            } else {
                                otherSelectableMonthItemViewProvider(date)
                            }
                        } else {
                            otherMonthItemViewProvider(date)
                        }
                    }
                }
            }
        }
        .padding(.top, .small)
        .padding([.leading, .trailing, .bottom], .medium)
    }

}

// MARK: - Computed Properties
private extension CalendarView {

    private var shouldShowNextMonth: Bool {
        guard let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth) else { return false }

        return dateRange.contains(calendar.startOfDay(for: nextMonthDate))
    }

    private var shouldShowPreviousMonth: Bool {
        guard let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth) else { return false }

        return dateRange.contains(calendar.startOfDay(for: previousMonthDate))
    }

    private var month: Date {
        dateForVisibleMonth.startOfMonth(using: calendar)
    }

    private var days: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: dateForVisibleMonth),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else { return [] }

        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)

        return calendar.generateDays(for: dateInterval)
    }

    private var dateInFormat: String {
        return DateFormatter.string(withFormat: .slashSeparatedFormat, date: selectedDate)
    }

}

// MARK: - View Components
private extension CalendarView {

    private func circleHighlight(for date: Date) -> some View {
        Circle()
            .fill(resolveBackgroundColor(for: date))
            .frame(width: 32, height: 32)
    }

    private func headerViewProvider(_ month: Date) -> some View {
        HStack {
            Button {
                guard let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth) else { return }

                dateForVisibleMonth = previousMonthDate
            } label: {
                Image.chevronLeft
                    .renderingMode(.template)
                    .foregroundStyle(Color.surfaceTextPrimary)
            }
            .frame(alignment: .leading)
            .opacity(shouldShowPreviousMonth ? 1 : 0)

            Text(DateFormatter.string(withFormat: .monthYear, date: month).uppercased())
                .font(.fontHeading5)
                .foregroundColor(.surfaceTextPrimary)
                .frame(maxWidth: .infinity, alignment: .center)

            Button {
                guard let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth) else { return }

                dateForVisibleMonth = nextMonthDate
            } label: {
                Image.chevronRight
                    .renderingMode(.template)
                    .foregroundStyle(Color.surfaceTextPrimary)
            }
            .frame(alignment: .trailing)
            .opacity(shouldShowNextMonth ? 1 : 0)
        }
        .padding([.top, .bottom], .base)
        .padding([.leading, .trailing], .base)
    }

    private func daysOfWeekViewProvider(_ date: Date) -> some View {
        Text(DateFormatter.string(withFormat: .weekDay, date: date))
            .foregroundColor(.white)
            .font(.fontLabelMedium)
    }

    private func selectedMonthItemViewProvider(_ date: Date) -> some View {
        Button {
            selectedDate = date
        } label: {
            Text(DateFormatter.string(withFormat: .day, date: date))
                .font(.fontBodyMedium)
                .foregroundColor(.surfaceTextPrimary)
                .padding(.small)
        }
    }

    private func otherMonthItemViewProvider(_ date: Date) -> some View {
        Text(DateFormatter.string(withFormat: .day, date: date))
            .foregroundColor(.surfaceTextPrimary)
            .font(.fontBodyMedium)
            .opacity(0.5)
            .padding(.small)
    }

    private func otherSelectableMonthItemViewProvider(_ date: Date) -> some View {
        Button(action: {
            if dateForVisibleMonth.year == date.year {
                if
                    date.month < dateForVisibleMonth.month,
                    let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth)
                {
                    dateForVisibleMonth = previousMonthDate
                } else if
                    date.month > dateForVisibleMonth.month,
                    let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth)
                {
                    dateForVisibleMonth = nextMonthDate
                }
            } else if dateForVisibleMonth.year < date.year {
                if let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth) {
                    dateForVisibleMonth = previousMonthDate
                }
            } else if dateForVisibleMonth.year < date.year {
                if let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth) {
                    dateForVisibleMonth = nextMonthDate
                }
            }
        }, label: {
            Text(DateFormatter.string(withFormat: .day, date: date))
                .font(.fontBodyMedium)
                .foregroundColor(.surfaceTextPrimary)
                .opacity(0.5)
                .padding(Padding.small)
        })
    }

    private func resolveBackgroundColor(for date: Date) -> Color {
        let isSelectedDate = calendar.isDate(date, inSameDayAs: selectedDate)

        if isSelectedDate {
            return .accentBlue
        }

        let isToday = calendar.isDate(date, inSameDayAs: Date())

        if isToday {
            return .accentBlue.opacity(0.2)
        }

        return .clear
    }

}

#Preview {
    CalendarView(
        selectedDate: .constant(.now),
        dateRange: DateInterval(start: .distantPast, end: .distantFuture),
        calendar: .current)
    Spacer()
}
