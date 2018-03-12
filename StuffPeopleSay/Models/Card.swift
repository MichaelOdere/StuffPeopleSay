import Foundation
import SwiftyJSON

class Card {
    var id: String
    var name: String
    var active: Bool

    init(id: String, name: String, active: Bool) {
        self.id = id
        self.name = name
        self.active = active
    }

    func copyCard() -> Card {
        return Card(id: id, name: name, active: active)
    }
}

extension Card {
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
