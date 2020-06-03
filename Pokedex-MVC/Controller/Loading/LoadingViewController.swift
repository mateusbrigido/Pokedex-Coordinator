import UIKit

protocol LoadingViewControllerDelegate: class {
    func loadingViewControllerDidLoad(_ loadingViewController: LoadingViewController)
}

final class LoadingViewController: UIViewController, Storyboarded {
    weak var delegate: LoadingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Pokedex.load(completionHandler: { list in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.loadingViewControllerDidLoad(self)
            }
        })
    }
    
    deinit {
        print("LoadingViewController deinitialized")
    }
}

