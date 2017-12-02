import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{
    
    var gameStore:GameStore!
    
    var loadingView:UIActivityIndicatorView!

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {

        loadingView = UIActivityIndicatorView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor.gray
        loadingView.layer.opacity = 0.8
        self.loadingView.startAnimating()
        self.view.addSubview(self.loadingView)
        
        emailTextField.delegate = self
        self.updateEmailTextField()
        
        let group = DispatchGroup()
        group.enter()
        
        self.gameStore.loginUserStart(completionHandler: { login, error in
            
            guard let login = login else {
                print(error as Any)
                return
            }
            
            group.leave()
            
            if login {
                self.showGameScreen()
            }
        })
        
        group.notify(queue: DispatchQueue.main){
            self.loadingView.stopAnimating()
            self.loadingView.removeFromSuperview()
          
        }
        
    }
    
    @IBAction func Login(_ sender: Any) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        
        self.gameStore.loginUserEmail(email: self.emailTextField.text!, completionHandler: { login, error in
            guard let login = login else {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.sync {
               
                if login {
                    self.showGameScreen()
                    
                }
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
               
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showGameScreen(){
        if self.gameStore.isLoggedIn{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GamesTableView") as! GamesTableViewController
            let navigationController = UINavigationController(rootViewController: vc)
            
            vc.gameStore = self.gameStore
            self.present(navigationController, animated: true, completion: nil)
        }
        
    }
    
    func updateEmailTextField(){
        
        if gameStore.userdefaults.string(forKey: "email") != nil{
            self.emailTextField.text = gameStore.userdefaults.string(forKey: "email")
        }
    }
    
}
