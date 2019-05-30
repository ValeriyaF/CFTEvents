import Foundation

protocol IEventsPresenter {
    func numberOfRows() -> Int
    func cellModel(forRowAt index: Int) -> EventCellModel
    func cellImage(forRowAt index: Int) -> URL?
    func updateEventsList()
    func didSelectedTableViewCell(index: Int)
}

class EventsPresenter: IEventsPresenter {
    
    private let model: EventsService
    private weak var view: IEventsView?
    
    private var eventsList: [EventCellModel] = []
    
    init(model: EventsService, view: IEventsView) {
        self.model = model
        self.view = view
    }

    func numberOfRows() -> Int {
        print("count of events = \(eventsList.count)")
        return eventsList.count
    }
    
    func cellModel(forRowAt index: Int) -> EventCellModel {
        return eventsList[index]
    }
    
    func updateEventsList() {
        getEvents()
    }
    
    func cellImage(forRowAt index: Int) -> URL? {
        return model.getCurrentImageUrl(for: index)
    }
    
    func didSelectedTableViewCell(index: Int) {
        view?.pushToEventMembersViewController(withSharedData:
            DataToShare(id: eventsList[index].id, title: eventsList[index].title))
    }
    
}

private extension EventsPresenter {
    func initEventsList(with data: EventsApiResponse) {
        self.eventsList = data?.compactMap { EventCellModel(event: $0) } ?? []
    }
    
    func getEvents() {
        view?.startLoad()
        model.getData() { [weak self] data in
            if let data = data {
                self?.initEventsList(with: data)
            }
            DispatchQueue.main.async {
                self?.view?.setEvents()
            }
        }
    }
}
