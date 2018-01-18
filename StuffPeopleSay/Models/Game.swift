import Foundation
import SwiftyJSON

class Game {
    var gameId: String
//    var name:String
    var status: String
    var my: User
    var opponents: [User]

    init(gameId:String, status:String, my: User, opponents:[User]) {
        self.gameId = gameId
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
        
        guard let myData = usersData["my"] else {
            print("Error parsing game object for key: my")
            return nil
        }

        var myUser:User!
        if let aUser = User(json: myData) {
            myUser = aUser
        }else{
            return nil
        }

        guard let allOpponentsData = usersData["opponents"]?.arrayValue else {
            print("Error parsing game object for key: opponents")
            return nil
        }
        
        var allOpponents:[User] = []
        for opponentData in allOpponentsData {
            if let opponent = User(json: opponentData){
                allOpponents.append(opponent)
            }
        }

        self.init(gameId: gameId, status: status, my: myUser, opponents: allOpponents)
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
