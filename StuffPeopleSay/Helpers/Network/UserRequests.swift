public enum UserRequest: Request {

    case create(email: String, password: String)
    case login(email: String, password: String)
    case checkToken(token: String)
    
    public var path: String {
        switch self {
        case .create(_,_):
            return "/users/create"
        case .login(_):
            return "/users/auth"
        case .checkToken(_):
            return "/auth"
        }
    }
        
    public var method: HTTPMethod {
        switch self {
        case .create(_,_):
            return .post
        case .login(_):
            return .put
        case .checkToken(_):
            return .get
        }
    }
        
    public var parameters: [String : String]? {
        switch self {
        case .create(let email,_):
            return ["email" : email]
        case .login(let email, _):
            return ["email" : email]
        case .checkToken(let token):
            return nil
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .create(_,let password):
            return ["password" : password]
        case .login(_,let password):
            return ["password" : password]
        case .checkToken(let token):
            return ["Authorization": token]
        }
    }
}
