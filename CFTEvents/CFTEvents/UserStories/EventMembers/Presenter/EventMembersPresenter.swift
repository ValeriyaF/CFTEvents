import Foundation

protocol IEventMembersPresenter {
    func getTitle() -> String
    func numberOfRows() -> Int
    func cellModel(forRowAt index: Int) -> MemberImformation
    func viewInitiated(with dataToShare: DataToShare)
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
    
    func cellModel(forRowAt index: Int) -> MemberImformation {
        return MemberImformation(lastName: membersList[index].lastName, firstName: membersList[index].firstName, isVisited: membersList[index].isVisited)
    }
    
    
    func getTitle() -> String {
        return eventTitle ?? ""
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
