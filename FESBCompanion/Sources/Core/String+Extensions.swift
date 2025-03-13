import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: self)
    }

    var toTimeInterval: Double {
        guard let value = Double(self) else { return .zero }

        // Unix timestamped is in milliseconds, so we must divide by 1000 to get seconds for TimeInterval
        return value / 1000
    }

}
