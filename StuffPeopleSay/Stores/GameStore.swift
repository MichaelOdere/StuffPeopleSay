import Foundation
import KeychainSwift

class GameStore{
    
    // Managers
    var apiManager:APIManager
    var pushManager:PusherManager
    var dispatch:NetworkDispatcher

    private let baseURL = "https://smfs.now.sh"
   
    // User Variables
    var isLoggedIn:Bool
    var keychain:KeychainSwift

    // All of the games
    var games:[Game]
    var decks:[Deck]
    
    init() {
        apiManager = APIManager()
        pushManager = PusherManager()
       
        let environment = NetworkEnvironment(host: baseURL, token: "", socketId: "")
        dispatch = NetworkDispatcher(environment: environment)
       
        isLoggedIn = false
        keychain = KeychainSwift()
       
        games = []
        decks = []
    }
    
    
    // Check token user
    func checkToken(email: String, token:String, socketId: String, completionHandler: @escaping (Bool)->Void){
        apiManager.checkToken(dispatch: dispatch, email: email, token: token, socketId: socketId) { (success) in
            if success {
                self.isLoggedIn = true
                self.dispatch.setToken(token: token)
            }else{
                self.isLoggedIn = false
            }
            completionHandler(success)
        }
    }
    
    
    
//    func loginUser(email:String?, completionHandler: @escaping (Bool?, Error?) -> Void){
//        if let email = email{
//            print("Attempting loggin in user with no saved token....")
//            self.apiManager.getUser(email: email, completionHandler:  { (token, error) in
//                guard let token = token else {
//                    print(error as Any)
//                    return
//                }
//
//                print("token login user")
//                print(token)
//
//                self.keychain.set(token, forKey: "token")
//                self.keychain.set(email, forKey: "email")
//
//                self.updateGames(completionHandler: { error in
//                    completionHandler(self.isLoggedIn, error)
//                })
//            })
//        }else{
//            print("Attempting loggin in user with a saved token....")
//            completionHandler(false, nil)
//            return
//            if keychain.get("token") != nil{
//                print("found token")
//                apiManager.token =  keychain.get("token")!
//                print(apiManager.token)
//                apiManager.socketId = "4313973413"
//                self.updateGames(completionHandler: { error in
//                    completionHandler(self.isLoggedIn, error)
//                })
//            }else{
//                print("no token")
//                completionHandler(false, nil)
//            }
//        }
//    }
//
//    func updateGames(completionHandler: @escaping (Error?) -> Void){
//        self.apiManager.getGames(completionHandler: { loggedIn, gameData, error in
//            if let error = error {
//                print(error as Any)
//                return
//            }
//            self.isLoggedIn = loggedIn
//            self.games = gameData
//
//            completionHandler(error)
//        })
//    }
//
//    func createDeck(completionHandler: @escaping (Error?) -> Void){
//
//        self.apiManager.createDeck(deckName: "TestName") { (data, error) in
//            if let error = error {
//                print(error as Any)
//                return
//            }
//            completionHandler(error)
//        }
//    }
//
//    func getDecks(completionHandler: @escaping (Error?) -> Void){
//        self.apiManager.getDecks { (data, error) in
//            if let error = error {
//                print(error as Any)
//                return
//            }
//            completionHandler(error)
//        }
//    }
}
