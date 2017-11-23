//
//  CardStore.swift
//  ShitMyFamilySaysForTheHolidays
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

class GameStore{
    
    // Managers
    var apiManager:APIManager!
    var pushManager:PusherManager!

    // User Variables
    var loggedIn:Bool!
    var userdefaults:UserDefaults!

    // All of the games
    var games:[Game]!
    
    init(completion: @escaping (Bool?, Error?) -> Void ) {
        apiManager = APIManager()
        pushManager = PusherManager()
       
        loggedIn = false
        userdefaults = UserDefaults()
       
        games = []
        
       
        if userdefaults.string(forKey: "token") != nil{
            apiManager.token =  userdefaults.string(forKey: "token")
            apiManager.socketId = "431.3973413"
            
        }
        
        completion(loggedIn, nil)
    }
    
    func updateGames(completion: @escaping (Error?) -> Void){
        self.apiManager.getGames(completionHandler: { isLoggedin, gameData, error in
            
            guard let gameData = gameData else {
                print(error as Any)
                return
            }
            
            self.loggedIn = isLoggedin
            self.games = gameData
            
        })
    }
    
}
