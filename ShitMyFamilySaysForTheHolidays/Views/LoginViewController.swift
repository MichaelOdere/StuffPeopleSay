//
//  LoginViewController.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import UIKit

class LoginViewController:UIViewController, UITextFieldDelegate{
    var pushManager:PusherManager!
    var loadView:UIActivityIndicatorView!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
       
        
        pushManager = PusherManager()
       
        usernameTextField.delegate = self

        loginButton.isEnabled = false
        loginButton.layer.opacity = 0.5

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
    
    @IBAction func usernameTextFieldEditChanged(_ sender: Any) {
        if (usernameTextField.text?.isEmpty)!{
            loginButton.isEnabled = false
            loginButton.layer.opacity = 0.5
        }else{
            loginButton.isEnabled = true
            loginButton.layer.opacity = 1
            
        }
    }
    
    @IBAction func Login(_ sender: Any) {
       
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BingoController") as! BingoViewController
        
        vc.pushManager = pushManager
        present(vc, animated: true, completion: nil)
        self.usernameTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    


}
