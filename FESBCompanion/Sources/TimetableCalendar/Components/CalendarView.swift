import SwiftUI

public struct CalendarView: View {

    @Binding private var selectedDate: Date
    @Binding private var dateForVisibleMonth: Date

    var monthName: String
    var days: [CalendarDayModel]
    var shouldShowNextMonth: Bool
    var shouldShowPreviousMonth: Bool

    private let daysInWeek = 7

    private var calendar: Calendar

    init(
        selectedDate: Binding<Date>,
        dateForVisibleMonth: Binding<Date>,
        days: [CalendarDayModel],
        monthName: String,
        shouldShowNextMonth: Bool,
        shouldShowPreviousMonth: Bool,
        calendar: Calendar = .current
    ) {
        self._selectedDate = selectedDate
        self._dateForVisibleMonth = dateForVisibleMonth
        self.calendar = calendar
        self.days = days
        self.monthName = monthName
        self.shouldShowNextMonth = shouldShowNextMonth
        self.shouldShowPreviousMonth = shouldShowPreviousMonth
    }

    public var body: some View {
        VStack(spacing: .base) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                Section(header: headerViewProvider(monthName)) {
                    ForEach(days.prefix(daysInWeek), content: daysOfWeekViewProvider)
                    ForEach(days) { date in
                        if date.isInSelectedInterval {
                            if date.isInCurrentMonth {
                                selectedMonthItemViewProvider(date)
                                    .font(.fontBodySmall)
                                    .maxSize()
                                    .background(circleHighlight(for: date.date))
                            } else {
                                otherSelectableMonthItemViewProvider(date.date)
                            }
                        } else {
                            otherMonthItemViewProvider(date.date)
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing, .bottom], .medium)
    }

}

// MARK: - View Components
private extension CalendarView {

    private func circleHighlight(for date: Date) -> some View {
        Circle()
            .fill(resolveBackgroundColor(for: date))
            .frame(width: 32, height: 32)
    }

    private func headerViewProvider(_ month: String) -> some View {
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

            Text(month)
                .font(.fontHeading5)
                .foregroundColor(.surfaceTextPrimary)
                .maxWidth(alignment: .center)

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
        .padding([.top, .bottom], .medium)
        .padding([.leading, .trailing], .base)
    }

    private func daysOfWeekViewProvider(_ date: CalendarDayModel) -> some View {
        Text(DateFormatter.string(withFormat: .weekDay, date: date.date))
            .foregroundColor(.white)
            .font(.fontLabelMedium)
    }

    private func selectedMonthItemViewProvider(_ day: CalendarDayModel) -> some View {
        Button {
            selectedDate = day.date
        } label: {
            VStack(spacing: 2) {
                Text(DateFormatter.string(withFormat: .day, date: day.date))
                    .font(.fontBodyMedium)
                    .foregroundColor(.surfaceTextPrimary)

                HStack(spacing: 2) {
                    ForEach(day.events) { item in
                        Circle()
                            .fill(item.color)
                            .frame(width: 4, height: 4)
                    }
                }
            }
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
        Text(DateFormatter.string(withFormat: .day, date: date))
            .font(.fontBodyMedium)
            .foregroundColor(.surfaceTextPrimary)
            .opacity(0.5)
            .padding(Padding.small)
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
        dateForVisibleMonth: .constant(.now),
        days: [],
        monthName: "January",
        shouldShowNextMonth: true,
        shouldShowPreviousMonth: true,
        calendar: .current)
    Spacer()
}
