import UIKit

protocol IEventsView: class {
    func setEvents() // rename
    func startLoad() // rename
    func pushToEventMembersViewController(withSharedData data: DataToShare)
}
