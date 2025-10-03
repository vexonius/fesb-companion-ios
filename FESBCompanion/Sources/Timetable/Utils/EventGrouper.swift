import Foundation

class EventGrouper {

    func groupOverlappingEventsEnhanced(_ events: [TimetableEventModel]) -> [String: [TimetableEventModel]] {
        guard !events.isEmpty else { return [:] }

        let unionFind = UnionFind(size: events.count)

        for index in 0..<events.count {
            for secondIndex in (index + 1)..<events.count where events[index].overlaps(with: events[secondIndex]) {
                unionFind.union(index, secondIndex)
            }
        }

        dump(events)

        let eventGroups = Dictionary(grouping: events.enumerated()) { index, _ in
            "Group_\(unionFind.find(index))"
        }

        return eventGroups.mapValues { $0.map(\.element) }
    }

}

private class UnionFind {

    private var parent: [Int]
    private var rank: [Int]

    init(size: Int) {
        parent = Array(0..<size)
        rank = Array(repeating: 0, count: size)
    }

    func find(_ x: Int) -> Int { // swiftlint:disable:this identifier_name
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) { // swiftlint:disable:this identifier_name
        let rootX = find(x)
        let rootY = find(y)

        if rootX != rootY {
            if rank[rootX] < rank[rootY] {
                parent[rootX] = rootY
            } else if rank[rootX] > rank[rootY] {
                parent[rootY] = rootX
            } else {
                parent[rootY] = rootX
                rank[rootX] += 1
            }
        }
    }

    func getGroups(for events: [TimetableEventModel]) -> [String: [TimetableEventModel]] {
        var groups: [Int: [TimetableEventModel]] = [:]

        for (index, event) in events.enumerated() {
            let root = find(index)
            groups[root, default: []].append(event)
        }

        return Dictionary(grouping: groups.values.enumerated().flatMap { groupIndex, events in
            events.map { (event: $0, groupId: "Group_\(groupIndex)") }
        }, by: { $0.groupId }).mapValues { $0.map(\.event) }
    }

}
