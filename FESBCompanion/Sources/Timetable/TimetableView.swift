import SwiftUI
import ComposableArchitecture

@ViewAction(for: TimetableReducer.self)
struct TimetableView: View {

    @Bindable var store: StoreOf<TimetableReducer>
    @State var containerWidth: CGFloat = 0

    @GestureState var zoomFactorGesture: CGFloat = 1
    @State var zoomFactor: CGFloat = 1

    var verticalSpacing: CGFloat = 60

    var xSpacing: CGFloat {
        containerWidth / 5
    }

    var ySpacing: CGFloat {
        zoomFactor * verticalSpacing
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: .medium) {
                monthDropdown
                    .padding(.horizontal, 24)

                daysInWeek
            }

            switch store.viewState {
            case .loading:
                TimetableSkeleton(containerWidth: containerWidth, model: .createDummyModel())
            case .loaded(let model):
                scrollableGridView(model: model)
            default:
                EmptyView()
            }
        }
        .gesture(pinchGesture(minZoomFactor: store.minZoomFactor, maxZoomFactor: store.maxZoomFactor))
        .onGeometryChange(for: CGSize.self, of: \.size) {
            containerWidth = $0.width
        }
        .onAppear {
            send(.fetchTimetable)
            send(.startTimeline)
        }
    }

    private var monthDropdown: some View {
        Button {
            send(.calendar)
        } label: {
            Text(store.dropDownText.capitalized)
                .font(.fontHeading5)
                .foregroundStyle(Color.white)
                .padding(.vertical, 6)
                .padding(.horizontal, .medium)
                .background(Capsule().fill(Color.container))
                .maxWidth(alignment: .center)
        }
    }

    private func dayInAWeek(day: String, date: String, isSelected: Bool = false) -> some View {
        VStack(spacing: .small) {
            Text(date)
                .font(.fontHeading4)
                .foregroundStyle(Color.white)
                .background {
                    if isSelected {
                        Circle()
                            .fill(Color.accentBlue)
                            .frame(width: 28, height: 28)
                    }
                }

            Text(day)
                .font(.fontBodyMedium)
                .foregroundStyle(Color.white)
        }
        .maxWidth()
    }

    private var daysInWeek: some View {
        HStack {
            ForEach(store.weekdayNames, id: \.self.0) { item in
                dayInAWeek(day: item.0, date: item.1)
            }
        }
    }

    private func scrollableGridView(model: TimetableModel) -> some View {
        ScrollView {
            ZStack {
                ForEach(model.events) { event in
                    EventView(
                        event: event,
                        xSpacing: xSpacing,
                        ySpacing: ySpacing,
                        zoomFactor: zoomFactor,
                        startOffset: model.startHour.inMinutes.asCGFloat)
                    .onTapGesture { send(.eventDetails(model: event)) }
                }
            }
            .frame(width: containerWidth, height: model.rows * ySpacing)
            .background {
                Path { path in
                    for index in 1...Int(model.cols - 1) {
                        let vOffset: CGFloat = CGFloat(index) * xSpacing
                        path.move(to: CGPoint(x: vOffset, y: -3000))
                        path.addLine(to: CGPoint(x: vOffset, y: 3000))
                    }
                    for index in 1...Int(model.rows - 1) {
                        let hOffset: CGFloat = CGFloat(index) * ySpacing
                        path.move(to: CGPoint(x: 0, y: hOffset))
                        path.addLine(to: CGPoint(x: containerWidth, y: hOffset))
                    }
                }
                .stroke(Color.container.opacity(0.8), lineWidth: 2)
            }
            .background {
                Path { path in
                    for index in 2...Int(model.rows - 1) {
                        let hOffset: CGFloat = CGFloat(index) * ySpacing - ySpacing / 2
                        path.move(to: CGPoint(x: 0, y: hOffset))
                        path.addLine(to: CGPoint(x: containerWidth, y: hOffset))
                    }
                }
                .stroke(Color.container.opacity(0.6), style: .init(lineWidth: 2, dash: [2]))
            }
        }
        .overlay(alignment: .top) {
            LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
                .maxWidth()
                .frame(height: 40)
        }
    }

    private func pinchGesture(minZoomFactor: CGFloat, maxZoomFactor: CGFloat) -> some Gesture {
        MagnifyGesture()
            .updating($zoomFactorGesture) { value, gestureState, _ in
                gestureState = value.magnification

                guard
                    gestureState > minZoomFactor
                    && gestureState < maxZoomFactor
                else { return }

                zoomFactor = gestureState
            }
    }

}

struct TimetableView_Previews: PreviewProvider {

    @State private static var store = Store(
        initialState: TimetableReducer.State(),
        reducer: TimetableReducer.init)

    static var previews: some View {
        TimetableView(store: store)
    }

}
