public enum UserRequest: Request {

    case create(email: String, password: String)
    case login(email: String)
    case loginWithToken(token:String)
    case checkToken(token: String)
    
    public var path: String {
        switch self {
        case .create(_,_):
            return "/users/create"
        case .login(_):
            return "/users/auth"
        case .loginWithToken(_):
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
        case .loginWithToken(_):
            return .put
        case .checkToken(_):
            return .get
        }
    }
        
    public var headers: [String : String]? {
        switch self {
        case .create(_,_):
            return nil
        case .login(_):
            return nil
        case .loginWithToken(_):
            return nil
        case .checkToken(let token):
            return ["Authorization": token]
        }
        
    }
}
