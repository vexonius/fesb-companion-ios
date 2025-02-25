import shared

extension CalendarMetadataModel {

    init(from model: CalendarMetadataResponse) {
        let startDateText = model.startDate.filter { $0.isNumber }
        let endDateText = model.endDate.filter { $0.isNumber }

        let startDate = (Double(startDateText) ?? 1000) / 1000
        let endDate = (Double(endDateText) ?? 1000 ) / 1000

        self.init(
            id: model.id,
            name: model.name,
            startDate: Date(timeIntervalSince1970: startDate),
            endDate: Date(timeIntervalSince1970: endDate),
            startDateText: model.startDateText,
            endDateText: model.endDateText,
            colorCode: MetadataColorCode(rawValue: model.colorCode) ?? .grey,
            isWorking: model.isWorking)
    }

}
