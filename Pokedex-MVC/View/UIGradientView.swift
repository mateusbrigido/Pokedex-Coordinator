import UIKit

class UIGradientView: UIView {
    enum Direction {
        case vertical
        case horizontal
        case custom(start: CGPoint, end: CGPoint)
       
        var startPoint: CGPoint {
            switch self {
            case .vertical: return CGPoint(x: 0.5, y: 0)
            case .horizontal: return CGPoint(x: 0, y: 0.5)
            case .custom(start: let start, end: _): return start
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .vertical: return CGPoint(x: 0.5, y: 1)
            case .horizontal: return CGPoint(x: 1, y: 0.5)
            case .custom(start: _, end: let end): return end
            }
        }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var colors: [UIColor]? {
        didSet {
            gradientLayer.colors = colors?.map { $0.cgColor }
        }
    }

    var locations: [Double]? {
        didSet {
            gradientLayer.locations = locations?.map(NSNumber.init(value:))
        }
    }

    var direction: Direction = .horizontal {
        didSet {
            gradientLayer.startPoint = direction.startPoint
            gradientLayer.endPoint   = direction.endPoint
        }
    }
    
    var opacity: Float = 0 {
        didSet {
            gradientLayer.opacity = opacity
        }
    }
}
