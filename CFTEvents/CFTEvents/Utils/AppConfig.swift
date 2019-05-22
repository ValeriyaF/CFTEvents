import Foundation

struct AppConfig {
     static var isDebug: Bool {
        get {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }
    }
}
