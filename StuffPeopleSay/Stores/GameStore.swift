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
                completionHandler(success)
            })
        case .password(let email, let password):
            loginWithPassword(email: email, password: password, completionHandler: { (success) in
                if self.isLoggedIn{
                    self.getData(completionHandler: { (success) in
                        completionHandler(success)
                    })
                }else{
                    completionHandler(success)
                }
            })
        }
    }
    
    func getData(completionHandler: @escaping (Bool)->Void) {
        let group = DispatchGroup()
        
        var didGetGames = false
        var didGetDecks = false
        
        group.enter()
        getGames(completionHandler: { (success) in
            didGetGames = success
            group.leave()
        })
        
        group.enter()
        getDecks(completionHandler: { (decks) in
            if let decks = decks {
                if decks.count != 0{
                    self.decks = decks.reversed()
                }
                didGetDecks = true
            }
            group.leave()
        })
        
        group.notify(queue: DispatchQueue.main){
            completionHandler(didGetGames && didGetDecks)
        }
    }
    
    // MARK: GameStore - User

    func createUser(email: String, password: String, completionHandler: @escaping (Bool)->Void) {
        apiManager.createUser(email: email, password: password, dispatch: dispatch) { (token) in
            guard let token = token else {
                completionHandler(false)
                return
            }
            
            self.apiManager.checkToken(email: email, token: token, socketId: "123", dispatch: self.dispatch, completionHandler: { (success) in
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

//        apiManager.checkToken(email: email, token: token, socketId: "123", dispatch: dispatch) { (success) in
//            if success {
//                self.isLoggedIn = true
//                let environment = NetworkEnvironment(host: self.baseURL, token: token, socketId: "123")
//                self.dispatch.setEnvironment(environment: environment)
//            }else{
//                self.isLoggedIn = false
//            }
//
//            print("checked token", success)
//            completionHandler(success)
//        }
        
        let environment = NetworkEnvironment(host: self.baseURL, token: token, socketId: "123")
        self.dispatch.setEnvironment(environment: environment)
        
        self.getData { (success) in
            if success {
                self.isLoggedIn = true
                
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
            
            completionHandler(true)
        }
    }
    
    // MARK: GameStore - Game
    
    func createGame(name: String, boards: Int, deckId: String, completionHandler: @escaping (Game?)->Void){
        apiManager.createGame(name: name, boards: boards, deckId: deckId, dispatch: dispatch) { (game) in
            if let game = game {
                self.games.append(game)
            }
            completionHandler(game)
        }
    }
    
    func getGames(completionHandler: @escaping (Bool)->Void){
        apiManager.getGames(dispatch: dispatch) { (games) in
            if let games = games {
                self.games = games
                completionHandler(true)
                return
            }
            completionHandler(false)
        }
    }
    
    func updateGame(gameId: String, completionHandler: @escaping (Bool)->Void) {
        apiManager.updateGame(gameId: gameId, dispatch: dispatch) { (success) in
            completionHandler(success)
        }
    }
    
    func updateBoard(boardCardId: String, completionHandler: @escaping (Bool)->Void) {
        apiManager.updateBoard(boardCardId: boardCardId, dispatch: dispatch) { (success) in
            completionHandler(success)
        }
    }
    
    // MARK: GameStore - Deck

    func createDeck(name:String, completionHandler: @escaping (Deck?)->Void){
        apiManager.createDeck(name:name, dispatch: dispatch) { (jsonData) in
            
            guard let json = jsonData as? JSON, let id = json["id"].string else {
                print("Error parsing user object for key: id")
                completionHandler(nil)
                return
            }
            
            self.getDeck(deckId: id, completionHandler: { (deck) in
                if let deck = deck {
                    self.decks.append(deck)
                }
                completionHandler(deck)
            })
        }
    }
    
    func createCard(name:String, completionHandler: @escaping (Card?)->Void){
        apiManager.createCard(name:name, dispatch: dispatch) { (card) in
            guard let card = card else {
                completionHandler(nil)
                return
            }
            
            // Add card to every deck
            for deck in self.decks {
                deck.cards.append(card)
            }
            completionHandler(card)
        }
    }
    
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
    
    func getDecks(completionHandler: @escaping ([Deck]?)->Void){
        var tempDecks:[Deck] = []
        var decksData:JSON?
        let group = DispatchGroup()

        group.enter()
        
        getDecksData { (jsonData) in
            guard let jsonData = jsonData else{
                completionHandler(nil)
                return
            }
            decksData = jsonData
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main){
            group.enter()
            guard let decksDataArray = decksData?.array else {
                completionHandler(nil)
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
    
    func addCards(deckId: String, cards: [String], completionHandler: @escaping (Bool)->Void) {
        apiManager.addCards(deckId: deckId, cards: cards, dispatch: dispatch) { (success) in
            completionHandler(success)
        }
    }
    
    func removeCards(deckId: String, cards: [String], completionHandler: @escaping (Bool)->Void) {
        apiManager.removeCards(deckId: deckId, cards: cards, dispatch: dispatch) { (success) in
            completionHandler(success)
        }
    }
}
