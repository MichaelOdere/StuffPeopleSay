public enum GameRequest: Request {
    
    case createGame(name: String, boards: Int, deckId: String)
    case getGames()
    case updateGame(gameId: String)

    public var path: String {
        switch self {
        case .createGame(_,_,_):
            return "/games"
        case .getGames():
            return "/games"
        case .updateGame(let gameId):
            return "/games/{" + gameId + "}"
        }
    }
    
    public var method: HTTPMethodCase {
        switch self {
        case .createGame(_,_,_):
            return .put
        case .getGames():
            return .get
        case .updateGame(_):
            return .put
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .createGame(let name, let boards, let deckId):
            return ["name":name, "boards": boards, "deckId": deckId]
        case .getGames():
            return nil
        case .updateGame(_):
            return ["winner":"true"]
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .createGame(_,_,_):
            return nil
        case .getGames():
            return nil
        case .updateGame(_):
            return nil
        }
    }
    
    public var needsAuthHeader: Bool {
        return true
    }
}
