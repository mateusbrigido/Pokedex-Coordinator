import Foundation

class Pokedex {
    private(set) static var list: Array<Pokemon> = [Pokemon]()
    
    static func load(completionHandler: @escaping ([Pokemon]) -> Void) {
        URLSession.shared.dataTask(with: .pokedex, completionHandler: { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                guard let list = try? decoder.decode([Pokemon].self, from: data) else { return }
                
                self.list = list
                completionHandler(self.list)
            case .failure(_):
                completionHandler(self.list)
            }
        })
    }
}
