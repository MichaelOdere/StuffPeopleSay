public enum GameRequest: Request {
    
    case createGame(token: String, socketId: String, name: String, boards: Int, deckId: String)
    case getGames(token: String, socketId: String)
    case updateGame(token: String, socketId: String, gameId: String)

    public var path: String {
        switch self {
        case .createGame(_,_,_,_,_):
            return "/games"
        case .getGames(_,_):
            return "/games"
        case .updateGame(_, _, let gameId):
            return "/games/{" + gameId + "}"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createGame(_,_,_,_,_):
            return .put
        case .getGames(_,_):
            return .get
        case .updateGame(_, _, _):
            return .put
        }
    }
    
    public var parameters: [String : String]? {
        switch self {
        case .createGame(_,_,_,_,_):
            return nil
        case .getGames(_,_):
            return nil
        case .updateGame(_, _, _):
            return ["winner":"true"]
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .createGame(_,_,_,_,_):
            return nil
        case .getGames(_,_):
            return nil
        case .updateGame(_, _, _):
            return .put
        }
    }
}
