//
//  CardStore.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation
import SwiftyJSON

class GameStore{
    
    // Managers
    var apiManager:APIManager!
    var pushManager:PusherManager!

    // User Variables
    var isLoggedIn:Bool!
    var userdefaults:UserDefaults!

    // All of the games
    var games:[Game]!
    
    // Return a bool indicating a login was successfull
    init() {
        apiManager = APIManager()
        pushManager = PusherManager()
       
        isLoggedIn = false
        userdefaults = UserDefaults()
       
        games = []
        
    }
    
    func loginUserStart(completionHandler: @escaping (Bool?, Error?) -> Void){
       
        if userdefaults.string(forKey: "token") != nil{
            apiManager.token =  userdefaults.string(forKey: "token")
            apiManager.socketId = "431.3973413"
            
            self.updateGames(completionHandler: { error in
                
                completionHandler(self.isLoggedIn, error)
            })
            
        }else{
            completionHandler(false, nil)
        }
    }
    
    func loginUserEmail(email:String, completionHandler: @escaping (Bool?, Error?) -> Void){
        
        self.apiManager.getUser(email: email, completionHandler:  { (token, error) in
            
            guard let token = token else {
                print(error as Any)
                return
            }
            
            self.userdefaults.set(token, forKey: "token")
            self.userdefaults.set(email, forKey: "email")
            
            self.updateGames(completionHandler: { error in
                
                completionHandler(self.isLoggedIn, error)
            })
        })
        
    }
    
    func updateGames(completionHandler: @escaping (Error?) -> Void){
        self.apiManager.getGames(completionHandler: { loggedIn, gameData, error in
            
            guard let gameData = gameData else {
                print(error as Any)
                return
            }
            
            self.isLoggedIn = loggedIn
            self.games = gameData
            
            completionHandler(error)
        })
        
    }
        
}
