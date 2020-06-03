//import UIKit
//
//extension UIView {
//    func setBackgroundGradient(for type: Type, opacity: Float = 1.0, cornerRadius: CGFloat = 0, invertColors: Bool = false) {
//        let darkColor = UIColor(named: "\(type)Dark")!.cgColor
//        let lightColor = UIColor(named: "\(type)Light")!.cgColor
//        
//        let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer ?? CAGradientLayer()
//        
//        gradientLayer.frame = bounds
//        gradientLayer.colors = invertColors ? [lightColor, darkColor] : [darkColor, lightColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
//        gradientLayer.opacity = opacity
//        gradientLayer.cornerRadius = cornerRadius
//        
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
