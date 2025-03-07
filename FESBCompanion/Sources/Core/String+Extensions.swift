import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: self)
    }

}
