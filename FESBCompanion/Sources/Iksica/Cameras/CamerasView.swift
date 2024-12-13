import SwiftUI
import ComposableArchitecture

@ViewAction(for: CamerasReducer.self)
struct CamerasView: View {

    @Bindable var store: StoreOf<CamerasReducer>
    @State var isPresented: Bool = false
    @State var model: Restaurant?
    @Namespace var animation
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                switch store.viewState {
                case .loading, .initial:
                    EmptyView()
                case .loaded(let model), .fetchingMore(let model), .refreshing(let model):
                    content(model: model)
                case .empty:
                    EmptyView()
                }
            }
            .padding(.horizontal, .base)
            .fullScreenCover(isPresented: $isPresented) {
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.container)
                        .navigationTransition(.zoom(sourceID: model?.name ?? "", in: animation))
                        .maxWidth()
                        .frame(height: 200)
                }
                .maxSize()
                .overlay(alignment: .topTrailing) {
                    Image.close
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .frame(width: 30, height: 30)
                        .padding(.medium)
                        .onTapGesture {
                            isPresented = false
                        }
                }
                .background(Color.surface)
            }

        }
    }

    private func content(model: [Restaurant]) -> some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: .medium) {
                    ForEach(model) { item in
                        listItem(model: item)
                    }
                }
                .maxWidth()
                .padding(.top, .medium)
            }
        }
        .navigationTitle(String.menzas)
    }

    private func listItem(model: Restaurant) -> some View {
        HStack(alignment: .top, spacing: .medium) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.container)
                .frame(width: 150, height: 80)
                .matchedTransitionSource(id: model.name, in: animation)

            VStack(alignment: .leading, spacing: .base) {
                Text(model.name)
                    .font(.fontHeading3)
                    .lineLimit(0)
                    .foregroundStyle(Color.white)

                Text(model.description)
                    .font(.fontBodyMedium)
                    .lineLimit(2)
                    .foregroundStyle(Color.white)
            }
            .maxWidth(alignment: .leading)
            .padding(.top, .small)
        }
        .maxWidth(alignment: .leading)
        .onTapGesture {
            self.model = model
            isPresented = true
        }
    }

}
