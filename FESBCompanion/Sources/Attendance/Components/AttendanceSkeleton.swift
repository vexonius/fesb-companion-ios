import SwiftUI

struct AttendanceSkeleton: View {

    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack(spacing: .base) {
                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 120, height: 30)

                Capsule()
                    .foregroundColor(Color.container)
                    .frame(width: 120, height: 30)
            }
            .maxWidth(alignment: .leading)
            .padding(.top, .base)

            RoundedRectangle(cornerRadius: 30)
                .maxWidth()
                .frame(height: 240)
                .foregroundColor(Color.container)

            RoundedRectangle(cornerRadius: 30)
                .maxWidth()
                .frame(height: 240)
                .foregroundColor(Color.container)
        }
        .maxWidth()
        .pushedTop()
        .padding(.horizontal, .medium)
        .shimmer()
    }

}
