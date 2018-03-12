import Foundation
import SwiftyJSON

struct APIManager {

    // MARK: APIManager - User Operations
    func createUser(email: String, password: String, dispatch: NetworkDispatcher, completionHandler: @escaping (String?) -> Void) {
        let operation = CreateUserOperation(email: email, password: password)
        operation.execute(in: dispatch, completionHandler: { (response) in
            completionHandler(response)
        })
    }

    func login(email: String, password: String, dispatch: NetworkDispatcher, completionHandler: @escaping (String?) -> Void) {
        let operation = GetTokenOperation(email: email, password: password)
        operation.execute(in: dispatch, completionHandler: { (response) in
            completionHandler(response)
        })
    }

    func checkToken(email: String, token: String, socketId: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Bool) -> Void) {
        let operation = CheckTokenOperation(email: email, token: token, socketId: socketId)
        operation.execute(in: dispatch, completionHandler: { (response) in
            guard let response = response else {
                completionHandler(false)
                return
            }
            completionHandler(response)
        })
    }

    // MARK: APIManager - Game Operations

    func createGame(name: String, boards: Int, deckId: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Game?) -> Void) {
        let operation = CreateGameOperation(name: name, boards: boards, deckId: deckId)
        operation.execute(in: dispatch) { (game) in
            guard let game = game else {
                completionHandler(nil)
                return
            }
            completionHandler(game)
        }
    }

    func getGames(dispatch: NetworkDispatcher, completionHandler: @escaping ([Game]?) -> Void) {
        let operation = GetGamesOperation()
        operation.execute(in: dispatch) { (games) in
            guard let games = games else {
                completionHandler(nil)
                return
            }
            completionHandler(games)
        }
    }

    func updateGame(gameId: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Bool) -> Void) {
        let operation = UpdateGameOperation(gameId: gameId)
        operation.execute(in: dispatch) { (success) in
            guard let success = success else {
                completionHandler(false)
                return
            }
            completionHandler(success)
        }
    }

    func updateBoard(boardCardId: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Bool) -> Void) {
        let operation = UpdateBoardOperation(boardCardId: boardCardId)
        operation.execute(in: dispatch) { (success) in
            guard let success = success else {
                completionHandler(false)
                return
            }
            completionHandler(success)
        }
    }

    // MARK: APIManager - Deck Operations

    func createDeck(name: String, dispatch: NetworkDispatcher, completionHandler: @escaping (JSON?) -> Void) {
        let operation = CreateDeckOperation(name: name)
        operation.execute(in: dispatch) { (jsonData) in
            completionHandler(jsonData)
        }
    }

    func createCard(name: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Card?) -> Void) {
        let operation = CreateCardOperation(name: name)
        operation.execute(in: dispatch) { (card) in
            completionHandler(card)
        }
    }

    func getDecksData(dispatch: NetworkDispatcher, completionHandler: @escaping (JSON?) -> Void) {
        let operation = GetDecksOperation()
        operation.execute(in: dispatch) { (jsonData) in
            guard let jsonData = jsonData else {
                completionHandler(nil)
                return
            }
            completionHandler(jsonData)
        }
    }

    func getDeck(deckId: String, dispatch: NetworkDispatcher, completionHandler: @escaping (Deck?) -> Void) {
        let operation = GetDeckOperation(deckId: deckId)
        operation.execute(in: dispatch) { (deck) in
            guard let deck = deck else {
                completionHandler(nil)
                return
            }
            completionHandler(deck)
        }
    }

    func addCards(deckId: String, cards: [String], dispatch: NetworkDispatcher, completionHandler: @escaping (Bool) -> Void) {
        let operation = AddCardsOperation(deckId: deckId, cards: cards)
        operation.execute(in: dispatch) { (success) in
            guard let success = success else {
                completionHandler(false)
                return
            }
            completionHandler(success)
        }
    }

    func removeCards(deckId: String, cards: [String], dispatch: NetworkDispatcher, completionHandler: @escaping (Bool) -> Void) {
        let operation = RemoveCardsOperation(deckId: deckId, cards: cards)
        operation.execute(in: dispatch) { (success) in
            guard let success = success else {
                completionHandler(false)
                return
            }
            completionHandler(success)
        }
    }
}
