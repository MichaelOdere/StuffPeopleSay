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
