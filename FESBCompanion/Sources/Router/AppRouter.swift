import ComposableArchitecture

@Reducer(state: .equatable, action: .equatable)
enum AppRouter {

    case dummy(DummyReducer)

}
