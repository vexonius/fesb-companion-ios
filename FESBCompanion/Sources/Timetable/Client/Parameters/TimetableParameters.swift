struct TimetableParameters: Encodable {

    let dataType: String
    let minDate: String
    let maxDate: String
    let dataId: String

    enum CodingKeys: String, CodingKey {

        case dataType = "DataType"
        case minDate = "MinDate"
        case maxDate = "MaxDate"
        case dataId = "DataId"

    }

}
