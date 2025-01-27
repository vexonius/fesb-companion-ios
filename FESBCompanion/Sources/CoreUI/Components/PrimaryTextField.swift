import SwiftUI

struct PrimaryTextField: View {

    @FocusState private var isFocused: Bool
    @Binding var text: String
    var placeholder: String
    var isDisabled: Bool = false

    init(text: Binding<String>, placeholder: String, isDisabled: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isDisabled = isDisabled
    }

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.fontBodyMedium)
            .autocorrectionDisabled()
            .tint(.surfaceTextPrimary)
            .padding(.horizontal, 12)
            .padding(.top, 18)
            .padding(.bottom, 17)
            .maxWidth(alignment: .leading)
            .frame(height: 50)
            .background(!isDisabled ? Color.inputBackground : .black.opacity(0.1))
            .border(
                cornerRadius: 10,
                color: isFocused ? .accentBlue : .divider,
                lineWidth: isFocused ? 2 : 1.5)
            .disabled(isDisabled)
            .focused($isFocused)
    }

}

#Preview {
    @Previewable @State var text: String = ""

    PrimaryTextField(text: $text, placeholder: "Username")
}
