class CheckToken: Operation {

    typealias Output = Bool

    var token: String
    var socketId: String

    init(token: String, socketId: String) {
        self.token = token
        self.socketId = socketId
    }

    var request: Request {
        return UserRequests.checkToken(token: token, socketId: socketId)
    }

    func execute(in dispatcher: Dispatcher) -> Output? {
        
        let response = dispatcher.execute(request: request)
        
        print("HERE IS JSON")
        print(response)
//        return Promise<User>({ resolve, reject in
//            do {
//                try dispatcher.execute(request: self.request).then({ response in
//                    let user = User(response as! JSON)
//                    resolve(user)
//                }).catch(reject)
//            } catch {
//                reject(error)
//            }
//        })
        return true
    }
}



