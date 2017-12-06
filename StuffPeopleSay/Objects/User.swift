import Foundation
import SwiftyJSON

struct User{
    var userId: String
    var name: String
    var boards: [Deck] = []
    var count: Int
    init(userId:String, name:String, boards:[Deck], count:Int) {
        self.userId = userId
        self.name = name
        self.boards = boards
        self.count = count
    }
    
    func getCardsActive(index: Int)->Int{
       
        let deck = self.boards[index]
        
        var count = 0
        for card in deck.cards{
            if card.active == 1{
                count += 1
            }
        }
        
        return count
    }
}
extension User {
    init?(json: JSON) {

        guard let name = json["name"].string else {
            print("Error parsing user object for key: name")
            return nil
        }
        
        guard let userId = json["userId"].string else {
            print("Error parsing user object for key: userId")
            return nil
        }
        
        guard let count = json["count"].int else {
            print("Error parsing user object for key: count")
            return nil
        }
        
        guard let cardsData = json["cards"].array else {
            print("Error parsing user object for key: user")
            return nil
        }

        self.name = name
        self.userId = userId
        self.count = count

        if let tempDeck = Deck(json: cardsData){
            self.boards.append(tempDeck)
        }

    }
    
}

