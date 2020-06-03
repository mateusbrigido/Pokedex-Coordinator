import UIKit

protocol SigninViewControllerDelegate: AnyObject {
    func signinViewControllerDidTapSignUp(_ signinViewController: SigninViewController)
    func signinViewControllerDidSignIn(_ signinViewController: SigninViewController)
    func signinViewControllerDidTapContinueWithOutSignIn(_ signinViewController: SigninViewController)
}

class SigninViewController: UIViewController, Storyboarded {

    @IBOutlet weak var darkView: UIView!
    
    @IBOutlet weak var signStackView: UIStackView! {
        didSet{
            signStackView.isHidden = true
        }
    }
    
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.layer.borderColor = UIColor.white.cgColor
            usernameTextField.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.borderColor = UIColor.white.cgColor
            passwordTextField.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var continueWithOutSignInButton: UIButton! {
        didSet {
            continueWithOutSignInButton.isHidden = true
        }
    }
    
    
    weak var delegate: SigninViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.darkView.layer.opacity = 0.83
        }, completion: { finished in
            self.signStackView.isHidden = false
            self.continueWithOutSignInButton.isHidden = false
        })
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        delegate?.signinViewControllerDidSignIn(self)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        delegate?.signinViewControllerDidTapSignUp(self)
    }
    
    @IBAction func continueWithOutSignInButtonTapped(_ sender: UIButton) {
        delegate?.signinViewControllerDidTapContinueWithOutSignIn(self)
    }
    
    deinit {
        print("SigninViewController deinitialized")
    }
}

extension SigninViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("here")
    }
}
