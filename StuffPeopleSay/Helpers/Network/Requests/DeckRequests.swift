public enum DeckRequests: Request {

    case createDeck(name:String)
    case createCard(name:String)
    case getDecks()
    case getDeck(deckId:String)
    case addCardsToDeck(deckId:String, cards:[String])
    case removeCardsFromDeck(deckId:String, cards:[String])
    
    public var path: String {
        switch self {
        case .createDeck(_):
            return "/decks"
        case .createCard(_):
            return "/cards"
        case .getDecks():
            return "/decks"
        case .getDeck(let deckId):
            return "/decks/" + deckId
        case .addCardsToDeck(let deckId,_):
            return "/decks/" + deckId + "/cards"
        case .removeCardsFromDeck(let deckId,_):
            return "/decks/" + deckId + "/cards"
        }
    }
        
    public var method: HTTPMethodCase {
        switch self {
        case .createDeck(_):
            return .post
        case .createCard(_):
            return .post
        case .getDecks():
            return .get
        case .getDeck(_):
            return .get
        case .addCardsToDeck(_,_):
            return .put
        case .removeCardsFromDeck(_,_):
            return .delete
        }
    }
        
    public var parameters: [String : Any]? {
        switch self {
        case .createDeck(let name):
            return ["name": name]
        case .createCard(let name):
            return ["name": name]
        case .getDecks():
            return nil
        case .getDeck(_):
            return nil
        case .addCardsToDeck(_,let cards):
            return ["cards": cards]
        case .removeCardsFromDeck(_,let cards):
            return ["cards": cards]
        }
    }
            
    public var headers: [String : String]? {
        switch self {
        case .createDeck(_):
            return nil
        case .createCard(_):
            return nil
        case .getDecks():
            return nil
        case .getDeck(_):
            return nil
        case .addCardsToDeck(_,_):
            return nil
        case .removeCardsFromDeck(_,_):
            return nil
        }
    }
    
    public var needsAuthHeader: Bool {
        return true
    }
}
