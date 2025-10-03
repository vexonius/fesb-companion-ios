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

            PrimaryTextField(text: $store.username, placeholder: String.username)
            PrimaryTextField(text: $store.password, placeholder: String.password, isSecureText: true) {
                send(.login)
            }
            .padding(.bottom, .medium)

            Button {
                send(.login)

            } label: {
                Text(String.login)
                    .font(.fontButtonMedium)
                    .padding(.horizontal, 16)
            }
            .controlSize(.large)
            .buttonStyle(.glassProminent)
            .maxWidth(alignment: .trailing)

            Spacer()
            Spacer()
            Spacer()
        }
        .maxWidth()
        .padding(.horizontal, 40)
        .background(Color.surface)
        .interactiveDismissDisabled()
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
