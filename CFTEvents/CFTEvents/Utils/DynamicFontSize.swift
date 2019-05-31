import UIKit

class DynamicFontSize {
    
    static func convertTextSize(_ FontSize: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let calculatedFontSize = screenWidth / 768.0 * FontSize
        return calculatedFontSize
    }
    
}

