import Foundation

enum Type: String {
    case bug
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ice
    case ghost
    case grass
    case ground
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
    
    var badge: String {
        return "\(self.rawValue)Badge"
    }
    
    var tag: String {
        return "\(self.rawValue)Tag"
    }
    
    var darkColor: String {
        return "\(self)Dark"
    }
    
    var lightColor: String {
        return "\(self)Light"
    }
}

extension Type: Decodable {
    init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self)
        self.init(rawValue: try type.decode(String.self, forKey: .name))!
    }
    
    fileprivate enum TypeKeys: String, CodingKey {
        case name
    }
}
