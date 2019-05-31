import UIKit

class CustomTabBarController: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.subscribeOnThemeChange()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.subscribeOnThemeChange()
    }
    
    private func subscribeOnThemeChange() {
        NotificationCenter.default.addObserver(
        forName: .preferencesChangeTheme, object: nil, queue: nil) { [weak self] notif in
            if let theme = notif.object as? Theme {
                self?.tabBar.tintColor = theme.tabBarTintColor
                self?.tabBar.barTintColor = theme.tabBarBarTintColor
            }
        }
    }
}
