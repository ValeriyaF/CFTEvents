import UIKit

extension UIView {
    func addShadow(withOpacity opacity: Float) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = ViewConstants.viewCornerRadius
        self.layer.shouldRasterize = true
    }
}
