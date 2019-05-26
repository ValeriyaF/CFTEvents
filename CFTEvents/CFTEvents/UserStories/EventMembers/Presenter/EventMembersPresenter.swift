import Foundation

protocol IEventMembersPresenter {
    func updateMembers()
    func getTitle() -> String
    func numberOfRows() -> Int
    func cellModel(forRowAt index: Int) -> MemberInformation
    func viewInitiated(with dataToShare: DataToShare)
    func checkboxStateChange(to state: Bool, forRow index: Int)
//    func searchBarFilter(textDidChange searchText: String?, scope: SearchScope)
}

class EventMembersPresenter: IEventMembersPresenter {
    
    private var model: EventMembersService
    private weak var view: IEventMemberView?
    
    private var membersList: [EventMemberCellModel] = []
    private var eventTitle: String?
    private var eventId: Int?
    
    init(model: EventMembersService, view: IEventMemberView) {
        self.model = model
        self.view = view
    }
    
    func viewInitiated(with dataToShare: DataToShare) {
        
        model.testLoadML()
        if AppConfig.isDebug {
            self.eventId = 106
        } else {
            self.eventId = dataToShare.eventId
        }
        
        self.eventTitle = dataToShare.eventTitle

        getMembersList()
    }
    
    func numberOfRows() -> Int {
        return membersList.count
    }
    
    func cellModel(forRowAt index: Int) -> MemberInformation {
        return MemberInformation(lastName: membersList[index].lastName, firstName: membersList[index].firstName, isVisited: membersList[index].isVisited)
    }
    
    
    func getTitle() -> String {
        return eventTitle ?? ""
    }
    
    func updateMembers() {
        getMembersList()
        
    }
    
    func checkboxStateChange(to state: Bool, forRow index: Int) {
        model.confirmMembersVisit(withEventId: eventId ?? 106, memderId: membersList[index].id, memberState: state) { (str) in
            print(str)
        }
    }
    
    private func getMembersList() {
        model.loadMembersList(withEventId: eventId ?? 0) { [weak self] (data) in
            self?.membersList = data?.compactMap { EventMemberCellModel(member: $0) } ?? []
            DispatchQueue.main.async {
                self?.view?.setMembers()
            }
        }
    }

}
