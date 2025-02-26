import Foundation

struct CalendarDayModel: Identifiable, Equatable {

    let id: String
    let date: Date
    let events: [CalendarMetadataModel]
    let isInSelectedInterval: Bool
    let isToday: Bool
    let isInCurrentMonth: Bool

    init(
        _ date: Date,
        events: [CalendarMetadataModel] = [],
        isInSelectedInterval: Bool = true,
        isToday: Bool = false,
        isInCurrentMonth: Bool = true
    ) {
        self.id = DateFormatter.string(withFormat: .slashSeparatedFormat, date: date)
        self.date = date
        self.events = events
        self.isInSelectedInterval = isInSelectedInterval
        self.isToday = isToday
        self.isInCurrentMonth = isInCurrentMonth
    }

}

extension CalendarDayModel {

    func with(
        events: [CalendarMetadataModel],
        isInSelectedInterval: Bool,
        isToday: Bool,
        isInCurrentMonth: Bool
    ) -> Self {
        CalendarDayModel(
            date,
            events: events,
            isInSelectedInterval: isInSelectedInterval,
            isToday: isToday,
            isInCurrentMonth: isInCurrentMonth)
    }

}
