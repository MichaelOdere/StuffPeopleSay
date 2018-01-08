import Foundation
import SwiftyJSON

class Card:SearchableObject {
    var active:Int
    var order:Int

    init(id: String, name: String, active: Int, order: Int) {
        self.active = active
        self.order = order
        super.init(id: id, name: name)
    }
    
    func copyCard()->Card{
        return Card(id: id, name: name, active: active, order: order)
    }
}

extension Card {
    convenience init?(json: JSON) {
        guard let id = json["boardCardId"].string else {
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
        
        self.init(id: id, name: name, active: active, order: order)

    }
}
