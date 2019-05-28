import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    var presenter: ISettingsPresenter!
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let cellReuseID = "SettingsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        
        configureTableView()
        configurenavigationBarItem()
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
        cell.configureCell(with: presenter.dataForCell(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48 // add consts
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22 // add consts
    }
}

extension SettingsViewController: UITableViewDelegate { }

