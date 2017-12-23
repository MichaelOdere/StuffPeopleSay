import Foundation
import SwiftyJSON

class Board{
    
    var deck: [Card] = []
    var boardId:String
    var count:Int
    
    init(deck: [Card], boardId:String, count:Int) {
        self.deck = deck
        self.boardId = boardId
        self.count = count
    }
}
extension Board {
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
        
        guard let boardId = json["boardId"].string else {
            print("Error parsing user object for key: boardId")
            return nil
        }
        
        guard let count = json["count"].int else {
            print("Error parsing user object for key: count")
            return nil
        }
        
        self.init(deck: allCards, boardId: boardId, count: count)
       
    }
}
