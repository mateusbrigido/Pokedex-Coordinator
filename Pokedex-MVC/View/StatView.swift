import UIKit

final class StatView: UIView {
    private var stat: Stat?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var foregroundView: UIGradientView!
    @IBOutlet weak var foregroundWidth: NSLayoutConstraint!
    
    private var foregroundCalculatedWidth: Float = 0.0
    
    private struct Constants {
        static let cornerRadius = CGFloat(5.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.cornerRadius = Constants.cornerRadius
        
        foregroundView.layer.masksToBounds = false
        foregroundView.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("StatView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setup(with stat: Stat, of type: Type) {
        textLabel.text = stat.name
        valueLabel.text = String(format: "%03d", stat.value)
        
        foregroundCalculatedWidth = Float(stat.value) / 240
        
        let darkColor = UIColor(named: type.darkColor)!
        let lightColor = UIColor(named: type.lightColor)!
        
        foregroundView.colors = [lightColor, darkColor]
    }
    
    func animate() {
        foregroundWidth.constant = backgroundView.frame.width * CGFloat(foregroundCalculatedWidth)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

