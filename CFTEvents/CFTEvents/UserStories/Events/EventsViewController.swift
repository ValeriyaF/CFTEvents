import UIKit

class EventsViewController: UIViewController {
    var presenter: IEventsPresenter!

    private let tableView = UITableView(frame: .zero)
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    private let cellReuseID = "EventsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.updateEventsList()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        configureTableView()
        configureNavigationBarItem()
        configureActivityIndicator()
    }
    
    private func configureTableView() {
        tableView.register(EventCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.view)
        }
        
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
    }
    
    private func configureNavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NavBarItems.eventsTitle.rawValue // localize
        self.title = NavBarItems.eventsTitle.rawValue
    }
    
    private func configureActivityIndicator() {
        activityIndicator.snp.makeConstraints { make -> Void in
            make.bottom.top.equalTo(tableView)
            make.height.equalTo(tableView)
            make.width.equalTo(tableView)
        }
        
        activityIndicator.center = self.view.center
        activityIndicator.color = .red
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.updateEventsList()
    }
}

extension EventsViewController: IEventsView {
    func setCellImage(image: UIImage) {
        
    }
    
    func startLoad() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func setEvents() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventCell
        cell.configureLabels(with: presenter.cellModel(forRowAt: indexPath.row), index: indexPath.row)
        cell.configureImage(with: presenter.cellImage(forRowAt: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.eventsTableViewHeightForRow
    }

}

extension EventsViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        // right way to push data ???
        let vc = EventMembersViewController()
        vc.dataToShare = presenter.dataToShare(forRowAt: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

