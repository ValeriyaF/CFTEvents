import UIKit
import SnapKit

class EventCell: UITableViewCell {
    private let roundView = UIView(frame: .zero)
    
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
    
    private let dateLabel: UILabel = {
        let dLabel = UILabel(frame: .zero)
        dLabel.backgroundColor = .green
        dLabel.layer.masksToBounds = true
        return dLabel
    }()
    
    private let cityLabel: UILabel = {
        let cLabel = UILabel(frame: .zero)
        cLabel.backgroundColor = .purple
        cLabel.layer.masksToBounds = true
        return cLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureSubviews() {
        addSubview(roundView)
        roundView.addSubview(cardImageView)
        roundView.addSubview(descriptionLabel)
        roundView.addSubview(dateLabel)
        roundView.addSubview(cityLabel)
        roundView.addSubview(titleLabel)
        
//        selectedBackgroundView = roundView 

        configureRoundView()
        configureLabels()

        
    }
    
    private func configureRoundView() {
        roundView.snp.makeConstraints { view -> Void in
            view.width.height.equalTo(self).offset(ViewConstants.cellRoundViewOffset)
            view.center.equalTo(self)
        }
    
        roundView.layer.cornerRadius = ViewConstants.viewCornerRadius
        roundView.backgroundColor = .lightGray
    }
    
    private func configureLabels() {
        descriptionLabel.snp.makeConstraints { label -> Void in
            label.bottom.left.right.equalTo(roundView)
            label.height.equalTo(roundView).offset(ViewConstants.eventCellDescriptionLabel)
        }
        
        titleLabel.snp.makeConstraints { label -> Void in
            label.bottom.equalTo(descriptionLabel.snp.top)
            label.height.equalTo(descriptionLabel.snp.height)
            label.width.equalTo(descriptionLabel.snp.width).dividedBy(2)
        }
        
        dateLabel.snp.makeConstraints { label -> Void in
            label.top.equalTo(roundView)
            label.height.width.equalTo(titleLabel)
        }
        
        cityLabel.snp.makeConstraints { label -> Void in
            label.top.equalTo(roundView)
            label.right.equalTo(roundView)
            label.height.width.equalTo(titleLabel)
        }
    }
}

