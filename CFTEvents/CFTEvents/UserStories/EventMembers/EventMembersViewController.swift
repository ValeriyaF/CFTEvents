import UIKit


enum SearchScope: Int {
    case visited
    case notVisited
}

fileprivate extension SearchScope {
    var title: String {
        switch self {
        case .visited:
            return "Visited"
        case .notVisited:
            return "Not visited"
        }
    }
}

struct DataToShare {
    let eventId: Int?
    let eventTitle: String?
    init(id eventId: Int, title eventTitle: String) {
        self.eventId = eventId
        self.eventTitle = eventTitle
    }
    
    init(eventId: Int? = nil, eventTitle: String? = nil) {
        self.eventId = eventId
        self.eventTitle = eventTitle
    }
}

class EventMembersViewController: UIViewController {
    
    var presenter: IEventMembersPresenter!
    
    private let preferences = Preferences()
    
    internal var dataToShare: DataToShare = DataToShare()
    private let cellReuseID = "EventMemberCell"
    
    private let tableView = UITableView(frame: .zero)
    private let blurEffectView = UIVisualEffectView(effect: nil)
    private let searchController = UISearchController(searchResultsController: nil)
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    private var isSearchActive = false {
        didSet {
            if isSearchActive == oldValue {
                return
            }
            if isSearchActive {
                refreshControl.removeFromSuperview()
            } else {
                tableView.addSubview(refreshControl)
                if presenter.numberOfRows(isFiltered: false) > 0 { // ???
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInitiated(with: dataToShare)
        subscribeOnThemeChange()
        configureView()
    }
    
    private func applyTheme() {
        tableView.backgroundView = nil
        tableView.backgroundColor = preferences.selectedTheme.backgroundColor
        tableView.separatorColor = preferences.selectedTheme.separatorColor
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] _ in
            self?.applyTheme()
            self?.tableView.reloadData()
        }
    }
    
    private func configureView() {
        view.addSubview(tableView)
        configureTableView()
        configureNavigationBarItem()
        configureSearchController()
    }
    
    private func configureTableView() {
        tableView.register(EventMemberCell.self, forCellReuseIdentifier: cellReuseID)
        
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
        self.navigationItem.title = presenter.getTitle() // localize
        self.title = presenter.getTitle() // presenter ???
    }
    
    private func configureSearchController() {
        searchController.searchBar.scopeButtonTitles = [SearchScope.visited.title, SearchScope.notVisited.title]
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
    }
    
    private func addBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        self.blurEffectView.effect = blurEffect
        blurEffectView.alpha = 0.4
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
    }
    
    
    @IBAction private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.updateMembers()
    }
    
}

extension EventMembersViewController: IEventMemberView {
    func setMembers() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func showAlert(withMsg msg: String, title: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func returnActualCheckboxState(forCell index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension EventMembersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(isFiltered: isSearchActive)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventMemberCell
        cell.configureState(with: presenter.cellModel(forRowAt: indexPath.row, isFiltered: isSearchActive), theme: preferences.selectedTheme)
        cell.checkboxState = { state in
            self.presenter.checkboxStateChange(to: state, forRow: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.eventMembersTableViewHeightForRow
    }
}

extension EventMembersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let ratingVC = MemberInfoPopupViewController(nibName: nil, bundle: nil)
        ratingVC.model = presenter.setPopupViewModel(forRowAt: indexPath.row)
        addBlurEffectView()
        ratingVC.modalPresentationStyle = .overCurrentContext
        self.present(ratingVC, animated: true, completion: nil)
        
        ratingVC.memberInfoViewDidDisappear = {
            self.blurEffectView.removeFromSuperview()
        }
    }
}
//      SearchBar
extension EventMembersViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let scope = SearchScope(rawValue: searchBar.selectedScopeButtonIndex) else {
            return
        }
        presenter.searchBarFilter(textDidChange: searchBar.text, scope: scope)
    }
}

extension EventMembersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let scope = SearchScope(rawValue: searchBar.selectedScopeButtonIndex) else {
            return
        }
        presenter.searchBarFilter(textDidChange: searchBar.text, scope: scope)
    }
    
    
}
