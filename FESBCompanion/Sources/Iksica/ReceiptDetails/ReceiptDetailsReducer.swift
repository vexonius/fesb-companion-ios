import MapKit
import ComposableArchitecture

@Reducer
struct ReceiptDetailsReducer {

    @ObservableState
    struct State: Equatable {

        let model: ReceiptModel

        init(model: ReceiptModel) {
            self.model = model
        }

    }

    enum Action: Equatable {}

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }

}
