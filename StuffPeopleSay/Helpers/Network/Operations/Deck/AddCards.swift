import SwiftyJSON

class AddCards: Operation {
    
    typealias Output = Game
    
    var deckId: String
    var cards: [String]

    init(deckId: String, cards: [String]) {
        self.deckId = deckId
        self.cards = cards
    }
    
    var request: Request {
        return DeckRequests.addCardsToDeck(deckId: deckId, cards: cards)
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
