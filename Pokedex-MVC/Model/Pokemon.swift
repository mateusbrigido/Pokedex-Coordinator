import Foundation

final class Pokemon {
    var order: Int
    var name: String
    var description: String
    var height: Double
    var weight: Double
    
    var stats: [Stat]
    var types: [Type]
    
    var normalSprite: URL
    var shinySprite: URL?
    
    init(from decoder: Decoder) throws {
        let pokemon = try decoder.container(keyedBy: PokemonKeys.self)
        
        self.order = try pokemon.decode(Int.self, forKey: .order)
        self.name = try pokemon.decode(String.self, forKey: .name)
        self.description = try pokemon.decode(String.self, forKey: .description)
        self.height = try pokemon.decode(Double.self, forKey: .height)
        self.weight = try pokemon.decode(Double.self, forKey: .weight)
        
        self.stats = try pokemon.decode([Stat].self, forKey: .stats)
        self.types = try pokemon.decode([Type].self, forKey: .types)
        
        let sprites = try pokemon.nestedContainer(keyedBy: PokemonKeys.SpritesKeys.self, forKey: .sprites)
        
        let urlString = try sprites.decode(String.self, forKey: .normal)
        normalSprite = URL(string: urlString.replacingOccurrences(of: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/", with: "https://raw.githubusercontent.com/mateusbrigido/PokemonAssets/master/oficial/"))!
//        shinySprite = try sprites.decode(URL.self, forKey: .shiny)
    }
}

extension Pokemon: Decodable {
    fileprivate enum PokemonKeys: String, CodingKey {
        case order
        case name
        case description
        case height
        case weight
        case stats
        case types
        case sprites
        
        enum SpritesKeys: String, CodingKey {
            case normal
            case shiny
        }
    }
}
