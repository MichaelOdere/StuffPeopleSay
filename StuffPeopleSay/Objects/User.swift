//
//  User.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 11/14/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

struct User{
    var userId:String
    var name:String
    var cards:[Card]
    var count:Int
    init(userId: String, name: String, cards: [Card], count: Int) {
        self.userId = userId
        self.name = name
        self.cards = cards
        self.count = count
    }
    
}
extension User {
    init?(json: [String: Any]) {
        guard let cardsData = json["cards"] as? [[String: Any]],
            let name = json["name"] as? String,
            let userId = json["userId"] as? String,
            let count = json["count"] as? Int

            else {
                return nil
        }
        
        var allCards:[Card] = []
        for c in cardsData {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }
        
        self.name = name
        self.userId = userId
        self.cards = allCards
        self.count = count
    }
}

