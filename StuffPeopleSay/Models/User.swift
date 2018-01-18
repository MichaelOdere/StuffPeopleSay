import Foundation
import SwiftyJSON

struct User{
    var userId: String
    var name: String
    var boards: [Board] = []
    
    init(userId:String, name:String, boards:[Board]) {
        self.userId = userId
        self.name = name
        self.boards = boards
    }
    
    func getCardsActive(index: Int)->Int{       
        let deck = self.boards[index].boardDeck
        var count = 0
        for card in deck.cards{
            if card.active{
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
        
        guard let boardsData = json["boards"].array else{
            print("Error parsing user object for key: boards")
            return nil
        }

        for boardData in boardsData{
            if let tempBoard = Board(json: boardData){
                self.boards.append(tempBoard)
            }
        }
        
        self.name = name
        self.userId = userId
    }
}

