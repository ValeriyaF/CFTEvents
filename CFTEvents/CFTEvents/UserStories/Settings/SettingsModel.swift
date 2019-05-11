import Foundation

struct SectionData {
    let title: String
    let rowData: RowType
}

enum RowType {
    case theme(allCases: [Theme])
}

extension Theme {
    static let title = "THEME:"
    var title: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"

        }
    }
}


