public enum DeckRequests: Request {

    case createDeck(name:String)
    case getDecks()
    case getDeck(deckId:String)
    case addCardsToDeck(deckId:String, cards:[String])
    case deleteCardsFromDeck(deckId:String, cards:[String])
    
    public var path: String {
        switch self {
        case .createDeck(_):
            return "/decks"
        case .getDecks():
            return "/decks"
        case .getDeck(let deckId):
            // URL Does not accept curly brackets ex. {}
            // They can be encoded with %7B and %7d respectfully
            return "/decks/%7B" + deckId + "%7D"
        case .addCardsToDeck(let deckId,_):
            return "/decks/%7B" + deckId + "%7D/cards"
        case .deleteCardsFromDeck(let deckId,_):
            return "/decks/%7B" + deckId + "%7D/cards"
        }
    }
        
    public var method: HTTPMethodCase {
        switch self {
        case .createDeck(_):
            return .post
        case .getDecks():
            return .get
        case .getDeck(_):
            return .get
        case .addCardsToDeck(_,_):
            return .put
        case .deleteCardsFromDeck(_,_):
            return .delete
        }
    }
        
    public var parameters: [String : Any]? {
        switch self {
        case .createDeck(let name):
            return ["name": name]
        case .getDecks():
            return nil
        case .getDeck(_):
            return nil
        case .addCardsToDeck(_,let cards):
            return ["cards": cards]
        case .deleteCardsFromDeck(_,let cards):
            return ["cards": cards]
        }
    }
            
    public var headers: [String : String]? {
        switch self {
        case .createDeck(_):
            return nil
        case .getDecks():
            return nil
        case .getDeck(_):
            return nil
        case .addCardsToDeck(_,_):
            return nil
        case .deleteCardsFromDeck(_,_):
            return nil
        }
    }
    
    public var needsAuthHeader: Bool {
        return true
    }
}
