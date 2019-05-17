import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
       let eventsNC = Application.eventsNavigationControllerInitiated(withRootViewController: Application.eventsViewControllerInitiated())
        
        let settingsNC = Application.settingsNavigationControllerInitiated(withRootViewController: Application.settingsViewControllerInitiated())
        
        let tabBarController = Application.tabBarControllerInitiated(withControllers: eventsNC, settingsNC)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

class Application {
    
    class func tabBarControllerInitiated(withControllers firstNC: UINavigationController, _ secondNC:
        UINavigationController) -> UITabBarController {
        let tabBarController = UITabBarController()
        let controllers = [firstNC, secondNC]
        tabBarController.viewControllers = controllers
        
        return tabBarController
    }
    
    class func settingsViewControllerInitiated() -> UIViewController {
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0) // relocate
        let presenter = SettingsPresenter(view: settingsVC)
        settingsVC.presenter = presenter
        
        return settingsVC
    }
    
    class func settingsNavigationControllerInitiated(withRootViewController vc: UIViewController) -> UINavigationController {
        let settingsNC = UINavigationController(rootViewController: vc)
        return settingsNC
    }

    class func eventsViewControllerInitiated() -> UIViewController {
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1) // relocate
        let presenter = EventsPresenter(model: EventsModel(), view: eventsVC)
        eventsVC.presenter = presenter
        return eventsVC
    }
    
    class func eventsNavigationControllerInitiated(withRootViewController vc: UIViewController) -> UINavigationController {
        let eventsNC = UINavigationController(rootViewController: vc)
        return eventsNC
    }
    
    
}

