import UIKit

struct EventCellModel {
    let title: String
    let description: String
    let startDate: String
    let cities: String
    
    init(event: Event) {
        self.title = event.title ?? ""
        self.description = event.description ?? ""
        self.startDate = event.date?.start ?? "" // DateFormatter later
        self.cities = event.cities?.compactMap { String($0?.nameEng ?? "") }.joined(separator: " ") ?? ""
    }
}
