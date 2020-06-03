import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.shared.loadImage(at: url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
