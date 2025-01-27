import SwiftUI
import ComposableArchitecture

@ViewAction(for: LoginReducer.self)
struct LoginView: View {

    @Bindable var store: StoreOf<LoginReducer>

    var body: some View {
        VStack(spacing: .base) {
            Spacer()

            Text(String.login)
                .font(.fontHeading1)
                .foregroundStyle(Color.white)
                .maxWidth(alignment: .leading)

            Text(String.loginSubtitle)
                .font(.fontBodyMedium)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.leading)
                .maxWidth(alignment: .leading)
                .padding(.bottom, 24)

            PrimaryTextField(text: $store.username, palceholder: String.username)
            PrimaryTextField(text: $store.password, palceholder: String.password)

            Spacer()
            Spacer()
            Spacer()
        }
        .maxWidth()
        .padding(.horizontal, 40)
        .background(Color.surface)
    }

}

struct LoginView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: LoginReducer.State(),
        reducer: LoginReducer.init)

    static var previews: some View {
        LoginView(store: store)
    }

}
