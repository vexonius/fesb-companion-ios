import SwiftUI

public struct Chip: View {

    private let text: String
    private let isSelected: Bool

    private let topPadding: CGFloat = 7
    private let bottomPadding: CGFloat = 6
    private let horizontalPadding: CGFloat = 12
    private let strokeWidth: CGFloat = 2
    private let strokeInset: CGFloat = 1

    public init(text: String, isSelected: Bool) {
        self.text = text
        self.isSelected = isSelected
    }

    public var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.text)
            .padding(.top, topPadding)
            .padding(.bottom, bottomPadding)
            .padding(.horizontal, horizontalPadding)
            .background(isSelected ? Color.accentBlue : Color.container)
            .clipShape(Capsule())
            .animation(.easeIn, value: isSelected)
    }

}

#Preview {
    VStack {
        Chip(text: "Semstar", isSelected: true)
        Chip(text: "Semstar", isSelected: false)
    }
    .maxSize()
    .background(Color.surface)
}
