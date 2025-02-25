import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct TimetableCalendarReducer {

    @Dependency(\.dismiss) private var dismiss
    @Dependency(\.timetableRepository) private var repository: TimeTableRepositoryProtocol

    @ObservableState
    struct State: Equatable {

        var selectedDate: Date
        var dateForVisibleMonth: Date

        var metadataEvents: [CalendarMetadataModel] = []

        var dateRange: DateInterval {
            let now = Date.now

            let start = Calendar.current.date(byAdding: DateComponents(year: -1), to: now) ?? .now
            let end = Calendar.current.date(byAdding: DateComponents(year: 1), to: now) ?? .now

            return DateInterval(start: start, end: end)
        }

        var shouldShowNextMonth: Bool {
            guard let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth) else { return false }

            return dateRange.contains(calendar.startOfDay(for: nextMonthDate))
        }

        var shouldShowPreviousMonth: Bool {
            guard let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth) else { return false }

            return dateRange.contains(calendar.startOfDay(for: previousMonthDate))
        }

        var month: Date {
            dateForVisibleMonth.startOfMonth(using: calendar)
        }

        var monthName: String {
            DateFormatter.string(withFormat: .monthYear, date: month).uppercased()
        }

        var currentMonthInterval: DateInterval? {
            guard
                let monthInterval = calendar.dateInterval(of: .month, for: dateForVisibleMonth),
                let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
            else { return nil }

            return DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        }

        var days: [Date] {
            guard let currentMonthInterval else { return [] }

            return calendar.generateDays(for: currentMonthInterval)
        }

        var calendarDays: [CalendarDayModel] {
            days
                .map { date in
                    let events = metadataEvents
                        .filter { $0.colorCode != .white }
                        .filter { $0.contains(date) || calendar.isDate(date, inSameDayAs: $0.startDate) }
                    let isToday = calendar.isDateInToday(date)
                    let isInCurrentMonth = calendar.isDate(date, equalTo: month, toGranularity: .month)

                    return CalendarDayModel(
                        date,
                        events: events,
                        isInSelectedInterval: true,
                        isToday: isToday,
                        isInCurrentMonth: isInCurrentMonth)
                }
        }

        var selectedDateEvents: [CalendarMetadataModel] {
            calendarDays
                .filter { calendar.isDate($0.date, equalTo: selectedDate, toGranularity: .day) }
                .flatMap { $0.events }
        }

        private let calendar = Calendar.current
        private var defaultDate: Date

        init(selectedDate: Date) {
            self.selectedDate = selectedDate
            self.defaultDate = selectedDate
            self.dateForVisibleMonth = selectedDate
        }

    }

    enum Action: Equatable, BindableAction, ViewAction {

        case view(View)
        case binding(BindingAction<State>)
        case dateSelected(Date)
        case fetchCalendarMetadata
        case updateMetadata([CalendarMetadataModel])

        enum View: Equatable {

            case apply
            case dismiss
            case fetchMetadata

        }

    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.apply):
                let date = state.selectedDate

                return .run { send in
                    await send(.dateSelected(date))
                    await dismiss()
                }
            case .view(.dismiss):
                return .run { _ in
                    await dismiss()
                }
            case .view(.fetchMetadata):
                return .send(.fetchCalendarMetadata)
            case .fetchCalendarMetadata:
                let interval = state.dateRange

                return .run { send in
                    do {
                        let metadataEvents = try await repository.getCalendarMetadata(for: interval)
                        await send(.updateMetadata(metadataEvents))
                    } catch {
                        debugPrint(error)
                    }
                }
            case .updateMetadata(let events):
                state.metadataEvents = events

                return .none
            default:
                return .none
            }
        }
    }

}

extension TimetableCalendarReducer.State {

    static var dummyEvents: [CalendarMetadataModel] =
        [
            .init(
                id: "2",
                name: "Mine",
                startDate: .now,
                endDate: .now,
                startDateText: "Pon",
                endDateText: "Uto",
                colorCode: .orange,
                isWorking: false)
        ]

}
