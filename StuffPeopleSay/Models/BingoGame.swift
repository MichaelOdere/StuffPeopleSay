import Foundation

class BingoBoard{
    enum DiagonalResult {
        case slantingLeft
        case slantingRight
        case both
        case neither
    }
    
    var board:[[Int]]!
    
    init() {
        boardReset()
    }
    
    func cardsToBoard(cards: [Card]){
        for index in 0..<cards.count{
            if index > 24 {
                break
            }
            let card = cards[index]
            let x = index % 5
            let y:Int = index / 5
            if card.active == 1{
                board[x][y] = 1
            }
        }
    }

    func checkVictory(x:Int, y: Int)->Bool{
        var victory = false
        if checkVertical(y: y) || checkHorizontal(x: x){
            victory = true
        }else {
            let result = isDiagonal(x: x, y: y)
            
            if result != DiagonalResult.neither{
                victory = checkDiagonal(dr: result)
            }
        }
        return victory
    }
    
    func boardReset(){
        board = []
        for _ in 0..<5{
            let row = Array(repeatElement(0, count: 5))
            board.append(row)
        }
    }
    
    private func checkHorizontal(x:Int)->Bool{
        for elem in 0..<5{
            if board[x][elem] != 1{
                return false
            }
        }
        return true
    }
    
    private func checkVertical(y: Int)->Bool{
        for elem in 0..<5{
            if board[elem][y] != 1{
                return false
            }
        }
        return true
    }
    
    private func checkDiagonal(dr: DiagonalResult)->Bool{
        var victory = false
        switch dr {
        case .both:
            if checkLeftSlant() || checkRightSlant(){
                victory = true
            }
        case .slantingLeft:
            victory = checkLeftSlant()
            
        case .slantingRight:
            victory = checkRightSlant()
            
        default:
            victory = false
        }
        return victory
    }
    
    private func checkRightSlant()->Bool{
        for elem in 0..<5{
            let x = 4 - elem
            let y = elem
            if board[x][y] != 1{
                return false
            }
        }
        return true
    }

    private func checkLeftSlant()->Bool{
        for elem in 0..<5{
            if board[elem][elem] != 1{
                return false
            }
        }
        return true
    }
    
    private func isDiagonal(x:Int, y: Int)->DiagonalResult{
        if x == y{
            if x == 2{
                return DiagonalResult.both
            }
            return DiagonalResult.slantingLeft
        }
        if (x + y) == 4{
            return DiagonalResult.slantingRight
        }
        return DiagonalResult.neither
    }
}
