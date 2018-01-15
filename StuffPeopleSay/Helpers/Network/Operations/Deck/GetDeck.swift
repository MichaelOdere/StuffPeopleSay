class GetDeck: Operation {
    
    typealias Output = Deck
    
    var deckId: String
    
    init(deckId: String) {
        self.deckId = deckId
    }
    
    var request: Request {
        return DeckRequests.getDeck(deckId: deckId)
    }
    
    func execute(in dispatcher: Dispatcher, completionHandler: @escaping (Output?)->Void) {
        dispatcher.execute(request: request) { (response) in

            if case let NetworkResponse.json(jsonData) = response {
                print("IN GET DECK")
                print(jsonData)
                
                completionHandler(Deck(json: jsonData))
            }
        }
    }
}


