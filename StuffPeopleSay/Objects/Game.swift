import Foundation
import SwiftyJSON
struct Game {

    let gameId: String
    var status: String
    var my: User
    var users: [User]
}

extension Game {
    init?(json: JSON) {

        guard let gameId = json["gameId"].string else {
            print("Error parsing game object for key: gameId")
            return nil
        }
        
        guard let status = json["status"].string else {
            print("Error parsing game object for key: status")
            return nil
        }
        
        let myUserData = json["boards"]["my"]

        guard let usersData = json["boards"]["users"].array else {
            print("Error parsing game object for key: users")
            return nil
        }

        guard let myUser = User(json: myUserData) else {
            print("My user was nil")
            return nil
            
        }
        
        var allUsers:[User] = []
        for uData in usersData {
            if let user = User(json: uData){
                allUsers.append(user)
            }
        }
        
        self.gameId = gameId
        self.status = status
        self.my = myUser
        self.users = allUsers

    }
    
}


