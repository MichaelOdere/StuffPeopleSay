import Foundation
import SwiftyJSON

class Game {
    var gameId: String
    var name:String
    var status: String
    var my: User
    var opponents: [User]
    
    init(gameId:String, name:String, status:String, my:User, opponents:[User]) {
        self.gameId = gameId
        self.name = name
        self.status = status
        self.my = my
        self.opponents = opponents
    }
}

extension Game {
    convenience init?(json: JSON) {
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
        
        var allOpponents:[User] = []
        for opponentData in opponentsUserData {
            if let opponent = User(json: opponentData){
                allOpponents.append(opponent)
            }
        }

        self.init(gameId: gameId, name:"String", status: status, my: myUser, opponents: allOpponents)
    }
    
    func getOpponents()->String{
        var opponentsText = ""
        
        switch self.opponents.count {
            case 0:
                opponentsText = "No Opponents"
            case 1:
                opponentsText = self.opponents[0].name
            case 2:
                opponentsText = self.opponents[0].name + " & " + self.opponents[1].name
            case 3:
                opponentsText = self.opponents[0].name + ", " + self.opponents[1].name + ", & " + self.opponents[2].name
            default:
                opponentsText = self.opponents[0].name + ", " + self.opponents[1].name + ", & " + String(self.opponents.count - 2) + " Opponents"
        }
        
        if opponentsText.count > 42{
            opponentsText = String(self.opponents.count) + " Opponents"

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
