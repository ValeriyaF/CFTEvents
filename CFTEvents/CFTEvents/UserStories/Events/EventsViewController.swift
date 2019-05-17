import UIKit

class EventsViewController: UIViewController {
    var presenter: IEventsPresenter!

    private let tableView = UITableView(frame: .zero)
    private let activityIndicator = UIActivityIndicatorView(frame: .zero) // do not work
    
//    private lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(
//            self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
//        return refreshControl
//    }()
    
    private let cellReuseID = "EventsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.loadEvents()
//        configureView()
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    private func configureNavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = NavBarItems.eventsTitle.rawValue // localize
        self.title = NavBarItems.eventsTitle.rawValue
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.view.center
    }
}

extension EventsViewController: IEventsView {
    func startLoad() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func setEvents() {
        tableView.reloadData()
    }
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventCell
        cell.textLabel?.text = "text"
        return cell
    }
}

extension EventsViewController: UITableViewDelegate {}

