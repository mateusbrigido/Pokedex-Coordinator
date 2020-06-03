import UIKit

final class PokedexCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]
    var rootViewController: UIViewController
    
    var navigationController: UINavigationController
    var childCoordinator = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.rootViewController = navigationController
        self.navigationController = navigationController
    }
    
    func start() {
        let pokedexViewController = PokedexViewController.instantiate()
        pokedexViewController.delegate = self
        
        navigationController.isNavigationBarHidden = false
        navigationController.setViewControllers([pokedexViewController], animated: false)
    }
    
    func presentPokemonViewController(with pokemon: Pokemon) {
        let pokemonViewController = PokemonViewController.instantiate()
        pokemonViewController.pokemon = pokemon
        
        navigationController.pushViewController(pokemonViewController, animated: true)
    }
    
    deinit {
        print("PokedexCoordinator deinitialized")
    }
}

extension PokedexCoordinator: PokedexViewControllerDelegata {
    func pokedexViewController(_ pokedexViewController: PokedexViewController, didSelect pokemon: Pokemon) {
        self.presentPokemonViewController(with: pokemon)
    }
    
    func pokedexViewControllerDidTapLogin(_ pokedexViewController: PokedexViewController) {
        let loginCoordinator = LoginCoordinator(presentingViewController: navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        
        childCoordinators.append(loginCoordinator)
    }
}

extension PokedexCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(_ loginCoordinator: LoginCoordinator) {
        removeChildCoordinator(loginCoordinator)
        navigationController.dismiss(animated: true)
    }
}
