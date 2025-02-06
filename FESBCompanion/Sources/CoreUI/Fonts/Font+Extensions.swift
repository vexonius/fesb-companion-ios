import SwiftUI

extension Font {

    static let fontHeading1 = Font.custom("Inter-Black", size: 32)
    static let fontHeading2 = Font.custom("Inter-SemiBold", size: 24)
    static let fontHeading3 = Font.custom("Inter-SemiBold", size: 20)
    static let fontHeading4 = Font.custom("Inter-SemiBold", size: 16)
    static let fontHeading5 = Font.custom("Inter-SemiBold", size: 14)

    static let fontBodyLarge = Font.custom("Inter-Regular", size: 16)
    static let fontBodyMedium = Font.custom("Inter-Regular", size: 14)
    static let fontBodySmall = Font.custom("Inter-Regular", size: 12)
    static let fontBodyRedacted = Font.system(size: 14, weight: .black)

    static let fontButtonLarge = Font.custom("Inter-Medium", size: 18)
    static let fontButtonMedium = Font.custom("Inter-Medium", size: 16)
    static let fontButtonSmall = Font.custom("Inter-Medium", size: 14)
    static let fontButtonExtraSmall = Font.custom("Inter-Regular", size: 10)

    static let fontLabelLarge = Font.custom("Inter-SemiBold", size: 16)
    static let fontLabelMedium = Font.custom("Inter-SemiBold", size: 14)

}
