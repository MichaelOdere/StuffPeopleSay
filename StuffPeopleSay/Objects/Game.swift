import Foundation
import SwiftyJSON
struct Game {

    let gameId: String
    var status: String
    var my:     User
    var users:  [User]
}
//"games" : [
//{
//"gameId" : "1ab283b1-3ba1-4458-8fb8-2b6c08db3bde",
//"status" : "Playing",
//"boards" : {
//"my" : {
//"name" : "Michael Odere",
//"userId" : "76735554-97ff-43cb-8f05-6de7de5eb65a",
//"cards" : [
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
        
        guard let myUserData = json["boards"]["my"].dictionaryObject else {
            print("Error parsing game object for key: my")
            return nil
        }
        
        guard let usersData = json["boards"]["users"].arrayObject else {
            print("Error parsing game object for key: users")
            return nil
        }

        guard let myUser = User(json: myUserData) else {
            print("My user was nil")
            return nil
            
        }
        
        var allUsers:[User] = []
        for uData in usersData {
            if let u = uData as? [String: Any]{
                if let user = User(json: u){
                    allUsers.append(user)
                }
            }
        }


        
        self.gameId = gameId
        self.status = status
        self.my = myUser
        self.users = allUsers

    }
    
}


