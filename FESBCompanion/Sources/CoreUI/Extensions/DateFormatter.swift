import Foundation

extension DateFormatter {

    enum Format: String {

        case `default` = "yyyy-MM-dd"
        case dropDown = "MMM dd., yyyy"
        case dayName = "EE"
        case day = "d"
        case time = "HH:mm"
        case dotSeparatedDate = "dd.MM.yyyy"
        case dayAndDotSeparatedDate = "EEEE, dd.MM.yyyy"

    }

    static func string(withFormat format: Format = .default, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue

        return dateFormatter.string(from: date)
    }

}
