import shared

extension TimetableEventModel {

    init(from model: EventResponse) {
        self.init(
            id: model.id,
            name: model.name,
            professor: model.professor,
            eventType: TimetableType(from: model.eventType),
            groups: model.groups,
            classroom: model.classroom,
            start: model.start.toDate() ?? .now, // TODO: Decide strategy parsing incorrect date
            end: model.end.toDate() ?? .now,
            description: model.description,
            recurring: model.recurring,
            recurringType: Recurring(from: model.recurringType),
            recurringUntil: model.recurringUntil.toDate(),
            studyCode: model.studyCode
        )
    }

}
