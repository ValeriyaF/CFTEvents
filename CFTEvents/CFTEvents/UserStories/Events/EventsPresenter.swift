import Foundation

protocol IEventsPresenter {
    func numberOfRows() -> Int
    func loadEvents()
}

class EventsPresenter: IEventsPresenter {
    let model: EventsModel
    private weak var view: IEventsView?
    private var events: Events = []
    
    init(model: EventsModel, view: IEventsView) {
        self.model = model
        self.view = view
    }

    func numberOfRows() -> Int {
        print("count of events = \(events?.count ?? -1)")
        return events?.count ?? 0
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
    
    private func initEvents(with data: Events) {
        self.events = data
    }

    
}
