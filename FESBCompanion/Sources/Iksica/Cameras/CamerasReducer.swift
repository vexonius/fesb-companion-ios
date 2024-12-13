import ComposableArchitecture

@Reducer
struct CamerasReducer {

    @ObservableState
    struct State: Equatable {

        var viewState: Loadable<[Restaurant]> = .loaded(Restaurant.allCases)

    }

    enum Action: Equatable, ViewAction {

        case view(View)

        enum View: Equatable {

        }

    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }

}
