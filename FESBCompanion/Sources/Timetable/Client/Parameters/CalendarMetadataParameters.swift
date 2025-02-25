struct CalendarMetadataParameters: Encodable {

    let dateFrom: String
    let dateTo: String

    enum CodingKeys: String, CodingKey {

        case dateFrom = "FromDate"
        case dateTo = "ToDate"

    }

}
