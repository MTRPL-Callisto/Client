import Foundation

struct CategoryInfo: Codable {
    let categoryName: String
    let info: String
    let recyclingPoints: [RecyclingPoint]?
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case info
        case recyclingPoints = "recycling_points"
    }
}

struct RecyclingPoint: Codable {
    let name: String
    let coordinate: Coordinate
}

struct Coordinate: Codable {
    let latitude: Float
    let longitude: Float
}
