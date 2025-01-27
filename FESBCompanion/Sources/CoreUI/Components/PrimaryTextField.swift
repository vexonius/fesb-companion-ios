import SwiftUI

struct PrimaryTextField: View {

    @FocusState private var isFocused: Bool
    @Binding var text: String
    var placeholder: String
    var isDisabled: Bool = false
    var isTextRedacted: Bool = false

    init(text: Binding<String>, placeholder: String, isDisabled: Bool = false, isTextRedacted: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isDisabled = isDisabled
        self.isTextRedacted = isTextRedacted
    }

    var body: some View {
        Group {
            if isTextRedacted {
                SecureField(placeholder, text: $text)
                    .font(.fontBodyRedacted)
            } else {
                TextField(placeholder, text: $text)
                    .font(.fontBodyMedium)
            }
        }
        .autocorrectionDisabled()
        .tint(.surfaceTextPrimary)
        .padding(.horizontal, 12)
        .padding(.top, 18)
        .padding(.bottom, 17)
        .maxWidth(alignment: .leading)
        .frame(height: 50)
        .background(!isDisabled ? Color.inputBackground : .black.opacity(0.1))
        .border(cornerRadius: 10, color: isFocused ? .accentBlue : .divider, lineWidth: 2)
        .disabled(isDisabled)
        .focused($isFocused)
    }

}

#Preview {
    @Previewable @State var text: String = "username"
    @Previewable @State var emptyText: String = "username"

    VStack {
        PrimaryTextField(text: $text, placeholder: "Username")
        PrimaryTextField(text: $text, placeholder: "Username", isDisabled: true)
        PrimaryTextField(text: $text, placeholder: "Username", isTextRedacted: true)
    }
    .padding()
    .maxSize()
    .background(Color.surface)
}
