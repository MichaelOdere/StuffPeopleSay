import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{

    var gameStore:GameStore!
    var loadingView:LoadingView!
    var loginView:LoginView!
    override func viewDidLoad() {


        let colorTop = UIColor.white.cgColor
        let colorBottom = BingoPalette.bingoCellBackgroundColor.cgColor

        let gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.startPoint = CGPoint(x: 0.5, y: 0)
        gl.endPoint = CGPoint(x: 0.5, y: 1)

        gl.frame = view.frame
        view.layer.addSublayer(gl)
        
        loginView = LoginView(frame: view.frame)
        view.addSubview(loginView)

//        self.updateEmailTextField()
//        emailTextField.delegate = self
//        emailTextField.returnKeyType = UIReturnKeyType.done
//        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)),
//                                 for: UIControlEvents.editingChanged)

        loadingView = LoadingView(frame: self.view.frame)

        // tap to remove keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
//        login(loginType: .token)
    }
//
//    func login(loginType:LoginType) {
//        loadingView.startAnimating()
//        self.view.addSubview(loadingView)
//        let group = DispatchGroup()
//        group.enter()
//
//        gameStore.login(loginType: loginType) { (success) in
//            group.leave()
//        }
//
//        group.notify(queue: DispatchQueue.main){
//            if self.gameStore.isLoggedIn {
//                self.showGameScreen {
//                    self.loadingView.stopAnimating()
//                    self.loadingView.removeFromSuperview()
//                }
//            }else{
//                self.loadingView.stopAnimating()
//                self.loadingView.removeFromSuperview()
//            }
//        }
//    }
//
//    @IBAction func LoginButton(_ sender: Any?) {
//        login(loginType: .password(email: emailTextField.text!, password: "pw"))
//    }
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if (self.emailTextField.text?.isEmpty)!{
//            configureButton(for: .inactive)
//        }else{
//            configureButton(for: .active)
//        }
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.emailTextField.resignFirstResponder()
//        if !(textField.text?.isEmpty)!{
//            LoginButton(nil)
//        }
//        return true
//    }
//
//    func showGameScreen(completionHandler: @escaping () -> Void){
//        if self.gameStore.isLoggedIn{
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let navigationController = sb.instantiateViewController(withIdentifier: "nav")
//            let vc = navigationController.childViewControllers.first as! GamesTableViewController
//            vc.gameStore = self.gameStore
//            self.dismiss(animated: false, completion: nil)
//            self.present(navigationController, animated: false, completion: completionHandler)
//        }
//    }
//
  

}
