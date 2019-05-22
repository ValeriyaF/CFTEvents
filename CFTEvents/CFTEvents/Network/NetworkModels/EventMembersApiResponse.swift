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
}
