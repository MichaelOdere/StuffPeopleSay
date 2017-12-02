import Foundation

struct User{
    var userId:String
    var name:String
    var deck:Deck
    var count:Int
    init(userId: String, name: String, deck: Deck, count: Int) {
        self.userId = userId
        self.name = name
        self.deck = deck
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
        
        if let tempDeck = Deck(json: cardsData){
            self.deck = tempDeck
        }else{
            self.deck = Deck(cards: [])
        }
        
        self.name = name
        self.userId = userId
        self.count = count
    }
}

