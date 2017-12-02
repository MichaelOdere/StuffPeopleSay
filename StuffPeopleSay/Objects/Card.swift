import Foundation

struct Card{
    var active:Int!
    var boardCardId:String!
    var name:String!
    var order:Int!

    init(active: Int, boardCardId: String, name: String, order: Int) {
        self.active = active
        self.boardCardId = boardCardId
        self.name = name
        self.order = order

    }
}

extension Card {
    init?(json: [String: Any]) {
        guard let active = json["active"] as? Int,
            let boardCardId = json["boardCardId"] as? String,
            let name = json["name"] as? String,
            let order = json["order"] as? Int
        
            else {
                return nil
        }
       
        self.active = active
        self.boardCardId = boardCardId
        self.name = name
        self.order = order
    }
}
