import Foundation
import SwiftyJSON

class Board{
    
    var boardId:String
    var deck: Deck
    var count:Int
    
    init( boardId:String, deck: Deck, count:Int) {
        self.boardId = boardId
        self.deck = deck
        self.count = count
    }
}
extension Board {
    convenience init?(json: JSON) {
        guard let boardId = json["boardId"].string else {
            print("Error parsing user object for key: boardId")
            return nil
        }
        
        guard let deckData = Deck(json: json) else {
            print("Error parsing Deck")
            return nil
        }

        guard let count = json["count"].int else {
            print("Error parsing user object for key: count")
            return nil
        }
        
        self.init(boardId: boardId, deck: deckData, count: count)
    }
}
