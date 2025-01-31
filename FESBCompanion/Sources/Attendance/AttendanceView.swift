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
            ZStack {
                switch store.viewState {
                case .loading, .initial:
                    AttendanceSkeleton()
                case .loaded(let items), .fetchingMore(let items), .refreshing(let items):
                    render(items: items)
                case .empty:
                    EmptyView()
                }
            }
            .maxSize()
            .background(Color.surface.ignoresSafeArea())
            .navigationTitle(String.attendance)
        }
        .onAppear { send(.fetch) }
    }

    private func render(items: [AttendanceModel]) -> some View {
        ScrollView {
            HStack(spacing: .base) {
                ForEach(Semester.allCases) { semester in
                    Chip(text: semester.title, isSelected: semester == store.selectedSemester)
                        .onTapGesture { send(.select(semester: semester)) }
                }
            }
            .padding(.vertical, .base)
            .padding(.horizontal, .medium)
            .maxWidth(alignment: .leading)

            LazyVStack(spacing: .medium) {
                ForEach(items) { model in
                    attendanceCard(model: model)
                }
            }
            .padding(.horizontal, .medium)
        }
        .refreshable {
            send(.refresh)
        }
    }

    private func attendanceCard(model: AttendanceModel) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(model.class)
                .font(Font.fontHeading3)
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
        VStack(alignment: .leading, spacing: .base) {
            Text(model.type)
                .font(.fontLabelMedium)
                .foregroundStyle(Color.text)

            LazyVGrid(columns: adaptiveColumn, spacing: 6) {
                ForEach(0..<model.attended, id: \.self) { _ in
                    progressDot(color: .accentGreen)
                }

                let emptySpots = model.total - model.absent - model.attended
                ForEach(0..<emptySpots, id: \.self) { _ in
                    progressDot(color: .surface)
                }

                ForEach(0..<model.absent, id: \.self) { _ in
                    progressDot(color: .accentRed)
                }
            }

            Text(String(format: .attendanceProgressFormat, model.attended, model.required, model.required))
                .font(.fontBodyMedium)
                .foregroundStyle(Color.text)
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
