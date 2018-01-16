import Foundation
import KeychainSwift
import SwiftyJSON

enum LoginType {
    case token
    case password(email: String, password: String)
}

class GameStore{
    
    // Managers
    var apiManager:APIManager
    var pushManager:PusherManager
    var dispatch:NetworkDispatcher

    // Local
    //    private let baseURL = "http://smfs.info:8000"
    /*
     
     if local add to plist
     
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     
     */
    private let baseURL = "https://smfs.now.sh"
//    private let baseURL = "http://smfs.info:8000"

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
    
    // MARK: GameStore - Multiple

    func login(loginType: LoginType, completionHandler: @escaping (Bool)->Void) {
        switch loginType {
        case .token:
            loginWithToken(completionHandler: { (success) in
                
                if success {
                    
                }else{
                    completionHandler(success)
                }
            })
        case .password(let email, let password):
            loginWithPassword(email: email, password: password, completionHandler: { (success) in
                completionHandler(success)
            })
        }
    }
    
    func getData(completionHandler: @escaping (Bool)->Void) {
    
        let group = DispatchGroup()
        group.enter()
        
        getGames(completionHandler: { (success) in
            print(self.games.count)
            group.leave()
        })
        
        group.enter()
        getDecks(completionHandler: { (decks) in
            print("decks")
            print(decks.count)

            if decks.count != 0{
                self.decks = decks
            }
            print(self.decks.count)
            group.leave()
        })
        
        group.notify(queue: DispatchQueue.main){
            completionHandler(true)
        }
    }
    
    // MARK: GameStore - User

    func loginWithToken(completionHandler: @escaping (Bool)->Void) {
        guard let token = keychain.get("token"), let email = keychain.get("email") else{
            self.isLoggedIn = false
            completionHandler(false)
            return
        }

        apiManager.checkToken(email: email, token: token, socketId: "123", dispatch: dispatch) { (success) in
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
        apiManager.login(email: email, password: password, dispatch: dispatch) { (token) in
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
    
    // MARK: GameStore - Game

    func createGame(name: String, boards: Int, deckId: String, completionHandler: @escaping (Game?)->Void){
        apiManager.createGame(name: name, boards: boards, deckId: deckId, dispatch: dispatch) { (game) in
            completionHandler(game)
        }
    }
    
    func getGames(completionHandler: @escaping (Bool)->Void){
        apiManager.getGames(dispatch: dispatch) { (games) in
            self.games = games
            completionHandler(true)
        }
    }
    
    // MARK: GameStore - Deck

    func getDecksData(completionHandler: @escaping (JSON?)->Void){
        apiManager.getDecksData(dispatch: dispatch) { (deckData) in
            completionHandler(deckData)
        }
    }
    
    func getDeck(deckId: String, completionHandler: @escaping (Deck?)->Void){
        apiManager.getDeck(deckId: deckId, dispatch: dispatch) { (deck) in
            completionHandler(deck)
        }
    }
    
    func getDecks(completionHandler: @escaping ([Deck])->Void){
        var tempDecks:[Deck] = []
        var decksData:JSON?
        let group = DispatchGroup()

        group.enter()
        
        getDecksData { (jsonData) in
            decksData = jsonData
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main){
            group.enter()
            guard let decksDataArray = decksData?.array else {
                group.leave()
                return
            }
            
            for d in decksDataArray{
                group.enter()
                if let id = d["id"].string{
                    self.getDeck(deckId: id, completionHandler: { (deck) in
                        if let deck = deck {
                            tempDecks.append(deck)
                            group.leave()
                        }else{
                            group.leave()
                        }
                    })
                }
            }
            group.leave()
         
            group.notify(queue: DispatchQueue.main){
                completionHandler(tempDecks)
            }
        }
    }
    
    // MARK: GameStore - Card
}
