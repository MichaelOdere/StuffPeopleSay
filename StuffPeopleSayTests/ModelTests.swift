import XCTest
@testable import StuffPeopleSay
import SwiftyJSON

class ModelTests: XCTestCase {
    var gameJsonData: JSON!

    override func setUp() {
        super.setUp()

        print("setup")
        if let path = Bundle.main.path(forResource: "FakeGameData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                let gameArray = json["games"].arrayValue
                gameJsonData = gameArray[0]
            } catch {
                print("error")
                print(error)
            }
        } else {
            print("No such path")
        }

    }

    override func tearDown() {
        super.tearDown()
        gameJsonData = nil
    }

    func testBoardDeckCard() {
        let json = gameJsonData["users"]["my"]["boards"][0]["cards"][0]
        let boardDeckCard = BoardDeckCard(json: json)
        XCTAssertTrue(boardDeckCard != nil, "BoardDeckCard not parsing!")
    }

    func testBoardDeck() {
        let json = gameJsonData["users"]["my"]["boards"][0]
        let boardDeckCard = BoardDeck(json: json)
        XCTAssertTrue(boardDeckCard != nil, "BoardDeck not parsing!")
    }

    func testBoard() {
        let json = gameJsonData["users"]["my"]["boards"][0]
        let boardDeckCard = Board(json: json)
        XCTAssertTrue(boardDeckCard != nil, "Board not parsing!")
    }

    func testUser() {
        let json = gameJsonData["users"]["my"]
        let boardDeckCard = User(json: json)
        XCTAssertTrue(boardDeckCard != nil, "User not parsing!")
    }

    func testGame() {
        let game = Game(json: gameJsonData)
        XCTAssertTrue(game != nil, "Game not parsing!")
    }
}
