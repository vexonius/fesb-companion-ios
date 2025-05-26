import Dependencies
import shared

extension AttendanceRepositoryImpl: @retroactive DependencyKey {

    static public var liveValue: any AttendanceRepository = DependenciesProvider().provideAttendanceRepository()

}

extension DependencyValues {

    var attendanceRepository: any AttendanceRepository {
        get { self[AttendanceRepositoryImpl.self] }
        set { self[AttendanceRepositoryImpl.self] = newValue }
    }

}
