import Foundation
import SwiftyJSON

class APIManager{
    
    var token:String = ""
    var socketId:String = ""

    private let baseURL = "https://692188cd-b52e-4eef-8712-6b069331e1d9.now.sh"
    
    func getUser(email:String, completionHandler: @escaping (String?, Error?) -> Void) {
        let url = URL(string: baseURL + "/users/auth")!
        var request = URLRequest(url: url)
        request.httpBody = "{\"email\" : \"\(email)\"}".data(using: .utf8)
        request.httpMethod = "PUT"
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                for (key, value) in dictionary {
                    if key == "token"{

                        self.token = value as! String
                        self.socketId = "431.3973413"
                    }
                }
                completionHandler(self.token, nil)
            }
        }
        task.resume()
    }
    
    func getGames(completionHandler: @escaping (Bool, [Game], Error?) -> Void) {
        let url = URL(string: baseURL + "/games")!
        var request = URLRequest(url: url)

        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(false, [], error)
                return
            }
            
            do {
                let json = try JSON(data: data)
                               
                if !self.checkLoggedIn(json: json){
                    completionHandler(false, [], nil)
                    return
                }
                
                var games:[Game] = []
               
                let jsonArr:[JSON] = json["games"].arrayValue

                for g in jsonArr{
                    if let game = Game(json: g){
                        games.append(game)
                    }
                }
                completionHandler(true, games, nil)

             } catch {

                print(error)
                completionHandler(true, [], nil)
             }
        
        }
        task.resume()
    }

    func getDecks(completionHandler: ([Deck]?, Error?)->Void){
        if let path = Bundle.main.path(forResource: "Decks", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                
                guard let decksData = json["decks"].array else {
                    print("Error parsing user object for key: decks")
                    return
                }
                
                var allDecks:[Deck] = []
                for d in decksData{
                    if let deck = Deck(json: d){
                        allDecks.append(deck)
                    }
                }
                completionHandler(allDecks, nil)
            } catch {
                completionHandler(nil, error)
                print(error)
            }
        }else{
            completionHandler(nil, nil)
        }
        
    }
    
    func createGame(completionHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: baseURL + "/games")!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")

        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        
        task.resume()
        
    }
    
    func updateBoard(boardCardId: String){
        let url = URL(string: baseURL + "/boards/" + boardCardId)!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        task.resume()
    }
    
    func updateGame(gameId: String){
        let url = URL(string: baseURL + "/games/" + gameId )!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"winner\" : \"true\"}".data(using: .utf8)

        request.httpMethod = "PUT"

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        task.resume()
    }
    
    func createCard(name: String){
        let url = URL(string: baseURL + "/cards")!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = "{\"name\" : \"\(name)\"}".data(using: .utf8)
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
        }
        task.resume()
    }
    
    func checkLoggedIn(json: JSON)->Bool{
        if let message = json["message"].string {
            print("User recieved message from login attempt: \(message)")
            return false
        }
        return true
    }
}
