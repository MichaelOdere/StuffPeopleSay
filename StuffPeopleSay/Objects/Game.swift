import Foundation
import SwiftyJSON

class Game {

    var gameId: String
    var status: String
    var my: User
    var users: [User]
    
    init(gameId:String, status:String, my:User, users:[User]) {
        self.gameId = gameId
        self.status = status
        self.my = my
        self.users = users
    }
}

extension Game {
    convenience init?(json: JSON) {

        print(json)
        guard let gameId = json["gameId"].string else {
            print("Error parsing game object for key: gameId")
            return nil
        }
        
        guard let status = json["status"].string else {
            print("Error parsing game object for key: status")
            return nil
        }
        
        guard let usersData = json["users"].dictionary else {
            print("Error parsing game object for key: users")
            return nil
        }
        
        let myUserData =  usersData["my"]
        
        guard let opponentsUserData =  usersData["opponents"]?.array else {
            print("Error parsing game object for key: opponents")
            return nil
        }
        
        guard let myUser = User(json: myUserData!) else {
            print("My user was nil")
            return nil
            
        }
        var allUsers:[User] = []
        for opponentData in opponentsUserData {
            if let user = User(json: opponentData){
                allUsers.append(user)
            }
        }
        
        self.init(gameId: gameId, status: status, my: myUser, users: allUsers)

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
