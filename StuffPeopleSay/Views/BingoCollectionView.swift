import UIKit

protocol BingoCollectionViewDelegate: class {
    func specificDidSelectRow(card: Card, cell: BingoCollectionCell)
}

class BingoCollectionView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    var deck:Deck!
    var bingoGame:BingoBoard = BingoBoard()
    var pieceTransparency:CGFloat = 0.2
    weak var didSelectDelegate: BingoCollectionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(deck.cards.count, 25)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCell", for: indexPath) as! BingoCollectionCell
        let card = deck.cards[indexPath.row]
        cell.backgroundColor = BingoPalette.bingoCellBackgroundColor
        cell.pieceView.backgroundColor = UIColor.clear
        cell.title.text = card.name
        cell.xIndex = indexPath.row / 5
        cell.yIndex = indexPath.row % 5
        if card.active{
            cell.pieceView.alpha = pieceTransparency
            bingoGame.board[cell.xIndex][cell.yIndex] = 1

        }else{
            cell.pieceView.alpha = 0.0
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BingoCollectionCell
        let card = deck.cards[indexPath.row]

        if let didSelectDelegate = didSelectDelegate {
            didSelectDelegate.specificDidSelectRow(card: card, cell: cell)
            if card.active{
               deck.cards[indexPath.row].active = true
            }else{
                deck.cards[indexPath.row].active = false
            }
        }
    }
}

