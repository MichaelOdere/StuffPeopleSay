public enum GameRequests: Request {
    
    case createGame(name: String, boards: Int, deckId: String)
    case getGames()
    case updateGame(gameId: String)
    case updateBoard(boardCardId: String)

    public var path: String {
        switch self {
        case .createGame(_,_,_):
            return "/games"
        case .getGames():
            return "/games"
        case .updateGame(let gameId):
            return "/games/" + gameId
        case .updateBoard(let boardCardId):
            return "/boards/" + boardCardId
        }
    }
    
    public var method: HTTPMethodCase {
        switch self {
        case .createGame(_,_,_):
            return .post
        case .getGames():
            return .get
        case .updateGame(_):
            return .put
        case .updateBoard(_):
            return .put
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .createGame(let name, let boardsCount, let deckId):
            return ["name":name, "boardsCount": boardsCount, "deckId": deckId]
        case .getGames():
            return nil
        case .updateGame(_):
            return ["winner":"true"]
        case .updateBoard(_):
            return nil
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
        case .updateBoard(_):
            return nil
        }
    }
    
    public var needsAuthHeader: Bool {
        return true
    }
}
