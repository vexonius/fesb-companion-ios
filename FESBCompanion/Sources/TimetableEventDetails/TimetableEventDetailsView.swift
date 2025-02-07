import SwiftUI
import ComposableArchitecture

@ViewAction(for: TimetableEventDetailsReducer.self)
struct TimetableEventDetailsView: View {

    @Bindable var store: StoreOf<TimetableEventDetailsReducer>

    private let layout = [
        GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: Padding.base.value),
        GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: Padding.base.value)
    ]

    var body: some View {
        VStack(spacing: .base) {
            Text(store.model.name)
                .font(.fontHeading2)
                .foregroundStyle(Color.surfaceTextPrimary)
                .multilineTextAlignment(.leading)
                .maxWidth(alignment: .leading)

            HStack(spacing: .base) {
                Circle()
                    .foregroundStyle(store.model.eventType.color)
                    .frame(width: 12)

                Text(store.model.eventType.title)
                    .font(.fontHeading4)
                    .foregroundStyle(Color.surfaceTextPrimary)
                    .multilineTextAlignment(.leading)
                    .maxWidth(alignment: .leading)
            }
            .padding(.bottom, .base * 3)

            LazyVGrid(columns: layout, spacing: Padding.medium.value) {
                ForEach(store.cellItems, id: \.type.id) { item in
                    cell(title: item.type.title, value: item.value)
                }
            }
            .padding(.horizontal, .medium)
        }
        .padding(.top, .large)
        .padding(.horizontal, .large)
        .maxSize(alignment: .top)
        .background(Color.surface.ignoresSafeArea())
    }

    private func cell(title: String, value: String) -> some View {
        VStack(spacing: .small) {
            Text(title)
                .font(.fontLabelMedium)
                .foregroundStyle(Color.surfaceTextPrimary)
                .multilineTextAlignment(.leading)
                .maxWidth(alignment: .leading)

            Text(value)
                .font(.fontBodyMedium)
                .foregroundStyle(Color.surfaceTextPrimary)
                .multilineTextAlignment(.leading)
                .maxWidth(alignment: .leading)
        }
        .maxWidth(alignment: .leading)
        .padding(.bottom, .medium)
    }

}

struct TimetableEventDetailsView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: TimetableEventDetailsReducer.State(
            model: .init(
                id: "1234",
                name: "Uvod u programiranje",
                professor: "Ivo Ivic",
                eventType: .`classes`,
                groups: "Grupa 2",
                classroom: "A100",
                start: Date(),
                end: Date(),
                description: "Jedan kolegij o programiranju",
                recurring: true,
                recurringType: .everyWeek,
                recurringUntil: Date(),
                studyCode: "BB45")),
        reducer: TimetableEventDetailsReducer.init)

    static var previews: some View {
        TimetableEventDetailsView(store: store)
    }

}
