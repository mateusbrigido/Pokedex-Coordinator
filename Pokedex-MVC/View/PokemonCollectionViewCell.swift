import UIKit

final class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCell"
    
    @IBOutlet weak var gradientView: UIGradientView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet var typeBadgesImageView: [UIImageView]!
    
    private var taskId: UUID?
    
    fileprivate struct Constants {
        static let cornerRadius: CGFloat = 15.0
        static let shadowOffset = CGSize(width: 3, height: 5)
        static let gradientOpacity: Float = 0.4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        pokemonImageView.image = nil
        pokemonImageView.cancelImageLoad()
        
        typeBadgesImageView.forEach {
            $0.isHidden = true
            $0.image = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Float(Constants.cornerRadius)
    }
    
    func setup(with pokemon: Pokemon) {
        pokemonImageView.loadImage(at: pokemon.normalSprite)
        
        let darkColor = UIColor(named: pokemon.types.first!.darkColor)!
        let lightColor = UIColor(named: pokemon.types.first!.lightColor)!
        
        gradientView.colors = [darkColor, lightColor]
        gradientView.opacity = Constants.gradientOpacity
        
        nameLabel.text = pokemon.name
        orderLabel.text = String(format: "#%03d", pokemon.order)
        
        for (index, type) in pokemon.types.enumerated() {
            typeBadgesImageView[index].isHidden = false
            typeBadgesImageView[index].image = UIImage(named: type.badge)
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.pokemonImageView.image = image
            })
        }).resume()
    }
}
