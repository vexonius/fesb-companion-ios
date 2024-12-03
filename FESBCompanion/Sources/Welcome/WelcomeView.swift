import SwiftUI
import ComposableArchitecture

@ViewAction(for: WelcomeReducer.self)
struct WelcomeView: View {

    @Bindable var store: StoreOf<WelcomeReducer>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.router, action: \.router)) {
            VStack(alignment: .center, spacing: 16) {
                Text("Welcome to FESB Companion")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } destination: { store in
            switch store.case {
            default:
                EmptyView()
            }
        }
    }

}

struct WelcomeView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: WelcomeReducer.State(), 
        reducer: WelcomeReducer.init)

    static var previews: some View {
        WelcomeView(store: store)
    }

}
