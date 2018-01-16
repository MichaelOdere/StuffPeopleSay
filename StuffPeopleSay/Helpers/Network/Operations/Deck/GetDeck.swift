class GetDeckOperation: Operation {
    
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
                completionHandler(Deck(json: jsonData))
            }else{
                completionHandler(nil)
            }
            
        }
    }
}
