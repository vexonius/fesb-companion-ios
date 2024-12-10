import Algorithms

struct CardModel: Equatable {

    let name: String
    let surname: String
    let cardNumber: String
    let balance: Double

    var fullName: String {
        name + " " + surname
    }

    var cardNumberString: String {
        cardNumber
            .chunks(ofCount: 4)
            .joined(separator: " ")
    }

}
