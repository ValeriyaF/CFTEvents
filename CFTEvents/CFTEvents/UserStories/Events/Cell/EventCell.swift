import UIKit
import SnapKit

class EventCell: UITableViewCell {
    private let roundView = UIView(frame: .zero)
    
    private let cardImageView: UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.layer.cornerRadius = ViewConstants.viewCornerRadius
        return imgView
    }()
    
    private let descriptionLabel: UILabel = {
        let dLabel = UILabel(frame: .zero)
        dLabel.backgroundColor = .clear
        dLabel.layer.masksToBounds = true
        return dLabel
    }()
    
    private let titleLabel: UILabel = {
        let tLabel = UILabel(frame: .zero)
        tLabel.backgroundColor = .clear
        tLabel.layer.masksToBounds = true
        return tLabel
    }()
    
    private let startDateLabel: UILabel = {
        let dLabel = UILabel(frame: .zero)
        dLabel.backgroundColor = .clear
        dLabel.layer.masksToBounds = true
        return dLabel
    }()
    
    private let cityLabel: UILabel = {
        let cLabel = UILabel(frame: .zero)
        cLabel.backgroundColor = .clear
        cLabel.textAlignment = .right
        cLabel.layer.masksToBounds = true
        return cLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews() // TODO: add shadow
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureLabels(with model: EventCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        startDateLabel.text = model.startDate
        cityLabel.text = model.cities
        
//        eventsModel.getImage(for: index) { (image, url) in
//            DispatchQueue.main.async {
//                self.cardImageView.image = image
//            }
//        }
    }
    
    func configureImage(with image: UIImage?) {
        cardImageView.image = image
    }
    
//    func configureImage(with image: UIImage?) {
//        cardImageView.image = image
//    }
    
    private func configureSubviews() {
        self.backgroundColor = .white
        addSubview(roundView)
        roundView.addSubview(cardImageView)
        roundView.addSubview(descriptionLabel)
        roundView.addSubview(startDateLabel)
        roundView.addSubview(cityLabel)
        roundView.addSubview(titleLabel)

        configureRoundView()
        configureLabels()
        configureImageView()
    }
    
    private func configureRoundView() {
        roundView.snp.makeConstraints { make -> Void in
            make.width.height.equalTo(self).offset(ViewConstants.cellRoundViewOffset)
            make.center.equalTo(self)
        }
        roundView.layer.cornerRadius = ViewConstants.viewCornerRadius
    }
    
    private func configureLabels() {
        descriptionLabel.snp.makeConstraints { make -> Void in
            make.bottom.left.right.equalTo(roundView)
            make.height.equalTo(roundView).offset(ViewConstants.eventCellDescriptionLabel)
        }
        
        descriptionLabel.layer.cornerRadius = ViewConstants.viewCornerRadius
        
        titleLabel.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.height.equalTo(descriptionLabel.snp.height)
            make.width.equalTo(descriptionLabel.snp.width).dividedBy(2)
        }
        
        startDateLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(roundView)
            make.height.width.equalTo(titleLabel)
        }
        
        cityLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(roundView)
            make.right.equalTo(roundView)
            make.width.equalTo(titleLabel)
            make.height.equalTo(titleLabel)
        }
    }
    
    private func configureImageView() {
        cardImageView.snp.makeConstraints { make -> Void in
            make.left.right.top.bottom.equalTo(roundView)
        }
        
        cardImageView.layer.cornerRadius = ViewConstants.viewCornerRadius
    }
}

