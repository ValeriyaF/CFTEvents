import SnapKit
import SDWebImage

class EventCell: UITableViewCell {
    private let roundView = UIView(frame: .zero)
    private let bottomDefaultCellBackground = UIImageView(frame: .zero)
    private let topDefaultCellBackground = UIImageView(frame: .zero)
    
    private let cardImageView: UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.layer.cornerRadius = ViewConstants.viewCornerRadius
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private let descriptionLabel: UILabel = {
        let dLabel = UILabel(frame: .zero)
        dLabel.backgroundColor = .clear
        dLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        dLabel.textAlignment = .left
        dLabel.textColor = .darkGray
        dLabel.layer.masksToBounds = true
        return dLabel
    }()
    
    private let titleLabel: UILabel = {
        let tLabel = UILabel(frame: .zero)
        tLabel.backgroundColor = .clear
        tLabel.layer.masksToBounds = true
        tLabel.font = UIFont.boldSystemFont(ofSize: DynamicFontSize.convertTextSize(25))
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
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        selectedBackgroundView = bgColorView

        configureSubviews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureLabels(with model: EventCellModel, theme: Theme) {
        titleLabel.text = "  \(model.title)"
        descriptionLabel.text = "  \(model.description)"
        startDateLabel.text = "  \(model.startDate.prefix(10))"
        print(model.startDate)
        cityLabel.text = "\(model.cities)"
        
        configureCellDesign(theme: theme)
    }
    
    func configureImage(with url: URL?) {
        cardImageView.sd_setImage(with: url, placeholderImage: nil)
    }
    
    private func configureCellDesign(theme: Theme) {
        backgroundColor = theme.eventCellbackgroundColor
        
        titleLabel.textColor = theme.eventCellTitleTextColor
        descriptionLabel.textColor = theme.eventCellTextColor
        startDateLabel.textColor = theme.eventCellTextColor
        cityLabel.textColor = theme.eventCellTextColor
        
        switch theme {
        case .light:
            bottomDefaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            bottomDefaultCellBackground.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForLightTheme")
            
            topDefaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForLightTheme")
            topDefaultCellBackground.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForLightTheme")
        case .dark:
            bottomDefaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForDarkTheme")
            bottomDefaultCellBackground.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForDarkTheme")
            
            topDefaultCellBackground.image = UIImage(named: "defaultCellBackgroundColorForDarkTheme")
            topDefaultCellBackground.highlightedImage = UIImage(named: "highlightedCellBackgroundColorForDarkTheme")
        }
    }
    
    private func configureSubviews() {
        self.backgroundColor = .white
        addSubview(roundView)
        roundView.addSubview(cardImageView)
        cardImageView.addSubview(bottomDefaultCellBackground)
        cardImageView.addSubview(topDefaultCellBackground)
        bottomDefaultCellBackground.addSubview(descriptionLabel)
        bottomDefaultCellBackground.addSubview(titleLabel)
        topDefaultCellBackground.addSubview(startDateLabel)
        topDefaultCellBackground.addSubview(cityLabel)

        configureRoundView()
        configureLabels()
        configureImageView()
        configureDefaultCellBackground()
    
    }
    
    private func configureRoundView() {
        roundView.snp.makeConstraints { make -> Void in
            make.width.height.equalTo(self).offset(ViewConstants.cellRoundViewOffset)
            make.center.equalTo(self)
        }
        
        roundView.addShadow(withOpacity: 0.5) //  const
    
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
            make.width.equalTo(descriptionLabel.snp.width)
        }
        
        startDateLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(roundView)
            make.height.width.equalTo(titleLabel).multipliedBy(2.0 / 3.0)
        }
        
        cityLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(roundView)
            make.right.equalTo(roundView)
            make.width.equalTo(titleLabel)
            make.height.equalTo(titleLabel).multipliedBy(2.0 / 3.0)
        }
    }
    
    private func configureImageView() {
        cardImageView.snp.makeConstraints { make -> Void in
            make.left.right.top.bottom.equalTo(roundView)
        }
        cardImageView.layer.cornerRadius = ViewConstants.viewCornerRadius
    }
    
    private func configureDefaultCellBackground() {
        bottomDefaultCellBackground.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        topDefaultCellBackground.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.top)
            make.bottom.equalTo(cityLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }

    }
}

