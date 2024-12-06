import SwiftUI
import ComposableArchitecture

@ViewAction(for: AttendanceReducer.self)
struct AttendanceView: View {

    @Bindable var store: StoreOf<AttendanceReducer>

    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 20, maximum: 20))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                HStack(spacing: Padding.base.rawValue) {
                    ForEach(Semester.allCases) { semester in
                        Chip(text: semester.title, isSelected: semester == store.selectedSemester)
                            .onTapGesture { send(.select(semester: semester)) }
                    }
                }
                .padding(.top, .base)
                .padding(.bottom, .medium)
                .padding(.horizontal, .medium)
                .maxWidth(alignment: .leading)

                LazyVStack(spacing: Padding.medium.value) {
                    ForEach(store.attendanceItems) { model in
                        attendanceCard(model: model)
                    }
                }
                .padding(.horizontal, .medium)
            }
            .refreshable {
                send(.refresh)
                // TODO: Remove this after implementation
                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            }
            .maxSize()
            .background(Color.surface.ignoresSafeArea())
            .navigationTitle(String.attendance)
            .onAppear { send(.fetch) }
        }
    }

    private func attendanceCard(model: AttendanceModel) -> some View {
        VStack(alignment: .leading, spacing: Padding.small.value) {
            Text(model.class)
                .font(Font.headline)
                .foregroundStyle(Color.text)
                .padding(.bottom, .base)

            ForEach(model.items) { item in
                attendanceItem(model: item)
            }
        }
        .padding(.medium)
        .maxWidth(alignment: .leading)
        .background(Color.container)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }

    public func attendanceItem(model: AttendanceItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.type)
                .font(Font.body)
                .foregroundStyle(Color.text)
                .padding(.bottom, .base)

            LazyVGrid(columns: adaptiveColumn, spacing: 6) {
                ForEach(0..<model.attended, id: \.self) { item in
                    progressDot(color: .accentGreen)
                }

                let emptySpots = model.total - model.absent - model.attended
                ForEach(0..<emptySpots, id: \.self) { item in
                    progressDot(color: .surface)
                }

                ForEach(0..<model.absent, id: \.self) { item in
                    progressDot(color: .accentRed)
                }
            }

            Text(String(format: .attendanceProgressFormat, model.attended, model.required, model.required))
                .font(Font.body)
                .foregroundStyle(Color.text)
                .padding(.bottom, .base)
            }
        }

    private func progressDot(color: Color, radius: CGFloat = 10) -> some View {
        Circle()
            .fill(color)
            .frame(width: 2 * radius, height: 2 * radius)
    }

}

struct AttendanceView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: AttendanceReducer.State(), 
        reducer: AttendanceReducer.init)

    static var previews: some View {
        AttendanceView(store: store)
    }

}
