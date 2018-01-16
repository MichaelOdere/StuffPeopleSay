class CheckToken: Operation {

    typealias Output = Bool

    var email: String
    var token: String
    var socketId: String

    init(email: String, token: String, socketId: String) {
        self.email = email
        self.token = token
        self.socketId = socketId
    }

    var request: Request {
        return UserRequests.checkToken(email: email, token: token, socketId: socketId)
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
                if jsonData["token"].string?.lowercased() == "true"{
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
