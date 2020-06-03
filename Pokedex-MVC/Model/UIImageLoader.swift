import UIKit

final class UIImageLoader {
    
    static let shared = UIImageLoader()
    
    private let loader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() { }
    
    func loadImage(at url: URL, for imageView: UIImageView) {
        let uuid = loader.load(from: url) { image in
            defer { self.uuidMap.removeValue(forKey: imageView)}
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        if let uuid = uuid {
            uuidMap[imageView] = uuid
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            loader.cancel(uuid: uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
