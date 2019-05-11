import UIKit

class SettingsCell: UITableViewCell {
    
    private var cellLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(with name: String) {
        cellLabel.text = name
    }
    
    
    private func configureSubviews() {
        
//        self.backgroundColor = .lightGray
        
        self.addSubview(cellLabel)
        
        
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5).isActive = true
        cellLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25).isActive = true
        cellLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 5).isActive = true
        
    }
    
}
