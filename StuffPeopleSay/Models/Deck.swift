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
    
    // Returns amount of active cards
    func activeCards()->Int {
        return cards.reduce(0){ $0 + ($1.active ? 1 : 0)}
    }
}

extension Deck {
    convenience init?(json: JSON) {
        guard let id = json["id"].string else {
            print("Error parsing user object for key: id")
            return nil
        }
        
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
        
//        allCards = allCards.sorted(by: { $0.order > $1.order })
        self.init(id: id, name: name, cards: allCards)
    }
}
