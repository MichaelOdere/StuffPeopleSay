import Foundation
import SwiftyJSON

class Deck:SearchableObject{
    var cards:[Card]
    
    init(id:String, name:String, cards: [Card]) {
        self.cards = cards
        super.init(id: id, name: name)
    }
    
    func copyDeck()->Deck{
        var newCards:[Card] = []
        for c in cards{
            newCards.append(c.copyCard())
        }
        return Deck(id: id, name: name, cards: newCards)
    }
}

extension Deck {
    convenience init?(json: JSON) {
        guard let coardData = json["cards"].array else {
            print("Error parsing user object for key: cards")
            return nil
        }

        var allCards:[Card] = []
        for c in coardData {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }
        
        allCards = allCards.sorted(by: { $0.order > $1.order })
        self.init(id: String(Int(arc4random_uniform(600000))), name:"Deck", cards: allCards)
    }
}
