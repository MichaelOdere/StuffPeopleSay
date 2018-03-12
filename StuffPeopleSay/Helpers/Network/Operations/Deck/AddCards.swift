import SwiftyJSON

class AddCardsOperation: Operation {

    typealias Output = Bool

    var deckId: String
    var cards: [String]

    init(deckId: String, cards: [String]) {
        self.deckId = deckId
        self.cards = cards
    }

    var request: Request {
        return DeckRequests.addCardsToDeck(deckId: deckId, cards: cards)
    }

    func execute(in dispatcher: Dispatcher, completionHandler: @escaping (Output?) -> Void) {
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
                completionHandler(true)
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
