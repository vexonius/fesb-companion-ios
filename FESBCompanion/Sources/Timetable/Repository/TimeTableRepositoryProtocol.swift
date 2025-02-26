import Foundation

protocol TimeTableRepositoryProtocol {

    func getTimetableEvents(for date: Date) async throws -> [TimetableEventModel]

    func getCalendarMetadata(for dateRange: DateInterval) async throws -> [CalendarMetadataModel]

}
