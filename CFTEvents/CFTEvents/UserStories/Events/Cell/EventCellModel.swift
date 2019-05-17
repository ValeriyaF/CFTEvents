import UIKit

struct EventCellModel {
    let title: String
    let description: String
    let date: String
    
    init(title: String, description: String, date: String) {
        self.title = title
        self.description = description
        self.date = date
    }
}
