import SwiftyJSON

class CreateGameOperation: Operation {

    typealias Output = Game

    var name: String
    var boards: Int
    var deckId: String

    init(name: String, boards: Int, deckId: String) {
        self.name = name
        self.boards = boards
        self.deckId = deckId
    }
    var request: Request {
        return GameRequests.createGame(name: name, boards: boards, deckId: deckId)
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
                completionHandler(Game(json: jsonData))
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
