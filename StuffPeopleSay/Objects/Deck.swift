//
//  Deck.swift
//  StuffPeopleSay
//
//  Created by Michael Odere on 12/1/17.
//  Copyright © 2017 michaelodere. All rights reserved.
//

import Foundation

class Deck{
    
    var cards: [Card] = []
    
    init(cards: [Card]) {
        self.cards = cards
       
    }
}
extension Deck {
    convenience init?(json: [[String: Any]]) {
        var allCards:[Card] = []
        for c in json {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }
        
        self.init(cards: allCards)

    }
}
