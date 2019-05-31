import Foundation

protocol IEventMemberView: class {
    func setMembers()
    func showAlert(withMsg msg: String, title: String)
    func returnActualCheckboxState(forCell index: Int)
}
