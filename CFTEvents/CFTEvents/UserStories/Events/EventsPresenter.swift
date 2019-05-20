import UIKit

protocol IEventsPresenter {
    func numberOfRows() -> Int
    func cellModel(forRowAt index: Int) -> EventCellModel
    func cellImage(forRowAt index: Int) -> UIImage?
    func updateEventsList()
}

class EventsPresenter: IEventsPresenter {

    let model: EventsModel
    private weak var view: IEventsView?
    
    private var eventsList: Response = []
    private var image: UIImage?
    
    init(model: EventsModel, view: IEventsView) {
        self.model = model
        self.view = view
    }

    func numberOfRows() -> Int {
        print("count of events = \(eventsList?.count ?? -1)")
        return eventsList?.count ?? 0
    }
    
    func cellModel(forRowAt index: Int) -> EventCellModel {
        return EventCellModel(event: eventsList?[index] ?? Event())
    }
    
    func updateEventsList() {
        getEvents()
    }
    
    func cellImage(forRowAt index: Int) -> UIImage? {
        model.getImage(for: index) { (image, url) in
            self.initImage(with: image ?? nil)
        }
        return self.image
    }
    
    
    private func getEvents() {
        view?.startLoad()
        model.getData() { data, url in
            self.initEventsList(with: data)
            DispatchQueue.main.async {
                self.view?.setEvents()
            }
        }
    }
    
    private func initEventsList(with data: Response) {
        self.eventsList = data
    }
    
    private func initImage(with image: UIImage?) {
        self.image = image
    }
}
