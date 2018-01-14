public enum DeckRequest: Request {

    case createDeck(token: String, socketId: String, name:String)
    case getDecks(token: String, socketId: String)
    case getDeck(token: String, socketId: String, deckId:String)
    case addCardsToDeck(token: String, socketId: String, deckId:String, cards:[String])
    case deleteCardsFromDeck(token: String, socketId: String, deckId:String, cards:[String])
    
    public var path: String {
        switch self {
        case .createDeck(_,_,_):
            return "/decks"
        case .getDecks(_,_):
            return "/decks"
        case .getDeck(_,_,let deckId):
            return "/decks/{" + deckId + "}"
        case .addCardsToDeck(_,_,let deckId,_):
            return "/decks/{" + deckId + "}/cards"
        case .deleteCardsFromDeck(_,_,let deckId,_):
            return "/decks/{" + deckId + "}/cards"
        }
    }
        
    public var method: HTTPMethod {
        switch self {
        case .createDeck(_,_,_):
            return .post
        case .getDecks(_,_):
            return .get
        case .getDeck(_,_,_):
            return .get
        case .addCardsToDeck(_,_,_,_):
            return .put
        case .deleteCardsFromDeck(_,_,_,_):
            return .delete
        }
    }
        
    public var parameters: [String : Any]? {
        switch self {
        case .createDeck(_,_,let name):
            return ["name": name]
        case .getDecks(_,_):
            return nil
        case .getDeck(_,_,_):
            return nil
        case .addCardsToDeck(_,_,_,let cards):
            return ["cards": cards]
        case .deleteCardsFromDeck(_,_,_,let cards):
            return ["cards": cards]
        }
    }
            
    public var headers: [String : String]? {
        switch self {
        case .createDeck(let token, let socketId,_):
            return createHeader(token: token, socketId: socketId)
        case .getDecks(let token, let socketId):
            return createHeader(token: token, socketId: socketId)
        case .getDeck(let token, let socketId,_):
            return createHeader(token: token, socketId: socketId)
        case .addCardsToDeck(let token, let socketId,_,_):
            return createHeader(token: token, socketId: socketId)
        case .deleteCardsFromDeck(let token, let socketId,_,_):
            return createHeader(token: token, socketId: socketId)
        }
    }
}
