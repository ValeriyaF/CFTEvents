import Foundation

struct EventMemberCellModel {
    let id: Int
    let phone: String
    let company: String
    let registeredDate: String
    let isVisited: Bool
    let lastName: String
    let firstName: String
    
    init(member: Member) {
        self.id = member.id ?? 0
        self.phone = member.phone ?? ""
        self.company = member.company ?? ""
        self.registeredDate = member.registeredDate ?? ""
        self.isVisited = member.isVisited ?? false
        self.lastName = member.lastName ?? ""
        self.firstName = member.firstName ?? ""
    }
}
