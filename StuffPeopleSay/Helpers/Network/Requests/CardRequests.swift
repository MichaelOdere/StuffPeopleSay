public enum CardRequests: Request {

    case createCard(name: String)
    case getCards()
    
    public var path: String {
        switch self {
        case .createCard(_):
            return "/cards"
        case .getCards():
            return "/cards"
        }
    }
    
    public var method: HTTPMethodCase {
        switch self {
        case .createCard(_):
            return .post
        case .getCards():
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .createCard(let name):
            return ["name":name]
        case .getCards():
            return nil
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .createCard(_):
            return nil
        case .getCards():
            return nil
        }
    }
    
    public var needsAuthHeader: Bool {
        return true
    }
}
