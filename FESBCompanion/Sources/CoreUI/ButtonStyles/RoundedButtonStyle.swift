import SwiftUI

struct RoundedButtonStyle: ButtonStyle {

    let opacityDefault = 1.0
    let opacityPressed = 0.6

    let cornerRadius: CGFloat
    let backgroundColor: Color
    let shouldTakeFullFrame: Bool
    let isEnabled: Bool

    private var maxSize: CGFloat? {
        shouldTakeFullFrame ? .infinity : nil
    }

    init(
        shouldTakeFullFrame: Bool = false,
        backgroundColor: Color = .accentColor,
        cornerRadius: CGFloat = 10,
        isEnabled: Bool = true
    ) {
        self.shouldTakeFullFrame = shouldTakeFullFrame
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isEnabled = isEnabled
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.fontLabelMedium)
            .frame(maxWidth: maxSize, maxHeight: maxSize)
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 40)
            .background(backgroundColor)
            .opacity((!isEnabled || configuration.isPressed) ? opacityPressed : opacityDefault)
            .cornerRadius(cornerRadius)
    }

}
