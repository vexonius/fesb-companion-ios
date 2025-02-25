import shared

extension CalendarMetadataModel {

    init(from model: CalendarMetadataResponse) {
        let startDateText = model.startDate.filter { $0.isNumber }
        let endDateText = model.endDate.filter { $0.isNumber }

        let startDateTimeInterval = (Double(startDateText) ?? 1000) / 1000
        let endDateTimeInterval = (Double(endDateText) ?? 1000 ) / 1000

        let startDate = Date(timeIntervalSince1970: startDateTimeInterval)
        let endDate = Date(timeIntervalSince1970: endDateTimeInterval)

        let isOneDayEvent = Calendar.current.isDate(startDate, inSameDayAs: endDate)

        self.init(
            id: model.id,
            name: model.name,
            startDate: startDate,
            endDate: endDate,
            startDateText: model.startDateText,
            endDateText: model.endDateText,
            colorCode: MetadataColorCode(rawValue: model.colorCode) ?? .grey,
            isWorking: model.isWorking,
            isOneDayEvent: isOneDayEvent)
    }

}
