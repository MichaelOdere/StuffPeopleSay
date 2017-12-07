import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{
    
    var gameStore:GameStore!
    
    var loadingView:LoadingView!

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {

        
        self.updateEmailTextField()
        emailTextField.delegate = self
        emailTextField.returnKeyType = UIReturnKeyType.done
        
        self.loadingView = LoadingView(frame: self.view.frame)
        self.loadingView.startAnimating()
        self.view.addSubview(self.loadingView)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        let group = DispatchGroup()
        group.enter()
        
        self.gameStore.loginUserStart(completionHandler: { login, error in
            
            guard let login = login else {
                print(error as Any)
                return
            }
            
            group.leave()
           
        })
        
        group.notify(queue: DispatchQueue.main){
            if self.gameStore.isLoggedIn {
                print("user was logged in" )
                self.showGameScreen{
                    self.loadingView.removeFromSuperview()
                }
            }else{
                self.loadingView.removeFromSuperview()
            }
        }
        
    }
    
    @IBAction func Login(_ sender: Any?) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        let group = DispatchGroup()
        group.enter()
        
        self.gameStore.loginUserEmail(email: self.emailTextField.text!, completionHandler: { login, error in
            guard let login = login else {
                print(error as Any)
                return
            }

            group.leave()
        })
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        
        if !(textField.text?.isEmpty)!{
            Login(nil)
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
            self.emailTextField.text = gameStore.keychain.get("email")!
        }
    }
    
}
