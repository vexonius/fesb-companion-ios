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

        var dateRange: DateInterval = {
            let now = Date.now

            let start = Calendar.current.date(byAdding: DateComponents(year: -1), to: now) ?? .now
            let end = Calendar.current.date(byAdding: DateComponents(year: 1), to: now) ?? .now

            return DateInterval(start: start, end: end)
        }()

        var month: Date = .now
        var currentMonthInterval: DateInterval?
        var days: [Date] = []
        var calendarDays: [CalendarDayModel] = []

        var shouldShowNextMonth: Bool {
            guard let nextMonthDate = calendar.nextMonthDate(of: dateForVisibleMonth) else { return false }

            return dateRange.contains(calendar.startOfDay(for: nextMonthDate))
        }

        var shouldShowPreviousMonth: Bool {
            guard let previousMonthDate = calendar.previousMonthDate(of: dateForVisibleMonth) else { return false }

            return dateRange.contains(calendar.startOfDay(for: previousMonthDate))
        }

        var monthName: String {
            DateFormatter.string(withFormat: .monthYear, date: month).uppercased()
        }

        var selectedDateEvents: [CalendarMetadataModel] {
            calendarDays
                .filter { calendar.isDate($0.date, equalTo: selectedDate, toGranularity: .day) }
                .flatMap { $0.events }
        }

        fileprivate let calendar = Calendar.current
        fileprivate var defaultDate: Date

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

        // Calendar
        case generateVisibleDays
        case updateCalendarDays([CalendarDayModel])

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
                state.selectedDate = .now
                state.dateForVisibleMonth = .now

                return .merge(.send(.fetchCalendarMetadata), .send(.generateVisibleDays))
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
            case .binding(\.dateForVisibleMonth):
                return .send(.generateVisibleDays)
            case .generateVisibleDays:
                let dateForVisibleMonth = state.dateForVisibleMonth
                let calendar = state.calendar
                let metadataEvents = state.metadataEvents
                let dateRange = state.dateRange

                let month = dateForVisibleMonth.startOfMonth(using: calendar)

                let monthInterval = calendar.dateInterval(of: .month, for: dateForVisibleMonth)!
                let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start)!
                let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)!

                let currentMonthInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)

                let calendarDays = calendar
                    .generateDays(for: currentMonthInterval)
                    .map {
                        CalendarDayModel(
                            $0,
                            isInSelectedInterval: dateRange.contains($0),
                            isInCurrentMonth: calendar.isDate($0, equalTo: month, toGranularity: .month))
                    }

                state.calendarDays = calendarDays
                state.month = month

                return .run { send in
                    let calendarDays = calendarDays.map { day in
                        let events = metadataEvents
                            .filter { $0.colorCode != .white }
                            .filter { $0.contains(day.date) || calendar.isDate(day.date, inSameDayAs: $0.startDate) }
                        let isToday = calendar.isDateInToday(day.date)
                        let isInCurrentMonth = calendar.isDate(day.date, equalTo: month, toGranularity: .month)

                        return day.with(
                            events: events,
                            isInSelectedInterval: isInCurrentMonth,
                            isToday: isToday,
                            isInCurrentMonth: isInCurrentMonth)
                    }

                    await send(.updateCalendarDays(calendarDays))
                }
                .cancellable(id: "calendarGenerationTask", cancelInFlight: true)
            case .updateCalendarDays(let models):
                state.calendarDays = models

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
            CalendarMetadataModel(
                id: "2",
                name: "Mine",
                startDate: .now,
                endDate: .now,
                startDateText: "Pon",
                endDateText: "Uto",
                colorCode: .orange,
                isWorking: false,
                isOneDayEvent: false)
        ]

}
