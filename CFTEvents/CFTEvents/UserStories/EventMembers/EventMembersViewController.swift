import UIKit

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
    
    internal var dataToShare: DataToShare = DataToShare()
    private let cellReuseID = "EventMemberCell"
    
    private let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInitiated(with: dataToShare)
        configureView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        
        configureTableView()
        configureNavigationBarItem()
    }
    
    private func configureTableView() {
        tableView.register(EventMemberCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self.view)
        }
        
        tableView.separatorStyle = .none
    }
    
    private func configureNavigationBarItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = presenter.getTitle() // localize
        self.title = presenter.getTitle() // presenter ???
    }

    
}

extension EventMembersViewController: IEventMemberView {
    func setMembers() {
        tableView.reloadData()
    }
}

extension EventMembersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! EventMemberCell
        cell.configureState(with: presenter.cellModel(forRowAt: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.eventMembersTableViewHeightForRow
    }
}

extension EventMembersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
