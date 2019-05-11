import Foundation

enum Theme: Int {
    case light
    case dark
    
    var index: Int {
        switch self {
        case .light:
            return 0
        case .dark:
            return 1
        }
    }
    
    init(index: Int) {
        switch index {
        case 0:
            self = .light
        case 1:
            self = .dark
        default:
            self = .dark
        }
    }
}
