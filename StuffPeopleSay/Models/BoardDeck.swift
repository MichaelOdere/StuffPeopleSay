import Foundation
import SwiftyJSON

class BoardDeck{
    var cards:[Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    
}

extension BoardDeck {
    convenience init?(json: JSON) {
        guard let coardData = json["cards"].array else {
            print("Error parsing boarddeck object for key: cards")
            return nil
        }
        
        var allCards:[Card] = []
        for c in coardData {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }
        
//        allCards = allCards.sorted(by: { $0.order > $1.order })
        self.init(cards: allCards)
    }
}

