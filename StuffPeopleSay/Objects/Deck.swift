import Foundation
import SwiftyJSON

class Deck{
    
    var cards: [Card] = []
    
    init(cards: [Card]) {
        self.cards = cards
       
    }
}
extension Deck {
    convenience init?(json: [JSON]) {
        
        var allCards:[Card] = []
        for c in json {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }
        
        self.init(cards: allCards)
       
    }
}
