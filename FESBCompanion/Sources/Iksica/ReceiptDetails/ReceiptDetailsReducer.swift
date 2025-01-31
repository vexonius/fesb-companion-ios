import MapKit
import ComposableArchitecture

@Reducer
struct ReceiptDetailsReducer {

    @ObservableState
    struct State: Equatable {

        let model: ReceiptModel

    }

    enum Action: Equatable {}

    var body: some ReducerOf<Self> {
        Reduce { _, _ in
            return .none
        }
    }

}
