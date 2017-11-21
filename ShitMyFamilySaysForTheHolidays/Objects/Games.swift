

import Foundation

struct Game {

    let gameId: String
    let status: String
    var cards: [Card]
    let name: String
    let userId: String
    let users: [String]
}
extension Game {
    init?(json: [String: Any]) {
        guard let gameId = json["gameId"] as? String,
            let status = json["status"] as? String,
            let boards = json["boards"] as? [String:Any],
            let users = boards["users"] as? [[String: Any]],
            let my = boards["my"] as? [String: Any],
            let cardsData = my["cards"] as? [[String: Any]],
            let name = my["name"] as? String,
            let userId = my["userId"] as? String
            else {
                return nil
        }

        var allCards:[Card] = []
        for c in cardsData {
            if let card = Card(json: c){
                allCards.append(card)
            }
        }

        self.gameId = gameId
        self.status = status
        self.cards = allCards
        self.name = name
        self.userId = userId
        self.users = []
    }
}

