import Foundation

enum Stat {
    case hp(Int)
    case attack(Int)
    case defense(Int)
    case specialAttack(Int)
    case specialDefense(Int)
    case speed(Int)
    
    init(from decoder: Decoder) throws {
        let stat = try decoder.container(keyedBy: StatKeys.self)
        let name = StatName.init(rawValue: try stat.decode(String.self, forKey: .name))!
        
        switch name {
        case .hp:
            self = .hp(try stat.decode(Int.self, forKey: .value))
        case .attack:
            self = .attack(try stat.decode(Int.self, forKey: .value))
        case .defense:
            self = .defense(try stat.decode(Int.self, forKey: .value))
        case .specialDefense:
            self = .specialDefense(try stat.decode(Int.self, forKey: .value))
        case .specialAttack:
            self = .specialAttack(try stat.decode(Int.self, forKey: .value))
        case .speed:
            self = .speed(try stat.decode(Int.self, forKey: .value))
        }
    }
    
    var name: String {
        switch self {
        case .hp(_):
            return "HP"
        case .attack(_):
            return "ATK"
        case .defense(_):
            return "DEF"
        case .specialAttack(_):
        return "SATK"
        case .specialDefense(_):
            return "SDEF"
        case .speed(_):
            return "SPD"
        }
    }
    
    var value: Int {
        switch self {
        case .hp(let value):
            return value
        case .attack(let value):
            return value
        case .defense(let value):
            return value
        case .specialAttack(let value):
            return value
        case .specialDefense(let value):
            return value
        case .speed(let value):
            return value
        }
    }
}

extension Stat: Decodable {
    fileprivate enum StatKeys: String, CodingKey {
        case name
        case value
    }
    
    fileprivate enum StatName: String {
        case hp
        case attack
        case defense
        case specialDefense = "special-defense"
        case specialAttack = "special-attack"
        case speed
    }
}
