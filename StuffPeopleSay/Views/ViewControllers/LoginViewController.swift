import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{
    
    var gameStore:GameStore!
    
    var loadingView:LoadingView!

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        loadingView = LoadingView(frame: self.view.frame)

        self.loadingView.startAnimating()
        self.view.addSubview(self.loadingView)
        
        emailTextField.delegate = self
        self.updateEmailTextField()
        emailTextField.returnKeyType = UIReturnKeyType.done

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
        textField.resignFirstResponder()
        Login(nil)
        
        return true
    }
    
    func showGameScreen(completionHandler: @escaping () -> Void){
        if self.gameStore.isLoggedIn{
            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "GamesTableView") as! GamesTableViewController
            let navigationController = sb.instantiateViewController(withIdentifier: "nav")
            let vc = navigationController.childViewControllers.first as! GamesTableViewController
//            UINavigationController(rootViewController: vc)
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
