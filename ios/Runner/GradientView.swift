import UIKit

@IBDesignable
class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Convert hex colors to UIColor
        let yellowColor = UIColor(red: 255/255, green: 219/255, blue: 111/255, alpha: 1.0) // #FFDB6F
        let orangeColor = UIColor(red: 246/255, green: 134/255, blue: 31/255, alpha: 1.0)  // #F6861F
        let pinkColor = UIColor(red: 223/255, green: 35/255, blue: 123/255, alpha: 1.0)    // #DF237B
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [yellowColor.cgColor, orangeColor.cgColor, pinkColor.cgColor]
        gradientLayer.locations = [0.0, 0.42, 0.88]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // top-left
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)   // bottom-right
        
        if let existingLayer = layer as? CAGradientLayer {
            existingLayer.colors = gradientLayer.colors
            existingLayer.locations = gradientLayer.locations
            existingLayer.startPoint = gradientLayer.startPoint
            existingLayer.endPoint = gradientLayer.endPoint
        }
    }
}
