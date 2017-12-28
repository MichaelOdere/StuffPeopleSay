import Foundation
import SwiftyJSON

class Deck{
    var deckId:String
    var name:String
    var cards:[Card]
    
    
    init(deckId:String, name:String, cards: [Card]) {
        self.deckId = deckId
        self.name = name
        self.cards = cards
    }
    
    func copyDeck()->Deck{
        var newCards:[Card] = []
        for c in cards{
            newCards.append(c.copyCard())
        }
        return Deck(deckId: deckId, name: name, cards: newCards)
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
        self.init(deckId: "1", name:"Deck", cards: allCards)
    }
}
