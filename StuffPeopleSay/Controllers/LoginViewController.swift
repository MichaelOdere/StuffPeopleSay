import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{
    enum ButtonState{
        case active
        case inactive
    }
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var gameStore:GameStore!
    var loadingView:LoadingView!

    override func viewDidLoad() {

        self.updateEmailTextField()
        emailTextField.delegate = self
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)),
                                 for: UIControlEvents.editingChanged)

        self.loadingView = LoadingView(frame: self.view.frame)
        self.loadingView.startAnimating()
        self.view.addSubview(self.loadingView)

        // tap to remove keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        login(loginType: .token)
    }
    
    func login(loginType:LoginType) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        let group = DispatchGroup()
        group.enter()
        
        gameStore.login(loginType: loginType) { (success) in

            if self.gameStore.isLoggedIn {
                self.gameStore.getGames(completionHandler: { (success) in
                    print(self.gameStore.games.count)
                })
            }
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
    
    @IBAction func LoginButton(_ sender: Any?) {
        login(loginType: .password(email: emailTextField.text!, password: "pw"))
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if (self.emailTextField.text?.isEmpty)!{
            configureButton(for: .inactive)
        }else{
            configureButton(for: .active)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        
        if !(textField.text?.isEmpty)!{
            LoginButton(nil)
        }
        return true
    }
    
    func showGameScreen(completionHandler: @escaping () -> Void){
        if self.gameStore.isLoggedIn{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = sb.instantiateViewController(withIdentifier: "nav")
            let vc = navigationController.childViewControllers.first as! GamesTableViewController
            vc.gameStore = self.gameStore
            self.present(navigationController, animated: false, completion: completionHandler)
        }
    }
    
    func updateEmailTextField(){
        if gameStore.keychain.get("email") != nil{
            print("here is email ", gameStore.keychain.get("email"))
            emailTextField.text = gameStore.keychain.get("email")
            configureButton(for: .active)
        }else{
            configureButton(for: .inactive)
        }
    }
    
    func configureButton(for state: ButtonState){
        switch state{
        case .active:
            self.loginButton.alpha = 1.0
            self.loginButton.isEnabled = true
        case .inactive:
            self.loginButton.alpha = 0.6
            self.loginButton.isEnabled = false
        }
    }
}
