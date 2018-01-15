import Foundation
import SwiftyJSON
import Alamofire

class APIManager{
    
    var token:String = ""
    var socketId:String = ""

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
    // Online
    private let baseURL = "https://smfs.now.sh"
    
    func checkToken(checkToken:String, completion: @escaping (Bool) -> Void){
        let url = URL(string: baseURL + "/auth")!
        Alamofire.request(
            url,
            method: .get,
            headers: [ "Authorization": checkToken])
        .validate()
        .responseJSON { (response) -> Void in

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                completion(false)
                return
            }
            
            let json = JSON(response.data)
            
            if json["token"] == "true" {
                completion(true)
            }
            completion(false)
        }
    }
    
    
    
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
                        print("getUser")
                        print(self.token)
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

        print("token get games")
        print(token)
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

//    func getDecks(completionHandler: ([Deck]?, Error?)->Void){
//        if let path = Bundle.main.path(forResource: "Decks", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let json = try JSON(data: data)
//                
//                guard let decksData = json["decks"].array else {
//                    print("Error parsing user object for key: decks")
//                    return
//                }
//                
//                var allDecks:[Deck] = []
//                for d in decksData{
//                    if let deck = Deck(json: d){
//                        allDecks.append(deck)
//                    }
//                }
//                completionHandler(allDecks, nil)
//            } catch {
//                completionHandler(nil, error)
//                print(error)
//            }
//        }else{
//            completionHandler(nil, nil)
//        }
//        
//    }
    
    func createDeck(deckName:String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: baseURL + "/decks")!
        var request = URLRequest(url: url)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue(socketId, forHTTPHeaderField: "SocketId")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = "{\"name\" : \"\(deckName)\"}".data(using: .utf8)

        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any] {
                print(dictionary)
            }
            
            var backToString = String(data: data, encoding: String.Encoding.utf8) as String!
            print("String11")
            print(backToString)
            print("String21")
            completionHandler(data, nil)
        }
        task.resume()
    }
    
    func getDecks(completionHandler: @escaping ([Deck]?, Error?) -> Void) {
        let url = URL(string: baseURL + "/decks")!
//        var request = URLRequest(url: url)
//
//        request.addValue(token, forHTTPHeaderField: "Authorization")
//        request.addValue(socketId, forHTTPHeaderField: "SocketId")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) {data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, error)
//                return
//            }
//
//            do {
//                let json = try JSON(data: data)
//                print("json")
//                print(json)
//                if !self.checkLoggedIn(json: json){
//                    completionHandler(nil,nil)
//                    return
//                }
//
//                var decks:[Deck] = []
//
//                let jsonArr:[JSON] = json.arrayValue
//
//                for g in jsonArr{
//                    if let deck = Deck(json: g){
//                        decks.append(deck)
//                    }
//                }
//                completionHandler(decks, nil)
//
//            } catch {
//
//                print(error)
//                completionHandler(nil, nil)
//            }
//
//        }
//        task.resume()
//        print("token get decks")
//        print(token)
//
//
        let headers: HTTPHeaders = [
            "Authorization": token,
            "SocketId": socketId
        ]

        
//
//        Alamofire.request(url, method: .get, headers: headers)
//            .responseJSON { response in
//                print("Debug")
//                debugPrint(response)
//        }
//        //
//
//        print(headers)
        
        Alamofire.request(
            url,
            method: .get,
            headers: headers)
//            .validate()
//            .responseJSON { (response) -> Void in
//
//                var backToString = String(data: response.data!, encoding: String.Encoding.utf8) as String!
//                print("Alamofire1")
//                print(backToString)
//                print("Alamofire2")
//
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    completionHandler(nil,nil)
//
//                    return
//                }
//
//                guard let value = response.result.value as? [String: Any],
//                    let rows = value["rows"] as? [[String: Any]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        completionHandler(nil,nil)
//                        return
//                }
//
//                let decks = rows.flatMap({ (deckDict) -> Deck? in
//                    let json = JSON(deckDict)
//                    return Deck(json: json)
//                })
//                print("THIS IS THE DECKS!!!!!!!!!!!!!!!!")
//                print(decks)
//                completionHandler(decks, nil)
//        }
//
//        print("request")
//        print(request)
// method: .get , headers: headers , encoding: JSONEncoding.default
//        Alamofire.request(URL(string: baseURL + "/decks")!, method: .get, parameters: ["Content-Type" : "application/json"], encoding: .jsonSerialization, headers: headers)
//

//        Alamofire.request(url: url!, method: .get, parameters: ["Content-Type" : "application/json"], encoding: .jsonSerialization, headers: headers).responseJSON { response in
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    completionHandler(nil,nil)
//                    return
//                }
//
//                print("response.result.value")
//                print(response.result.value)
//
//                guard let value = response.result.value as? [String: Any],
//                    let rows = value["rows"] as? [[String: Any]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        completionHandler(nil, nil)
//                        return
//                }
//
//                let decks = rows.flatMap({ (deckDict) -> Deck? in
//                    let json = JSON(deckDict)
//                    return Deck(json: json)
//                })
//
//                completionHandler(decks, nil)
//        }
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
        print("CHECK LOGGED IN")
        print(json)
        if let message = json["message"].string {
            print("User recieved message from login attempt: \(message)")
            return false
        }
        return true
    }
}
