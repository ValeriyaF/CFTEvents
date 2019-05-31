import UIKit

class EventsViewController: UIViewController {
    var presenter: IEventsPresenter!
    
    private let tableView = UITableView(frame: .zero)
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    private let preferences = Preferences()
    private let cellReuseID = "EventsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeOnThemeChange()
        configureView()
        applyTheme()
        presenter.updateEventsList()
    }
    
}

private extension EventsViewController {
    
    func applyTheme() {
        tableView.backgroundView = nil
        tableView.backgroundColor = preferences.selectedTheme.backgroundColor
        tableView.separatorColor = preferences.selectedTheme.separatorColor
    }
    
    func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] _ in
            self?.applyTheme()
            self?.tableView.reloadData()
        }
        
    }
    
    func configureView() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        configureTableView()
        configureNavigationBarItem()
        configureActivityIndicator()
    }
    
    func configureTableView() {
        tableView.register(EventCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.view)
        }
        
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
    }
    
    func configureNavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NavBarItems.eventsTitle.rawValue // localize
        self.title = NavBarItems.eventsTitle.rawValue
        
    }
    
    func configureActivityIndicator() {
        activityIndicator.snp.makeConstraints { make -> Void in
            make.bottom.top.equalTo(tableView)
            make.height.equalTo(tableView)
            make.width.equalTo(tableView)
        }
        
        activityIndicator.center = self.view.center
        activityIndicator.color = .red
    }
    
    @objc  func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.updateEventsList()
    }
}
extension EventsViewController: IEventsView {
    func startLoad() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func setEvents() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func pushToEventMembersViewController(withSharedData data: DataToShare) {
        let eventsMembersVC = Assembly.eventMembersViewController()
        eventsMembersVC.dataToShare = data
        navigationController?.pushViewController(eventsMembersVC, animated: true)
    }
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventCell
        cell.configureLabels(with: presenter.cellModel(forRowAt: indexPath.row), theme: preferences.selectedTheme)
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
        presenter.didSelectedTableViewCell(index: indexPath.row)
    }
}


