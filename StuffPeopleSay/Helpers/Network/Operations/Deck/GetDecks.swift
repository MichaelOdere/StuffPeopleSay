import SwiftyJSON

class GetDecks: Operation {
    
    typealias Output = JSON
    
    var request: Request {
        return DeckRequests.getDecks()
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
                completionHandler(jsonData)
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}





/*
let group = DispatchGroup()
var decks:[Deck] = []

for d in jsonData.array!{
    group.enter()
    let id = d["id"].string
    
    let getDeck = GetDeck(deckId: id!)
    getDeck.execute(in: dispatcher, completionHandler: { (deckResponse) in
        if let deck = deckResponse {
            decks.append(deck)
        }
        group.leave()
    })
}

group.notify(queue: DispatchQueue.main){
    completionHandler(decks)
}

 
 */
