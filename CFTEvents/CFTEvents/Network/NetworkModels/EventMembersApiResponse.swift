import Foundation

typealias EventMembersApiResponse = [Member]?

struct Member: Codable {
    let id: Int?
    let phone: String?
    let company: String?
    let registeredDate: String?
    let isVisited: Bool?
    let lastName: String?
    let firstName: String?
    
    init(id: Int? = nil, phone: String? = nil, company: String? = nil, registeredDate: String? = nil, isVisited: Bool? = nil, lastName: String? = nil, firstName: String? = nil) {
        self.id = id
        self.phone = phone
        self.company = company
        self.registeredDate = registeredDate
        self.isVisited = isVisited
        self.lastName = lastName
        self.firstName = firstName
    }
}
