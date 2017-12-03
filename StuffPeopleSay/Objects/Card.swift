import Foundation
import SwiftyJSON

struct Card{
    var boardCardId:String!
    var name:String!
    var active:Int!
    var order:Int!

    init(active: Int, boardCardId: String, name: String, order: Int) {
        self.boardCardId = boardCardId
        self.name = name
        self.active = active
        self.order = order

    }
}

extension Card {
    init?(json: JSON) {

        guard let boardCardId = json["boardCardId"].string else {
            print("Error parsing Card object for key: boardCardId")
            return nil
        }
        
        guard let name = json["name"].string else {
            print("Error parsing Card object for key: name")
            return nil
        }
        
        guard let active = json["active"].int else {
            print("Error parsing Card object for key: active")
            return nil
        }
        
        guard let order = json["order"].int else {
            print("Error parsing Card object for key: order")
            return nil
        }
        
        self.active = active
        self.boardCardId = boardCardId
        self.name = name
        self.order = order
    }
}
