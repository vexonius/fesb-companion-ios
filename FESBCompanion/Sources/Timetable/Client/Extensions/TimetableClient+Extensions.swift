import Dependencies
import shared

extension DependencyValues {

    var timetableClient: TimetableClient {
        get { self[TimetableClientImpl.self] }
        set { self[TimetableClientImpl.self] = newValue }
    }

}

extension TimetableClientImpl: @retroactive DependencyKey {

    public static var liveValue: any TimetableClient = TimetableClientImpl()

}
