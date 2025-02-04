import Dependencies
import shared

class TimetableRepository: TimeTableRepositoryProtocol, DependencyKey {

    static var liveValue: any TimeTableRepositoryProtocol = TimetableRepository()

    @Dependency(\.timetableClient) private var client: TimetableClient

    func getTimetableEvents(for date: Date) async throws -> [TimetableEventModel] {
        let startDate = date.next(.monday, direction: .backward)
        let endDate = startDate.next(.saturday, direction: .forward)

        let data = try await client.getTimetableEvents(
            params: [
                "DataType": "User",
                "DataId": "sjurko00",
                "MinDate": startDate.toString(),
                "MaxDate": endDate.toString()])

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
