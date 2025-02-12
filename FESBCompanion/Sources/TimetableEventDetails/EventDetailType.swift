enum EventDetailType: String, Identifiable {

    case name
    case recurring
    case professor
    case group
    case date
    case time

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .date:
            String.date
        case .name:
            String.name
        case .professor:
            String.professor
        case .group:
            String.group
        case .recurring:
            String.recurring
        case .time:
            String.time
        }
    }

}
