import SwiftyJSON

class CreateCardOperation: Operation {

    typealias Output = Card

    var name: String

    init(name: String) {
        self.name = name
    }

    var request: Request {
        return DeckRequests.createCard(name: name)
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

                if let card = Card(json: jsonData) {
                    card.active = false
                    completionHandler(card)
                } else {
                    completionHandler(nil)
                }
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
