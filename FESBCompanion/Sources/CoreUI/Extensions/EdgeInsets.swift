import SwiftUI

public extension EdgeInsets {

    static var zero = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

    init(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

}
