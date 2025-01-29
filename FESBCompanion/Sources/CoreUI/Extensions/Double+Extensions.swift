import Foundation

extension Double {

    func currencyFormat(minFractionDigits: Int = 2, maxFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = minFractionDigits
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.locale = Locale(identifier: "HR")
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true

        guard let value = formatter.string(from: abs(self) as NSNumber) else { return "" }

        let prefix = self < 0 ? "-" : ""
        return "\(prefix)\(value) €"
    }

}
