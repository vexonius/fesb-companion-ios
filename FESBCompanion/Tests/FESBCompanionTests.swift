import Foundation
import XCTest
@testable import FESBCompanion

final class FESBCompanionTests: XCTestCase {

    func testGroupingTimetableEvents() {
        let eventGroupper = EventGrouper()

        let testModels = testModels
        let result = eventGroupper.groupOverlappingEventsEnhanced(testModels)

        dump(result)

        XCTAssert(result.count < testModels.count)
    }

}

private let testModels: [TimetableEventModel] = [
    TimetableEventModel(
        id: "CS101-001",
        name: "Introduction to Computer Science",
        professor: "Dr. Sarah Johnson",
        eventType: .classes,
        groups: "CS-1A, CS-1B",
        classroom: "Room A101",
        start: Date.from("2025-10-06 09:00"), // Monday 9:00 AM
        end: Date.from("2025-10-06 11:00"),   // Monday 11:00 AM
        description: "Fundamental concepts of computer science and programming",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS101"
    ),
    TimetableEventModel(
        id: "MATH201-001",
        name: "Mathematics for Computer Science",
        professor: "Prof. Michael Chen",
        eventType: .classes,
        groups: "CS-1A, MATH-2A",
        classroom: "Room B203",
        start: Date.from("2025-10-06 10:00"), // Overlaps with CS101
        end: Date.from("2025-10-06 12:00"),
        description: "Discrete mathematics and logic for computer science applications",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "MATH201"
    ),
    TimetableEventModel(
        id: "CS202-001",
        name: "Data Structures and Algorithms",
        professor: "Dr. Emily Rodriguez",
        eventType: .classes,
        groups: "CS-2A",
        classroom: "Room C301",
        start: Date.from("2025-10-07 14:00"), // Tuesday 2:00 PM
        end: Date.from("2025-10-07 16:00"),   // Tuesday 4:00 PM
        description: "Advanced data structures and algorithmic problem solving",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS202"
    ),
    TimetableEventModel(
        id: "CS101-LAB001",
        name: "Programming Lab Session",
        professor: "Dr. James Wilson",
        eventType: .classes,
        groups: "CS-1B, CS-1C",
        classroom: "Computer Lab 1",
        start: Date.from("2025-10-07 15:00"), // Overlaps with dataStructures
        end: Date.from("2025-10-07 17:00"),
        description: "Hands-on programming exercises and project work",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS101"
    ),
    TimetableEventModel(
        id: "CS202-SEM001",
        name: "Algorithms Discussion Seminar",
        professor: "Dr. Emily Rodriguez",
        eventType: .classes,
        groups: "CS-2A, CS-2B",
        classroom: "Room D105",
        start: Date.from("2025-10-07 15:30"), // Overlaps with both above
        end: Date.from("2025-10-07 16:30"),
        description: "Interactive discussion on algorithm design and analysis",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS202"
    ),
    TimetableEventModel(
        id: "CS301-001",
        name: "Database Systems",
        professor: "Prof. Anna Thompson",
        eventType: .classes,
        groups: "CS-3A",
        classroom: "Room E201",
        start: Date.from("2025-10-08 09:30"), // Wednesday 9:30 AM
        end: Date.from("2025-10-08 11:30"),   // Wednesday 11:30 AM
        description: "Relational database design and SQL programming",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS301"
    ),
    TimetableEventModel(
        id: "CS302-001",
        name: "Software Engineering Principles",
        professor: "Dr. Robert Kim",
        eventType: .classes,
        groups: "CS-3A, CS-3B",
        classroom: "Room F302",
        start: Date.from("2025-10-08 11:00"), // 30-minute overlap with database
        end: Date.from("2025-10-08 13:00"),
        description: "Software development lifecycle and project management",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "CS302"
    ),
    TimetableEventModel(
        id: "CS101-EXAM001",
        name: "CS101 Midterm Examination",
        professor: "Dr. Sarah Johnson",
        eventType: .classes,
        groups: "CS-1A, CS-1B, CS-1C",
        classroom: "Main Hall",
        start: Date.from("2025-10-10 10:00"), // Friday 10:00 AM
        end: Date.from("2025-10-10 12:00"),   // Friday 12:00 PM
        description: "Midterm examination covering chapters 1-5",
        recurring: false,
        recurringType: .everyWeek,
        recurringUntil: nil,
        studyCode: "CS101"
    ),
    TimetableEventModel(
        id: "MATH201-TUT001",
        name: "Mathematics Tutorial Session",
        professor: "Teaching Assistant Alex Brown",
        eventType: .classes,
        groups: "MATH-2A, CS-1A",
        classroom: "Room I201",
        start: Date.from("2025-10-10 11:00"), // 1-hour overlap with exam
        end: Date.from("2025-10-10 13:00"),
        description: "Extra help session for mathematics concepts",
        recurring: true,
        recurringType: .everyWeek,
        recurringUntil: Date.from("2025-12-15 23:59"),
        studyCode: "MATH201"
    )
]

import Foundation

// Extension for Date to create dates from readable strings
extension Date {
    static func from(_ dateString: String, format: String = "yyyy-MM-dd HH:mm") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX") // Use POSIX for reliable parsing
        return formatter.date(from: dateString) ?? Date()
    }
}
