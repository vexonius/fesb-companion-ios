import CoreLocation

enum Restaurant: String {

    case kampus
    case fesb
    case efst
    case hostel
    case fgag

}

extension Restaurant {

    var name: String {
        switch self {
        case .kampus:
            "Kampus Menza"
        case .fesb:
            "FESB Menza"
        case .efst:
            "EFST fakultet"
        case .hostel:
            "Hostel Menza"
        case .fgag:
            "FGAG Menza"
        }
    }

    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .kampus:
            CLLocationCoordinate2D(latitude: 43.51183427752868, longitude: 16.466311284536662)
        case .fesb:
            CLLocationCoordinate2D(latitude: 43.5113706685734, longitude: 16.469120300582688)
        case .efst:
            CLLocationCoordinate2D(latitude: 43.51229054359121, longitude: 16.4672339547559)
        case .hostel:
            CLLocationCoordinate2D(latitude: 43.51183977571285, longitude: 16.46630941804453)
        case .fgag:
            CLLocationCoordinate2D(latitude: 43.510979586181435, longitude: 16.465558252975608)
        }
    }

}
