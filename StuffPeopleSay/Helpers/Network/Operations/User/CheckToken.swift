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
        print(email)
        print(token)
        print(socketId)
        let response = dispatcher.execute(request: request) { (response) in
            print("HERE IS JSON")
            print(response)
            completionHandler(true)
        }
    }
}



