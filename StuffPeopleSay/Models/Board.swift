import Foundation
import SwiftyJSON

class Board {
    var boardId: String
    var boardDeck: BoardDeck
    var count: Int

    init(boardId: String, boardDeck: BoardDeck, count: Int) {
        self.boardId = boardId
        self.boardDeck = boardDeck
        self.count = count
    }
}

extension Board {
    convenience init?(json: JSON) {
        guard let boardId = json["boardId"].string else {
            print("Error parsing board object for key: boardId")
            return nil
        }

        guard let deck = BoardDeck(json: json) else {
            print("Error parsing board object for key: boardDeck")
            return nil
        }

        guard let count = json["count"].int else {
            print("Error parsing board object for key: count")
            return nil
        }

        self.init(boardId: boardId, boardDeck: deck, count: count)
    }
}
