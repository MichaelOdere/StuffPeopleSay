    

import Foundation

struct Game {

    let gameId: String
    var status: String
    var my:     User
    var users:  [User]
}
extension Game {
    init?(json: [String: Any]) {
        
        guard let gameId = json["gameId"] as? String,
            let status = json["status"] as? String,
            let boards = json["boards"] as? [String:Any],
            let users = boards["users"] as? [[String: Any]],
            let my = boards["my"] as? [String: Any]
            else {
                return nil
        }

   
        var allUsers:[User] = []
        for u in users {
            if let user = User(json: u){
                allUsers.append(user)
            }
        }

        guard let myUser = User(json: my) else {
            print("My user was nil")
            return nil
            
        }
        self.gameId = gameId
        self.status = status
        self.my = myUser
        self.users = allUsers
    }
}

