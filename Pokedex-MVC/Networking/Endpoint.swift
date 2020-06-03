import Foundation

struct Endpoint {
    var path: String
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokedex-23964.firebaseio.com"
        components.path = self.path
        
        guard let url = components.url else {
            preconditionFailure("Malformed URL: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static var pokedex: Self {
        return Endpoint(path: "/pokemon.json")
    }
}
