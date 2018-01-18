class UpdateGameOperation: Operation {
    
    typealias Output = Bool
    
    var gameId: String
    
    init(gameId: String) {
        self.gameId = gameId
    }
    
    var request: Request {
        return GameRequests.updateGame(gameId: gameId)
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
                completionHandler(true)
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
