import Foundation
import SwiftyJSON

class BoardDeckCard {
    var boardCardId:String
    var name:String
    var active:Bool
    var order:Int

    init(id: String, name: String, active: Bool) {
        self.id = id
        self.name = name
        self.active = active
    }
}

extension BoardDeckCard {
    convenience init?(json: JSON) {
        guard let id = json["id"].string else {
            print("Error parsing Card object for key: id")
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
        
        self.init(id: id, name: name, active: active)
    }
}

