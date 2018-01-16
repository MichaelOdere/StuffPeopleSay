import SwiftyJSON

class CreateDeckOperation: Operation {
    
    typealias Output = Deck
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var request: Request {
        return DeckRequests.createDeck(name: name)
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
                print("JSON")
                print(jsonData)
                completionHandler(nil)
                //                completionHandler(Game(gameId: "s", name: "s", status: "2", my: User(userId: "d", name: "d", boards: [] ), opponents: []))
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
