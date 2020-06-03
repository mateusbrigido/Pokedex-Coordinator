import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidFinish(_ loginCoordinator: LoginCoordinator)
}

class LoginCoordinator: NSObject, Coordinator {    
    var childCoordinators = [Coordinator]()
    private var navigationController: UINavigationController
    private var presentingViewController: UIViewController?
    
    weak var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let signinViewController = SigninViewController.instantiate()
        signinViewController.delegate = self
        
        navigationController.pushViewController(signinViewController, animated: false)
        
        
        if let presentingViewController = presentingViewController {
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.setNavigationBarHidden(true, animated: false)
        
            presentingViewController.present(navigationController, animated: true)
        }
    }
    
    deinit {
        print("LoginCoordinator deinitialized")
    }
}

extension LoginCoordinator: SigninViewControllerDelegate {
    func signinViewControllerDidSignIn(_ signinViewController: SigninViewController) {
        delegate?.loginCoordinatorDidFinish(self)
    }
    
    func signinViewControllerDidTapSignUp(_ signinViewController: SigninViewController) {
        let signupViewController = SignupViewController.instantiate()
        
        if let _ = presentingViewController {
            navigationController.pushViewController(signupViewController, animated: true)
            navigationController.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController.present(signupViewController, animated: true)
        }
    }
    
    func signinViewControllerDidTapContinueWithOutSignIn(_ signinViewController: SigninViewController) {
        delegate?.loginCoordinatorDidFinish(self)
    }
}
