import SwiftUI

struct PrimaryTextField: View {

    @FocusState private var isFocused: Bool
    @Binding var text: String
    var palceholder: String
    var isDisabled: Bool = false

    init(text: Binding<String>, palceholder: String, isDisabled: Bool = false) {
        self._text = text
        self.palceholder = palceholder
        self.isDisabled = isDisabled
    }

    var body: some View {
        TextField(palceholder, text: $text)
            .font(.fontBodyMedium)
            .autocorrectionDisabled()
            .tint(.surfaceTextPrimary)
            .padding(.horizontal, 12)
            .padding(.top, 18)
            .padding(.bottom, 17)
            .maxWidth(alignment: .leading)
            .frame(height: 50)
            .background(!isDisabled ? Color.surface : .black.opacity(0.1))
            .border(
                cornerRadius: 10,
                color: isFocused ? .accentBlue : .surfaceTextPrimary,
                lineWidth: isFocused ? 2 : 1.5)
            .disabled(isDisabled)
            .focused($isFocused)
    }

}

#Preview {
    @Previewable @State var text: String = ""

    PrimaryTextField(text: $text, palceholder: "Username")
}
