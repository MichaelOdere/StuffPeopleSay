import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{

    var gameStore:GameStore!
    var loadingView:LoadingView!
    var loginView:LoginView!
    var gl: CAGradientLayer!

    override func viewDidLoad() {
        loadingView = LoadingView(frame: self.view.frame)
        loginView = LoginView(frame: view.frame)
        let colorTop = UIColor(red: 97.0/255.0, green: 169/255.0, blue: 207/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 221/255.0, green: 126/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        
        
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
        gl.startPoint = CGPoint(x: 1.0, y: 0.0)
        gl.endPoint = CGPoint(x: 0.0, y: 1.0)
        gl.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        view.layer.addSublayer(gl)
        
//        view.backgroundColor = BingoPalette.bingoCellBackgroundColor
        view.addSubview(loginView)
        
        loginView.loginButton.addTarget(self, action: #selector(LoginViewController.LoginButton), for: .touchUpInside)
        updateEmailTextField()

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

        loginView.emailView.textField.resignFirstResponder()
        loginView.passwordView.textField.resignFirstResponder()

        login(loginType: .password(email: loginView.emailView.textField.text!, password: "pw"))
    }

    func updateEmailTextField(){
        if gameStore.keychain.get("email") != nil{
            loginView.emailView.textField.text = gameStore.keychain.get("email")
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
