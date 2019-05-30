import Foundation

protocol IEventMembersPresenter {
    func updateMembers()
    func getTitle() -> String
    func numberOfRows(isFiltered: Bool) -> Int
    func cellModel(forRowAt index: Int, isFiltered: Bool) -> MemberInformation
    func viewInitiated(with dataToShare: DataToShare)
    func checkboxStateChange(to state: Bool, forRow index: Int)
    func setPopupViewModel(forRowAt index: Int) -> PopupViewModel
    func searchBarFilter(textDidChange searchText: String?, scope: SearchScope)
}

class EventMembersPresenter: IEventMembersPresenter {
    
    private var model: EventMembersService
    private weak var view: IEventMemberView?
    
    private var membersList: [EventMemberCellModel] = []
    private var filteredMembersList: [EventMemberCellModel] = []
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
    
    func numberOfRows(isFiltered: Bool) -> Int {
        if isFiltered {
            return filteredMembersList.count
        } else {
            return membersList.count
        }
    }
    
    func cellModel(forRowAt index: Int, isFiltered: Bool) -> MemberInformation {
        if isFiltered {
            return MemberInformation(lastName: filteredMembersList[index].lastName, firstName: filteredMembersList[index].firstName, isVisited: filteredMembersList[index].isVisited)
        } else {
            return MemberInformation(lastName: membersList[index].lastName, firstName: membersList[index].firstName, isVisited: membersList[index].isVisited)
        }
    }
    
    
    func getTitle() -> String {
        return eventTitle ?? ""
    }
    
    func updateMembers() {
        getMembersList()
        
    }
    
    func checkboxStateChange(to state: Bool, forRow index: Int) {
        if state {
            model.confirmMembersVisit(withEventId: eventId ?? 106, memderId: membersList[index].id, memberState: state) { [weak self] (error) in
                if error == nil {
                    self?.membersList[index].changeMemberState(state: true)
                }
            }
        } else {
            view?.showAlert(withMsg: "You can't change the status of an already visited member", title: "Sorry")
            view?.returnActualCheckboxState(forCell: index)
        }
    }
    
    func setPopupViewModel(forRowAt index: Int) -> PopupViewModel {
        return PopupViewModel(model: membersList[index])
    }
    
    func searchBarFilter(textDidChange searchText: String?, scope: SearchScope) {
        filteredMembersList = membersList.filter { model -> Bool in
            switch scope {
            case .visited:
                if model.firstName.lowercased().contains((searchText ?? "").lowercased()) ||
                    model.lastName.lowercased().contains((searchText ?? "").lowercased()) {
                    return true
                } else {
                    return false
                }
            case .notVisited:
                if model.firstName.lowercased().contains((searchText ?? "").lowercased()) ||
                    model.lastName.lowercased().contains((searchText ?? "").lowercased()) {
                    return true
                } else {
                    return false
                }
            }
        }
        view?.setMembers()
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
