import UIKit

class BingoCollectionView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    var deck:[Card] = []
    var bingoGame:BingoGame = BingoGame()
    var pieceTransparency:CGFloat = 0.2
    
    var didSelectRow: ((_ card: Card, _ cell: BingoCollectionCell ) -> Void)?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(deck.count, 25)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCell", for: indexPath) as! BingoCollectionCell
        let card = deck[indexPath.row]
        cell.backgroundColor = BingoPalette.bingoCellBackgroundColor
        cell.pieceView.backgroundColor = UIColor.clear
        cell.title.text = card.name
        cell.xIndex = indexPath.row / 5
        cell.yIndex = indexPath.row % 5
        if card.active == 1{
            cell.pieceView.alpha = pieceTransparency
            bingoGame.board[cell.xIndex][cell.yIndex] = 1

        }else{
            cell.pieceView.alpha = 0.0
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BingoCollectionCell
        let card = deck[indexPath.row]

        if let didSelectRow = didSelectRow {
            didSelectRow(card, cell)

            if card.active == 0{
               deck[indexPath.row].active = 1
            }else{
                deck[indexPath.row].active = 0
            }
        }
    }
}

