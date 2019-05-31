import Foundation

typealias EventMembersApiResponse = [Member]?

struct Member: Codable {
    let id: Int?
    let phone: String?
    let city: String?
    let company: String?
    let position: String?
    let registeredDate: String?
    let isVisited: Bool?
    let lastName: String?
    let firstName: String?
    let patronymic: String?
    let email: String?
    
    init(id: Int? = nil, phone: String? = nil, city: String? = nil, company: String? = nil, position: String? = nil, registeredDate: String? = nil, isVisited: Bool? = nil, lastName: String? = nil, firstName: String? = nil, patronymic: String? = nil, email: String? = nil) {
        
        self.id = id
        self.phone = phone
        self.city = city
        self.company = company
        self.position = position
        self.registeredDate = registeredDate
        self.isVisited = isVisited
        self.lastName = lastName
        self.firstName = firstName
        self.patronymic = patronymic
        self.email = email
    }
}
