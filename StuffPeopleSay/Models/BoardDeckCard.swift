import Foundation
import SwiftyJSON

class BoardDeckCard {
    var boardCardId: String
    var name: String
    var active: Bool
    var order: Int

    init(boardCardId: String, name: String, active: Bool, order: Int) {
        self.boardCardId = boardCardId
        self.name = name
        self.active = active
        self.order = order
    }
}

extension BoardDeckCard {
    convenience init?(json: JSON) {
        guard let boardCardId = json["boardCardId"].string else {
            print("Error parsing Card object for key: boardCardId")
            return nil
        }

        guard let name = json["name"].string else {
            print("Error parsing Card object for key: name")
            return nil
        }

        guard let active = json["active"].bool else {
            print("Error parsing Card object for key: active")
            return nil
        }

        guard let order = json["order"].int else {
            print("Error parsing Card object for key: order")
            return nil
        }

        self.init(boardCardId: boardCardId, name: name, active: active, order: order)
    }
}
