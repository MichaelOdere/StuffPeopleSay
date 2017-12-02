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
