import Foundation

struct TimetableModel: Equatable {

    let date: Date
    let customStartHour: Int?
    let customEndHour: Int?
    let events: [TimetableEventModel]
    let isSaturdayShown: Bool

    let defaultStartHour = 7
    let defaultEndHour = 20
    let defaultRows: CGFloat = 17
    let defaultCols: CGFloat = 5
    let minZoomFactor: CGFloat = 0.8
    let maxZoomFactor: CGFloat = 2

    var rows: CGFloat {
        CGFloat(24 - defaultStartHour)
    }

    var cols: CGFloat {
        isSaturdayShown ? 5 : 6
    }

    var startHour: Int {
        customStartHour ?? defaultStartHour
    }

    var endHour: Int {
        customEndHour ?? defaultEndHour
    }

    init(
        date: Date,
        events: [TimetableEventModel],
        customStartHour: Int? = nil,
        customEndHour: Int? = nil,
        isSaturdayShown: Bool = false
    ) {
        self.date = date
        self.customStartHour = customStartHour
        self.customEndHour = customEndHour
        self.isSaturdayShown = isSaturdayShown
        self.events = events
    }

}

extension TimetableModel {

    static func createDummyModel() -> TimetableModel {
        var events: [TimetableEventModel] = []

        for item in 0...20 {
            let dateComponents = DateComponents(
                year: 2025,
                month: 1,
                day: [19, 20, 21, 22, 23, 24].randomElement()!,
                hour: Int.random(in: 8...17),
                minute: [0, 15, 30, 45].randomElement()!
            )
            let date = Calendar.current.date(from: dateComponents)!
            debugPrint(date.debugDescription)

            events.append(
                TimetableEventModel(
                    id: String(item),
                    name: "Dummy text dummy text dummy text",
                    professor: "Drago Dragic",
                    eventType: .`classes`,
                    groups: "",
                    classroom: "C502",
                    start: date,
                    end: date.addingTimeInterval(3600),
                    description: "",
                    recurring: false,
                    recurringType: .undefined,
                    recurringUntil: .now,
                    studyCode: "GDV3728"
                )
            )
        }

        return TimetableModel(date: createRandomDate(), events: events)
    }

    private static func createRandomDate() -> Date {
        let dateComponents = DateComponents(
            year: 2025,
            month: 1,
            day: [19, 20, 21, 22, 23, 24].randomElement()!,
            hour: Int.random(in: 8...17),
            minute: [0, 15, 30, 45].randomElement()!
        )

        return Calendar.current.date(from: dateComponents)!
    }

}
