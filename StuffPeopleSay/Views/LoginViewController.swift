//
//  LoginViewController.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

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
    

    
    /*
     
     let games = dictionary["games"] as? [[String:Any]]
     let boards = games![0]["boards"] as? [String:Any]
     //                            let source = images[0]["source"] as? [String:Any],
     //                            print(games)
     print(boards)
     //                            let d  = dictionary["games"] as? [String: Any]
     //                            print(d)
     //                            let s = d!["boards"]
     //                            print(s)
     
     //                            for (key, value) in dictionary {
     //                                print("Key \(key)")
     //                                print("value \(value)")
     //                            }
     
     
 

let group = DispatchGroup()

group.enter()
if !(emailTextField.text?.isEmpty)!{
    self.gameStore.apiManager.getUser(email: emailTextField.text!, completionHandler: { token, error in
        
        guard let token = token else {
            print(error as Any)
            return
        }
        
        
        
        self.gameStore.apiManager.getGames(completionHandler: { isLogedIn, gameData, error in
            
            guard let gameData = gameData else {
                print(error as Any)
                return
            }
            
            self.gameStore.games = gameData
            
            DispatchQueue.main.sync {
                self.gameStore.userdefaults.set(token, forKey: "token")
                self.gameStore.userdefaults.set(self.emailTextField.text, forKey: "email")
                self.gameStore.isLoggedIn = true
                
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
            
            group.leave()
            
        })
        
    })
 
 group.notify(queue: DispatchQueue.main){
 self.showGameScreen()
 }
*/
}
