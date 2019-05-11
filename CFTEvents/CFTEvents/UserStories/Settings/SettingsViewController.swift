import UIKit

private enum Consts {

}

private struct TableData {
    
    let data: [SectionData]
    
    init() {
        let themeRowType = RowType.theme(allCases: [.light, .dark])
        let themeSection = SectionData(title: Theme.title, rowData: themeRowType)
        self.data = [themeSection]
    }
}


class SettingsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private lazy var tableData = TableData()
    private let cellReuseID = "SettingsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellReuseID) // relocate
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    private func configurenavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NavBarItems.settingsTitle.rawValue // localize
        self.title = NavBarItems.settingsTitle.rawValue
        
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableData.data[section].rowData {
        case .theme(let rows):
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData.data[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! SettingsCell
        
        switch tableData.data[indexPath.section].rowData {
        case .theme(let rows):
            let model = rows[indexPath.row].title
            cell.configureCell(with: model)
            //            cell.configure(with: model, theme: preferences.selectedTheme ?? .light) // add presenter
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
}

extension SettingsViewController: UITableViewDelegate { }

