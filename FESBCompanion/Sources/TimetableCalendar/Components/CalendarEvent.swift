import SwiftUI

struct CalendarEvent: View {

    var model: CalendarMetadataModel

    var body: some View {
        HStack(spacing: .medium) {
            RoundedRectangle(cornerRadius: 10)
                .fill(model.color)
                .frame(width: 8)
                .maxHeight()

            VStack(alignment: .leading, spacing: .small) {
                Text(model.name)
                    .font(.fontLabelMedium)
                    .foregroundStyle(Color.surfaceTextPrimary)
                    .multilineTextAlignment(.leading)
                    .maxWidth(alignment: .leading)

                Text(String(format: "%@ - %@", model.startDateText, model.endDateText))
                    .font(.fontLabelMedium)
                    .foregroundStyle(Color.surfaceTextSecondary)
                    .multilineTextAlignment(.leading)
                    .maxWidth(alignment: .leading)
            }
            .padding(.vertical, .small)
            .maxWidth()
        }
        .maxWidth()
        .fixedSize(horizontal: false, vertical: true)
    }

}

#Preview {
    CalendarEvent(
        model: CalendarMetadataModel(
            id: "2",
            name: "Praznici",
            startDate: .now,
            endDate: .now,
            startDateText: "Ponedjeljak 13.6.2025 - Srijeda, 15.6.2025.",
            endDateText: "Uto",
            colorCode: .orange,
            isWorking: false)
    )
    .maxSize()
    .padding(32)
}
