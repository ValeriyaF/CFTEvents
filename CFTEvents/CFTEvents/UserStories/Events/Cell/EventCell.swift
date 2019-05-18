import UIKit
import SnapKit

class EventCell: UITableViewCell {
    private let cardImageView: UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        return imgView
    } ()
    
    private let descriptionLabel: UILabel = {
        let dLabel = UILabel(frame: .zero)
        dLabel.backgroundColor = .red
        dLabel.layer.masksToBounds = true
        return dLabel
    }()
    
    private let titleLabel: UILabel = {
        let tLabel = UILabel(frame: .zero)
        tLabel.backgroundColor = .yellow
        tLabel.layer.masksToBounds = true
        return tLabel
    }()
    
    private let dateLabel = UILabel(frame: .zero)
    private let cityLabel = UILabel(frame: .zero)
    private let roundView = UIView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureSubviews() {
        addSubview(roundView)
        addSubview(cardImageView)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(cityLabel)
        addSubview(titleLabel)
        
        configureRoundView()
        configureDescriptionLabel()
        configureTitleLabel()
    }
    
    private func configureRoundView() {
        roundView.translatesAutoresizingMaskIntoConstraints = false
        // how to replace magic numbers
        roundView.widthAnchor.constraint(equalToConstant: 750).isActive = true
        roundView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        roundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        roundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        roundView.layer.cornerRadius = ViewConstants.viewCornerRadius
        roundView.backgroundColor = .lightGray
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: roundView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: roundView.rightAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: roundView.bottomAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: roundView.topAnchor, constant: ViewConstants.eventCellDescriptionLabel).isActive = true
        descriptionLabel.layer.cornerRadius = ViewConstants.viewCornerRadius
    }
    
    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 50).isActive = true
        
        
    }
}
