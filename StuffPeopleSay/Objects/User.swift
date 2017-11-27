//
//  User.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

struct User{
    var userId:String!
    var name:String!
    var cardsActiveCount:Int!
    init(userId: String, name: String, cardsActiveCount:Int) {
        self.userId = userId
        self.name = name
        self.cardsActiveCount = cardsActiveCount
    }
    
}
extension User {
    init?(json: [String: Any]) {
        guard let cards = json["cards"] as? Int,
            let name = json["name"] as? String,
            let userId = json["userId"] as? String
        
            else {
                return nil
        }
        
        self.cardsActiveCount = cards
        self.name = name
        self.userId = userId
    }
}

