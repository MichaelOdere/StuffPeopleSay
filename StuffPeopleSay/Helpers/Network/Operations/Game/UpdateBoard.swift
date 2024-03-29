class UpdateBoardOperation: Operation {

    typealias Output = Bool

    var boardCardId: String

    init(boardCardId: String) {
        self.boardCardId = boardCardId
    }

    var request: Request {
        return GameRequests.updateBoard(boardCardId: boardCardId)
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
