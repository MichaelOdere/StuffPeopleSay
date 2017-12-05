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
    
    func getOpponents()->String{
        var opponentsText = ""
        
        switch self.users.count {
            case 0:
                opponentsText = "No Opponents"
            case 1:
                opponentsText = self.users[0].name
            case 2:
                opponentsText = self.users[0].name + " & " + self.users[1].name
            case 3:
                opponentsText = self.users[0].name + ", " + self.users[1].name + ", & " + self.users[2].name
            default:
                opponentsText = self.users[0].name + ", " + self.users[1].name + ", & " + String(self.users.count - 2) + " Opponents"
        }
        
        if opponentsText.count > 42{
            opponentsText = String(self.users.count) + " Opponents"

        }

        return opponentsText
    }
    
    func getSatusColor()->UIColor{
        switch self.status {
        case "Playing":
            return UIColor.green
        case "Ended":
            return UIColor.red
        default:
            return UIColor.green
        }
    }
}
