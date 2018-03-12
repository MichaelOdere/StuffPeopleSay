class CreateUserOperation: Operation {

    typealias Output = String

    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    var request: Request {
        return UserRequests.create(email: email, password: password)
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
                completionHandler("fake token")
                return
            } else {
                completionHandler(nil)
                return
            }
        }
    }
}
