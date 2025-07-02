import Dependencies
import shared

extension DependencyValues {

    var timetableRepository: TimetableRepository {
        get { self[TimetableRepositoryImpl.self] }
        set { self[TimetableRepositoryImpl.self] = newValue }
    }

}

extension TimetableRepositoryImpl: @retroactive DependencyKey {

    public static var liveValue: any TimetableRepository = TimetableRepositoryImpl(
        client: TimetableClientImpl(),
        parser: TimetableParser())

}
