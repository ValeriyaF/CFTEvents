import UIKit

enum Theme: Int {
    case light = 0
    case dark = 1
    
    var index: Int {
        switch self {
        case .light:
            return 0
        case .dark:
            return 1
            
        }
    }
    
    init(index: Int) {
        switch index {
        case 0:
            self = .light
        case 1:
            self = .dark
        default:
            self = .dark
        }
    }
}

extension Theme {
    var mainColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("289bff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var separatorColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("e41e30")
        case .dark:
            return .colorFromHexString("161c24")
        }
    }
}

// navigation bar 
extension Theme {
    var navigationBarBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("e41e30")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var navigationBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("000000")
        case .dark:
            return .colorFromHexString("ffffff")
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .light:
            return .default
        case .dark:
            return .black
        }
    }
}

// tab bar

extension Theme {
    var tabBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
    
    var tabBarBarTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("e41e30")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
}


// cell

extension Theme {
    var eventCellbackgroundColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("1d2a39")
        }
    }
    
    var eventCellTitleTextColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("000000")
        case .dark:
            return .colorFromHexString("ffffff")
        }
    }
    
    var eventCellTextColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("73777a")
        case .dark:
            return .colorFromHexString("73777a")
        }
    }
    
    var settingsCellTextColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("000000")
        case .dark:
            return .colorFromHexString("73777a")
        }
    }
    
    var settingsCellBackgroundColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("ffffff")
        case .dark:
            return .colorFromHexString("171d22")
        }
    }
    
    var cellTintColor: UIColor {
        switch self {
        case .light:
            return .colorFromHexString("e41e30")
        case .dark:
            return .colorFromHexString("289bff")
        }
    }
}

class ThemeManager {
    
    static func applyTheme(theme: Theme) {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.navigationBarBarTintColor
        UINavigationBar.appearance().tintColor = theme.navigationBarTintColor
        
        
        UITabBar.appearance().tintColor = theme.tabBarTintColor
        UITabBar.appearance().barTintColor = theme.tabBarBarTintColor
        
        UITableViewCell.appearance().tintColor = theme.cellTintColor
        
    }
}
