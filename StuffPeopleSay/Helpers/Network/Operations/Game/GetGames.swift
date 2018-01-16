import SwiftyJSON

class GetGames: Operation {
    
    typealias Output = [Game]
    
    var request: Request {
        return GameRequests.getGames()
    }
    
    func execute(in dispatcher: Dispatcher, completionHandler: @escaping (Output?)->Void) {
        dispatcher.execute(request: request) { (response) in
            if case let NetworkResponse.error(code, error) = response {
                if let code = code {
                    print("Status code \(code)")
                }
                
                if let error = error {
                    print("Error \(error)")
                }
                completionHandler(nil)
                return
            }
            
            if case let NetworkResponse.json(jsonData) = response {
//                print("JSON")
//                print(jsonData)

                var games:[Game] = []
                
                guard let gamesArray = jsonData["games"].array else {
                    completionHandler([])
                    return
                }
                
                for g in gamesArray{
                    if let game = Game(json: g) {
                        games.append(game)
                    }
                }
                
//                User()
                
                completionHandler(games)
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
