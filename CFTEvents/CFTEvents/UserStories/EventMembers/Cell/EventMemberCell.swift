import UIKit
import M13Checkbox

class EventMemberCell: UITableViewCell {
    
    private let cellBackgroundView = UIImageView(frame: .zero)
    var checkbox = M13Checkbox(frame: .zero)
    var checkboxState: ((_ state: Bool) -> ())? = nil
    
    private let membersNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: DynamicFontSize.convertTextSize(30))
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureState(with model: MemberInformation, theme: Theme) {
        membersNameLabel.text = "\(model.firstName) \(model.lastName)"
        if model.isVisited {
            checkbox.setCheckState(.checked, animated: false)
        } else {
            checkbox.setCheckState(.unchecked, animated: false)
        }
        configureTheme(theme: theme)
    }
    
    private func configureTheme(theme: Theme) {
        self.backgroundColor = theme.backgroundColor
//        membersNameLabel.backgroundColor = theme.settingsCellBackgroundColor
        membersNameLabel.textColor = theme.settingsCellTextColor
        checkbox.backgroundColor = theme.settingsCellBackgroundColor
        
        switch theme {
        case .light:
            cellBackgroundView.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            cellBackgroundView.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForLightTheme")

        case .dark:
            cellBackgroundView.image = UIImage(named: "defaultCellBackgroundColorForDarkTheme")
            cellBackgroundView.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForDarkTheme")

        }
    }
    
    
    @IBAction private func checkboxValueChanged(_ sender: M13Checkbox) {
        if let checkboxAction = self.checkboxState {
            switch sender.checkState {
            case .checked:
                checkboxAction(true)
            case .mixed:
                checkboxAction(false)
            case .unchecked:
                checkboxAction(false)
            }
            
        }
    }
    
    private func configureSubviews() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(membersNameLabel)
        cellBackgroundView.addSubview(checkbox)
        
        cellBackgroundView.snp.makeConstraints { make -> Void in
            make.width.height.equalTo(self).offset(ViewConstants.cellEventMembersOffset)
            make.center.equalTo(self)
        }
        cellBackgroundView.layer.cornerRadius = ViewConstants.viewCornerRadius
        
        membersNameLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(7.0 / 8.0)
        }
        
        cellBackgroundView.addShadow(withOpacity: 0.3)
        checkbox.boxType = .square
        
        checkbox.addTarget(self, action: #selector(self.checkboxValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        checkbox.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.left.equalTo(membersNameLabel.snp.right).offset(25)
            make.right.equalToSuperview().offset(-5)
        }
    }
    
}
