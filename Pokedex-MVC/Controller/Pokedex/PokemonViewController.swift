import UIKit

final class PokemonViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var gradientView: UIGradientView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet var typeTagsImageView: [UIImageView]!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var statViews: [StatView]!
    
    var pokemon: Pokemon?
    
    fileprivate struct Constants {
        static let cornerRadius = CGFloat(25)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pokemon = pokemon else { return }
        
        let darkColor = UIColor(named: pokemon.types.first!.darkColor)!
        let lightColor = UIColor(named: pokemon.types.first!.lightColor)!
        
        gradientView.colors = [darkColor, lightColor]
        
        title = pokemon.name
        pokemonImageView.loadImage(at: pokemon.normalSprite)
        descriptionLabel.text = pokemon.description
        
        for (index, type) in pokemon.types.enumerated() {
            typeTagsImageView[index].image = UIImage(named: type.tag)
            typeTagsImageView[index].isHidden = false
        }
        
        for (index, stat) in pokemon.stats.enumerated() {
            statViews[index].setup(with: stat, of: pokemon.types[0])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        statViews.forEach {
            $0.animate()
        }
    }
    
    deinit {
        print("PokemonViewController deinitialized")
    }
}
