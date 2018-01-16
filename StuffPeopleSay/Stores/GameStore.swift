import Foundation
import KeychainSwift

enum LoginType {
    case token
    case password(email: String, password: String)
}

class GameStore{
    
    // Managers
    var apiManager:APIManager
    var pushManager:PusherManager
    var dispatch:NetworkDispatcher

//    private let baseURL = "https://smfs.now.sh"
    private let baseURL = "http://smfs.info:8000"

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
    
    func login(loginType: LoginType, completionHandler: @escaping (Bool)->Void) {
        switch loginType {
        case .token:
            loginWithToken(completionHandler: { (success) in
                completionHandler(success)
            })
        case .password(let email, let password):
            loginWithPassword(email: email, password: password, completionHandler: { (success) in
                completionHandler(success)
            })
        }
    }
    
    func loginWithToken(completionHandler: @escaping (Bool)->Void) {
        guard let token = keychain.get("token"), let email = keychain.get("email") else{
            self.isLoggedIn = false
            completionHandler(false)
            return
        }

        apiManager.checkToken(dispatch: dispatch, email: email, token: token, socketId: "123") { (success) in
            if success {
                self.isLoggedIn = true
                let environment = NetworkEnvironment(host: self.baseURL, token: token, socketId: "123")
                self.dispatch.setEnvironment(environment: environment)
            }else{
                self.isLoggedIn = false
            }
            completionHandler(success)
        }
    }
    
    func loginWithPassword(email: String, password: String, completionHandler: @escaping (Bool)->Void){
        apiManager.login(dispatch: dispatch, email: email, password: password) { (token) in
            guard let token = token else{
                self.isLoggedIn = false
                completionHandler(false)
                return
            }
            
            self.isLoggedIn = true
          
            let environment = NetworkEnvironment(host: self.baseURL, token: token, socketId: "123")
            self.dispatch.setEnvironment(environment: environment)
            
            self.keychain.set(token, forKey: "token")
            self.keychain.set(email, forKey: "email")
            
            print("THIS IS THE TOKEN IN LOGIN")
            print(token)
            completionHandler(true)
        }
    }
    
    func getGames(completionHandler: @escaping (Bool)->Void){
        apiManager.getGames(dispatch: dispatch) { (games) in
            self.games = games
            completionHandler(true)
        }
    }
    
    // Check token user
//    func checkToken(email: String, token:String, socketId: String, completionHandler: @escaping (Bool)->Void){
//        apiManager.checkToken(dispatch: dispatch, email: email, token: token, socketId: socketId) { (success) in
//            if success {
//                self.isLoggedIn = true
//                self.dispatch.setToken(token: token)
//            }else{
//                self.isLoggedIn = false
//            }
//            completionHandler(success)
//        }
//    }
    
    
    
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
