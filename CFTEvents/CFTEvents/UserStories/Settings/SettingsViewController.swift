import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    var presenter: ISettingsPresenter!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var selectedTheme = Theme.light
    private let cellReuseID = "SettingsCell"
    private let preferences = Preferences()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        
        subscribeOnThemeChange()
        configureTableView()
        configurenavigationBarItem()
        applyTheme()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] _ in
            self?.applyTheme()
            self?.tableView.reloadData()
        }
    }
    
    private func applyTheme() {
            tableView.backgroundView = nil
            tableView.backgroundColor = preferences.selectedTheme.backgroundColor
            tableView.separatorColor = preferences.selectedTheme.separatorColor
            selectedTheme = preferences.selectedTheme
    }
    
    private func configureTableView() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellReuseID)

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { (tableView) -> Void in
            tableView.width.height.equalTo(self.view)
            tableView.height.equalTo(self.view)
            tableView.center.equalTo(self.view)
        }
    }
    
    private func configurenavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NavBarItems.settingsTitle.rawValue // localize
        self.title = NavBarItems.settingsTitle.rawValue
    }
    
}

extension SettingsViewController: ISettingsView { }

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeader(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! SettingsCell
        switch presenter.rowData(indexPath: indexPath) {
        case .theme:
            cell.configureCell(with: presenter.dataForCell(indexPath: indexPath), theme: preferences.selectedTheme)
            if selectedTheme.index == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
//
//        cell.tintColor = UIColor.red
//        cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.eventMembersTableViewHeightForRow
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch presenter.rowData(indexPath: indexPath) {
        case .theme:
            let prevCell = tableView.cellForRow(
                at: IndexPath(row: selectedTheme.index, section: indexPath.section))
            prevCell?.accessoryType = .none
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            
            selectedTheme = Theme(index: indexPath.row)
            preferences.selectedTheme = selectedTheme
        }
    }
}

