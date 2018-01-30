import XCTest
@testable import StuffPeopleSay

class StuffPeopleSayTests: XCTestCase {
    var bingoBoard: BingoBoard!
    
    override func setUp() {
        super.setUp()
        bingoBoard = BingoBoard()
    }
    
    override func tearDown() {
        super.tearDown()
        bingoBoard = nil
    }
    
    func testHorizontalWinConditions() {
        // 1. given clear board
        bingoBoard.boardReset()
        // 2. when we create horizontal win conditions
        for row in 0..<bingoBoard.size {
            for col in 0..<bingoBoard.size {
                bingoBoard.board[row][col] = 1
                if col == bingoBoard.size - 1 {
                    // 3. then when we reach the end of the row we should have a win
                    XCTAssertTrue(bingoBoard.checkVictory(x: row, y: col), "Win condition failed")
                } else {
                    // 4. then when we have not reached the end of the row we should not have a win
                    XCTAssertFalse(bingoBoard.checkVictory(x: row, y: col), "No win condition failed")
                }
            }
            // 5. clear the board so we can check the next row
            bingoBoard.boardReset()
        }
    }
    
    func testVerticalWinConditions() {
        // 1. given clear board
        bingoBoard.boardReset()
        // 2. when we create vertical win conditions
        for col in 0..<bingoBoard.size {
            for row in 0..<bingoBoard.size {
                bingoBoard.board[row][col] = 1
                if row == bingoBoard.size - 1 {
                    // 3. then when we reach the end of the column we should have a win
                    XCTAssertTrue(bingoBoard.checkVictory(x: row, y: col), "Win condition failed")
                } else {
                    // 4. then when we have not reached the end of the column we should not have a win
                    XCTAssertFalse(bingoBoard.checkVictory(x: row, y: col), "No win condition failed")
                }
            }
            // 5. clear the board so we can check the next column
            bingoBoard.boardReset()
        }
    }
    
    func testSlantLeftConditions() {
        // 1. given clear board
        bingoBoard.boardReset()
        // 2. when we create slant left win conditions
        for index in 0..<bingoBoard.size {
            // 3. then when we have not reached the end of the slant we should not have a win
            XCTAssertFalse(bingoBoard.checkVictory(x: index, y: index), "No win condition failed")
            bingoBoard.board[index][index] = 1
        }
        // 4. then when we reach the end of the slant we should have a win
        XCTAssertTrue(bingoBoard.checkVictory(x: bingoBoard.size - 1, y: bingoBoard.size - 1), "Win condition failed")
    }
    
    func testSlantRightConditions() {
        // 1. given clear board
        bingoBoard.boardReset()
        // 2. when we create slant right win conditions
        for index in 0..<bingoBoard.size {
            // 3. then when we have not reached the end of the slant we should not have a win
            XCTAssertFalse(bingoBoard.checkVictory(x: index, y: index), "No win condition failed")
            bingoBoard.board[bingoBoard.size - index - 1][index] = 1
        }
        // 4. then when we reach the end of the slant we should have a win
        XCTAssertTrue(bingoBoard.checkVictory(x: 0, y: bingoBoard.size - 1), "Win condition failed")
    }
}

