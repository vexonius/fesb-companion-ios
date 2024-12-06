import SwiftUI

struct AttendanceSkeleton: View {

    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .maxWidth()
            .frame(height: 240)
            .foregroundColor(Color.container)
    }

}
