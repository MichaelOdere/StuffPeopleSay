import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{

    var gameStore:GameStore!
    var loadingView:LoadingView!
    var loginView:LoginView!
    override func viewDidLoad() {
        view.backgroundColor = BingoPalette.bingoCellBackgroundColor

        loginView = LoginView(frame: view.frame)
        view.addSubview(loginView)
        loginView.loginButton.addTarget(self, action: #selector(LoginViewController.LoginButton), for: .touchUpInside)
        
        updateEmailTextField()

        loadingView = LoadingView(frame: self.view.frame)

//        login(loginType: .token)
    }

    func login(loginType:LoginType) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        let group = DispatchGroup()
        group.enter()

        gameStore.login(loginType: loginType) { (success) in
            group.leave()
        }

        group.notify(queue: DispatchQueue.main){
            if self.gameStore.isLoggedIn {
                self.showGameScreen {
                    self.loadingView.stopAnimating()
                    self.loadingView.removeFromSuperview()
                }
            }else{
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
        }
    }

    @objc func LoginButton() {
        login(loginType: .password(email: loginView.emailTextField.textField.text!, password: "pw"))
    }

    func updateEmailTextField(){
        if gameStore.keychain.get("email") != nil{
            print("here is email ", gameStore.keychain.get("email"))
            loginView.emailTextField.textField.text = gameStore.keychain.get("email")
            loginView.configureButton(for: .active)
        }
    }

    func showGameScreen(completionHandler: @escaping () -> Void){
        if self.gameStore.isLoggedIn{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = sb.instantiateViewController(withIdentifier: "nav")
            let vc = navigationController.childViewControllers.first as! GamesTableViewController
            vc.gameStore = self.gameStore
            self.dismiss(animated: false, completion: nil)
            self.present(navigationController, animated: false, completion: completionHandler)
        }
    }
}
