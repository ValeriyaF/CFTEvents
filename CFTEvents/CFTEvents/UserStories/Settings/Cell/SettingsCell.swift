import UIKit

class SettingsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(with name: String, theme: Theme) {
        self.textLabel?.text = name
        self.textLabel?.font = UIFont(name: ((self.textLabel?.font.fontName)!), size: DynamicFontSize.convertTextSize(30))
        
        self.backgroundColor = theme.settingsCellBackgroundColor
        self.textLabel?.textColor = theme.settingsCellTextColor
    }
    
}
