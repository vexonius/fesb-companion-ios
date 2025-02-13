import shared

extension CalendarMetadataModel {

    init(from model: CalendarMetadataResponse) {
        id = model.id
        name = model.name
        startDate = model.startDate.toDate() ?? .now
        endDate = model.endDate.toDate() ?? .now
        startDateText = model.startDateText
        endDateText = model.endDateText
        category = model.category
        colorCode = model.colorCode
        isWorking = model.isWorking
    }

}
