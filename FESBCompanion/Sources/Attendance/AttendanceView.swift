import SwiftUI
import ComposableArchitecture

@ViewAction(for: AttendanceReducer.self)
struct AttendanceView: View {

    @Bindable var store: StoreOf<AttendanceReducer>

    var body: some View {
        ScrollView {

        }
        .background(Color.surface.ignoresSafeArea())
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
