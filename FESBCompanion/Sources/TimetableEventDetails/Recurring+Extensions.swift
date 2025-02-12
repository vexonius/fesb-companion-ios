extension Recurring {

    var description: String {
        switch self {
        case .undefined:
            String.recurringUndefined
        case .everyWeek:
            String.recurringWeekly
        case .everyTwoWeeks:
            String.recurringBiWeekly
        case .everyMonth:
            String.recurringMonthly
        }
    }

}
