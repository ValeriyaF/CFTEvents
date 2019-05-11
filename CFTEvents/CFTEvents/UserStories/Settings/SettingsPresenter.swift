import Foundation

protocol ISettingsPresenter {
    func numberOfSections() -> Int
    func numberOrRows(inSection section: Int) -> Int
    func dataForCell(indexPath: IndexPath) -> String
    func titleForHeader(inSection section: Int) -> String
}

private struct TableData {
    
    let data: [SectionData]
    
    init() {
        let themeRowType = RowType.theme(allCases: [.light, .dark])
        let themeSection = SectionData(title: Theme.title, rowData: themeRowType)
        self.data = [themeSection]
    }
}

class SettingsPresenter: ISettingsPresenter {
    
    private weak var view: ISettingsView?
    private lazy var tableData = TableData()
    
    init(view: ISettingsView) {
        self.view = view
    }
    
    func numberOfSections() -> Int {
        return tableData.data.count
    }
    
    func numberOrRows(inSection section: Int) -> Int {
        switch tableData.data[section].rowData {
        case .theme(let rows):
            return rows.count
        }
    }
    
    func titleForHeader(inSection section: Int) -> String {
        return tableData.data[section].title
    }
    
    func dataForCell(indexPath: IndexPath) -> String {
        switch tableData.data[indexPath.section].rowData {
        case .theme(let rows):
            let model = rows[indexPath.row].title
            return model
        }
    }
}

