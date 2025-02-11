import Dependencies
import shared

class TimetableRepository: TimeTableRepositoryProtocol, DependencyKey {

    static var liveValue: any TimeTableRepositoryProtocol = TimetableRepository()

    @Dependency(\.timetableClient) private var client: TimetableClient

    private let dataType: String = "User"

    func getTimetableEvents(for date: Date) async throws -> [TimetableEventModel] {
        let startDate = date.next(.monday, direction: .backward)
        let endDate = startDate.next(.saturday, direction: .forward)

        let params = TimetableParameters(
            dataType: dataType,
            minDate: startDate.toString(),
            maxDate: endDate.toString(),
            dataId: ProcessInfo.processInfo.environment["userId"] ?? "")

        let data = try await client.getTimetableEvents(params: params.toQueryItemsString)
        let parser = TimetableParser()
        let response = parser.parse(data: data)

        return response.map(TimetableEventModel.init)
    }

}

extension DependencyValues {

    var timetableRepository: TimeTableRepositoryProtocol {
        get { self[TimetableRepository.self] }
        set { self[TimetableRepository.self] = newValue }
    }

}
