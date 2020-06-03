import UIKit

protocol LoadingCoordinatorDelegate: AnyObject {
    func loadingCoordinatorDidFinish(_ loadingCoordinator: LoadingCoordinator)
}

final class LoadingCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var rootViewController: UIViewController
    
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    weak var delegate: LoadingCoordinatorDelegate?
    
    init(rootViewController: UIViewController) {
        childCoordinators = []
        self.rootViewController = rootViewController
        navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let loadingViewController = LoadingViewController.instantiate()
        loadingViewController.delegate = self
        
        navigationController?.pushViewController(loadingViewController, animated: false)
    }
    
    deinit {
        print("LoadingCoordinator deinitialized")
    }
}

extension LoadingCoordinator: LoadingViewControllerDelegate {
    func loadingViewControllerDidLoad(_ loadingViewController: LoadingViewController) {
        delegate?.loadingCoordinatorDidFinish(self)
    }
}
