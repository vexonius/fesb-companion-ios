import Foundation
import SwiftUI

struct PrimaryTextField: View {

    @Binding var text: String
    var placeholder: String
    var isDisabled: Bool = false
    var isSecureText: Bool = false

    @FocusState private var isFocused: Bool
    @State private var isTextRedacted: Bool = false

    init(text: Binding<String>, placeholder: String, isDisabled: Bool = false, isSecureText: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isDisabled = isDisabled
        self.isSecureText = isSecureText
    }

    var body: some View {
        Group {
            HStack(spacing: .base) {
                if isSecureText && !isTextRedacted {
                    // TODO: change font for secure field without changing font for hint text
                    SecureField(placeholder, text: $text)
                        .focused($isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                }

                let image = isTextRedacted ? Image.visible : Image.invisible

                if isSecureText {
                    image
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.surfaceTextPrimary)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            isTextRedacted.toggle()

                            // To switch focus from textfield to securefield
                            DispatchQueue.main.async {
                                isFocused = true
                            }
                        }
                }
            }
        }
        .font(.fontBodyMedium)
        .autocorrectionDisabled()
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .tint(.surfaceTextPrimary)
        .padding(.horizontal, 12)
        .padding(.top, 18)
        .padding(.bottom, 17)
        .maxWidth(alignment: .leading)
        .frame(height: 50)
        .background(!isDisabled ? Color.inputBackground : .black.opacity(0.1))
        .border(cornerRadius: 10, color: isFocused ? .accentBlue : .divider, lineWidth: 2)
        .disabled(isDisabled)
    }

}

#Preview {
    @Previewable @State var text: String = "username"
    @Previewable @State var emptyText: String = "username"

    VStack {
        PrimaryTextField(text: $text, placeholder: "Username")
        PrimaryTextField(text: $text, placeholder: "Username", isDisabled: true)
        PrimaryTextField(text: $text, placeholder: "Username", isSecureText: true)
    }
    .padding()
    .maxSize()
    .background(Color.surface)
}
