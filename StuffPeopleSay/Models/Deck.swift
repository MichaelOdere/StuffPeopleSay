import Foundation
import SwiftyJSON

class Deck{
    var cards:[Card]
    var id:String
    var name:String
    
    init(id: String, name: String, cards: [Card]) {
        self.cards = cards
        self.id = id
        self.name = name
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
        guard let name = json["name"].string else {
            print("Error parsing user object for key: name")
            return nil
        }

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
        self.init(id: String(Int(arc4random_uniform(600000))), name: name, cards: allCards)
    }
}
