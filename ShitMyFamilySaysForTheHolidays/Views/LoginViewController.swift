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
    var loadView:UIActivityIndicatorView!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
       
        
        pushManager = PusherManager()
        // If we have the tokens we can initialize here
        apiManager = APIManager(token: nil, socketId: "1")
//        emailTextField.delegate = self

//        loginButton.isEnabled = false
//        loginButton.layer.opacity = 0.5

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        if userLoggedIn{
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController
//
//            vc.pushManager = pushManager
//            present(vc, animated: true, completion: {self.loadView.removeFromSuperview()})
//        }
        
    }
    
//    @IBAction func usernameTextFieldEditChanged(_ sender: Any) {
//        if (usernameTextField.text?.isEmpty)!{
//            loginButton.isEnabled = false
//            loginButton.layer.opacity = 0.5
//        }else{
//            loginButton.isEnabled = true
//            loginButton.layer.opacity = 1
//
//        }
//    }
    
    @IBAction func Login(_ sender: Any) {
       
        let group = DispatchGroup()
        
        group.enter()
        if !(emailTextField.text?.isEmpty)!{
            apiManager.getUser(email: "david@odereinc.com", completionHandler: { data, error in
                
            guard let data = data else {
                print(error as Any)
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let dictionary = json as? [String: Any] {
                
                
                for (key, value) in dictionary {
                    if key == "token"{
                        self.apiManager.token = value as! String
                        self.apiManager.socketId = "431.3973413"

                    }
                }
                
                self.apiManager.getGames(completionHandler: { data, error in
                    
                    guard let data = data else {
                        print(error as Any)
                        return
                    }
                    
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    
                        if let dictionary = json as? [String: Any] {
                            let games = dictionary["games"] as? [[String:Any]]

                            for b in games!{
                                if let game = Game(json: b){
                                    self.games.append(game)
                                }
                            }
                            
                            group.leave()

                            
                        }
                    
                    })
                }
            
            })
        
        
        }
        
        group.notify(queue: DispatchQueue.main){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GamesTableView") as! GamesTableViewController
            let navigationController = UINavigationController(rootViewController: vc)

            vc.games = self.games
            vc.apiManager = self.apiManager
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
