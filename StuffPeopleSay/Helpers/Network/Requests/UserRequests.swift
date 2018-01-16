public enum UserRequests: Request {

    case create(email: String, password: String)
    case login(email: String, password: String)
    case checkToken(email: String, token: String, socketId: String)
    
    public var path: String {
        switch self {
        case .create(_,_):
            return "/users/create"
        case .login(_):
            return "/users/auth"
        case .checkToken(_,_,_):
            return "/auth"
        }
    }
        
    public var method: HTTPMethodCase {
        switch self {
        case .create(_,_):
            return .post
        case .login(_):
            return .put
        case .checkToken(_,_,_):
            return .get
        }
    }
        
    public var parameters: [String : Any]? {
        switch self {
        case .create(let email,_):
            return ["email" : email]
        case .login(let email, _):
            return ["email" : email]
        case .checkToken(let email,_,_):
            return ["email" : email]
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .create(_,let password):
            return ["password" : password]
        case .login(_,_):
            return nil
        case .checkToken(_, let token, let socketId):
            return ["Authorization": token, ]
        }
    }
    
    public var needsAuthHeader: Bool {
        return false
    }
}
