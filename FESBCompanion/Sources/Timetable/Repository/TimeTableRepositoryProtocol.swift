import Foundation

protocol TimeTableRepositoryProtocol {

    func getTimetableEvents(for date: Date) async throws -> [TimetableEventModel]

}
