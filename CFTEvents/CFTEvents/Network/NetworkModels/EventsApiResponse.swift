import Foundation

typealias EventsApiResponse = [Event]?

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let cities: [City?]?
    let cardImage: String?
    let date: Date?
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil,
         cities: [City?]? = nil, cardImage: String? = nil, date: Date? = nil) {
            self.id = id
            self.title = title
            self.description = description
            self.cities = cities
            self.cardImage = cardImage
            self.date = date
    }
    
}

struct City: Codable {
    let nameEng: String?
}

struct Date: Codable {
    let start: String?
    let end: String?
}
