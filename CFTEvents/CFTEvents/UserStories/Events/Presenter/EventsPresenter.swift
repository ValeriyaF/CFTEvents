import UIKit

protocol IEventsPresenter {
    func numberOfRows() -> Int
    func cellModel(forRowAt index: Int) -> EventCellModel
    func cellImage(forRowAt index: Int) -> UIImage?
    func updateEventsList()
    func didSelectedTableViewCell(index: Int)
}

class EventsPresenter: IEventsPresenter {

    
    private let model: EventsService
    private weak var view: IEventsView?
    
    private var eventsList: [EventCellModel] = []
    
    private var image: UIImage?
    
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
    
    func cellImage(forRowAt index: Int) -> UIImage? {
        model.getImage(for: index) { [weak self] (image, url) in
            self?.initImage(with: image ?? nil)
//            self.view.reload
        }
        return self.image
    }
    
    func didSelectedTableViewCell(index: Int) {
        view?.pushToEventMembersViewController(withSharedData:
            DataToShare(id: eventsList[index].id, title: eventsList[index].title))
    }
    
    private func getEvents() {
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
    
    private func initEventsList(with data: EventsApiResponse) {
            let newData = data?.compactMap { elenent in
            EventCellModel(event: elenent)
        }
        self.eventsList = data?.compactMap { EventCellModel(event: $0) } ?? []
    }
    
    private func initImage(with image: UIImage?) {
        self.image = image
    }
}
