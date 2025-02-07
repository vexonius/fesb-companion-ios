import SwiftUI

struct EventView: View {

    var event: TimetableEventModel
    var xSpacing: CGFloat
    var ySpacing: CGFloat
    var zoomFactor: CGFloat
    var startOffset: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(event.start.formatted(date: .omitted, time: .shortened))
                .font(.fontButtonExtraSmall)
                .lineLimit(0)
                .foregroundStyle(Color.secondary)
                .padding(.leading, 12)
                .padding([.top, .trailing, .bottom], .small)

            Text(event.name)
                .font(.fontButtonExtraSmall)
                .foregroundStyle(Color.white)
                .padding(.leading, 12)
                .padding([.trailing], .small)

            Text(event.classroom)
                .font(.fontButtonExtraSmall)
                .lineLimit(0)
                .foregroundStyle(Color.secondary)
                .padding(.leading, 12)
                .padding([.top, .trailing, .bottom], .small)
        }
        .frame(width: xSpacing - 6, height: CGFloat(event.minutesDelta) * zoomFactor, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.container)
                .frame(width: xSpacing - 6, height: CGFloat(event.minutesDelta) * zoomFactor)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(event.eventType.color)
                        .frame(width: 4, height: CGFloat(event.minutesDelta) * zoomFactor - 12)
                        .padding(.leading, 4)
                }
        )
        .position(
            x: event.getPosition(xSpacing: xSpacing).x - xSpacing / 2,
            y: zoomFactor * CGFloat(event.startMinute)
               + CGFloat(event.minutesDelta) * zoomFactor / 2 - startOffset * zoomFactor
        )
    }

}

#Preview {
    VStack {
        EventView(
            event: TimetableEventModel(
                id: "32",
                name: "Umjetna inteligencija",
                professor: "Drago Dragic",
                eventType: .class,
                groups: "",
                classroom: "C502",
                start: Date(timeIntervalSinceNow: 60 * 27),
                end: .now.addingTimeInterval(7200),
                description: "",
                recurring: false,
                recurringType: .undefined,
                recurringUntil: .now,
                studyCode: "GDV3728"
            ),
            xSpacing: 0,
            ySpacing: 60,
            zoomFactor: 1,
            startOffset: 0
        )
    }
    .background(Color.surface)
}
