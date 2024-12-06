import Foundation

public enum Loadable<T: Equatable>: Equatable {

    case initial
    case empty
    case loading
    case refreshing(T)
    case fetchingMore(T)
    case loaded(T)

}
