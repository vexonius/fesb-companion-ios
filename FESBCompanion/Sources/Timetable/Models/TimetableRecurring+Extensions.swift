import shared

extension Recurring {

    init(from value: RecurringResponse) {
        switch value {
        case .once:
            self = .undefined
        case .everyTwoWeeks:
            self = .everyTwoWeeks
        case .weekly:
            self = .everyWeek
        default:
            self = .undefined
        }
    }

}
