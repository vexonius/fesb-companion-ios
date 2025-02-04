import Foundation

extension Encodable {

    private var toDictionary: [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        else { return nil }

        return jsonObject as? [String: Any]
    }

    private var toQueryItemsList: [(String, String)]? {
        toDictionary?.compactMap { (key, value) -> (String, String)? in
            if let boolArrayValue = value as? [Bool] {
                let joinedValue = boolArrayValue.map { "\($0)" }.joined(separator: ",")

                return (key, joinedValue)
            } else if let arrayValue = value as? [Any] {
                let joinedValue = arrayValue.map { "\($0)" }.joined(separator: ",")

                return (key, joinedValue)
            } else if let numberValue = value as? NSNumber {
                if numberValue.isBool, let boolValue = value as? Bool {
                    return (key, "\(boolValue)")
                } else {
                    return (key, "\(numberValue)")
                }
            } else if let dictionary = value as? [String: Any] {
                guard
                    let jsonValue = try? JSONSerialization.data(withJSONObject: dictionary),
                    let stringValue = String(data: jsonValue, encoding: .utf8)
                else { return nil }

                return (key, stringValue)
            } else {
                return (key, "\(value)")
            }
        }
    }

    var toQueryItemsString: [String: String] {
        let dict = self.toQueryItemsList?.reduce(into: [String: String]()) { result, item in
            result[item.0] = item.1
        }

        return dict ?? [:]
    }

}

extension NSNumber {

    fileprivate var isBool: Bool {
        String(cString: objCType) == "c"
    }

}
