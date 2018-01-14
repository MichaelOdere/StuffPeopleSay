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
        case .getDecks(_,_)
        case .getDeck(_,_,_)
            
        case .addCardsToDeck(_,_,_,_)
        case .deleteCardsFromDeck(_,_,_,_)
    }
        
    public var method: HTTPMethod {
        switch self {
        case .createDeck(_,_,_):
            return "/decks"
        case .getDecks(_,_)
        case .getDeck(_,_,_)
            
        case .addCardsToDeck(_,_,_,_)
        case .deleteCardsFromDeck(_,_,_,_)
    }
        
    public var parameters: [String : String]? {
        switch self {
        case .createDeck(_,_,_):
            return "/decks"
        case .getDecks(_,_)
        case .getDeck(_,_,_)
            
        case .addCardsToDeck(_,_,_,_)
        case .deleteCardsFromDeck(_,_,_,_)
    }
            
    public var headers: [String : String]? {
        switch self {
        case .createDeck(_,_,_):
            return "/decks"
        case .getDecks(_,_)
        case .getDeck(_,_,_)
            
        case .addCardsToDeck(_,_,_,_)
        case .deleteCardsFromDeck(_,_,_,_)
    }
}
