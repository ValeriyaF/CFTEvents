import UIKit

struct PopupViewModel {
    let firstName: String
    let lastName: String
    let patronymic: String
    let phone: String
    let email: String
    let company: String
    let position: String
    let registeredDate: String
    
    init(model: EventMemberCellModel) {
        self.phone = model.phone
        self.email = model.email
        self.company = model.company
        self.position = model.position
        self.registeredDate = model.registeredDate
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.patronymic = model.patronymic
    }
}

fileprivate enum InfoLabels: String {
    case phone = "Phone:"
    case email = "Email:"
    case company = "Company:"
    case position = "Position:"
    case registeredDate = "Registered date:"
}

extension InfoLabels: CaseIterable { }

class MemberInfoPopupViewController: UIViewController {
    
    var model: PopupViewModel!
    
    private let memberInfoView = UIView(frame: .zero)
    
    private var infoLabelsDict: [String: UILabel] = [:]
    
    private lazy var labelsStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var infoStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    private let fullNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: DynamicFontSize.convertTextSize(30))
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        return label
    }()
    
    var memberInfoViewDidDisappear: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        memberInfoView.backgroundColor = .lightGray
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureMemberInfoView()
        configureLabelsStackView()
        configureinfoStackView()
        configureViewLabels(withModel: model)
    }
    
     private func configureViewLabels(withModel model: PopupViewModel) {
        fullNameLabel.text = "\(model.firstName) \(model.lastName) \(model.patronymic)"
        infoLabelsDict[InfoLabels.phone.rawValue]?.text = model.phone
        infoLabelsDict[InfoLabels.email.rawValue]?.text = model.email
        infoLabelsDict[InfoLabels.company.rawValue]?.text = model.company
        infoLabelsDict[InfoLabels.position.rawValue]?.text = model.position
    }
    
    private func configureMemberInfoView() {
        self.view.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.bottom.equalToSuperview().offset(-150)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        memberInfoView.layer.cornerRadius = ViewConstants.viewCornerRadius
        
        let action = #selector(tapOnBG)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    private func configureLabelsStackView() {
        memberInfoView.addSubview(fullNameLabel)
        memberInfoView.addSubview(labelsStackView)
        
//        labelsStackView.addBackground(color: .red)
//        infoStackView.addBackground(color: .yellow)
        fullNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(14.0 / 15.0)
            make.height.equalToSuperview().multipliedBy(1.0 / 9.0)
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0 / 4.0)
            make.height.equalToSuperview().multipliedBy(1.0 / 2.0)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(10)
            make.left.equalTo(fullNameLabel.snp.left).multipliedBy(2)
        }
        
        
        InfoLabels.allCases.forEach { labelName in
            let lbl = UILabel(frame: .zero)
            lbl.text = labelName.rawValue
            lbl.textAlignment = .left
            lbl.font = UIFont.boldSystemFont(ofSize: DynamicFontSize.convertTextSize(20))
            lbl.translatesAutoresizingMaskIntoConstraints = false
            labelsStackView.addArrangedSubview(lbl)
        }
    }
    
    private func configureinfoStackView() {
        memberInfoView.addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.height.equalTo(labelsStackView)
            make.right.equalToSuperview()
            make.left.equalTo(labelsStackView.snp.right).offset(20)
            make.top.equalTo(labelsStackView)
        }
        
        InfoLabels.allCases.forEach { labelName in
            let label = generateInfoLabel()
            infoLabelsDict[labelName.rawValue] = label
            infoStackView.addArrangedSubview(label)
        }
    }
    
    private func generateInfoLabel() -> UILabel {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: DynamicFontSize.convertTextSize(20))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    @IBAction private func tapOnBG(_ sender: UIViewController) {
        self.dismiss(animated: true, completion: nil)
        
        if let action = self.memberInfoViewDidDisappear {
            action()
        }
    }
    
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
