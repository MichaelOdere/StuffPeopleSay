import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    var gameStore: GameStore!
    var loadingView: LoadingView!
    var loginView: LoginView!
    var gl: CAGradientLayer!

    override func viewDidLoad() {
        loadingView = LoadingView(frame: self.view.frame)
        loginView = LoginView(frame: view.frame)

        view.backgroundColor = BingoPalette.bingoCellBackgroundColor
        view.addSubview(loginView)

        loginView.loginButton.addTarget(self, action: #selector(LoginViewController.loginButton), for: .touchUpInside)
        updateEmailTextField()

        login(loginType: .token)

        self.title = "Login"
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func login(loginType: LoginType) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        let group = DispatchGroup()
        group.enter()

        gameStore.login(loginType: loginType) { (_) in
            group.leave()
        }

        group.notify(queue: DispatchQueue.main) {
            if self.gameStore.isLoggedIn {
                self.showGameScreen {
                    self.loadingView.stopAnimating()
                    self.loadingView.removeFromSuperview()
                }
            } else {
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
        }
    }

    @objc func loginButton() {

        loginView.emailView.textField.resignFirstResponder()
        loginView.passwordView.textField.resignFirstResponder()

        login(loginType: .password(email: loginView.emailView.textField.text!, password: "pw"))
    }

    func updateEmailTextField() {
        if gameStore.keychain.get("email") != nil {
            loginView.emailView.textField.text = gameStore.keychain.get("email")
            loginView.configureButton(for: .active)
        }
    }

    func showGameScreen(completionHandler: @escaping () -> Void) {
        if self.gameStore.isLoggedIn {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = sb.instantiateViewController(withIdentifier: "nav")
            let vcOptional = navigationController.childViewControllers.first as? GamesTableViewController
            guard let vc = vcOptional else {
                fatalError("GamesTableViewController not found.")
            }
            vc.gameStore = self.gameStore
            self.dismiss(animated: false, completion: nil)
            self.present(navigationController, animated: false, completion: completionHandler)
        }
    }
}
