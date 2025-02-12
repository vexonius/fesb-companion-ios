import Foundation

extension Int {

    var inMinutes: Int {
        self * 60
    }

    var inHours: Int {
        self / 60
    }

    var asCGFloat: CGFloat {
        CGFloat(self)
    }

}
