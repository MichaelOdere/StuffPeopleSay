import Foundation
import KeychainSwift

class GameStore{
    
    // Managers
    var apiManager:APIManager
    var pushManager:PusherManager

    // User Variables
    var isLoggedIn:Bool
    var keychain:KeychainSwift

    // All of the games
    var games:[Game]
    
    init() {
        apiManager = APIManager()
        pushManager = PusherManager()
       
        isLoggedIn = false
        keychain = KeychainSwift()
       
        games = []
        
    }
    
    // Login user and get game data
    func loginUser(email:String?, completionHandler: @escaping (Bool?, Error?) -> Void){
        
        if let email = email{
            print("Attempting loggin in user with no saved token....")
            self.apiManager.getUser(email: email, completionHandler:  { (token, error) in
                
                guard let token = token else {
                    print(error as Any)
                    return
                }
                
                self.keychain.set(token, forKey: "token")
                self.keychain.set(email, forKey: "email")
                
                self.updateGames(completionHandler: { error in
                    
                    completionHandler(self.isLoggedIn, error)
                })
            })
        }else{
            print("Attempting loggin in user with a saved token....")
            if keychain.get("token") != nil{
                print("found token")
                apiManager.token =  keychain.get("token")!
                apiManager.socketId = "4313973413"
                
                self.updateGames(completionHandler: { error in
                    
                    completionHandler(self.isLoggedIn, error)
                })
                
            }else{
                print("no token")
                completionHandler(false, nil)
            }
        }
        
        
        
    }
    
    func updateGames(completionHandler: @escaping (Error?) -> Void){
        self.apiManager.getGames(completionHandler: { loggedIn, gameData, error in
            
            if let error = error {
                print(error as Any)
                return
            }
            
            self.isLoggedIn = loggedIn
            self.games = gameData
            
            completionHandler(error)
        })
        
    }
        
}
