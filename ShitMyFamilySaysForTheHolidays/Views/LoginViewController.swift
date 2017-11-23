//
//  LoginViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController:UIViewController, UITextFieldDelegate{
    var pushManager:PusherManager!
    var apiManager:APIManager!
    var games:[Game] = []
    var loadingView:UIActivityIndicatorView!
    var loggedIn:Bool = false
    var userdefaults = UserDefaults()
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        pushManager = PusherManager()
        // If we have the tokens we can initialize here
        apiManager = APIManager()

        loadingView = UIActivityIndicatorView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor.gray
        loadingView.layer.opacity = 0.8
        
        emailTextField.delegate = self
        
        if self.userdefaults.string(forKey: "email") != nil{
            self.emailTextField.text = userdefaults.string(forKey: "email")
        }


        if userdefaults.string(forKey: "token") != nil{
            loadingView.startAnimating()
            self.view.addSubview(loadingView)

            self.apiManager.token = userdefaults.string(forKey: "token")
            self.apiManager.socketId = "431.3973413"
            
            let group = DispatchGroup()
            group.enter()

            self.apiManager.getGames(completionHandler: { isLoggedIn, gameData, error in
                
                guard let gameData = gameData else {
                    print(error as Any)
                    return
                }
                
                self.games = gameData

                DispatchQueue.main.sync {
                    self.loadingView.stopAnimating()
                    self.loadingView.removeFromSuperview()
                }
                
                group.leave()
                
            })

            group.notify(queue: DispatchQueue.main){
                self.showGameScreen()
            }
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        loadingView.startAnimating()
        self.view.addSubview(loadingView)
        
        let group = DispatchGroup()
        
        group.enter()
        if !(emailTextField.text?.isEmpty)!{
            apiManager.getUser(email: emailTextField.text!, completionHandler: { token, error in
                
            guard let token = token else {
                print(error as Any)
                return
            }
            
                

                self.apiManager.getGames(completionHandler: { isLogedIn, gameData, error in
                    
                    guard let gameData = gameData else {
                        print(error as Any)
                        return
                    }
                    
                    self.games = gameData
                    
                    DispatchQueue.main.sync {
                        self.userdefaults.set(token, forKey: "token")
                        self.userdefaults.set(self.emailTextField.text, forKey: "email")
                        self.loggedIn = true

                        self.loadingView.stopAnimating()
                        self.loadingView.removeFromSuperview()
                    }
                    
                    group.leave()
                    
                    })
                
            })
        
        }
        
        group.notify(queue: DispatchQueue.main){
            self.showGameScreen()
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showGameScreen(){
        if self.apiManager.isLoggedIn{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GamesTableView") as! GamesTableViewController
            let navigationController = UINavigationController(rootViewController: vc)
            
            vc.games = self.games
            vc.apiManager = self.apiManager
            self.present(navigationController, animated: true, completion: nil)
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
     
     
     */


}
