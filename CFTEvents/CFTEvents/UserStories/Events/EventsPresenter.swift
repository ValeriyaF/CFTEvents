import UIKit

protocol IEventsPresenter {
    func numberOfRows() -> Int
    func cellModelFor(indexPath: IndexPath) -> EventCellModel
    func loadImageFor(indexPath: IndexPath)
    func currentImage() -> UIImage?
    func loadEvents()
}

class EventsPresenter: IEventsPresenter {

    
    let model: EventsModel
    private weak var view: IEventsView?
    private var events: Response = []
    private var image: UIImage?
    
    init(model: EventsModel, view: IEventsView) {
        self.model = model
        self.view = view
    }

    func numberOfRows() -> Int {
        print("count of events = \(events?.count ?? -1)")
        return events?.count ?? 0
    }
    
    func cellModelFor(indexPath: IndexPath) -> EventCellModel {
        return EventCellModel(event: events?[indexPath.row] ?? Event())
    }
    
    func loadImageFor(indexPath: IndexPath) {
        model.getImage(indexPath: indexPath) { image, url in
            self.initImage(with: image ?? nil)
        }
    }
    
    func loadEvents() {
        view?.startLoad()
        model.getData() { data, url in
            self.initEvents(with: data)
            DispatchQueue.main.async {
                self.view?.setEvents()
            }
        }
    }
    
    func currentImage() -> UIImage? {
        return self.image
    }
    
    private func initEvents(with data: Response) {
        self.events = data
    }
    
    private func initImage(with image: UIImage?) {
        self.image = image
    }
}
