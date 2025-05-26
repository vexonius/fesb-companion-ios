import shared

extension AttendanceItem {

    init(from model: AttendanceItemResponse) {
        id = model.id
        `class` = model.class_
        type = model.type
        attended = Int(model.attended)
        absent = Int(model.absent)
        required = Int(model.required)
        semester = Int(model.semester)
        total = Int(model.total)
    }

}
