import Foundation

protocol ISettingsPresenter {
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func dataForCell(indexPath: IndexPath) -> String
    func titleForHeader(inSection section: Int) -> String
}

// relocate to model
private struct TableContent {
    
    let sectionData: [SectionData]
    
    init() {
        let themeRowType = RowData.theme(allCases: [.light, .dark])
        let themeSection = SectionData(title: Theme.title, rowData: themeRowType)
        self.sectionData = [themeSection]
    }
}

class SettingsPresenter: ISettingsPresenter {
    
    private weak var view: ISettingsView?
    private var tableContent = TableContent()
    
//    use typealias
    
    init(view: ISettingsView) {
        self.view = view
    }
    
    func numberOfSections() -> Int {
        return tableContent.sectionData.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        switch tableContent.sectionData[section].rowData {
        case .theme(let rows):
            return rows.count
        }
    }
    
    func titleForHeader(inSection section: Int) -> String {
        return tableContent.sectionData[section].title
    }
    
    func dataForCell(indexPath: IndexPath) -> String {
        switch tableContent.sectionData[indexPath.section].rowData {
        case .theme(let rows):
            let model = rows[indexPath.row].title
            return model
        }
    }
}

