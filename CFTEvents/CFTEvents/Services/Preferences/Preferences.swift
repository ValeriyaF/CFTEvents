import Foundation
import SwiftyUserDefaults

extension Notification.Name {
    static let preferencesChangeTheme = Notification.Name("CFPreferencesChangeThemeNotofication")
}

class Preferences {
    private let settings = Defaults
    
    init() {
        ThemeManager.applyTheme(theme: selectedTheme)
    }
    
    var selectedTheme: Theme {
        set {
            settings[.selectedThemeKey] = newValue.rawValue
            NotificationCenter.default.post(name: .preferencesChangeTheme, object: newValue)
        }
        get {
            if let theme = Theme(rawValue: settings[.selectedThemeKey]) {
                ThemeManager.applyTheme(theme: theme)
                print(theme)
                return theme
            }
            return .light
        }
    }
}

extension DefaultsKeys {
    static let selectedThemeKey = DefaultsKey<Int>("SelectedThemeKey", defaultValue: 1)
}
