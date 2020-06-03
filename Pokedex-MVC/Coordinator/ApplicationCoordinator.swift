import UIKit

final class ApplicationCoordinator: Coordinator {
    var rootViewController: UIViewController
    var childCoordinators = [Coordinator]()
    
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = UINavigationController()
        navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let loadingCoordinator = LoadingCoordinator(rootViewController: navigationController)
        loadingCoordinator.delegate = self
        loadingCoordinator.start()
        
        addChildCoordinator(loadingCoordinator)
    }
    
    deinit {
        print("ApplicationCoordinator deinitialized")
    }
}

extension ApplicationCoordinator: LoadingCoordinatorDelegate {
    func loadingCoordinatorDidFinish(_ loadingCoordinator: LoadingCoordinator) {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        
        removeChildCoordinator(loadingCoordinator)
        addChildCoordinator(loginCoordinator)
    }
}

extension ApplicationCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(_ loginCoordinator: LoginCoordinator) {
        removeChildCoordinator(loginCoordinator)
        
        let pokedexCoordinator = PokedexCoordinator(navigationController: navigationController)
        pokedexCoordinator.start()
        
        addChildCoordinator(pokedexCoordinator)
    }
}
